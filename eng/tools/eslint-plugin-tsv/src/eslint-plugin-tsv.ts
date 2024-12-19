import { Linter } from "eslint";
import parser from "yaml-eslint-parser";
import { NamedESLint } from "./named-eslint.js";
import kebabCaseOrg from "./rules/kebab-case-org.js";

const plugin: NamedESLint.Plugin = {
  name: "tsv",
  rules: {
    [kebabCaseOrg.name]: kebabCaseOrg,
  },
};

const configs: Record<string, Linter.Config> = {
  recommended: {
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
  },
};

plugin.configs = configs;

export default plugin;
