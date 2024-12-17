import eslintPluginTsv from "../../src/eslint-plugin-tsv.js";
import parser from "yaml-eslint-parser";

export const config = [
  {
    plugins: { tsv: eslintPluginTsv },
    files: ["*.yaml", "**/*.yaml"],
    languageOptions: {
      parser,
    },
    rules: {
      "tsv/enforce-foo-bar": "error",
      "tsv/kebab-case-first-path-segment": "error",
    },
  },
];

export default config;
