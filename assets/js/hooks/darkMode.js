let body;
export default {
  mounted() {
    [body] = document.getElementsByTagName('body');
    this.el.addEventListener('click', () => this.setThemeIfAllowed());
  },


  setThemeIfAllowed() {
    if(!body.classList.contains('auto')) {
      body.classList.toggle('dark');
    }
  }
}