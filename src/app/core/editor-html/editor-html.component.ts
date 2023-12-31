import { ChangeDetectionStrategy, Component, forwardRef, Input, OnInit, ViewEncapsulation } from '@angular/core';
import { NG_VALUE_ACCESSOR } from '@angular/forms';
import { environment } from '@src/environments/environment';
import { uuidv4 } from '@utils';
declare let $: any;

@Component({
  selector: 'g-editor-html',
  templateUrl: './editor-html.component.html',
  encapsulation: ViewEncapsulation.None,
  changeDetection: ChangeDetectionStrategy.OnPush,
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => EditorHtmlComponent),
      multi: true,
    },
  ],
})
export class EditorHtmlComponent implements OnInit {
  @Input() data?: string;
  public id: string;
  constructor() {
    this.id = uuidv4();
  }
  ngOnInit(): void {
    setTimeout(() => {
      $('#summernote-' + this.id).summernote({
        placeholder: '',
        tabsize: 2,
        toolbar: [
          ['misc', ['codeview', 'undo', 'redo']],
          ['style', ['bold', 'italic', 'underline', 'clear']],
          // ['font', ['strikethrough', 'superscript', 'subscript']],
          ['fontsize', ['fontname', 'fontsize', 'color']],
          ['para', ['style', 'ul', 'ol', 'paragraph', 'height']],
          ['insert', ['table', 'picture', 'link', 'video', 'hr']],
          ['view', ['fullscreen', 'codeview', 'help']],
        ],
        fontNames: [
          'Helvetica',
          'Arial',
          'Arial Black',
          'Comic Sans MS',
          'Courier New',
          'Roboto',
          'Times',
          'sans-serif',
        ],
        height: 192,
        callbacks: {
          onBlur: () => {
            if (this.onChange) {
              this.onChange($('#summernote-' + this.id).summernote('code'));
            }
          },
          onImageUpload: async (files: any) => {
            if (this.id) {
              const bodyFormData = new FormData();
              bodyFormData.append('file', files[0]);
              const res = await (
                await fetch(
                  environment.apiUrl + `core/nodes/upload/physical/blob?destinationPhysicalPath=posts/8ebc5c9e`,
                  {
                    method: 'POST',
                    mode: 'cors',
                    cache: 'no-cache',
                    credentials: 'same-origin',
                    redirect: 'follow',
                    referrerPolicy: 'no-referrer',
                    headers: {
                      Authorization: 'Bearer ' + JSON.parse(localStorage.getItem(environment.userData))?.tokenString,
                    },
                    body: bodyFormData,
                  },
                )
              ).json();
              const image = $('<img>').attr('src', environment.hostUrl + res.data.physicalPath);
              $('#summernote-' + this.id).summernote('insertNode', image[0]);
            }
          },
        },
      });
      $('#summernote-' + this.id).summernote('code', this.data);
    }, 300);
  }
  get value() {
    return this.data;
  }
  set value(val) {
    this.data = val;
  }
  writeValue: any = (value: any) => {
    this.data = value;
    setTimeout(() => {
      $('#summernote-' + this.id).summernote('code', value);
    }, 500);
  };
  onChange: any;
  registerOnChange(fn: () => void) {
    this.onChange = fn;
  }
  onTouch: any;
  registerOnTouched(fn: () => void): void {
    this.onTouch = fn;
  }
}
