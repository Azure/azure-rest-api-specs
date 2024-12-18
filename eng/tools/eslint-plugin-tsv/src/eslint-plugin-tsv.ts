import kebabCaseOrg from "./rules/kebab-case-org.js";
import parser from "yaml-eslint-parser";

const pluginName = "tsv";

// TODO: Add types
export const plugin = {
  configs: { },
  rules: {
    [kebabCaseOrg.meta.name]: kebabCaseOrg,
  },
};

// assign configs here so we can reference `plugin`
Object.assign(plugin.configs, {
  recommended: [
    {
      plugins: {
        [pluginName]: plugin,
      },
      files: ["*.yaml", "**/*.yaml"],
      rules: {
        [`${pluginName}/${kebabCaseOrg.meta.name}`]: "error",
      },
      languageOptions: {
        parser: parser,
      },
    },
  ],
});

export default plugin;
