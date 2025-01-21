import { createManagementClientRule } from "../utils/rule.js";

const args: [string, string, string | boolean | RegExp, string | boolean, string | undefined][] = [
  // ts
  ["tspconfig-ts-mgmt-modular-generate-metadata-true", "generateMetadata", true, true, undefined],
  ["tspconfig-ts-mgmt-modular-hierarchy-client-false", "hierarchyClient", false, false, undefined],
  [
    "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
    "experimentalExtensibleEnums",
    true,
    true,
    undefined,
  ],
  [
    "tspconfig-ts-mgmt-modular-enable-operation-group-true",
    "enableOperationGroup",
    true,
    true,
    undefined,
  ],
  [
    "tspconfig-ts-mgmt-modular-package-dir-match-pattern",
    "package-dir",
    /^arm(?:-[a-z]+)+$/,
    "arm-aaa-bbb",
    "The package-dir should be a string that starts with 'arm' and is followed by one or more groups of a hyphen (-) and lowercase letters",
  ],
  [
    "tspconfig-ts-mgmt-modular-package-name-match-pattern",
    "packageDetails.name",
    /^\@azure\/arm(?:-[a-z]+)+$/,
    "@azure/arm-aaa-bbb",
    "The package name should be a string that starts with '@azure/arm' and is followed by one or more groups of a hyphen (-) and lowercase letters",
  ],
  // go
  [
    "tspconfig-go-mgmt-service-dir-match-pattern",
    "service-dir",
    /^sdk\/resourcemanager\/[^\/]*$/,
    "sdk/resourcemanager/aaa",
    "The service-dir should be a string that start with 'sdk/resourcemanager/' followed by any characters except '/', and end there",
  ],
  [
    "tspconfig-go-mgmt-package-dir-match-pattern",
    "package-dir",
    /^arm[^\/]*$/,
    "armaaa",
    "The package-dir should be a string that start with 'arm' and do not contain a forward slash (/) after it",
  ],
  [
    "tspconfig-go-mgmt-module-equal-string",
    "module",
    "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
    "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
    undefined,
  ],
  ["tspconfig-go-mgmt-fix-const-stuttering-true", "fix-const-stuttering", true, true, undefined],
  ["tspconfig-go-mgmt-generate-examples-true", "generate-examples", true, true, undefined],
  ["tspconfig-go-mgmt-generate-fakes-true", "generate-fakes", true, true, undefined],
  ["tspconfig-go-mgmt-head-as-boolean-true", "head-as-boolean", true, true, undefined],
  ["tspconfig-go-mgmt-inject-spans-true", "inject-spans", true, true, undefined],
];

export default args.map((a) => createManagementClientRule(...a));
