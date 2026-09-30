import { defineLinter } from "@typespec/compiler";
import { useStandardOperationsRule } from "./rules/use-standard-operations.ts";

export const $linter = defineLinter({
  rules: [useStandardOperationsRule],
});
