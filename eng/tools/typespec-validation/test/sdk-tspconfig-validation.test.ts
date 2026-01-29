/* eslint-disable */
// TODO: Enable eslint, fix errors

import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";

import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { strictEqual } from "node:assert";
import { join } from "path";
import { stringify } from "yaml";
import {
  SdkTspConfigValidationRule,
  TspConfigCommonAzServiceDirMatchPatternSubRule,
  TspConfigCsharpDpEmitterOutputDirSubRule,
  TspConfigCsharpDpNamespaceSubRule,
  TspConfigCsharpMgmtEmitterOutputDirSubRule,
  TspConfigCsharpMgmtNamespaceSubRule,
  TspConfigGoDpContainingModuleMatchPatternSubRule,
  TspConfigGoDpEmitterOutputDirMatchPatternSubRule,
  TspConfigGoDpModuleMatchPatternSubRule,
  TspConfigGoDpServiceDirMatchPatternSubRule,
  TspConfigGoMgmtContainingModuleMatchPatternSubRule,
  TspConfigGoMgmtEmitterOutputDirMatchPatternSubRule,
  TspConfigGoMgmtGenerateFakesTrueSubRule,
  TspConfigGoMgmtGenerateSamplesTrueSubRule,
  TspConfigGoMgmtHeadAsBooleanTrueSubRule,
  TspConfigGoMgmtInjectSpansTrueSubRule,
  TspConfigGoMgmtModuleMatchPatternSubRule,
  TspConfigGoMgmtServiceDirMatchPatternSubRule,
  TspConfigJavaAzEmitterOutputDirMatchPatternSubRule,
  TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule,
  TspConfigJavaMgmtNamespaceFormatSubRule,
  TspConfigPythonDpEmitterOutputDirSubRule,
  TspConfigPythonMgmtEmitterOutputDirSubRule,
  TspConfigPythonMgmtNamespaceSubRule,
  TspConfigPythonMgmtPackageGenerateSampleTrueSubRule,
  TspConfigPythonMgmtPackageGenerateTestTrueSubRule,
  TspConfigPythonNamespaceMatchesEmitterOutputDirSubRule,
  TspConfigRustAzEmitterOutputDirSubRule,
  TspconfigSubRuleBase,
  TspConfigTsDpEmitterOutputDirSubRule,
  TspConfigTsMgmtModularEmitterOutputDirSubRule,
  TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule,
  TspConfigTsMgmtModularPackageNameMatchPatternSubRule,
  TspConfigTsMlcDpPackageNameMatchPatternSubRule,
  TspConfigTsRlcDpPackageNameMatchPatternSubRule,
} from "../src/rules/sdk-tspconfig-validation.js";

import * as utils from "../src/utils.js";

export function createParameterExample(...pairs: { key: string; value: string | boolean | {} }[]) {
  const obj: Record<string, any> = { parameters: {} };
  for (const pair of pairs) {
    obj.parameters[pair.key] = { default: pair.value };
  }
  const content = stringify(obj);
  return content;
}

export function createEmitterOptionExample(
  emitter: string,
  ...pairs: { key: string; value: string | boolean | {} }[]
) {
  const obj = { options: { [emitter]: {} } };
  for (const pair of pairs) {
    const segments = pair.key.split(".");
    let cur: Record<string, any> = obj.options[emitter];
    for (const [i, segment] of segments.entries()) {
      if (i === segments.length - 1) {
        cur[segment] = pair.value;
        break;
      }
      if (!(segment in cur)) {
        cur[segment] = {};
      }
      cur = cur[segment];
    }
  }
  const content = stringify(obj);
  return content;
}

function createParameterTestCases(
  folder: string,
  key: string,
  validValue: boolean | string,
  invalidValue: boolean | string,
  subRules: TspconfigSubRuleBase[],
  additionalOptions: Record<string, string | boolean> = {},
): Case[] {
  const cases: Case[] = [
    {
      description: `Validate parameter ${key} with valid value ${validValue}`,
      folder,
      tspconfigContent: createParameterExample({ key: key, value: validValue }),
      success: true,
      subRules,
      additionalOptions,
    },
    {
      description: `Validate parameter ${key} with invalid value ${invalidValue}`,
      folder,
      tspconfigContent: createParameterExample({ key: key, value: invalidValue }),
      success: false,
      subRules,
      additionalOptions,
    },
    {
      description: `Validate parameter ${key} with undefined value`,
      folder,
      tspconfigContent: "",
      success: false,
      subRules,
      additionalOptions,
    },
  ];
  return cases;
}

