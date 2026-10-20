import { createTypeSpecLibrary, defineLinter } from "@typespec/compiler";

export const $lib = createTypeSpecLibrary({
  name: "@azure-tools/typespec-azure-rulesets",
  diagnostics: {},
});

export const $linter = defineLinter({
  rules: [],
  ruleSets: {
    "data-plane": {
      extends: ["@azure-tools/typespec-azure-rulesets-original/data-plane"],
    },
    "resource-manager": {
      extends: ["@azure-tools/typespec-azure-rulesets-original/resource-manager"],
    },
    "client-sdk": {
      extends: ["@azure-tools/typespec-azure-rulesets-original/client-sdk"],
    },
  },
});
