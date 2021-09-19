import { isAutoThemeSet, isDarkDefaultTheme } from "../helpers";

export const autoThemeSetter = {
  mounted() {
    const [body] = document.getElementsByTagName('body');
    if(isAutoThemeSet()) {
      const localStorageTheme = localStorage.getItem('theme');
      if(localStorageTheme) {
        body.classList.add(localStorageTheme);
      }else if (isDarkDefaultTheme()) {
        body.classList.add('dark')
      }
    }
  }
}