function createEmitterOptionTestCases(
  emitterName: string,
  folder: string,
  key: string,
  validValue: boolean | string,
  invalidValue: boolean | string,
  subRules: TspconfigSubRuleBase[],
  allowUndefined: boolean = false,
  additionalOptions: Record<string, string | boolean> = {},
): Case[] {
  const cases: Case[] = [];

  const language = emitterName.split("-").pop();
  cases.push({
    description: `Validate ${language}'s option:${key} with valid value ${validValue}`,
    folder,
    tspconfigContent: createEmitterOptionExample(
      emitterName,
      { key: key, value: validValue },
      ...Object.entries(additionalOptions).map(([key, value]) => ({ key, value })),
    ),
    success: true,
    subRules,
  });

  cases.push({
    description: `Validate ${language}'s option:${key} with invalid value ${invalidValue}`,
    folder,
    tspconfigContent: createEmitterOptionExample(
      emitterName,
      {
        key: key,
        value: invalidValue,
      },
      ...Object.entries(additionalOptions).map(([key, value]) => ({ key, value })),
    ),
    success: false,
    subRules,
  });

  cases.push({
    description: `Validate ${language}'s option:${key} with undefined value`,
    folder,
    tspconfigContent: createEmitterOptionExample(
      emitterName,
      ...Object.entries(additionalOptions).map(([key, value]) => ({ key, value })),
    ),
    success: allowUndefined ? true : false,
    subRules,
  });

  if (!allowUndefined && key.includes(".")) {
    cases.push({
      description: `Validate ${language}'s option:${key} with incomplete key`,
      folder,
      tspconfigContent: createEmitterOptionExample(
        emitterName,
        {
          key: key.split(".").slice(0, -1).join("."),
          value: validValue,
        },
        ...Object.entries(additionalOptions).map(([key, value]) => ({ key, value })),
      ),
      success: false,
      subRules,
    });
  }
  return cases;
}

interface Case {
  description: string;
  folder: string;
  subRules: TspconfigSubRuleBase[];
  tspconfigContent: string;
  success: boolean;
  ignoredKeyPaths?: string[];
  additionalOptions?: Record<string, string | boolean>;
}

const managementTspconfigFolder = "contosowidgetmanager/Contoso.Management/";

const commonAzureServiceDirTestCases = createParameterTestCases(
  "",
  "service-dir",
  "sdk/aaa",
  "sdka/aaa",
  [new TspConfigCommonAzServiceDirMatchPatternSubRule()],
);

const commonAzureServiceDirWithOutputDirTestCases = createParameterTestCases(
  "",
  "service-dir",
  "{output-dir}/sdk/aaa",
  "{output-dir}/sdka/aaa",
  [new TspConfigCommonAzServiceDirMatchPatternSubRule()],
);

const tsManagementExperimentalExtensibleEnumsTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "experimental-extensible-enums",
  true,
  false,
  [new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule()],
);

const tsManagementEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "emitter-output-dir",
  "{output-dir}/{service-dir}/arm-aaa-bbb",
  "{output-dir}/{service-dir}/aaa-bbb",
  [new TspConfigTsMgmtModularEmitterOutputDirSubRule()],
);

const tsManagementPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "package-details.name",
  "@azure/arm-aaa-bbb",
  "@azure/aaa-bbb",
  [new TspConfigTsMgmtModularPackageNameMatchPatternSubRule()],
);

const tsDpEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  "",
  "emitter-output-dir",
  "{output-dir}/{service-dir}/arm-aaa-rest",
  "{output-dir}/{service-dir}/aaa--rest",
  [new TspConfigTsDpEmitterOutputDirSubRule()],
  false,
  { "is-modular-library": false },
);

const tsDpPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  "",
  "package-details.name",
  "@azure-rest/aaa-bbb",
  "@azure/aaa-bbb",
  [new TspConfigTsRlcDpPackageNameMatchPatternSubRule()],
  false,
  { "is-modular-library": false },
);

const tsDpModularPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  "",
  "package-details.name",
  "@azure/aaa-bbb",
  "azure/aaa-bbb",
  [new TspConfigTsMlcDpPackageNameMatchPatternSubRule()],
  false,
  { "is-modular-library": true }, // Additional option added
);

const goManagementServiceDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "service-dir",
  "sdk/resourcemanager/aaa",
  "sdk/manager/aaa",
  [new TspConfigGoMgmtServiceDirMatchPatternSubRule()],
  true,
);

const goManagementEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "emitter-output-dir",
  "{output-dir}/{service-dir}/armcompute",
  "{output-dir}/{service-dir}/azsystemevents",
  [new TspConfigGoMgmtEmitterOutputDirMatchPatternSubRule()],
);

const goManagementModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "module",
  "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute",
  "github.com/Azure/azure-sdk-for-java/sdk/compute/arm-compute",
  [new TspConfigGoMgmtModuleMatchPatternSubRule()],
  false,
);

const goManagementContainingModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "containing-module",
  "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute",
  "github.com/Azure/azure-sdk-for-java/sdk/compute/arm-compute",
  [new TspConfigGoMgmtContainingModuleMatchPatternSubRule()],
  false,
);

const goManagementGenerateExamplesTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "generate-samples",
  true,
  false,
  [new TspConfigGoMgmtGenerateSamplesTrueSubRule()],
);

const goManagementGenerateFakesTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "generate-fakes",
  true,
  false,
  [new TspConfigGoMgmtGenerateFakesTrueSubRule()],
);

const goManagementHeadAsBooleanTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "head-as-boolean",
  true,
  false,
  [new TspConfigGoMgmtHeadAsBooleanTrueSubRule()],
);

const goManagementInjectSpansTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "inject-spans",
  true,
  false,
  [new TspConfigGoMgmtInjectSpansTrueSubRule()],
);

const goDpModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "module",
  "github.com/Azure/azure-sdk-for-go/sdk/messaging/aaa",
  "github.com/Azure/azure-sdk-for-cpp/bbb",
  [new TspConfigGoDpModuleMatchPatternSubRule()],
);

const goDpContainingModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "containing-module",
  "github.com/Azure/azure-sdk-for-go/sdk/messaging/aaa",
  "github.com/Azure/azure-sdk-for-cpp/bbb",
  [new TspConfigGoDpContainingModuleMatchPatternSubRule()],
  false,
);

const goDpEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "emitter-output-dir",
  "{output-dir}/{service-dir}/azsystemevents",
  "{output-dir}/{service-dir}/armcompute",
  [new TspConfigGoDpEmitterOutputDirMatchPatternSubRule()],
);

const goDpServiceDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "service-dir",
  "sdk/2/3",
  "sd/k",
  [new TspConfigGoDpServiceDirMatchPatternSubRule()],
  true,
);

const javaAzEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-java",
  "",
  "emitter-output-dir",
  "{output-dir}/{service-dir}/azure-aaa",
  "{output-dir}/{service-dir}/aaa",
  [new TspConfigJavaAzEmitterOutputDirMatchPatternSubRule()],
  false,
);

const javaMgmtEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-java",
  managementTspconfigFolder,
  "emitter-output-dir",
  "{output-dir}/{service-dir}/azure-resourcemanager-aaa-bbb",
  "{output-dir}/{service-dir}/azure-aaa",
  [new TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule()],
  false,
);

const javaMgmtNamespaceTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-java",
  managementTspconfigFolder,
  "namespace",
  "com.azure.resourcemanager.compute",
  "com.azure.compute", // Invalid: missing "resourcemanager"
  [new TspConfigJavaMgmtNamespaceFormatSubRule()],
);

