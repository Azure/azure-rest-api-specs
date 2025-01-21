import { Rule, RuleTester } from "eslint";
import { describe, it } from "vitest";
import parser from "yaml-eslint-parser";
import { defaultMessageId, emitters } from "../../src/utils/constants.js";
import { generateEmitterOptions } from "../../src/utils/rule.js";

interface Case {
  description: string;
  rulePath: string;
  fileName?: string;
  yamlContent: string;
  shouldReportError: boolean;
}

const managementTspconfigPath = "contosowidgetmanager/Contoso.Management/tspconfig.yaml";
const tspconfigTsMgmtModularGenerateMetadataTrueRule =
  "../../src/rules/tspconfig-ts-mgmt-modular-generate-metadata-true.js";

const managementGenerateMetadataTestCases: Case[] = [
  {
    description: "valid: generateMetadata is true",
    rulePath: tspconfigTsMgmtModularGenerateMetadataTrueRule,
    fileName: managementTspconfigPath,
    yamlContent: generateEmitterOptions(
      emitters.ts,
      { key: "generateMetadata", value: true },
      { key: "flavor", value: "azure" },
    ),
    shouldReportError: false,
  },
  {
    description: "invalid: generateMetadata is false",
    rulePath: tspconfigTsMgmtModularGenerateMetadataTrueRule,
    fileName: managementTspconfigPath,
    yamlContent: generateEmitterOptions(
      emitters.ts,
      { key: "generateMetadata", value: false },
      { key: "flavor", value: "azure" },
    ),
    shouldReportError: true,
  },
  {
    description: "invalid: generateMetadata is undefined",
    rulePath: tspconfigTsMgmtModularGenerateMetadataTrueRule,
    fileName: managementTspconfigPath,
    yamlContent: generateEmitterOptions(emitters.ts, { key: "flavor", value: "azure" }),
    shouldReportError: true,
  },
];

describe("Tspconfig emitter options validation", () => {
  it.each([...managementGenerateMetadataTestCases])("$description", async (c: Case) => {
    const ruleTester = new RuleTester({
      languageOptions: {
        parser: parser,
      },
    });

    const ruleModule = await import(c.rulePath);
    const rule = ruleModule.default;
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
