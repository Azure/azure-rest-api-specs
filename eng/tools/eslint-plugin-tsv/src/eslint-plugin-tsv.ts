import parser from "yaml-eslint-parser";
import { NamedESLint } from "./named-eslint.js";
import kebabCaseOrg from "./rules/kebab-case-org.js";

const plugin: NamedESLint.Plugin = {
  configs: { recommended: {} },
  name: "tsv",
  rules: {
    [kebabCaseOrg.name]: kebabCaseOrg,
  },
};

plugin.configs.recommended = {
  plugins: {
    [plugin.name]: plugin,
  },
  files: ["*.yaml", "**/*.yaml"],
  rules: {
    [`${plugin.name}/${kebabCaseOrg.name}`]: "error",
  },
  languageOptions: {
    parser: parser,
  },
};

export default plugin;
