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
        "@azure-tools/typespec-azure-core/no-boolean": true,
      },
    },
    "resource-manager": {
      extends: ["@azure-tools/typespec-azure-rulesets-original/resource-manager"],
      enable: {
        "@azure-tools/typespec-azure-resource-manager/no-query-in-post": true,
        "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op": true,
        "@azure-tools/typespec-azure-resource-manager/no-query-in-collection": true,
        "@azure-tools/typespec-azure-resource-manager/use-application-json-content-type": true,
        "@azure-tools/typespec-azure-resource-manager/use-model-request-body": true,
        "@azure-tools/typespec-azure-resource-manager/list-operation-missing-pageable": true,
        "@azure-tools/typespec-azure-resource-manager/no-tenant-level-apis": true,
        "@azure-tools/typespec-azure-core/no-boolean": true,
      },
    },
    "client-sdk": {
      extends: ["@azure-tools/typespec-azure-rulesets-original/client-sdk"],
      enable: {
        "@azure-tools/typespec-client-generator-core/get-operation-name": true,
      },
    },
  },
});
