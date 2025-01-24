import { Rule, RuleTester } from "eslint";
import { test } from "vitest";
import parser from "yaml-eslint-parser";

import emitAutorest from "../../src/rules/emit-autorest.js";

test("RuleTester", () => {
  const ruleTester = new RuleTester({
    languageOptions: {
      parser: parser,
    },
  });

  ruleTester.run(emitAutorest.name, emitAutorest as Rule.RuleModule, {
    valid: [
      {
        code: 'emit:\n  - "@azure-tools/typespec-autorest"',
      },
    ],
    invalid: [
      {
        code: "",
        errors: [{ messageId: "missing" }],
      },
      {
        code: "emit:\n  - foo",
        errors: [{ messageId: "missing" }],
      },
      { code: "not: valid", errors: [{ messageId: "invalid" }] },
    ],
  });
});
