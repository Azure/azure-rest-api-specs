import { describe, it } from "vitest";

import { Rule } from "../src/rule.js";
import { SdkTspConfigValidation } from "../src/rules/sdk-tspconfig-validation.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { join } from "path";
import { strictEqual } from "node:assert";
import { stringify } from "yaml";

// interface TestCase {
//   tspconfig: string;
//   actualExpectedResult: boolean;
//   skip: boolean;
//   when: string;
//   folder: string;
// }

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
  rulePath: string,
  ruleName: string,
  fileName: string,
  key: string,
  validValue: boolean | string,
  invalidValue: boolean | string,
): Case[] {
  const managementGenerateMetadataTestCases: Case[] = [
    {
      description: `valid: ${key} is ${validValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createParameterExample({ key: key, value: validValue }),
      shouldReportError: false,
    },
    {
      description: `invalid: ${key} is ${invalidValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createParameterExample({ key: key, value: invalidValue }),
      shouldReportError: true,
    },
    {
      description: `invalid: ${key} is undefined`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: "",
      shouldReportError: true,
    },
  ];
  return managementGenerateMetadataTestCases;
}

function createEmitterOptionTestCases(
  emitterName: string,
  rulePath: string,
  ruleName: string,
  fileName: string,
  key: string,
  validValue: boolean | string,
  invalidValue: boolean | string,
): Case[] {
  const managementGenerateMetadataTestCases: Case[] = [
    {
      description: `valid: ${key} is ${validValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createEmitterOptionExample(emitterName, { key: key, value: validValue }),
      shouldReportError: false,
    },
    {
      description: `invalid: ${key} is ${invalidValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createEmitterOptionExample(emitterName, { key: key, value: invalidValue }),
      shouldReportError: true,
    },
    {
      description: `invalid: ${key} is undefined`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createEmitterOptionExample(emitterName),
      shouldReportError: true,
    },
  ];
  return managementGenerateMetadataTestCases;
}

interface Case {
  description: string;
  rulePath: string;
  ruleName: string;
  fileName?: string;
  yamlContent: string;
  shouldReportError: boolean;
}

const managementTspconfigPath = "contosowidgetmanager/Contoso.Management/tspconfig.yaml";
// TODO: remove
const rulePath = "../../src/rules/tspconfig-validation-rules.js";
const emitters = {
  ts: "@azure-tools/typespec-ts",
  java: "@azure-tools/typespec-java",
  csharp: "@azure-tools/typespec-csharp",
  python: "@azure-tools/typespec-python",
  go: "@azure-tools/typespec-go",
};

const commonAzureServiceDirTestCases = createParameterTestCases(
  rulePath,
  "tspconfig-common-az-service-dir-match-pattern",
  "",
  "service-dir",
  "sdk/aaa",
  "sdka/aaa",
);

const tsManagementGenerateMetadataTestCases = createEmitterOptionTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-generate-metadata-true",
  managementTspconfigPath,
  "generateMetadata",
  true,
  false,
);

const tsManagementHierarchyClientTestCases = createEmitterOptionTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-hierarchy-client-false",
  managementTspconfigPath,
  "hierarchyClient",
  false,
  true,
);

const tsManagementExperimentalExtensibleEnumsTestCases = createEmitterOptionTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
  managementTspconfigPath,
  "experimentalExtensibleEnums",
  true,
  false,
);

const tsManagementEnableOperationGroupTestCases = createEmitterOptionTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-enable-operation-group-true",
  managementTspconfigPath,
  "enableOperationGroup",
  true,
  false,
);

const tsManagementPackageDirTestCases = createEmitterOptionTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-package-dir-match-pattern",
  managementTspconfigPath,
  "package-dir",
  "arm-aaa-bbb",
  "aaa-bbb",
);

const tsManagementPackageNameTestCases = createEmitterOptionTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-package-name-match-pattern",
  managementTspconfigPath,
  "packageDetails.name",
  "@azure/arm-aaa-bbb",
  "@azure/aaa-bbb",
);

const goManagementServiceDirTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-service-dir-match-pattern",
  managementTspconfigPath,
  "service-dir",
  "sdk/resourcemanager/aaa",
  "sdk/manager/aaa",
);

const goManagementPackageDirTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-package-dir-match-pattern",
  managementTspconfigPath,
  "package-dir",
  "armaaa",
  "aaa",
);

const goManagementModuleTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-module-equal-string",
  managementTspconfigPath,
  "module",
  "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
  "github.com/Azure/azure-sdk-for-java/{service-dir}/{package-dir}",
);

const goManagementFixConstStutteringTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-fix-const-stuttering-true",
  managementTspconfigPath,
  "fix-const-stuttering",
  true,
  false,
);

const goManagementGenerateExamplesTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-generate-examples-true",
  managementTspconfigPath,
  "generate-examples",
  true,
  false,
);

const goManagementGenerateFakesTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-generate-fakes-true",
  managementTspconfigPath,
  "generate-fakes",
  true,
  false,
);

const goManagementHeadAsBooleanTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-head-as-boolean-true",
  managementTspconfigPath,
  "head-as-boolean",
  true,
  false,
);

const goManagementInjectSpansTestCases = createEmitterOptionTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-inject-spans-true",
  managementTspconfigPath,
  "inject-spans",
  true,
  false,
);

const javaManagementPackageDirTestCases = createEmitterOptionTestCases(
  emitters.java,
  rulePath,
  "tspconfig-java-az-package-dir-match-pattern",
  "",
  "package-dir",
  "azure-aaa",
  "aaa",
);

const pythonManagementPackageDirTestCases = createEmitterOptionTestCases(
  emitters.python,
  rulePath,
  "tspconfig-python-mgmt-package-dir-match-pattern",
  managementTspconfigPath,
  "package-dir",
  "azure-mgmt-aaa",
  "azure-aaa",
);

const pythonManagementPackageNameTestCases = createEmitterOptionTestCases(
  emitters.python,
  rulePath,
  "tspconfig-python-mgmt-package-name-equal-string",
  managementTspconfigPath,
  "package-name",
  "{package-dir}",
  "aaa",
);

const pythonManagementGenerateTestTestCases = createEmitterOptionTestCases(
  emitters.python,
  rulePath,
  "tspconfig-python-mgmt-generate-test-true",
  managementTspconfigPath,
  "generate-test",
  true,
  false,
);

const pythonManagementGenerateSampleTestCases = createEmitterOptionTestCases(
  emitters.python,
  rulePath,
  "tspconfig-python-mgmt-generate-sample-true",
  managementTspconfigPath,
  "generate-sample",
  true,
  false,
);

const csharpAzPackageDirTestCases = createEmitterOptionTestCases(
  emitters.csharp,
  rulePath,
  "tspconfig-csharp-az-package-dir-match-pattern",
  "",
  "package-dir",
  "Azure.AAA",
  "AAA",
);

const csharpAzNamespaceTestCases = createEmitterOptionTestCases(
  emitters.csharp,
  rulePath,
  "tspconfig-csharp-az-namespace-equal-string",
  "",
  "namespace",
  "{package-dir}",
  "AAA",
);

const csharpAzClearOutputFolderTestCases = createEmitterOptionTestCases(
  emitters.csharp,
  rulePath,
  "tspconfig-csharp-az-clear-output-folder-true",
  "",
  "clear-output-folder",
  true,
  false,
);

const csharpMgmtPackageDirTestCases = createEmitterOptionTestCases(
  emitters.csharp,
  rulePath,
  "tspconfig-csharp-mgmt-package-dir-match-pattern",
  managementTspconfigPath,
  "package-dir",
  "Azure.ResourceManager.AAA",
  "Azure.Management.AAA",
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
  ])(
    `??`,
    async (c: Case) => {
      let host = new TsvTestHost();
      host.checkFileExists = async (file: string) => {
        return file === join(TsvTestHost.folder, "tspconfig.yaml");
      };
      host.readTspConfig = async (_folder: string) => c.yamlContent;
      const rule = new SdkTspConfigValidation();
      const result = await rule.execute(host, TsvTestHost.folder);
      strictEqual(result.success, true);
      if (c.shouldReportError) {
        if (c.skip) strictEqual(result.stdOutput?.includes("skip."), true);
        else strictEqual(result.stdOutput?.includes("validation passed."), true);
      }
    },
  );
});
