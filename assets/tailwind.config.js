module.exports = {
  purge: [
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
    "./js/**/*.js"
  ],
  darkMode: 'class', // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'maple-dark-bg': '#212121',
        'maple-light-bg': '#F1F1F1',
        'maple-dark-border': '#8f8f8f',
        'maple-light-border': '#f2f2f2',
        'maple-dark-input-bg': '#474747',
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
