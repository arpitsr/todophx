// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const colors = require("tailwindcss/colors");

module.exports = {
  mode: "jit",
  purge: ["./js/**/*.js", "../lib/*_web/**/*.*ex"],
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      p1: "#db4c3f",
      p2: "#eb8909",
      p3: "#246fe0",
      p4: "#666",
      p5: "#f45d48",
      p6: "#ef523c",
      black: colors.black,
      white: colors.white,
      gray: colors.gray,
      emerald: colors.emerald,
      indigo: colors.indigo,
      yellow: colors.yellow,
      red: colors.red,
      green: colors.green,
      purple: colors.purple,
      blue: colors.blue,
      pink: colors.pink,
      organge: colors.orange,
      teal: colors.teal,
      lime: colors.lime,
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
  ],
};
