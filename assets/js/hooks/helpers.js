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
  return doesAutoThemeResultInDarkUi() || document.body.classList.contains('dark');
}