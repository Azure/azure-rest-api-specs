import { createTypeSpecLibrary, defineLinter } from "@typespec/compiler";

export const $lib = createTypeSpecLibrary({
  name: "@azure-tools/specs-typespec-rulesets",
  diagnostics: {},
});

export const $linter = defineLinter({
  rules: [],
  ruleSets: {
    "data-plane": {
      extends: ["@azure-tools/typespec-azure-rulesets/data-plane"],
    },
    "resource-manager": {
      extends: ["@azure-tools/typespec-azure-rulesets/resource-manager"],
    },
    "client-sdk": {
      extends: ["@azure-tools/typespec-azure-rulesets/client-sdk"],
    },
  },
});
