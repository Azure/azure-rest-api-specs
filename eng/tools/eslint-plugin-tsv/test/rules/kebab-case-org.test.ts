import { Rule, RuleTester } from "eslint";
import { test } from "vitest";
import parser from "yaml-eslint-parser";

import kebabCaseOrg from "../../src/rules/kebab-case-org.js";

test("RuleTester", () => {
  const ruleTester = new RuleTester({
    languageOptions: {
      parser: parser,
    },
  });

  ruleTester.run(kebabCaseOrg.name, kebabCaseOrg as Rule.RuleModule, {
    valid: [
      { code: "", filename: "/specification/contoso/Contoso.WidgetManager/tspconfig.yaml" },
      {
        code: `# eslint-disable rule-to-test/${kebabCaseOrg.name}`,
        filename: "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml",
      },
    ],
    invalid: [
      {
        code: "",
        filename: "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml",
        errors: [{ messageId: "kebab" }],
      },
      {
        code: "",
        filename: "tspconfig.yaml",
        errors: [{ messageId: "invalid" }],
      },
    ],
  });
});
