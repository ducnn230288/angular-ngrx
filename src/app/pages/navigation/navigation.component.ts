import {
  ChangeDetectionStrategy,
  ChangeDetectorRef,
  Component,
  OnDestroy,
  OnInit,
  TemplateRef,
  ViewChild,
  ViewEncapsulation,
} from '@angular/core';
import { NzTreeNodeOptions } from 'ng-zorro-antd/tree';
import { Subject, takeUntil } from 'rxjs';

import { FormModel } from '@model';
import { NavigationFacade, Role, RoleFacade, Navigation, GlobalFacade } from '@store';
import { Message } from '@utils';
import { icons } from './icon';
import { TransferItem } from 'ng-zorro-antd/transfer';
import { FormComponent } from '@core/form/form.component';

@Component({
  selector: 'app-navigations',
  templateUrl: './navigation.component.html',
  providers: [NavigationFacade, RoleFacade, GlobalFacade],
  encapsulation: ViewEncapsulation.None,
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class NavigationComponent implements OnInit, OnDestroy {
  @ViewChild('form') form!: FormComponent;
  private destroyed$ = new Subject<void>();

  selectedNode: Navigation | null = null;
  type: 0 | 1 = 1;
  searchValue = '';
  isShowForm = false;
  nodes: NzTreeNodeOptions[] = [];
  originRoles: Role[] = [];
  roles: TransferItem[] = [];
  icons = icons;
  permission: { roles: TransferItem[] } = { roles: [] };
  data?: Navigation;
  isLoading = false;
  dataTemp = '';

  constructor(
    protected message: Message,
    public navigationFacade: NavigationFacade,
    public roleFacade: RoleFacade,
    private cdr: ChangeDetectorRef,
    private globalFacade: GlobalFacade,
  ) {}

  async ngOnInit() {
    this.globalFacade.setBreadcrumbs([
      {
        title: 'SUPERADMIN',
        link: '/navigation',
      },
      {
        title: 'Phân quyền điều hướng',
        link: '/navigation',
      },
    ]);
    this.navigationFacade.getTree(this.type);
    this.roleFacade.get({ page: 1, size: 30 });
    this.roleFacade.pagination$.pipe(takeUntil(this.destroyed$)).subscribe((list) => {
      if (list.content && list.content.length > 0) this.originRoles = list.content;
    });
    this.navigationFacade.status$.subscribe((value) => {
      switch (value) {
        case 'postOk':
        case 'putOk':
          this.isShowForm = false;
          this.navigationFacade.getTree(this.type);
          this.roleFacade.get({ page: 1, size: 30 });
          break;
        case 'deleteOk':
          this.navigationFacade.getTree(this.type);
          this.roleFacade.get({ page: 1, size: 30 });
          break;
      }
    });
    this.navigationFacade.navigationList$.pipe(takeUntil(this.destroyed$)).subscribe((data) => {
      if (data.length) {
        this.nodes = JSON.parse(JSON.stringify(data));
        this.table(data);
        this.cdr.detectChanges();
      }
    });
  }

  @ViewChild('icon') icon!: TemplateRef<any>;
  table(data: any) {
    this.columnsForm = [
      {
        name: 'name',
        title: 'routes.admin.navigations.navaigationname',
        formItem: {
          rules: [
            {
              type: 'required',
            },
          ],
        },
      },
      {
        name: 'code',
        title: 'routes.admin.navigations.navigationcode',
        formItem: {
          col: 6,
          rules: [
            {
              type: 'required',
            },
          ],
        },
      },

      {
        name: 'urlRewrite',
        title: 'routes.admin.navigations.link',
        formItem: {
          col: 6,
          rules: [
            {
              type: 'required',
            },
          ],
        },
      },
      {
        name: 'order',
        title: 'routes.admin.navigations.order',
        formItem: {
          col: 6,
          type: 'number',
          rules: [
            {
              type: 'required',
            },
          ],
        },
      },
      {
        name: 'iconClass',
        title: 'routes.admin.navigations.icon',
        formItem: {
          col: 6,
          type: 'autocomplete',
          list: this.icons.map((i: any) => ({ value: i, label: i })),
          customOptionContent: (item: any) => `<i class="la-lg ${item.value}"></i> ${item.label}`,
          addOnBefore: this.icon,
        },
      },
      {
        name: 'parentId',
        title: 'routes.admin.navigations.parentnavigation',
        formItem: {
          col: 6,
          type: 'treeSelect',
          list: JSON.parse(JSON.stringify(data)) || [],
        },
      },
      {
        name: 'queryParams',
        title: 'Tham số truy vấn',
        formItem: {
          col: 6,
        },
      },
      {
        name: 'status',
        title: 'routes.admin.user.active',
        formItem: {
          col: 6,
          type: 'switch',
        },
      },
    ];
  }

  ngOnDestroy(): void {
    this.destroyed$.next();
    this.destroyed$.complete();
  }

  onSelectTree(event: any): void {
    let node: any;
    this.nodes.forEach((item) => {
      if (!node) {
        if (item.key === event) node = item;
        else {
          item.children.forEach((subItem) => {
            if (subItem.key === event) node = subItem;
          });
        }
      }
    });
    if (node?.isGroup) {
      this.selectedNode = null;
      this.isShowForm = false;
      return;
    }
    this.selectedNode = node;
    this.data = node;
    this.roles = this.originRoles.map((r) => ({
      id: r.id,
      title: r.name,
      direction: node.roleList?.includes(r.id) ? 'right' : 'left',
    }));
    this.permission = {
      roles: this.roles.filter((r) => r.direction === 'right').map((r) => r.id),
    };
    this.isShowForm = true;
  }

  async onSaveNode(event: any) {
    const { controls, valid } = event;
    const value = event.getRawValue();
    if (valid) {
      const parentModel = this.findParentNode(value.parentId, this.nodes);
      if (!this.selectedNode) {
        const payload = {
          ...value,
          parentModel,
          roleList: this.permission?.roles,
          type: this.type,
        };
        this.navigationFacade.post(payload);
      } else {
        const payload = {
          ...this.selectedNode,
          ...value,
          parentModel,
          roleList: this.permission?.roles,
        };
        this.navigationFacade.put(payload);
      }
      this.data = value;
    } else {
      for (const i in controls) {
        if (controls.hasOwnProperty(i)) {
          controls[i].markAsTouched();
          controls[i].updateValueAndValidity();
        }
      }
    }
  }

  async onDelete(item: any) {
    this.isShowForm = false;
    this.selectedNode = null;
    this.navigationFacade.delete(item?.origin.id);
  }

  onChangeRoles(ret: any): void {
    let roles = this.permission?.roles || [];
    const retId = ret.list.map((i: any) => i.id);
    if (ret.from === 'left') {
      roles = [...roles, ...retId];
    } else {
      roles = roles.filter((r: any) => !retId.includes(r));
    }
    this.permission = { roles };
  }

  onAddNew(): void {
    this.selectedNode = null;
    this.roles = this.originRoles.map((r) => ({
      id: r.id,
      title: r.name,
      direction: 'left',
    }));
    this.data = undefined;
    this.permission = { roles: [] };
    this.isShowForm = true;
    setTimeout(() => {
      !!this.form && this.form.validateForm.reset({});
    });
  }

  private findParentNode(id: string, menu: any): any {
    const stack = [...menu];
    let node;
    while (stack.length > 0) {
      node = stack.pop();
      if (node.id === id) {
        return node;
      } else if (node.subChild && node.subChild.length > 0) {
        for (let i = 0; i < node.subChild.length; i++) {
          stack.push(node.subChild[i]);
        }
      }
    }
  }

  columnsForm: FormModel[] = [];
}
