import { Rule, RuleTester } from "eslint";
import parser from "yaml-eslint-parser";
import { test } from "vitest";

import kebabCaseOrg from "../../src/rules/kebab-case-org.js";

test("tsv/" + kebabCaseOrg.meta.name, () => {
  const ruleTester = new RuleTester({
    languageOptions: {
      parser: parser,
    },
  });

  ruleTester.run(kebabCaseOrg.meta.name, kebabCaseOrg as Rule.RuleModule, {
    valid: [
      { code: "", filename: "/specification/contoso/Contoso.WidgetManager/tspconfig.yaml" },
      {
        code: `# eslint-disable rule-to-test/${kebabCaseOrg.meta.name}`,
        filename: "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml",
      },
    ],
    invalid: [
      {
        code: "",
        filename: "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml",
        errors: ["Organization name (first path segment after 'specification') does not use kebab-case: 'Not-Kebab-Case'"],
      },
    ],
  });
});
