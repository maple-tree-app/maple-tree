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
        'maple-white-bg': '#F1F1F1'
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