const javaMgmtNamespaceExtendedTestCases: Case[] = [
  {
    description: "Validate Java management namespace with numbers",
    folder: managementTspconfigFolder,
    tspconfigContent: createEmitterOptionExample("@azure-tools/typespec-java", {
      key: "namespace",
      value: "com.azure.resourcemanager.storage2024",
    }),
    success: true,
    subRules: [new TspConfigJavaMgmtNamespaceFormatSubRule()],
  },
  {
    description: "Validate Java management namespace with underscores",
    folder: managementTspconfigFolder,
    tspconfigContent: createEmitterOptionExample("@azure-tools/typespec-java", {
      key: "namespace",
      value: "com.azure.resourcemanager.storage_v2",
    }),
    success: true,
    subRules: [new TspConfigJavaMgmtNamespaceFormatSubRule()],
  },
  {
    description: "Validate Java management namespace with 5 segments",
    folder: managementTspconfigFolder,
    tspconfigContent: createEmitterOptionExample("@azure-tools/typespec-java", {
      key: "namespace",
      value: "com.azure.resourcemanager.storage.blob",
    }),
    success: true,
    subRules: [new TspConfigJavaMgmtNamespaceFormatSubRule()],
  },
  {
    description: "Validate Java management namespace with 6 segments",
    folder: managementTspconfigFolder,
    tspconfigContent: createEmitterOptionExample("@azure-tools/typespec-java", {
      key: "namespace",
      value: "com.azure.resourcemanager.network.security.rules",
    }),
    success: true,
    subRules: [new TspConfigJavaMgmtNamespaceFormatSubRule()],
  },
  {
    description:
      "Validate Java management namespace with numbers and underscores in multiple segments",
    folder: managementTspconfigFolder,
    tspconfigContent: createEmitterOptionExample("@azure-tools/typespec-java", {
      key: "namespace",
      value: "com.azure.resourcemanager.storage_v2.blob_2024",
    }),
    success: true,
    subRules: [new TspConfigJavaMgmtNamespaceFormatSubRule()],
  },
  {
    description: "Validate Java management namespace with invalid special characters",
    folder: managementTspconfigFolder,
    tspconfigContent: createEmitterOptionExample("@azure-tools/typespec-java", {
      key: "namespace",
      value: "com.azure.resourcemanager.storage@blob",
    }),
    success: false,
    subRules: [new TspConfigJavaMgmtNamespaceFormatSubRule()],
  },
];

const pythonManagementEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "emitter-output-dir",
  "{output-dir}/{service-dir}/azure-mgmt-aaa",
  "{output-dir}/{service-dir}/azure-aaa",
  [new TspConfigPythonMgmtEmitterOutputDirSubRule()],
);

const pythonManagementNamespaceTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "namespace",
  "azure.mgmt.aaa",
  "azure-aaa",
  [new TspConfigPythonMgmtNamespaceSubRule()],
);

