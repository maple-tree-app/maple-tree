export function isDarkDefaultTheme() {
  return window.matchMedia("(prefers-color-scheme: dark)").matches;
}

export function isAutoThemeSet() {
  return document.body.classList.contains('auto');
}

export function doesAutoThemeResultInDarkUi() {
  return isDarkDefaultTheme() && isAutoThemeSet();
}

export function isDarkThemeActive() {
  if (document.body.classList.contains('dark')) return true;
  if (localStorage.getItem('theme') == 'light') return false;
  
  return doesAutoThemeResultInDarkUi();
}