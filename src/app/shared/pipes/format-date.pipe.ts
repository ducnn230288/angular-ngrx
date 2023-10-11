import { Pipe, PipeTransform } from '@angular/core';
import dayjs from 'dayjs';

@Pipe({
  name: 'formatDate',
  pure: false,
})
export class FormatDatePipe implements PipeTransform {
  transform(date?: string, format = 'HH:mm:ss DD/MM'): string {
    return date ? dayjs(date).format(format) : '';
  }
}
