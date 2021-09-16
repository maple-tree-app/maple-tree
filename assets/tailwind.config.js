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
        'maple-light-bg': '#E7EDF3',
        'maple-dark-border': '#A7AFB2',
        'maple-light-border': '#8f8f8f',
        'maple-dark-input-bg': '#474747',
        'maple-red': '#EF4343',
        'maple-yellow': '#FBAF0A',
        'maple-navbar-dark': '#3333',
        'maple-dark-toggle-bg': '#2222',
        'maple-dark-toggle-border': '#403f3f'
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