const pythonManagementNamespaceDerivedTestCases: Case[] = [
  {
    description: "Validate Python namespace derived from emitter-output-dir",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-python":
    namespace: "azure.mgmt.compute"
    emitter-output-dir: "{output-dir}/{service-dir}/azure-mgmt-compute"
`,
    success: true,
    subRules: [new TspConfigPythonNamespaceMatchesEmitterOutputDirSubRule()],
  },
  {
    description:
      "Validate Python namespace derived from emitter-output-dir with namespace variable",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-python":
    namespace: "azure.mgmt.storage"
    emitter-output-dir: "{output-dir}/{service-dir}/{namespace}"
`,
    success: true,
    subRules: [new TspConfigPythonNamespaceMatchesEmitterOutputDirSubRule()],
  },
  {
    description: "Invalidate Python namespace when derived value mismatches",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-python":
    namespace: "azure.mgmt.mismatch"
    emitter-output-dir: "{output-dir}/{service-dir}/azure-mgmt-compute"
`,
    success: false,
    subRules: [new TspConfigPythonNamespaceMatchesEmitterOutputDirSubRule()],
  },
  {
    description: "Skip Python namespace derivation rule for data plane",
    folder: "",
    tspconfigContent: `
options:
  "@azure-tools/typespec-python":
    namespace: "azure.mgmt.mismatch"
    emitter-output-dir: "{output-dir}/{service-dir}/azure-mgmt-compute"
`,
    success: true,
    subRules: [new TspConfigPythonNamespaceMatchesEmitterOutputDirSubRule()],
  },
];

const pythonManagementGenerateTestTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "generate-test",
  true,
  false,
  [new TspConfigPythonMgmtPackageGenerateTestTrueSubRule()],
);

const pythonManagementGenerateSampleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "generate-sample",
  true,
  false,
  [new TspConfigPythonMgmtPackageGenerateSampleTrueSubRule()],
);

const pythonDpEmitterOutputTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  "",
  "emitter-output-dir",
  "{output-dir}/{service-dir}/azure-aaa-bbb-ccc",
  "{output-dir}/{service-dir}/azure-aa-b-c-d",
  [new TspConfigPythonDpEmitterOutputDirSubRule()],
);

const csharpDpNamespaceTestCases = createEmitterOptionTestCases(
  "@azure-typespec/http-client-csharp",
  "",
  "namespace",
  "Azure.AI.Vision.Face",
  "AI.Vision.Face",
  [new TspConfigCsharpDpNamespaceSubRule()],
);

const csharpDpEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-typespec/http-client-csharp",
  "",
  "emitter-output-dir",
  "{output-dir}/{service-dir}/Azure.AI.Vision.Face",
  "{output-dir}/{service-dir}/AI.Vision.Face",
  [new TspConfigCsharpDpEmitterOutputDirSubRule()],
);

const csharpMgmtNamespaceTestCases = createEmitterOptionTestCases(
  "@azure-typespec/http-client-csharp-mgmt",
  managementTspconfigFolder,
  "namespace",
  "Azure.ResourceManager.compute",
  "Azure.compute", // Invalid: missing "resourcemanager"
  [new TspConfigCsharpMgmtNamespaceSubRule()],
);

const csharpMgmtEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-typespec/http-client-csharp-mgmt",
  managementTspconfigFolder,
  "emitter-output-dir",
  "{output-dir}/{service-dir}/Azure.ResourceManager.compute",
  "{output-dir}/{service-dir}/ResourceManager.compute", // Invalid: missing "Azure."
  [new TspConfigCsharpMgmtEmitterOutputDirSubRule()],
);

// Test cases for emitter-output-dir with namespace variable resolution
const emitterOutputDirWithNamespaceVariableTestCases: Case[] = [
  {
    description: "Validate Python emitter-output-dir with {namespace} variable",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-python":
    namespace: "azure.mgmt.testservice"
    emitter-output-dir: "{output-dir}/{service-dir}/{namespace}"
`,
    success: true,
    subRules: [new TspConfigPythonMgmtEmitterOutputDirSubRule()],
  },
  {
    description: "Validate Java emitter-output-dir with {namespace} variable",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-java":
    namespace: "com.azure.resourcemanager.testservice"
    emitter-output-dir: "{output-dir}/{service-dir}/{namespace}"
`,
    success: false,
    subRules: [new TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule()],
  },
  {
    description: "Validate emitter-output-dir with undefined variable",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-java":
    emitter-output-dir: "{output-dir}/{service-dir}/{undefinedVariable}"
`,
    success: false,
    subRules: [new TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule()],
  },
  {
    description: "Validate http-client-csharp namespace with {package-name} variable",
    folder: "",
    tspconfigContent: `
  options:
    "@azure-typespec/http-client-csharp":
      package-name: "Azure.MyService"
      namespace: "{package-name}"
  `,
    success: true,
    subRules: [new TspConfigCsharpDpNamespaceSubRule()],
  },
  {
    description: "Validate http-client-csharp namespace with invalid {package-name} variable value",
    folder: "",
    tspconfigContent: `
options:
  "@azure-typespec/http-client-csharp":
    package-name: "MyService"
    namespace: "{package-name}"
`,
    success: false,
    subRules: [new TspConfigCsharpDpNamespaceSubRule()],
  },
  {
    description: "Validate http-client-csharp-mgmt emitter-output-dir with {package-name} variable",
    folder: managementTspconfigFolder,
    tspconfigContent: `
  options:
    "@azure-typespec/http-client-csharp-mgmt":
      package-name: "Azure.ResourceManager.MyService"
      emitter-output-dir: "{output-dir}/{service-dir}/{package-name}"
  `,
    success: true,
    subRules: [new TspConfigCsharpMgmtEmitterOutputDirSubRule()],
  },
  {
    description:
      "Validate http-client-csharp-mgmt recursive variable resolution (namespace -> package-name)",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-typespec/http-client-csharp-mgmt":
    package-name: "Azure.ResourceManager.Compute.Recommender"
    namespace: "{package-name}"
    emitter-output-dir: "{output-dir}/{service-dir}/{namespace}"
`,
    success: true,
    subRules: [new TspConfigCsharpMgmtEmitterOutputDirSubRule()],
  },
  {
    description:
      "Validate http-client-csharp-mgmt emitter-output-dir with custom service-dir and recursive variable resolution",
    folder: managementTspconfigFolder,
    tspconfigContent: `
  options:
    "@azure-typespec/http-client-csharp-mgmt":
      package-name: "Azure.ResourceManager.Compute.Recommender"
      namespace: "{package-name}"
      emitter-output-dir: "{output-dir}/sdk/dellstorage/{namespace}"
  `,
    success: true,
    subRules: [new TspConfigCsharpMgmtEmitterOutputDirSubRule()],
  },
  {
    description:
      "Validate http-client-csharp-mgmt emitter-output-dir fails when last segment is invalid",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-typespec/http-client-csharp-mgmt":
    namespace: "Azure.ResourceManager.Dell.Storage"
    emitter-output-dir: "{output-dir}/sdk/dellstorage/Dell.Storage"
`,
    success: false,
    subRules: [new TspConfigCsharpMgmtEmitterOutputDirSubRule()],
  },
];

