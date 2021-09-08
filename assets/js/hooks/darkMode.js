let body;
export default {
  mounted() {
    [body] = document.getElementsByTagName('body');
    this.el.addEventListener('click', () => this.setThemeIfAllowed());
  },


  setThemeIfAllowed() {
    body.classList.toggle('dark');
  }
}