// Placeholder to generate dist/src and dist/test folders
import { expect, test } from "vitest";
import { _getSuppressionsFromYaml } from "../src/index.js";

test("one suppression no match", () => {
  const suppressions = _getSuppressionsFromYaml(
    "TestTool",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "bar.json"\n  reason: test',
  );
  expect(suppressions).toEqual([]);
});
