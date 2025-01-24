import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";
import { createCodeGenSDKRule, isManagementSDK } from "../utils/rule-creator.js";
import { emitters } from "../utils/constants.js";
import { CreateCodeGenSDKRuleArgs, KeyType } from "../interfaces/rule-interfaces.js";

const tsIsManagementCondition = (tspconfig: TypeSpecConfig, context: Rule.RuleContext) => {
  const emitterName = emitters.ts;
  const isModularLibrary = tspconfig.options?.[emitterName]?.isModularLibrary as
    | boolean
    | undefined;
  return isManagementSDK(context) && isModularLibrary !== false;
};

const args: CreateCodeGenSDKRuleArgs[] = [
  // common
  {
    rule: "tspconfig-common-az-service-dir-match-pattern",
    key: "service-dir",
    type: KeyType.Parameter,
    expectedValue: /^sdk\/[^\/]*$/,
    exampleValue: "sdk/aaa",
    extraExplanation:
      "The 'service-dir' should be a string that starts with 'sdk/', followed by zero or more characters that are not a '/', and ends there",
    condition: (_: TypeSpecConfig, _1: Rule.RuleContext) => true,
  },
  // ts
  {
    rule: "tspconfig-ts-mgmt-modular-generate-metadata-true",
    key: "generateMetadata",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: tsIsManagementCondition,
  },
  {
    rule: "tspconfig-ts-mgmt-modular-hierarchy-client-false",
    key: "hierarchyClient",
    type: KeyType.EmitterOption,
    expectedValue: false,
    exampleValue: false,
    condition: tsIsManagementCondition,
  },
  {
    rule: "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
    key: "experimentalExtensibleEnums",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: tsIsManagementCondition,
  },
  {
    rule: "tspconfig-ts-mgmt-modular-enable-operation-group-true",
    key: "enableOperationGroup",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: tsIsManagementCondition,
  },
  {
    rule: "tspconfig-ts-mgmt-modular-package-dir-match-pattern",
    key: "package-dir",
    type: KeyType.EmitterOption,
    expectedValue: /^arm(?:-[a-z]+)+$/,
    exampleValue: "arm-aaa-bbb",
    extraExplanation:
      "The 'package-dir' should be a string that starts with 'arm' and is followed by one or more groups of a hyphen (-) and lowercase letters",
    condition: tsIsManagementCondition,
  },
  {
    rule: "tspconfig-ts-mgmt-modular-package-name-match-pattern",
    key: "packageDetails.name",
    type: KeyType.EmitterOption,
    expectedValue: /^\@azure\/arm(?:-[a-z]+)+$/,
    exampleValue: "@azure/arm-aaa-bbb",
    extraExplanation:
      "The package name should be a string that starts with '@azure/arm' and is followed by one or more groups of a hyphen (-) and lowercase letters",
    condition: tsIsManagementCondition,
  },
  // go
  {
    rule: "tspconfig-go-mgmt-service-dir-match-pattern",
    key: "service-dir",
    type: KeyType.EmitterOption,
    expectedValue: /^sdk\/resourcemanager\/[^\/]*$/,
    exampleValue: "sdk/resourcemanager/aaa",
    extraExplanation:
      "The 'service-dir' should be a string that starts with 'sdk/resourcemanager/', followed by zero or more characters that are not a '/', and ends there",
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-go-mgmt-package-dir-match-pattern",
    key: "package-dir",
    type: KeyType.EmitterOption,
    expectedValue: /^arm[^\/]*$/,
    exampleValue: "armaaa",
    extraExplanation:
      "The 'package-dir' should be a string that starts with 'arm' and do not contain a forward slash (/) after it",
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-go-mgmt-module-equal-string",
    key: "module",
    type: KeyType.EmitterOption,
    expectedValue: "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
    exampleValue: "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-go-mgmt-fix-const-stuttering-true",
    key: "fix-const-stuttering",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-go-mgmt-generate-examples-true",
    key: "generate-examples",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-go-mgmt-generate-fakes-true",
    key: "generate-fakes",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-go-mgmt-head-as-boolean-true",
    key: "head-as-boolean",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-go-mgmt-inject-spans-true",
    key: "inject-spans",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  // java
  {
    rule: "tspconfig-java-az-package-dir-match-pattern",
    key: "package-dir",
    type: KeyType.EmitterOption,
    expectedValue: /^azure(-\w+)+$/,
    exampleValue: "azure-aaa",
    extraExplanation:
      "The 'package-dir' should be a string that starts with 'azure', followed by one or more '-<word>' segments. Each segment can contains letters, digits, or underscores",
    condition: (_: TypeSpecConfig, _1: Rule.RuleContext) => true,
  },
  // python
  {
    rule: "tspconfig-python-mgmt-package-dir-match-pattern",
    key: "package-dir",
    type: KeyType.EmitterOption,
    expectedValue: /^azure-mgmt(-[a-z]+){1,2}$/,
    exampleValue: "azure-mgmt-aaa",
    extraExplanation:
      "The 'package-dir' should be a string that starts with 'azure-mgmt', followed by 1 or 2 hyphen-separated lowercase alphabetic segments",
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-python-mgmt-package-name-equal-string",
    key: "package-name",
    type: KeyType.EmitterOption,
    expectedValue: "{package-dir}",
    exampleValue: "{package-dir}",
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-python-mgmt-generate-test-true",
    key: "generate-test",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  {
    rule: "tspconfig-python-mgmt-generate-sample-true",
    key: "generate-sample",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
  // csharp
  {
    rule: "tspconfig-csharp-az-package-dir-match-pattern",
    key: "package-dir",
    type: KeyType.EmitterOption,
    expectedValue: /^Azure\./,
    exampleValue: "Azure.aaa",
    extraExplanation: "The 'package-dir' should be a string that starts with 'Azure.'",
    condition: (_: TypeSpecConfig, _1: Rule.RuleContext) => true,
  },
  {
    rule: "tspconfig-csharp-az-namespace-equal-string",
    key: "namespace",
    type: KeyType.EmitterOption,
    expectedValue: "{package-dir}",
    exampleValue: "{package-dir}",
    condition: (_: TypeSpecConfig, _1: Rule.RuleContext) => true,
  },
  {
    rule: "tspconfig-csharp-az-clear-output-folder-true",
    key: "clear-output-folder",
    type: KeyType.EmitterOption,
    expectedValue: true,
    exampleValue: true,
    condition: (_: TypeSpecConfig, _1: Rule.RuleContext) => true,
  },
  {
    rule: "tspconfig-csharp-mgmt-package-dir-match-pattern",
    key: "package-dir",
    type: KeyType.EmitterOption,
    expectedValue: /^Azure\.ResourceManager\./,
    exampleValue: "Azure.ResourceManager.aaa",
    extraExplanation:
      "The 'package-dir' should be a string that starts with 'Azure.ResourceManager.'",
    condition: (_: TypeSpecConfig, context: Rule.RuleContext) => isManagementSDK(context),
  },
];

export default args.map((a) => createCodeGenSDKRule(a));
