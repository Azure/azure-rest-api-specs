import { Rule, RuleTester } from "eslint";
import { test } from "vitest";

import kebabCaseFirstPathSegment from "../src/kebab-case-first-path-segment.js";

test(kebabCaseFirstPathSegment.meta.name, async ({ expect }) => {
  const ruleTester = new RuleTester();

  ruleTester.run(
    kebabCaseFirstPathSegment.meta.name,
    kebabCaseFirstPathSegment as Rule.RuleModule,
    {
      valid: [
        { code: "", filename: "/specification/contoso/Contoso.WidgetManager/tspconfig.yaml" },
      ],
      invalid: [
        {
          code: "",
          filename: "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml",
          errors: 1,
        },
      ],
    },
  );
});
