import kebabCaseOrg from "./kebab-case-org.js";

export const plugin = {
  rules: {
    [kebabCaseOrg.meta.name]: kebabCaseOrg,
  },
};

export default plugin;
