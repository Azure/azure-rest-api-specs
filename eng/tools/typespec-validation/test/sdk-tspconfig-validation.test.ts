import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";

import {
  SdkTspConfigValidationRule,
  TspConfigCommonAzServiceDirMatchPatternSubRule,
  TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule,
  TspConfigTsMgmtModularPackageDirectorySubRule,
  TspConfigTsMgmtModularPackageNameMatchPatternSubRule,
  TspConfigTsDpPackageDirectorySubRule,
  TspConfigTsRlcDpPackageNameMatchPatternSubRule,
  TspConfigGoMgmtServiceDirMatchPatternSubRule,
  TspConfigGoMgmtPackageDirectorySubRule,
  TspConfigGoMgmtModuleEqualStringSubRule,
  TspConfigGoMgmtFixConstStutteringTrueSubRule,
  TspConfigGoMgmtGenerateSamplesTrueSubRule,
  TspConfigGoMgmtHeadAsBooleanTrueSubRule,
  TspConfigGoAzGenerateFakesTrueSubRule,
  TspConfigGoAzInjectSpansTrueSubRule,
  TspConfigGoDpModuleMatchPatternSubRule,
  TspConfigGoDpPackageDirectoryMatchPatternSubRule,
  TspConfigGoDpServiceDirMatchPatternSubRule,
  TspConfigJavaAzPackageDirectorySubRule,
  TspConfigJavaMgmtNamespaceFormatSubRule,
  TspConfigPythonMgmtPackageDirectorySubRule,
  TspConfigPythonMgmtNamespaceSubRule,
  TspConfigPythonMgmtPackageGenerateSampleTrueSubRule,
  TspConfigPythonMgmtPackageGenerateTestTrueSubRule,
  TspConfigCsharpAzPackageDirectorySubRule,
  TspConfigCsharpAzNamespaceEqualStringSubRule,
  TspConfigCsharpAzClearOutputFolderTrueSubRule,
  TspConfigCsharpMgmtPackageDirectorySubRule,
  TspconfigSubRuleBase,
  TspConfigPythonDpPackageDirectorySubRule,
  TspConfigTsMlcDpPackageNameMatchPatternSubRule,
} from "../src/rules/sdk-tspconfig-validation.js";
import { contosoTspConfig } from "@azure-tools/specs-shared/test/examples";
import { join } from "path";
import { strictEqual } from "node:assert";
import { stringify } from "yaml";

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
  "package-dir",
  "arm-aaa-bbb",
  "aaa-bbb",
  [new TspConfigTsMgmtModularPackageDirectorySubRule()],
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
  "package-dir",
  "arm-aaa-rest",
  "aaa--rest",
  [new TspConfigTsDpPackageDirectorySubRule()],
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
);

const goManagementPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "package-dir",
  "armaaa",
  "aaa",
  [new TspConfigGoMgmtPackageDirectorySubRule()],
);

const goManagementModuleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "module",
  "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
  "github.com/Azure/azure-sdk-for-java/{service-dir}/{package-dir}",
  [new TspConfigGoMgmtModuleEqualStringSubRule()],
);

const goManagementFixConstStutteringTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  managementTspconfigFolder,
  "fix-const-stuttering",
  true,
  false,
  [new TspConfigGoMgmtFixConstStutteringTrueSubRule()],
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
  [new TspConfigGoAzGenerateFakesTrueSubRule()],
);

const goDpGenerateFakesTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "generate-fakes",
  true,
  false,
  [new TspConfigGoAzGenerateFakesTrueSubRule()],
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
  "github.com/Azure/azure-sdk-for-go/aaa",
  "github.com/Azure/azure-sdk-for-cpp/bbb",
  [new TspConfigGoDpModuleMatchPatternSubRule()],
  true,
);

const goDpPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "package-dir",
  "az1/2/3",
  "bzasd",
  [new TspConfigGoDpPackageDirectoryMatchPatternSubRule()],
);

const goDpServiceDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-go",
  "",
  "service-dir",
  "sdk/2/3",
  "sd/k",
  [new TspConfigGoDpServiceDirMatchPatternSubRule()],
);

const javaManagementPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-java",
  "",
  "package-dir",
  "azure-aaa",
  "aaa",
  [new TspConfigJavaAzPackageDirectorySubRule()],
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
  "package-dir",
  "azure-mgmt-aaa",
  "azure-aaa",
  [new TspConfigPythonMgmtPackageDirectorySubRule()],
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
  "package-dir",
  "azure-aaa-bbb-ccc",
  "azure-aa-b-c-d",
  [new TspConfigPythonDpPackageDirectorySubRule()],
);

const csharpAzPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-csharp",
  "",
  "package-dir",
  "Azure.AAA",
  "AAA",
  [new TspConfigCsharpAzPackageDirectorySubRule()],
);

const csharpAzNamespaceTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-csharp",
  "",
  "namespace",
  "{package-dir}",
  "AAA",
  [new TspConfigCsharpAzNamespaceEqualStringSubRule()],
);

const csharpAzNamespaceWithPackageDirTestCases: Case[] = [
  {
    description: `Validate csharp\'s option: namespace is equal to {package-dir} and package-dir exists`,
    folder: "",
    tspconfigContent: createEmitterOptionExample(
      "@azure-tools/typespec-csharp",
      { key: "namespace", value: "{package-dir}" },
      { key: "package-dir", value: "Azure.AAA" },
    ),
    success: true,
    subRules: [new TspConfigCsharpAzNamespaceEqualStringSubRule()],
  },
  {
    description: `Validate csharp\'s option: namespace is equal to package-dir`,
    folder: "",
    tspconfigContent: createEmitterOptionExample(
      "@azure-tools/typespec-csharp",
      { key: "namespace", value: "Azure.AAA" },
      { key: "package-dir", value: "Azure.AAA" },
    ),
    success: true,
    subRules: [new TspConfigCsharpAzNamespaceEqualStringSubRule()],
  },
  {
    description: `Validate csharp\'s option: namespace is not equal to package-dir`,
    folder: "",
    tspconfigContent: createEmitterOptionExample(
      "@azure-tools/typespec-csharp",
      { key: "namespace", value: "namespace" },
      { key: "package-dir", value: "Azure.AAA" },
    ),
    success: shouldBeTrueOnFailSubRuleValidation("@azure-tools/typespec-csharp"),
    subRules: [new TspConfigCsharpAzNamespaceEqualStringSubRule()],
  },
];

const csharpAzClearOutputFolderTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-csharp",
  "",
  "clear-output-folder",
  true,
  false,
  [new TspConfigCsharpAzClearOutputFolderTrueSubRule()],
);

const csharpMgmtPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-csharp",
  managementTspconfigFolder,
  "package-dir",
  "Azure.ResourceManager.AAA",
  "Azure.Management.AAA",
  [new TspConfigCsharpMgmtPackageDirectorySubRule()],
);

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
    subRules: [new TspConfigTsMgmtModularPackageDirectorySubRule()],
    tspconfigContent: `
options:
  "@azure-tools/typespec-ts":
    package-dir: "*@#$%(@)*$#@!()#*&"
`,
    success: true,
    ignoredKeyPaths: ["options.@azure-tools/typespec-ts.package-dir"],
  },
  {
    description: "Suppress option with wildcard at the end",
    folder: managementTspconfigFolder,
    subRules: [
      new TspConfigGoMgmtPackageDirectorySubRule(),
      new TspConfigGoMgmtModuleEqualStringSubRule(),
      new TspConfigGoMgmtFixConstStutteringTrueSubRule(),
    ],
    tspconfigContent: `
options:
  "@azure-tools/typespec-go":
    package-dir: "wrong/directory"
    module-name: "invalid-module"
    generate-consts: false
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
    // ts
    ...tsManagementExperimentalExtensibleEnumsTestCases,
    ...tsManagementPackageDirTestCases,
    ...tsManagementPackageNameTestCases,
    ...tsDpPackageDirTestCases,
    ...tsDpPackageNameTestCases,
    ...tsDpModularPackageNameTestCases,
    // go
    ...goManagementServiceDirTestCases,
    ...goManagementPackageDirTestCases,
    ...goManagementModuleTestCases,
    ...goManagementFixConstStutteringTestCases,
    ...goManagementGenerateExamplesTestCases,
    ...goManagementGenerateFakesTestCases,
    ...goManagementHeadAsBooleanTestCases,
    ...goManagementInjectSpansTestCases,
    ...goDpGenerateFakesTestCases,
    ...goDpInjectSpansTestCases,
    ...goDpModuleTestCases,
    ...goDpPackageDirTestCases,
    ...goDpServiceDirTestCases,
    // java
    ...javaManagementPackageDirTestCases,
    ...javaMgmtNamespaceTestCases,
    ...javaMgmtNamespaceExtendedTestCases,
    // python
    ...pythonManagementPackageDirTestCases,
    ...pythonManagementNamespaceTestCases,
    ...pythonManagementGenerateTestTestCases,
    ...pythonManagementGenerateSampleTestCases,
    ...pythonDpPackageDirTestCases,
    // csharp
    ...csharpAzPackageDirTestCases,
    ...csharpAzNamespaceTestCases,
    ...csharpAzClearOutputFolderTestCases,
    ...csharpMgmtPackageDirTestCases,
    ...csharpAzNamespaceWithPackageDirTestCases,
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
    strictEqual(result.success, c.success);
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
