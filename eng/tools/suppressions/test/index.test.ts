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

test("globstar matching", () => {
  const suppressions = _getSuppressionsFromYaml(
    "TestTool",
    "data-plane/Foo/stable/2024-01-01/foo.json",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "data-plane/Foo/stable/2024-01-01/foo.json"\n  reason: exact match\n' +
      '- tool: TestTool\n  path: "data-plane/Foo/stable/2024-01-01/**/*.json"\n  reason: all swagger under version\n' +
      '- tool: TestTool\n  path: "data-plane/**/*.json"\n  reason: all swagger under data-plane\n' +
      '- tool: TestTool\n  path: "**/*.json"\n  reason: all swagger under spec\n' +
      '- tool: TestTool\n  path: "**"\n  reason: all files under spec\n',
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      path: "data-plane/Foo/stable/2024-01-01/foo.json",
      reason: "exact match",
    },
    {
      tool: "TestTool",
      path: "data-plane/Foo/stable/2024-01-01/**/*.json",
      reason: "all swagger under version",
    },
    {
      tool: "TestTool",
      path: "data-plane/**/*.json",
      reason: "all swagger under data-plane",
    },
    {
      tool: "TestTool",
      path: "**/*.json",
      reason: "all swagger under spec",
    },
    {
      tool: "TestTool",
      path: "**",
      reason: "all files under spec",
    },
  ]);
});

test("tool matching", () => {
  const suppressions = _getSuppressionsFromYaml(
    "TestTool1",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool1\n  path: "foo.json"\n  reason: test1\n' +
      '- tool: TestTool2\n  path: "foo.json"\n  reason: test2\n',
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool1",
      path: "foo.json",
      reason: "test1",
    },
  ]);
});

test("suppression path relative to suppressions file", () => {
  let suppressions = _getSuppressionsFromYaml(
    "TestTool",
    "foo/foo.json",
    "bar/suppressions.yaml",
    '- tool: TestTool\n  path: "**"\n  reason: test',
  );
  expect(suppressions).toEqual([]);

  suppressions = _getSuppressionsFromYaml(
    "TestTool",
    "bar/foo.json",
    "bar/suppressions.yaml",
    '- tool: TestTool\n  path: "**"\n  reason: test',
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      path: "**",
      reason: "test",
    },
  ]);
});

test("yaml not array", () => {
  // Verify error contains suppressions filename and word "schema" in any order
  expect(() =>
    _getSuppressionsFromYaml("TestTool", "foo.json", "suppressions.yaml", "foo"),
  ).toThrowError(/suppressions.yaml.*schema|schema.*suppressions.yaml/);
});

test("yaml array not suppression", () => {
  // Verify error contains suppressions filename and word "schema" in any order
  expect(() =>
    _getSuppressionsFromYaml("TestTool", "foo.json", "suppressions.yaml", "- foo: bar"),
  ).toThrowError(/suppressions.yaml.*schema|schema.*suppressions.yaml/);
});
