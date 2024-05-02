// Placeholder to generate dist/src and dist/test folders
import { expect, test } from "vitest";
import { _getSuppressionsFromYaml } from "../src/index.js";

test("empty suppressions.yaml", () => {
  const suppressions = _getSuppressionsFromYaml("TestTool", "test.json", "suppressions.yaml", "");
  expect(suppressions).toEqual([]);
});
