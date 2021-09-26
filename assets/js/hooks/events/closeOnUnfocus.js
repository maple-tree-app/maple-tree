import { filter, fromEvent, Subject, takeUntil } from 'rxjs';
export const closeOnUnfocus = {
  mounted() {
    const target = document.getElementById(this.el.dataset.target);
    this.destroy$ = new Subject();
    fromEvent(document.body, 'click')
      .pipe(
        takeUntil(this.destroy$),
        filter(event => isClickInsideElement(target, event))
      ).subscribe(() => this.pushEvent(this.el.dataset.event, {}));

  },
  destroyed() {
    this.destroy$.next();
    this.destroy$.complete();
  }
}

function isClickInsideElement(target, event) {
  return target !== event.target && !target.contains(event.target);
}
