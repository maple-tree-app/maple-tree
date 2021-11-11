import { ViewHook } from 'phoenix_live_view';
import { isDarkThemeActive } from "../../helpers";

const body = document.body;
export const darkMode =  {
  mounted() {
    const checkboxes: HTMLInputElement[] = Array.from(this.el.querySelectorAll('.dark_theme_toggle_checkbox'));
    checkboxes.forEach(checkbox => {
      checkbox.checked = isDarkThemeActive();

      checkbox.addEventListener('change', () => {
        localStorage.setItem('theme', checkbox.checked ? 'dark' : 'light');
        setThemeIfAllowed();
        syncCheckboxes(checkbox, checkboxes);
      }
      );
    })
    
  },



}

  function setThemeIfAllowed() {
    body.classList.toggle('dark');
    body.classList.remove('auto')
  };

  function syncCheckboxes(checkbox: HTMLInputElement, checkboxes: HTMLInputElement[]) {
    checkboxes.filter(check => checkbox.id != check.id).map(check => check.checked = checkbox.checked);
  }
