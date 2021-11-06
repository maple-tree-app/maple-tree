export function isDarkDefaultTheme(): boolean {
  return window.matchMedia("(prefers-color-scheme: dark)").matches;
}

export function isAutoThemeSet(): boolean {
  return document.body.classList.contains('auto');
}

export function doesAutoThemeResultInDarkUi(): boolean {
  return isDarkDefaultTheme() && isAutoThemeSet();
}

export function isDarkThemeActive(): boolean {
  if (document.body.classList.contains('dark')) return true;
  if (localStorage.getItem('theme') == 'light') return false;
  
  return doesAutoThemeResultInDarkUi();
}
