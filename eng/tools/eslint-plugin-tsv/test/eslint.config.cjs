const eslintPluginTsv = require("../src/eslint-plugin-tsv.cjs");
const parser = require("yaml-eslint-parser");

module.exports = [
  {
    plugins: { tsv: eslintPluginTsv },
    files: ["*.yaml", "**/*.yaml"],
    languageOptions: {
      parser,
    },
    rules: {
      "tsv/enforce-foo-bar": "error",
    },
  },
];
