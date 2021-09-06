export default {
  mounted() {
    const [body] = document.getElementsByTagName('body');
    if (body.classList.contains('auto') && window.matchMedia("(prefers-color-scheme: dark)").matches) {
      body.classList.add('dark')
    }
  }
}