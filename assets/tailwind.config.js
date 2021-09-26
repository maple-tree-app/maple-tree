var _ = require('lodash')
var flattenColorPalette = require('tailwindcss/lib/util/flattenColorPalette').default

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
    fontFamily: {
      'roboto': ['roboto', 'sans-serif']
    },
    extend: {
      colors: {
        'maple-dark-bg': '#252526',
        'maple-light-bg': '#f1f1f1f1',

        'maple-dark-border': '#A7AFB2',
        'maple-light-border': '#8f8f8f',

        'maple-dark-surface': '#2d2d30',
        'maple-light-surface': '#ffffff',

        'maple-dark-input-bg': '#474747',

        'maple-red': '#b22c2c',
        'maple-yellow': '#dea730',
        'maple-dark-toggle-bg': '#2222',
        'maple-dark-toggle-border': '#403f3f',

        'maple-success': '#4BB543',
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    function({ addUtilities, e, theme, variants }) {
      const colors = flattenColorPalette(theme('borderColor'))

      const utilities = _.flatMap(_.omit(colors, 'default'), (value, modifier) => ({
        [`.${e(`border-t-${modifier}`)}`]: { borderTopColor: `${value}` },
        [`.${e(`border-r-${modifier}`)}`]: { borderRightColor: `${value}` },
        [`.${e(`border-b-${modifier}`)}`]: { borderBottomColor: `${value}` },
        [`.${e(`border-l-${modifier}`)}`]: { borderLeftColor: `${value}` },
      }))

      addUtilities(utilities, variants('borderColor'))
    },

  ],
}
