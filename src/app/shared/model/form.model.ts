import { TemplateRef } from '@angular/core';
import { FormGroup, ValidatorFn } from '@angular/forms';
import { NzTreeNode, NzTreeNodeOptions } from 'ng-zorro-antd/tree';
import { NzMarks } from 'ng-zorro-antd/slider/typings';

export type TypeFile = 'image' | 'video';

export class FormModel {
  name?: string;
  title?: string;
  formItem?: FormItem;
}

export class FormItem {
  type?:
    | 'markdown'
    | 'number'
    | 'mask'
    | 'password'
    | 'textarea'
    | 'autocomplete'
    | 'date'
    | 'date_range'
    | 'checkbox'
    | 'color'
    | 'radio'
    | 'select'
    | 'treeSelect'
    | 'upload'
    | 'switch'
    | 'slider'
    | 'only-text'
    | 'addable'
    | 'tab'
    | 'html';
  title?: (value?: string) => any;
  value?: any;
  formatDate?: string;
  showTime?: boolean;
  disabledDate?: (current: Date) => boolean;
  tooltip?: string;
  confirm?: boolean;
  html?: string;
  mask?: string;
  maskPrefix?: string;
  number?: boolean;
  autoSet?: (value?: string, validateForm?: FormGroup, formGroup?: FormGroup) => void;
  onSearch?: (value?: string) => void;
  disabled?: boolean;
  show?: boolean;
  noLabel?: boolean;
  viewTable?: boolean;
  rules?: FormItemRule[];
  list?: FormItemList[];
  facade?: any;
  tab?: FormItemTab;
  addOnBefore?: TemplateRef<any> | null;
  addOnAfter?: TemplateRef<any> | null;
  placeholder?: string;
  addableText?: string;
  col?: number;
  condition?: (value?: string) => boolean;
  render?: TemplateRef<any> | null;
  columns?: FormModel[];
  listNode?: (NzTreeNodeOptions | NzTreeNode)[];
  customOptionContent?: (value?: FormItemList) => void;
  rows?: number;
  onPaste?: (event?: ClipboardEvent, name?: string, value?: any, index?: number) => void;
  widthTable?: string;
  modeSelect?: 'multiple' | 'tags' | 'default';
  min?: number;
  max?: number;
  sliderMarks?: NzMarks | null;
  formatMarks?: (value: number) => string;
  physicalPathUpload?: string;
  typeUpload?: TypeFile;
}
export class FormItemList {
  label?: string;
  value: any;
  danger?: boolean;
  checked?: boolean;
}

export class FormItemRule {
  type?: string;
  message?: string;
  value?: any;
  validator?: ValidatorFn;
}

export class FormItemTab {
  label?: string;
  value: any;
  disabled?: boolean;
}
