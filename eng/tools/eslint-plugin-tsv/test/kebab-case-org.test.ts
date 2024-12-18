import { Rule, RuleTester } from "eslint";
import { test } from "vitest";

import kebabCaseOrg from "../src/kebab-case-org.js";

test(kebabCaseOrg.meta.name, () => {
  const ruleTester = new RuleTester();

  ruleTester.run(kebabCaseOrg.meta.name, kebabCaseOrg as Rule.RuleModule, {
    valid: [{ code: "", filename: "/specification/contoso/Contoso.WidgetManager/tspconfig.yaml" }],
    invalid: [
      {
        code: "",
        filename: "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml",
        errors: 1,
      },
    ],
  });
});
