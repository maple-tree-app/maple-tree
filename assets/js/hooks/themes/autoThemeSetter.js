import { doesAutoThemeResultInDarkUi } from "../helpers";

export const autoThemeSetter = {
  mounted() {
    const [body] = document.getElementsByTagName('body');
    if (doesAutoThemeResultInDarkUi()) {
      body.classList.add('dark')
    }
  }
}