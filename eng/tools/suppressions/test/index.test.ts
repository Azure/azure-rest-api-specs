import { expect, test } from "vitest";
import { Suppression, _getSuppressionsFromYaml } from "../src/index.js";

test("empty suppressions.yaml", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "test.json",
    "suppressions.yaml",
    "",
  );
  expect(suppressions).toEqual([]);
});

test("one suppression no match", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "bar.json"\n  reason: test',
  );
  expect(suppressions).toEqual([]);
});

test("one suppression match", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "foo.json"\n  reason: test',
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["foo.json"],
      reason: "test",
    },
  ]);
});

test("one suppression match directory", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Foo",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "**"\n  reason: test',
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["**"],
      reason: "test",
    },
  ]);
});

test("path and paths match first", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.First",
    "suppressions.yaml",
    "- tool: TestTool\n  path: Microsoft.First\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["Microsoft.First", "Microsoft.Foo", "Microsoft.Bar"],
      reason: "test",
    },
  ]);
});

test("path and paths match second", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Foo",
    "suppressions.yaml",
    "- tool: TestTool\n  path: Microsoft.First\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["Microsoft.First", "Microsoft.Foo", "Microsoft.Bar"],
      reason: "test",
    },
  ]);
});

test("path and paths match third", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Bar",
    "suppressions.yaml",
    "- tool: TestTool\n  path: Microsoft.First\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["Microsoft.First", "Microsoft.Foo", "Microsoft.Bar"],
      reason: "test",
    },
  ]);
});

test("path and paths match none", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Baz",
    "suppressions.yaml",
    "- tool: TestTool\n  path: Microsoft.First\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([]);
});

test("globstar matching", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
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
      paths: ["data-plane/Foo/stable/2024-01-01/foo.json"],
      reason: "exact match",
    },
    {
      tool: "TestTool",
      paths: ["data-plane/Foo/stable/2024-01-01/**/*.json"],
      reason: "all swagger under version",
    },
    {
      tool: "TestTool",
      paths: ["data-plane/**/*.json"],
      reason: "all swagger under data-plane",
    },
    {
      tool: "TestTool",
      paths: ["**/*.json"],
      reason: "all swagger under spec",
    },
    {
      tool: "TestTool",
      paths: ["**"],
      reason: "all files under spec",
    },
  ]);
});

test("tool matching", () => {
  const suppressions: Suppression[] = _getSuppressionsFromYaml(
    "TestTool1",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool1\n  path: "foo.json"\n  reason: test1\n' +
      '- tool: TestTool2\n  path: "foo.json"\n  reason: test2\n',
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool1",
      paths: ["foo.json"],
      reason: "test1",
    },
  ]);
});

test("suppression path relative to suppressions file", () => {
  let suppressions: Suppression[] = _getSuppressionsFromYaml(
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
      paths: ["**"],
      reason: "test",
    },
  ]);
});

test("yaml not array", () => {
  expect(() =>
    _getSuppressionsFromYaml("TestTool", "foo.json", "suppressions.yaml", "foo"),
  ).toThrowErrorMatchingInlineSnapshot(
    `[ZodValidationError: Validation error: Expected array, received string]`,
  );
});

test("yaml array not suppression", () => {
  expect(() =>
    _getSuppressionsFromYaml("TestTool", "foo.json", "suppressions.yaml", "- foo: bar"),
  ).toThrowErrorMatchingInlineSnapshot(
    `[ZodValidationError: Validation error: Required at "[0].tool"; Required at "[0].reason"]`,
  );
});
