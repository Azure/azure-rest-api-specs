// Placeholder to generate dist/src and dist/test folders
import { expect, test } from "vitest";
import { _getSuppressionsFromYaml } from "../src/index.js";

test("empty suppressions.yaml", () => {
  const suppressions = _getSuppressionsFromYaml("TestTool", "test.json", "suppressions.yaml", "");
  expect(suppressions).toEqual([]);
});

test("one suppression no match", () => {
  const suppressions = _getSuppressionsFromYaml(
    "TestTool",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "bar.json"\n  reason: test',
  );
  expect(suppressions).toEqual([]);
});

test("one suppression match", () => {
  const suppressions = _getSuppressionsFromYaml(
    "TestTool",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "foo.json"\n  reason: test',
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      path: "foo.json",
      reason: "test",
    },
  ]);
});