const optionalRulesWithoutEmitterConfigTestCases: Case[] = [
  {
    description: "Optional rule: should be skipped when emitter is not configured",
    folder: managementTspconfigFolder,
    tspconfigContent: `
parameters:
  service-dir: "sdk/test"
`,
    success: true,
    subRules: [new TspConfigJavaMgmtNamespaceFormatSubRule()],
  },
  {
    description: "Optional rule: multiple rules should be skipped when emitter is not configured",
    folder: managementTspconfigFolder,
    tspconfigContent: `
parameters:
  service-dir: "sdk/test"
`,
    success: true,
    subRules: [
      new TspConfigJavaMgmtNamespaceFormatSubRule(),
      new TspConfigTsRlcDpPackageNameMatchPatternSubRule(),
      new TspConfigGoDpEmitterOutputDirMatchPatternSubRule(),
      new TspConfigGoDpModuleMatchPatternSubRule(),
      new TspConfigGoDpContainingModuleMatchPatternSubRule(),
    ],
  },
];

const optionalRulesWithEmitterConfigTestCases: Case[] = [
  {
    description:
      "Validate Go DP emitter-output-dir should fail when not defined (emitter configured with model)",
    folder: "",
    tspconfigContent: `
options:
  "@azure-tools/typespec-go":
    model: "a"
`,
    success: false,
    subRules: [new TspConfigGoDpEmitterOutputDirMatchPatternSubRule()],
  },
  {
    description:
      "Validate Go Mgmt Module should fail when not defined (emitter configured with model)",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-go":
    model: "a"
`,
    success: false,
    subRules: [new TspConfigGoMgmtModuleMatchPatternSubRule()],
  },
  {
    description:
      "Validate Go Mgmt Containing Module should fail when not defined (emitter configured with model)",
    folder: managementTspconfigFolder,
    tspconfigContent: `
options:
  "@azure-tools/typespec-go":
    model: "a"
`,
    success: false,
    subRules: [new TspConfigGoMgmtContainingModuleMatchPatternSubRule()],
  },
];

const suppressEntireRuleTestCase: Case = {
  description: "Suppress entire rule",
  folder: managementTspconfigFolder,
  subRules: [new TspConfigCommonAzServiceDirMatchPatternSubRule()],
  tspconfigContent: `
parameters:
service-dir-x: ""
`,
  success: true,
  ignoredKeyPaths: [],
};

const suppressSubRuleTestCases: Case[] = [
  {
    description: "Suppress parameter",
    folder: managementTspconfigFolder,
    subRules: [new TspConfigCommonAzServiceDirMatchPatternSubRule()],
    tspconfigContent: `
parameters:
  service-dir-x: ""
`,
    success: true,
    ignoredKeyPaths: ["parameters.service-dir.default"],
  },
  {
    description: "Suppress option",
    folder: managementTspconfigFolder,
    subRules: [new TspConfigTsMgmtModularEmitterOutputDirSubRule()],
    tspconfigContent: `
options:
  "@azure-tools/typespec-ts":
    emitter-output-dir: "*@#$%(@)*$#@!()#*&"
`,
    success: true,
    ignoredKeyPaths: ["options.@azure-tools/typespec-ts.emitter-output-dir"],
  },
  {
    description: "Suppress option with wildcard at the end",
    folder: managementTspconfigFolder,
    subRules: [
      new TspConfigGoMgmtEmitterOutputDirMatchPatternSubRule(),
      new TspConfigGoDpModuleMatchPatternSubRule(),
    ],
    tspconfigContent: `
options:
  "@azure-tools/typespec-go":
    emitter-output-dir: "wrong/directory"
    module: "invalid-module"
`,
    success: true,
    ignoredKeyPaths: ["options.@azure-tools/typespec-go.*"],
  },
];

const rushEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-rust",
  managementTspconfigFolder,
  "emitter-output-dir",
  "{output-dir}/{service-dir}/{crate-name}",
  "{output-dir}/{service-dir}/aaa-bbb",
  [new TspConfigRustAzEmitterOutputDirSubRule()],
);

describe("tspconfig", function () {
  let fileExistsSpy: MockInstance;
  let readTspConfigSpy: MockInstance;

  beforeEach(() => {
    fileExistsSpy = vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    readTspConfigSpy = vi.spyOn(utils, "readTspConfig").mockResolvedValue(contosoTspConfig);
  });

  afterEach(() => {
    fileExistsSpy.mockReset();
    readTspConfigSpy.mockReset();
  });

  const requiredTestCases = [
    // common
    ...commonAzureServiceDirTestCases,
    ...commonAzureServiceDirWithOutputDirTestCases,
    // ts
    ...tsManagementExperimentalExtensibleEnumsTestCases,
    ...tsManagementEmitterOutputDirTestCases,
    ...tsManagementPackageNameTestCases,
    ...tsDpEmitterOutputDirTestCases,
    ...tsDpPackageNameTestCases,
    ...tsDpModularPackageNameTestCases,
    // go
    ...goManagementServiceDirTestCases,
    ...goManagementEmitterOutputDirTestCases,
    ...goManagementModuleTestCases,
    ...goManagementContainingModuleTestCases,
    ...goManagementGenerateExamplesTestCases,
    ...goManagementGenerateFakesTestCases,
    ...goManagementHeadAsBooleanTestCases,
    ...goManagementInjectSpansTestCases,
    // java
    ...javaAzEmitterOutputDirTestCases,
    ...javaMgmtEmitterOutputDirTestCases,
    ...javaMgmtNamespaceTestCases,
    ...javaMgmtNamespaceExtendedTestCases,
    // python
    ...pythonManagementEmitterOutputDirTestCases,
    ...pythonManagementNamespaceTestCases,
    ...pythonManagementNamespaceDerivedTestCases,
    ...pythonManagementGenerateTestTestCases,
    ...pythonManagementGenerateSampleTestCases,
    ...pythonDpEmitterOutputTestCases,
    // variable resolution in emitter-output-dir
    ...emitterOutputDirWithNamespaceVariableTestCases,
  ];

  const optionalTestCases = [
    // Test cases for optional rules when emitter is not configured
    ...optionalRulesWithoutEmitterConfigTestCases,
    ...optionalRulesWithEmitterConfigTestCases,
    // csharp
    ...csharpDpNamespaceTestCases,
    ...csharpMgmtNamespaceTestCases,
    ...csharpDpEmitterOutputDirTestCases,
    ...csharpMgmtEmitterOutputDirTestCases,
    // go data plane
    ...goDpEmitterOutputDirTestCases,
    ...goDpServiceDirTestCases,
    ...goDpModuleTestCases,
    ...goDpContainingModuleTestCases,
    // rust
    ...rushEmitterOutputDirTestCases,
  ];

  it.each([...requiredTestCases, ...optionalTestCases])(`$description`, async (c: Case) => {
    readTspConfigSpy.mockImplementation(async (_folder: string) => c.tspconfigContent);
    vi.spyOn(utils, "getSuppressions").mockImplementation(async (_path: string) => [
      {
        tool: "TypeSpecValidation",
        paths: ["tspconfig.yaml"],
        reason: "Test reason",
        rules: ["NOT-SdkTspConfigValidation"],
        subRules: c.ignoredKeyPaths,
      },
    ]);

    fileExistsSpy.mockImplementation(async (file: string) => {
      return file === join(c.folder, "tspconfig.yaml");
    });

    // Determine if the subRules are in optional test cases
    const isOptional = optionalTestCases.some((tc) => tc === c);
    const rule = isOptional
      ? new SdkTspConfigValidationRule([], c.subRules as any)
      : new SdkTspConfigValidationRule(c.subRules, []);
    const result = await rule.execute(c.folder);
    strictEqual(result.success, c.success); // Verify the validation result matches the expected outcome
    if (c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation passed."), true);
    if (!c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation failed."), true);
  });

  it.each([...suppressSubRuleTestCases])(`$description`, async (c: Case) => {
    readTspConfigSpy.mockImplementation(async (_folder: string) => c.tspconfigContent);
    vi.spyOn(utils, "getSuppressions").mockImplementation(async (_path: string) => [
      {
        tool: "TypeSpecValidation",
        paths: ["tspconfig.yaml"],
        reason: "Test reason",
        rules: ["SdkTspConfigValidation"],
        subRules: c.ignoredKeyPaths,
      },
    ]);

    fileExistsSpy.mockImplementation(async (file: string) => {
      return file === join(c.folder, "tspconfig.yaml");
    });

    const rule = new SdkTspConfigValidationRule(c.subRules, []);
    const result = await rule.execute(c.folder);
    const returnSuccess = c.folder.includes(".Management") ? c.success : true;
    strictEqual(result.success, returnSuccess);
    if (c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation passed."), true);
    if (!c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation failed."), true);
  });

  it.each([suppressEntireRuleTestCase])(`$description`, async (c: Case) => {
    readTspConfigSpy.mockImplementation(async (_folder: string) => c.tspconfigContent);
    vi.spyOn(utils, "getSuppressions").mockImplementation(async (_path: string) => [
      {
        tool: "TypeSpecValidation",
        paths: ["tspconfig.yaml"],
        reason: "Test reason",
        rules: ["SdkTspConfigValidation"],
      },
    ]);

    fileExistsSpy.mockImplementation(async (file: string) => {
      return file === join(c.folder, "tspconfig.yaml");
    });

    const rule = new SdkTspConfigValidationRule(c.subRules, []);
    const result = await rule.execute(c.folder);
    strictEqual(result.success, true);
    strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation skipped."), true);
  });

  it("Tests wildcard suppression for multiple AWS connector services", async () => {
    // List of AWS connector service paths to test
    const awsServiceFolders = [
      "awsconnector/AccessAnalyzerAnalyzer.Management",
      "awsconnector/AcmCertificateSummary.Management",
      "awsconnector/ApiGatewayRestApi.Management",
      "awsconnector/ApiGatewayStage.Management",
      "awsconnector/AppSyncGraphqlApi.Management",
      "awsconnector/AutoScalingAutoScalingGroup.Management",
      "awsconnector/Awsconnector.Management",
    ];

    // Mock suppressions.yaml containing a wildcard path for awsconnector/*/tspconfig.yaml
    const suppressionsSpy = vi
      .spyOn(utils, "getSuppressions")
      .mockImplementation(async (_path: string) => [
        {
          tool: "TypeSpecValidation",
          paths: ["awsconnector/*/tspconfig.yaml"], // Single wildcard pattern to match all paths
          reason: "AWS Connector services have special requirements",
          rules: ["SdkTspConfigValidation"],
          subRules: ["parameters.service-dir.default"],
        },
      ]);

    // Test each AWS connector service path
    for (const awsServiceFolder of awsServiceFolders) {
      // Reset mocks for each service
      suppressionsSpy.mockClear();

      // Mock configuration content
      const tspconfigContent = `
parameters:
  service-dir: "${awsServiceFolder}"
`;

      // Setup mocks
      readTspConfigSpy.mockImplementation(async () => tspconfigContent);
      fileExistsSpy.mockImplementation(async (file: string) => {
        return file === join(awsServiceFolder, "tspconfig.yaml");
      });

      // Create validation rule and execute
      const rule = new SdkTspConfigValidationRule(
        [new TspConfigCommonAzServiceDirMatchPatternSubRule()],
        [],
      );
      const result = await rule.execute(awsServiceFolder);

      // Validate that validation passes for each service
      strictEqual(result.success, true, `Validation should pass for ${awsServiceFolder}`);
      strictEqual(
        result.stdOutput?.includes("[SdkTspConfigValidation]: validation passed."),
        true,
        `Output should indicate validation passed for ${awsServiceFolder}`,
      );

      // Verify suppressions were called with the correct path
      strictEqual(
        suppressionsSpy.mock.calls.some(
          (call) => call[0] === join(awsServiceFolder, "tspconfig.yaml"),
        ),
        true,
        `getSuppressions should be called with path ${join(awsServiceFolder, "tspconfig.yaml")}`,
      );
    }
  });
});
