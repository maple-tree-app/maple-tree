export default {
  mounted() {
    const menu = document.getElementById('mobile-menu');
    this.el.addEventListener('click', () => {
      menu.classList.toggle('hidden');
    });
  }
}