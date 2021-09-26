import { concatMap, filter, from, fromEvent, Subject, takeUntil, tap, timer } from 'rxjs';

export const doCopyToClipboard = {
  mounted() {
    const [buttonRef] = [...this.el.getElementsByTagName('button')];
    const [inputRef] = [...this.el.getElementsByTagName('input')];
    this.destroy$ = new Subject();
    fromEvent(buttonRef, 'click')
      .pipe(
        takeUntil(this.destroy$),
        concatMap(() => from(copyToUserClipboard(inputRef.value, buttonRef))),
        filter(didCopy => didCopy),
        tap(() => addSuccess(this.el, buttonRef)),
        concatMap(() => timer(2000)),
        tap(() => removeSuccess(this.el, buttonRef)),
      ).subscribe();
  },
  destroyed() {
    this.el.classList.remove('copy-success');
    this.destroy$.next();
    this.destroy$.complete();
  }
}

function addSuccess(divRef, buttonRef) {
  divRef.classList.add('copy-success');
  const svgs = [...buttonRef.children];
  svgs[0].classList.add('hidden');
  svgs[1].classList.remove('hidden');
}

function removeSuccess(divRef, buttonRef) {
  divRef.classList.remove('copy-success');
  const svgs = [...buttonRef.children];
  svgs[0].classList.remove('hidden');
  svgs[1].classList.add('hidden');
}

async function copyToUserClipboard(value) {
  try {
    await navigator.clipboard.writeText(value);
  } catch (error) {
    return false;
  }
  return true;
}