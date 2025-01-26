import parser from "yaml-eslint-parser";
import { NamedESLint } from "./interfaces/named-eslint.js";
import tspconfigValidationRules from "./rules/tspconfig-validation-rules.js";

const plugin: NamedESLint.Plugin = {
  configs: { recommended: {} },
  name: "tsv",
  rules: {},
};

plugin.configs.recommended = {
  plugins: {
    [plugin.name]: plugin,
  },
  files: ["*.yaml", "**/*.yaml"],
  rules: {},
  languageOptions: {
    parser: parser,
  },
};

tspconfigValidationRules.forEach((rule) => {
  plugin.rules![rule.name] = rule;
  plugin.configs.recommended.rules![`${plugin.name}/${rule.name}`] = "error";
});

export default plugin;
