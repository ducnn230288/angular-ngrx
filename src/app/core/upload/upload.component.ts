import {
  ChangeDetectionStrategy,
  ChangeDetectorRef,
  Component,
  EventEmitter,
  forwardRef,
  Input,
  Output,
  ViewEncapsulation,
} from '@angular/core';
import { finalize } from 'rxjs';
import { HttpClient, HttpErrorResponse, HttpEvent, HttpEventType, HttpProgressEvent } from '@angular/common/http';
// @ts-ignore
import GLightbox from 'glightbox';

import { environment } from '@src/environments/environment';
import { NG_VALUE_ACCESSOR } from '@angular/forms';
import { TypeFile } from '@model';

@Component({
  selector: 'g-upload',
  templateUrl: './upload.component.html',
  encapsulation: ViewEncapsulation.None,
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => UploadComponent),
      multi: true,
    },
  ],
})
export class UploadComponent {
  @Input() title?: string;
  @Input() pasteTitle?: string;
  @Input() multiple = false;
  @Input() isPaste = true;
  @Input() cols = 2;
  @Input() url: any;
  @Input() physicalPath?: string;
  @Input() enityId?: string;
  @Input() isDescription?: boolean = true;
  @Input() showImage = true;
  @Input() typeUpload: TypeFile = 'image';
  @Output() handleRemove = new EventEmitter();
  @Output() handleChange = new EventEmitter();

  public formatImage = ['jpg', 'png', 'jpeg', 'JPG', 'PNG', 'JPEG'];
  public formatVideo = ['MP4', 'AVI', 'MPEG-4', 'H.264', 'mp4', 'avi', 'mpeg-4', 'h.264'];

  public isUploading = false;
  visible = false;
  constructor(protected http: HttpClient, private cdr: ChangeDetectorRef) {
    this.url = !this.multiple ? '' : [];
    setTimeout(() => {
      GLightbox();
      this.cdr.detectChanges();
    }, 300);
  }

  progress: { percentage: number } = { percentage: 0 };
  errorUpload?: string;
  customReq = (event: any, type: string) => {
    const file: File = type == 'paste' ? event.file : event.target.files[0];
    const formatFile = file.name.split('.')[file.name.split('.').length - 1];
    this.isUploading = true;
    if (
      (this.typeUpload === 'image' && this.formatImage.indexOf(formatFile) === -1) ||
      (this.typeUpload === 'video' && this.formatVideo.indexOf(formatFile) === -1)
    ) {
      setTimeout(() => {
        this.isUploading = false;
        this.cdr.detectChanges();
      });
      return true;
    }

    if (!this.multiple) this.url = '';

    const data = new FormData();
    data.append('file', file);
    this.progress.percentage = 0;
    this.errorUpload = '';
    if (this.enityId) data.append('enityId', this.enityId);
    return this.http
      .post(`${environment.apiUrl}upload/blob/${this.physicalPath}`, data, {
        observe: 'events',
        reportProgress: true,
      })
      .pipe(finalize(() => (this.isUploading = false)))
      .subscribe({
        next: (response: any) => {
          if (response.type === HttpEventType.UploadProgress) {
            this.progress.percentage = Math.round((100 * response.loaded) / (response.total ?? 1));
            this.cdr.markForCheck();
          }
          if (response.body?.code === 200) {
            response.body.data.physicalPath = environment.hostUrl + response.body.data.physicalPath;
            if (!this.multiple) {
              this.url = response.body.data;
            } else if (typeof this.url === 'object') {
              if (!this.url) this.url = [];
              this.url.push(response.body.data);
            }
            this.onChange(this.url);
          }
        },
        error: (error: HttpErrorResponse) => {
          this.errorUpload = error.statusText;
          this.cdr.markForCheck();
        },
      });
  };

  onPaste(event: any): void {
    const items = (event.clipboardData || event.originalEvent.clipboardData).items;
    for (const index in items) {
      if (items.hasOwnProperty(index)) {
        const item = items[index];
        if (item.kind === 'file') {
          const blob = item.getAsFile();
          this.customReq(
            {
              file: new File(
                [blob],
                `post-cover-${Date.now()}${'.' + blob.name.split('.').pop().toLowerCase()}`,
              ) as any,
            },
            'paste',
          );
        }
      }
    }
  }

  removeImage(url: string, index?: number) {
    if (typeof this.url === 'object' && this.multiple && index !== undefined) {
      this.url.splice(index, 1);
      this.handleRemove.emit(url);
    } else {
      this.url = '';
    }
    this.onChange(this.url);
  }

  array_move(arr: any[], old_index: number, new_index: number) {
    if (new_index >= arr.length) {
      let k = new_index - arr.length + 1;
      while (k--) {
        arr.push(undefined);
      }
    }
    arr.splice(new_index, 0, arr.splice(old_index, 1)[0]);
    return arr.filter((item) => !!item);
  }

  moverImage(index: number, new_index: number) {
    if (this.multiple) {
      this.url = this.array_move(this.url, index, new_index);
      this.onChange(this.url);
    }
  }

  changeDescription(el: any, index: number): void {
    this.isUploading = true;
    if (this.multiple) {
      const data = this.url.map((item: any, i: number) => {
        if (index === i) return { ...item, description: el.target.value };
        return item;
      });
      this.onChange(data);
    } else this.onChange({ ...this.url, description: el.target.value });
  }
  get value() {
    return this.url;
  }

  set value(val: string | string[]) {
    this.url = val;
    this.onChange(val);
  }

  onChange = (value: any) => {
    this.handleChange.emit(value);
    this.change(value);
    this.url = value;
    setTimeout(() => {
      this.isUploading = false;
      this.cdr.detectChanges();
      GLightbox();
    });
  };

  onTouch: any = (value: string | string[]) => {
    this.url = value;
  };

  writeValue: any = (value: string | string[]) => {
    this.url = Array.isArray(value) ? value.slice() : value;
  };

  change: any;

  registerOnChange(fn: () => void) {
    this.change = fn;
  }

  registerOnTouched(fn: () => void): void {
    this.onTouch = fn;
  }
}
