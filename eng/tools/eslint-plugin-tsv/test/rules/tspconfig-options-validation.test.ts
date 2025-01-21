import { Rule, RuleTester } from "eslint";
import { describe, it } from "vitest";
import parser from "yaml-eslint-parser";
import { defaultMessageId, emitters } from "../../src/utils/constants.js";
import { createEmitterOptions } from "../../src/utils/rule.js";
import { NamedRule } from "../../src/interfaces/named-eslint.js";

interface Case {
  description: string;
  rulePath: string;
  ruleName: string;
  fileName?: string;
  yamlContent: string;
  shouldReportError: boolean;
}

const managementTspconfigPath = "contosowidgetmanager/Contoso.Management/tspconfig.yaml";
const rulePath = "../../src/rules/tspconfig-validation-rules.js";

const tsManagementGenerateMetadataTestCases = generateManagementClientTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-generate-metadata-true",
  managementTspconfigPath,
  "generateMetadata",
  true,
  false,
);

const tsManagementHierarchyClientTestCases = generateManagementClientTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-hierarchy-client-false",
  managementTspconfigPath,
  "hierarchyClient",
  false,
  true,
);

const tsManagementExperimentalExtensibleEnumsTestCases = generateManagementClientTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
  managementTspconfigPath,
  "experimentalExtensibleEnums",
  true,
  false,
);

const tsManagementEnableOperationGroupTestCases = generateManagementClientTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-enable-operation-group-true",
  managementTspconfigPath,
  "enableOperationGroup",
  true,
  false,
);

const tsManagementPackageDirTestCases = generateManagementClientTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-package-dir-match-pattern",
  managementTspconfigPath,
  "package-dir",
  "arm-aaa-bbb",
  "aaa-bbb",
);

const tsManagementPackageNameTestCases = generateManagementClientTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-package-name-match-pattern",
  managementTspconfigPath,
  "packageDetails.name",
  "@azure/arm-aaa-bbb",
  "@azure/aaa-bbb",
);

const goManagementServiceDirTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-service-dir-match-pattern",
  managementTspconfigPath,
  "service-dir",
  "sdk/resourcemanager/aaa",
  "sdk/manager/aaa",
);

const goManagementPackageDirTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-package-dir-match-pattern",
  managementTspconfigPath,
  "package-dir",
  "armaaa",
  "aaa",
);

const goManagementModuleTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-module-equal-string",
  managementTspconfigPath,
  "module",
  "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
  "github.com/Azure/azure-sdk-for-java/{service-dir}/{package-dir}",
);

const goManagementFixConstStutteringTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-fix-const-stuttering-true",
  managementTspconfigPath,
  "fix-const-stuttering",
  true,
  false,
);

const goManagementGenerateExamplesTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-generate-examples-true",
  managementTspconfigPath,
  "generate-examples",
  true,
  false,
);

const goManagementGenerateFakesTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-generate-fakes-true",
  managementTspconfigPath,
  "generate-fakes",
  true,
  false,
);

const goManagementHeadAsBooleanTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-head-as-boolean-true",
  managementTspconfigPath,
  "head-as-boolean",
  true,
  false,
);

const goManagementInjectSpansTestCases = generateManagementClientTestCases(
  emitters.go,
  rulePath,
  "tspconfig-go-mgmt-inject-spans-true",
  managementTspconfigPath,
  "inject-spans",
  true,
  false,
);

function generateManagementClientTestCases(
  emitterName: string,
  rulePath: string,
  ruleName: string,
  fileName: string,
  optionName: string,
  validOptionValue: boolean | string,
  invalidOptionValue: boolean | string,
): Case[] {
  const managementGenerateMetadataTestCases: Case[] = [
    {
      description: `valid: ${optionName} is ${validOptionValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createEmitterOptions(
        emitterName,
        { key: optionName, value: validOptionValue },
        { key: "flavor", value: "azure" },
      ),
      shouldReportError: false,
    },
    {
      description: `invalid: ${optionName} is ${invalidOptionValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createEmitterOptions(
        emitterName,
        { key: optionName, value: invalidOptionValue },
        { key: "flavor", value: "azure" },
      ),
      shouldReportError: true,
    },
    {
      description: `invalid: ${optionName} is undefined`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: createEmitterOptions(emitterName, { key: "flavor", value: "azure" }),
      shouldReportError: true,
    },
  ];
  return managementGenerateMetadataTestCases;
}

describe("Tspconfig emitter options validation", () => {
  it.each([
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
  ])("$ruleName - $description", async (c: Case) => {
    const ruleTester = new RuleTester({
      languageOptions: {
        parser: parser,
      },
    });

    const ruleModule = await import(c.rulePath);
    const rule = ruleModule.default.find((r: NamedRule.RuleModule) => r.name === c.ruleName);
    const tests = c.shouldReportError
      ? {
          valid: [],
          invalid: [
            {
              filename: c.fileName,
              code: c.yamlContent,
              errors: [{ messageId: defaultMessageId }],
            },
          ],
        }
      : {
          valid: [
            {
              filename: c.fileName,
              code: c.yamlContent,
            },
          ],
          invalid: [],
        };
    ruleTester.run(rule.name, rule as Rule.RuleModule, tests);
  });
});
