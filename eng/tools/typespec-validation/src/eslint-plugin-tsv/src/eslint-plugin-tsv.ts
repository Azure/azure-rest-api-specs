import parser from "yaml-eslint-parser";
import { NamedESLint } from "./interfaces/named-eslint.js";
import emitAutorest from "./rules/emit-autorest.js";
import kebabCaseOrg from "./rules/kebab-case-org.js";
import tspconfigValidationRules from "./rules/tspconfig-validation-rules.js";

const plugin: NamedESLint.Plugin = {
  configs: { recommended: {} },
  name: "tsv",
  rules: {
    [kebabCaseOrg.name]: kebabCaseOrg,
    [emitAutorest.name]: emitAutorest,
  },
};

plugin.configs.recommended = {
  plugins: {
    [plugin.name]: plugin,
  },
  files: ["*.yaml", "**/*.yaml"],
  rules: {
    [`${plugin.name}/${kebabCaseOrg.name}`]: "error",
    [`${plugin.name}/${emitAutorest.name}`]: "error",
  },
  languageOptions: {
    parser: parser,
  },
};

tspconfigValidationRules.forEach((rule) => {
  plugin.rules![rule.name] = rule;
  plugin.configs.recommended.rules![`${plugin.name}/${rule.name}`] = "error";
});

export default plugin;
