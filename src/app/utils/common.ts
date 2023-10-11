import { Pagination } from '@model';
import { environment } from '@src/environments/environment';

export function emptyPagination(): Pagination<any> {
  return {
    content: [],
    numberOfElements: 0,
    page: 0,
    size: 0,
    totalElements: 0,
    totalPages: 0,
  };
}

export const getSizePageByHeight = (height = 40, minusNumber = 3) =>
  Math.floor(
    (document.body.getBoundingClientRect().height -
      document.getElementsByTagName('tbody')[0].getBoundingClientRect().top) /
      height,
  ) - minusNumber;

export const getLanguage = () => {
  const lang = location.pathname.split('/')[1];
  return '/' + (environment.languages.split(',').indexOf(lang) > -1 ? lang : environment.language);
};

export const uuidv4 = () => {
  let d = new Date().getTime(); //Timestamp
  let d2 = (typeof performance !== 'undefined' && performance.now && performance.now() * 1000) || 0; //Time in microseconds since page-load or 0 if unsupported
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
    let r = Math.random() * 16; //random number between 0 and 16
    if (d > 0) {
      //Use timestamp until depleted
      r = (d + r) % 16 | 0;
      d = Math.floor(d / 16);
    } else {
      //Use microseconds since page-load if supported
      r = (d2 + r) % 16 | 0;
      d2 = Math.floor(d2 / 16);
    }
    return (c === 'x' ? r : (r & 0x3) | 0x8).toString(16);
  });
};
