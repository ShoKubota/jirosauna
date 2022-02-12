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
        'dark-blue': '#0094D3',
        'main-blue': '#009fed',
        'accent-yellow': '#FAF000',
        'dark-yellow': '#ffd100'
      },
      backgroundImage: {
        'main-img-1': "url('/app/assets/images/main_background_1.jpg')",
        'main-img-2': "url('/app/assets/images/main_background_2.jpg')",
        'main-img-3': "url('/app/assets/images/main_background_3.jpg')"
      },
      spacing: {
        'sidebar': '500px'
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}