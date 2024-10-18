// This config is adapted from https://github.com/microsoft/typespec/blob/main/.prettierrc.json
// See eng/README.md for context.
/**
 * @see https://prettier.io/docs/en/configuration.html
 * @type {import("prettier").Config}
 */
const config = {
  arrowParens: "always",
  trailingComma: "es5",
  bracketSpacing: true,
  endOfLine: "lf",
  printWidth: 100,
  semi: true,
  singleQuote: false,
  tabWidth: 2,
};

export default config;
