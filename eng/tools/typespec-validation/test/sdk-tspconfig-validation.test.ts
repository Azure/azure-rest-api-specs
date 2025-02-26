import { describe, it } from "vitest";

import {
  SdkTspConfigValidationRule,
  TspConfigCommonAzServiceDirMatchPatternSubRule,
  TspConfigTsMgmtModularGenerateMetadataTrueSubRule,
  TspConfigTsMgmtModularHierarchyClientFalseSubRule,
  TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule,
  TspConfigTsMgmtModularEnableOperationGroupTrueSubRule,
  TspConfigTsMgmtModularPackageDirectorySubRule,
  TspConfigTsMgmtModularPackageNameMatchPatternSubRule,
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
  TspConfigPythonMgmtPackageNameEqualStringSubRule,
  TspConfigPythonMgmtGenerateTestTrueSubRule,
  TspConfigPythonMgmtGenerateSampleTrueSubRule,
  TspConfigCsharpAzPackageDirectorySubRule,
  TspConfigCsharpAzNamespaceEqualStringSubRule,
  TspConfigCsharpAzClearOutputFolderTrueSubRule,
  TspConfigCsharpMgmtPackageDirectorySubRule,
  TspconfigSubRuleBase,
} from "../src/rules/sdk-tspconfig-validation.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { join } from "path";
import { strictEqual } from "node:assert";
import { stringify } from "yaml";

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

  cases.push({
    description: `Validate ${emitterName}'s option:${key} with valid value ${validValue}`,
    folder,
    tspconfigContent: createEmitterOptionExample(emitterName, { key: key, value: validValue }),
    success: true,
    subRules,
  });

  cases.push({
    description: `Validate ${emitterName}'s option:${key} with invalid value ${invalidValue}`,
    folder,
    tspconfigContent: createEmitterOptionExample(emitterName, {
      key: key,
      value: invalidValue,
    }),
    success: false,
    subRules,
  });

  cases.push({
    description: `Validate ${emitterName}'s option:${key} with undefined value`,
    folder,
    tspconfigContent: createEmitterOptionExample(emitterName),
    success: allowUndefined ? true : false,
    subRules,
  });

  if (!allowUndefined && key.includes(".")) {
    cases.push({
      description: `Validate ${emitterName}'s option:${key} with incomplete key`,
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
}

const managementTspconfigFolder = "contosowidgetmanager/Contoso.Management/";

const commonAzureServiceDirTestCases = createParameterTestCases(
  "",
  "service-dir",
  "sdk/aaa",
  "sdka/aaa",
  [new TspConfigCommonAzServiceDirMatchPatternSubRule()],
);

const tsManagementGenerateMetadataTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "generateMetadata",
  true,
  false,
  [new TspConfigTsMgmtModularGenerateMetadataTrueSubRule()],
);

const tsManagementHierarchyClientTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "hierarchyClient",
  false,
  true,
  [new TspConfigTsMgmtModularHierarchyClientFalseSubRule()],
);

const tsManagementExperimentalExtensibleEnumsTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "experimentalExtensibleEnums",
  true,
  false,
  [new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule()],
);

const tsManagementEnableOperationGroupTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-ts",
  managementTspconfigFolder,
  "enableOperationGroup",
  true,
  false,
  [new TspConfigTsMgmtModularEnableOperationGroupTrueSubRule()],
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
  "packageDetails.name",
  "@azure/arm-aaa-bbb",
  "@azure/aaa-bbb",
  [new TspConfigTsMgmtModularPackageNameMatchPatternSubRule()],
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
  [new TspConfigPythonMgmtPackageNameEqualStringSubRule()],
);

const pythonManagementGenerateTestTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "generate-test",
  true,
  false,
  [new TspConfigPythonMgmtGenerateTestTrueSubRule()],
);

const pythonManagementGenerateSampleTestCases = createEmitterOptionTestCases(
  "@azure-tools/typespec-python",
  managementTspconfigFolder,
  "generate-sample",
  true,
  false,
  [new TspConfigPythonMgmtGenerateSampleTrueSubRule()],
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

describe("tspconfig", function () {
  it.each([
    // common
    ...commonAzureServiceDirTestCases,
    // ts
    ...tsManagementGenerateMetadataTestCases,
    ...tsManagementHierarchyClientTestCases,
    ...tsManagementExperimentalExtensibleEnumsTestCases,
    ...tsManagementEnableOperationGroupTestCases,
    ...tsManagementPackageDirTestCases,
    ...tsManagementPackageNameTestCases,
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
    // csharp
    ...csharpAzPackageDirTestCases,
    ...csharpAzNamespaceTestCases,
    ...csharpAzClearOutputFolderTestCases,
    ...csharpMgmtPackageDirTestCases,
  ])(`$description`, async (c: Case) => {
    let host = new TsvTestHost();
    host.checkFileExists = async (file: string) => {
      return file === join(c.folder, "tspconfig.yaml");
    };
    host.readTspConfig = async (_folder: string) => c.tspconfigContent;
    const rule = new SdkTspConfigValidationRule(c.subRules);
    const result = await rule.execute(host, c.folder);
    strictEqual(result.success, true);
    if (c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation passed."), true);
    if (!c.success)
      strictEqual(result.stdOutput?.includes("[SdkTspConfigValidation]: validation failed."), true);
  });
});
