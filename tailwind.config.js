module.exports = {
  mode: 'jit',
  purge: [
    './app/views/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'main-blue': '#0094D3',
        'accent-yellow': '#FAF000'
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}