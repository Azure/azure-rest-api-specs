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
      enable: {
        "@azure-tools/typespec-azure-core/list-operation-missing-200-response": true,
        "@azure-tools/typespec-azure-core/use-known-enum-default": true,
      },
    },
    "resource-manager": {
      extends: ["@azure-tools/typespec-azure-rulesets-original/resource-manager"],
      enable: {
        "@azure-tools/typespec-azure-core/list-operation-missing-200-response": true,
        "@azure-tools/typespec-azure-core/use-known-enum-default": true,
        "@azure-tools/typespec-azure-resource-manager/no-resource-duplicates": true,
        "@azure-tools/typespec-azure-resource-manager/use-model-request-body": true,
        "@azure-tools/typespec-azure-resource-manager/no-query-in-post": true,
      },
    },
    "client-sdk": {
      extends: ["@azure-tools/typespec-azure-rulesets-original/client-sdk"],
    },
  },
});
