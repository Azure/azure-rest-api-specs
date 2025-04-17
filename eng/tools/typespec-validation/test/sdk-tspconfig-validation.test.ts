import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";

import {
  SdkTspConfigValidationRule,
  TspConfigCommonAzServiceDirMatchPatternSubRule,
  TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule,
  TspConfigTsMgmtModularPackageDirectorySubRule,
  TspConfigTsMgmtModularPackageNameMatchPatternSubRule,
  TspConfigTsDpPackageDirectorySubRule,
  TspConfigTsDpPackageNameMatchPatternSubRule,
  TspConfigGoMgmtServiceDirMatchPatternSubRule,
  TspConfigGoMgmtPackageDirectorySubRule,
  TspConfigGoMgmtModuleEqualStringSubRule,
  TspConfigGoMgmtFixConstStutteringTrueSubRule,
  TspConfigGoMgmtGenerateExamplesTrueSubRule,
  TspConfigGoMgmtHeadAsBooleanTrueSubRule,
  TspConfigGoAzGenerateFakesTrueSubRule,
  TspConfigGoAzInjectSpansTrueSubRule,
  TspConfigGoDpModuleMatchPatternSubRule,
  TspConfigGoDpPackageDirectoryMatchPatternSubRule,
  TspConfigGoDpServiceDirMatchPatternSubRule,
  TspConfigJavaAzPackageDirectorySubRule,
  TspConfigPythonMgmtPackageDirectorySubRule,
  TspConfigPythonAzPackageNameEqualStringSubRule,
  TspConfigPythonAzGenerateTestTrueSubRule,
  TspConfigPythonAzGenerateSampleTrueSubRule,
  TspConfigCsharpAzPackageDirectorySubRule,
  TspConfigCsharpAzNamespaceEqualStringSubRule,
  TspConfigCsharpAzClearOutputFolderTrueSubRule,
  TspConfigCsharpMgmtPackageDirectorySubRule,
  TspconfigSubRuleBase,
  TspConfigPythonDpPackageDirectorySubRule,
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

function createParameterTestCases(
  folder: string,
  key: string,
  validValue: boolean | string,
  invalidValue: boolean | string,
  subRules: TspconfigSubRuleBase[],
): Case[] {
  const cases: Case[] = [
    {
      description: `Validate parameter ${key} with valid value ${validValue}`,
      folder,
      tspconfigContent: createParameterExample({ key: key, value: validValue }),
      success: true,
      subRules,
    },
    {
      description: `Validate parameter ${key} with invalid value ${invalidValue}`,
      folder,
      tspconfigContent: createParameterExample({ key: key, value: invalidValue }),
      success: false,
      subRules,
    },
    {
      description: `Validate parameter ${key} with undefined value`,
      folder,
      tspconfigContent: "",
      success: false,
      subRules,
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
): Case[] {
  const cases: Case[] = [];

  const language = emitterName.split("-").pop();
  cases.push({
    description: `Validate ${language}'s option:${key} with valid value ${validValue}`,
    folder,
    tspconfigContent: createEmitterOptionExample(emitterName, { key: key, value: validValue }),
    success: true,
    subRules,
  });

  cases.push({
    description: `Validate ${language}'s option:${key} with invalid value ${invalidValue}`,
    folder,
    tspconfigContent: createEmitterOptionExample(emitterName, {
      key: key,
      value: invalidValue,
    }),
    success: false,
    subRules,
  });

  cases.push({
    description: `Validate ${language}'s option:${key} with undefined value`,
    folder,
    tspconfigContent: createEmitterOptionExample(emitterName),
    success: allowUndefined ? true : false,
    subRules,
  });

  if (!allowUndefined && key.includes(".")) {
    cases.push({
      description: `Validate ${language}'s option:${key} with incomplete key`,
      folder,
      tspconfigContent: createEmitterOptionExample(emitterName, {
        key: key.split(".").slice(0, -1).join("."),
        value: validValue,
      }),
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
  "experimentalExtensibleEnums",
  true,
  false,
  [new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule()],
);

const newTsManagementExperimentalExtensibleEnumsTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "experimental-extensible-enums",
  true,
  false,
  [new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule()],
);

const mixTsManagementExperimentalExtensibleEnumsTestCases = {
  description: `Validate @azure-tools/typespec-ts's mix options: experimental-extensible-enums/experimentalExtensibleEnums with different values`,
  folder: "aaa.Management",
  tspconfigContent: createEmitterOptionExample(
    "@azure-tools/typespec-ts",
    { key: "experimentalExtensibleEnums", value: true },
    { key: "experimental-extensible-enums", value: false },
  ),
  success: false,
  subRules: [new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule()],
};

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
  "packageDetails.name",
  "@azure/arm-aaa-bbb",
  "@azure/aaa-bbb",
  [new TspConfigTsMgmtModularPackageNameMatchPatternSubRule()],
);

const newTsManagementPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "package-details.name",
  "@azure/arm-aaa-bbb",
  "@azure/aaa-bbb",
  [new TspConfigTsMgmtModularPackageNameMatchPatternSubRule()],
);

const mixTsManagementPackageNameTestCases = {
  description: `Validate @azure-tools/typespec-ts's mix options: package-details/packageDetails with different values`,
  folder: "aaa.Management",
  tspconfigContent: createEmitterOptionExample(
    "@azure-tools/typespec-ts",
    { key: "packageDetails.name", value: "@azure/arm-aaa-bbb" },
    { key: "package-details.name", value: "@azure/aaa-bbb" },
  ),
  success: false,
  subRules: [new TspConfigTsMgmtModularPackageNameMatchPatternSubRule()],
};

const tsDpPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  "",
  "package-dir",
  "arm--rest",
  "aaa-",
  [new TspConfigTsDpPackageDirectorySubRule()],
);

const tsDpPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  "",
  "packageDetails.name",
  "@azure-rest/aaa-bbb",
  "@azure/aaa-bbb",
  [new TspConfigTsDpPackageNameMatchPatternSubRule()],
);

const mixTsDpPackageNameTestCases = {
  description: `Validate @azure-tools/typespec-ts's mix options: package-details/packageDetails with different values`,
  folder: "",
  tspconfigContent: createEmitterOptionExample(
    "",
    { key: "packageDetails.name", value: "@azure/azure-rest-aaa-bbb" },
    { key: "package-details.name", value: "@azure/aaa-bbb" },
  ),
  success: false,
  subRules: [new TspConfigTsDpPackageNameMatchPatternSubRule()],
};

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
  "generate-examples",
  true,
  false,
  [new TspConfigGoMgmtGenerateExamplesTrueSubRule()],
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

const pythonManagementPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "package-dir",
  "azure-mgmt-aaa",
  "azure-aaa",
  [new TspConfigPythonMgmtPackageDirectorySubRule()],
);

const pythonManagementPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "package-name",
  "{package-dir}",
  "aaa",
  [new TspConfigPythonAzPackageNameEqualStringSubRule()],
);

const pythonManagementGenerateTestTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "generate-test",
  true,
  false,
  [new TspConfigPythonAzGenerateTestTrueSubRule()],
);

const pythonManagementGenerateSampleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "generate-sample",
  true,
  false,
  [new TspConfigPythonAzGenerateSampleTrueSubRule()],
);

const pythonDpPackageDirTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  "",
  "package-dir",
  "azure-aaa-bbb-ccc",
  "azure-aa-b-c-d",
  [new TspConfigPythonDpPackageDirectorySubRule()],
);

const pythonAzPackageNameTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  "",
  "package-name",
  "{package-dir}",
  "aaa",
  [new TspConfigPythonAzPackageNameEqualStringSubRule()],
);

const pythonAzGenerateTestTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  "",
  "generate-test",
  true,
  false,
  [new TspConfigPythonAzGenerateTestTrueSubRule()],
);

const pythonAzGenerateSampleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  "",
  "generate-sample",
  true,
  false,
  [new TspConfigPythonAzGenerateSampleTrueSubRule()],
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
    success: false,
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

const suppressSubRuleTestCases: Case[] = [
  {
    description: "Suppress parameter",
    folder: "",
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
    ...newTsManagementExperimentalExtensibleEnumsTestCases,
    ...tsManagementExperimentalExtensibleEnumsTestCases,
    ...tsManagementPackageDirTestCases,
    ...newTsManagementPackageNameTestCases,
    ...tsManagementPackageNameTestCases,
    mixTsManagementExperimentalExtensibleEnumsTestCases,
    mixTsManagementPackageNameTestCases,
    ...tsDpPackageDirTestCases,
    ...tsDpPackageNameTestCases,
    mixTsDpPackageNameTestCases,
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
    // python
    ...pythonManagementPackageDirTestCases,
    ...pythonManagementPackageNameTestCases,
    ...pythonManagementGenerateTestTestCases,
    ...pythonManagementGenerateSampleTestCases,
    ...pythonDpPackageDirTestCases,
    ...pythonAzPackageNameTestCases,
    ...pythonAzGenerateTestTestCases,
    ...pythonAzGenerateSampleTestCases,
    // csharp
    ...csharpAzPackageDirTestCases,
    ...csharpAzNamespaceTestCases,
    ...csharpAzClearOutputFolderTestCases,
    ...csharpMgmtPackageDirTestCases,
    ...csharpAzNamespaceWithPackageDirTestCases,
    // suppression
    ...suppressSubRuleTestCases,
  ])(`$description`, async (c: Case) => {
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
    strictEqual(result.success, true);
    if (c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation passed."), true);
    if (!c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation failed."), true);
  });
});
