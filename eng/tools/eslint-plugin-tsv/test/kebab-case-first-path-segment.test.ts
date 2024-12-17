import { Rule, RuleTester } from "eslint";
import kebabCaseFirstPathSegment from "../src/kebab-case-first-path-segment.js";

const ruleTester = new RuleTester();

ruleTester.run("kebab-case-first-path-segment", kebabCaseFirstPathSegment as Rule.RuleModule, {
  valid: [{ code: "", filename: "/specification/contoso/Contoso.WidgetManager/tspconfig.yaml" }],
  invalid: [
    { code: "", filename: "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml", errors: 1 },
  ],
});

console.log("All tests passed!");
