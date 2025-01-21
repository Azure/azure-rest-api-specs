import { Rule, RuleTester } from "eslint";
import { describe, it } from "vitest";
import parser from "yaml-eslint-parser";
import { defaultMessageId, emitters } from "../../src/utils/constants.js";
import { generateEmitterOptions } from "../../src/utils/rule.js";
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

const managementGenerateMetadataTestCases = generateManagementClientBooleanTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-generate-metadata-true",
  managementTspconfigPath,
  "generateMetadata",
  true,
);

const managementHierarchyClientTestCases = generateManagementClientBooleanTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-hierarchy-client-false",
  managementTspconfigPath,
  "hierarchyClient",
  false,
);

const managementExperimentalExtensibleEnumsTestCases = generateManagementClientBooleanTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
  managementTspconfigPath,
  "experimentalExtensibleEnums",
  true,
);

const managementEnableOperationGroupTestCases = generateManagementClientBooleanTestCases(
  emitters.ts,
  rulePath,
  "tspconfig-ts-mgmt-modular-enable-operation-group-true",
  managementTspconfigPath,
  "enableOperationGroup",
  true,
);

function generateManagementClientBooleanTestCases(
  emitterName: string,
  rulePath: string,
  ruleName: string,
  fileName: string,
  optionName: string,
  expectedOptionValue: boolean,
): Case[] {
  const managementGenerateMetadataTestCases: Case[] = [
    {
      description: `valid: ${optionName} is ${expectedOptionValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: generateEmitterOptions(
        emitterName,
        { key: optionName, value: expectedOptionValue },
        { key: "flavor", value: "azure" },
      ),
      shouldReportError: false,
    },
    {
      description: `invalid: ${optionName} is ${!expectedOptionValue}`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: generateEmitterOptions(
        emitterName,
        { key: optionName, value: !expectedOptionValue },
        { key: "flavor", value: "azure" },
      ),
      shouldReportError: true,
    },
    {
      description: `invalid: ${optionName} is undefined`,
      rulePath,
      ruleName,
      fileName,
      yamlContent: generateEmitterOptions(emitterName, { key: "flavor", value: "azure" }),
      shouldReportError: true,
    },
  ];
  return managementGenerateMetadataTestCases;
}

describe("Tspconfig emitter options validation", () => {
  it.each([
    ...managementGenerateMetadataTestCases,
    ...managementHierarchyClientTestCases,
    ...managementExperimentalExtensibleEnumsTestCases,
    ...managementEnableOperationGroupTestCases,
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
