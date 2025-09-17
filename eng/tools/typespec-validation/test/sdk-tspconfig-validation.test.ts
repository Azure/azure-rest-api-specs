import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";

import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { strictEqual } from "node:assert";
import { join } from "path";
import { stringify } from "yaml";
import {
  SdkTspConfigValidationRule,
  TspConfigCommonAzServiceDirMatchPatternSubRule,
  TspConfigCsharpAzClearOutputFolderTrueSubRule,
  TspConfigCsharpAzNamespaceSubRule,
  TspConfigCsharpMgmtNamespaceSubRule,
  TspConfigGoAzInjectSpansTrueSubRule,
  TspConfigGoContainingModuleMatchPatternSubRule,
  TspConfigGoDpEmitterOutputDirMatchPatternSubRule,
  TspConfigGoDpServiceDirMatchPatternSubRule,
  TspConfigGoMgmtEmitterOutputDirMatchPatternSubRule,
  TspConfigGoMgmtGenerateFakesTrueSubRule,
  TspConfigGoMgmtGenerateSamplesTrueSubRule,
  TspConfigGoMgmtHeadAsBooleanTrueSubRule,
  TspConfigGoMgmtServiceDirMatchPatternSubRule,
  TspConfigGoModuleMatchPatternSubRule,
  TspConfigJavaAzEmitterOutputDirMatchPatternSubRule,
  TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule,
  TspConfigJavaMgmtNamespaceFormatSubRule,
  TspConfigPythonDpEmitterOutputDirSubRule,
  TspConfigPythonMgmtEmitterOutputDirSubRule,
  TspConfigPythonMgmtNamespaceSubRule,
  TspConfigPythonMgmtPackageGenerateSampleTrueSubRule,
  TspConfigPythonMgmtPackageGenerateTestTrueSubRule,
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

// TODO: remove when @azure-tools/typespec-csharp is ready for validating tspconfig
function shouldBeTrueOnFailSubRuleValidation(emitterName: string) {
  return emitterName === "@azure-tools/typespec-csharp" ? true : false;
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
    success: shouldBeTrueOnFailSubRuleValidation(emitterName),
    subRules,
  });

  cases.push({
    description: `Validate ${language}'s option:${key} with undefined value`,
    folder,
    tspconfigContent: createEmitterOptionExample(
      emitterName,
      ...Object.entries(additionalOptions).map(([key, value]) => ({ key, value })),
    ),
    success: allowUndefined ? true : shouldBeTrueOnFailSubRuleValidation(emitterName),
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
      success: shouldBeTrueOnFailSubRuleValidation(emitterName),
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

const tsManagementPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "emitter-output-dir",
  "arm-aaa-bbb",
  "aaa-bbb",
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

const tsDpPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  "",
  "emitter-output-dir",
  "arm-aaa-rest",
  "aaa--rest",
  [new TspConfigTsDpEmitterOutputDirSubRule()],
);

const tsDpPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  "",
  "package-details.name",
  "@azure-rest/aaa-bbb",
  "@azure/aaa-bbb",
  [new TspConfigTsRlcDpPackageNameMatchPatternSubRule()],
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
  [new TspConfigGoModuleMatchPatternSubRule()],
  false,
);

const goManagementContainingModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "containing-module",
  "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute",
  "github.com/Azure/azure-sdk-for-java/sdk/compute/arm-compute",
  [new TspConfigGoContainingModuleMatchPatternSubRule()],
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
  [new TspConfigGoAzInjectSpansTrueSubRule()],
);

const goDpInjectSpansTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "inject-spans",
  true,
  false,
  [new TspConfigGoAzInjectSpansTrueSubRule()],
);

const goDpModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "module",
  "github.com/Azure/azure-sdk-for-go/sdk/messaging/aaa",
  "github.com/Azure/azure-sdk-for-cpp/bbb",
  [new TspConfigGoModuleMatchPatternSubRule()],
  false,
);

const goDpContainingModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "containing-module",
  "github.com/Azure/azure-sdk-for-go/sdk/messaging/aaa",
  "github.com/Azure/azure-sdk-for-cpp/bbb",
  [new TspConfigGoContainingModuleMatchPatternSubRule()],
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
  "aaa",
  [new TspConfigJavaAzEmitterOutputDirMatchPatternSubRule()],
  true,
);

const javaMgmtEmitterOutputDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-java",
  managementTspconfigFolder,
  "emitter-output-dir",
  "{service-dir}/azure-resourcemanager-aaa-bbb",
  "azure-aaa",
  [new TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule()],
  true,
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

const pythonManagementPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "emitter-output-dir",
  "azure-mgmt-aaa",
  "azure-aaa",
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

const pythonDpPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  "",
  "emitter-output-dir",
  "azure-aaa-bbb-ccc",
  "azure-aa-b-c-d",
  [new TspConfigPythonDpEmitterOutputDirSubRule()],
);

const csharpAzNamespaceTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-csharp",
  "",
  "namespace",
  "Azure.AAA",
  "AAA",
  [new TspConfigCsharpAzNamespaceSubRule()],
);

const csharpAzClearOutputFolderTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-csharp",
  "",
  "clear-output-folder",
  true,
  false,
  [new TspConfigCsharpAzClearOutputFolderTrueSubRule()],
);

const csharpMgmtNamespaceTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-csharp",
  managementTspconfigFolder,
  "namespace",
  "Azure.ResourceManager.AAA",
  "Azure.Management.AAA",
  [new TspConfigCsharpMgmtNamespaceSubRule()],
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
      new TspConfigGoModuleMatchPatternSubRule(),
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

  it.each([
    // common
    ...commonAzureServiceDirTestCases,
    ...commonAzureServiceDirWithOutputDirTestCases,
    // ts
    ...tsManagementExperimentalExtensibleEnumsTestCases,
    ...tsManagementPackageDirTestCases,
    ...tsManagementPackageNameTestCases,
    ...tsDpPackageDirTestCases,
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
    ...goDpInjectSpansTestCases,
    ...goDpModuleTestCases,
    ...goDpContainingModuleTestCases,
    ...goDpEmitterOutputDirTestCases,
    ...goDpServiceDirTestCases,
    // java
    ...javaAzEmitterOutputDirTestCases,
    ...javaMgmtEmitterOutputDirTestCases,
    ...javaMgmtNamespaceTestCases,
    ...javaMgmtNamespaceExtendedTestCases,
    // python
    ...pythonManagementPackageDirTestCases,
    ...pythonManagementNamespaceTestCases,
    ...pythonManagementGenerateTestTestCases,
    ...pythonManagementGenerateSampleTestCases,
    ...pythonDpPackageDirTestCases,
    // csharp
    ...csharpAzNamespaceTestCases,
    ...csharpAzNamespaceTestCases,
    ...csharpAzClearOutputFolderTestCases,
    ...csharpMgmtNamespaceTestCases,
    // variable resolution in emitter-output-dir
    ...emitterOutputDirWithNamespaceVariableTestCases,
  ])(`$description`, async (c: Case) => {
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

    const rule = new SdkTspConfigValidationRule(c.subRules);
    const result = await rule.execute(c.folder);
    strictEqual(result.success, true);
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

    const rule = new SdkTspConfigValidationRule(c.subRules);
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

    const rule = new SdkTspConfigValidationRule(c.subRules);
    const result = await rule.execute(c.folder);
    strictEqual(result.success, c.success);
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
      const rule = new SdkTspConfigValidationRule([
        new TspConfigCommonAzServiceDirMatchPatternSubRule(),
      ]);
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
