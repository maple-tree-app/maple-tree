import { isDarkThemeActive } from "../helpers";

const body = document.body;
export const darkMode =  {
  mounted() {
    const checkboxes = Array.from(this.el.querySelectorAll('.dark_theme_toggle_checkbox'));

    checkboxes.forEach(checkbox => {
      checkbox.checked = isDarkThemeActive();

      checkbox.addEventListener('change', () => {
        localStorage.setItem('theme', checkbox.checked ? 'dark' : 'light');
        this.setThemeIfAllowed();
        this.syncCheckboxes(checkbox, checkboxes);
      }
      );
    })
    
  },


  setThemeIfAllowed() {
    body.classList.toggle('dark');
    body.classList.remove('auto')
  },

  syncCheckboxes(checkbox, checkboxes) {
    checkboxes.filter(check => checkbox.id != check.id).map(check => check.checked = checkbox.checked);
  }

}