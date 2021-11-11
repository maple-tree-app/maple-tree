import { isAutoThemeSet, isDarkDefaultTheme } from "../helpers/index";

export const autoThemeSetter = () => {
    const body = document.body;
    if(isAutoThemeSet()) {
      const localStorageTheme = localStorage.getItem('theme');
      if(localStorageTheme) {
        body.classList.add(localStorageTheme);
      } else if (isDarkDefaultTheme()) {
        body.classList.add('dark')
      }
    }
}

