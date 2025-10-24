import { expect, test } from "vitest";
import { Suppression, getSuppressionsFromYaml } from "../src/suppressions.js";

test("empty suppressions.yaml", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "test.json",
    "suppressions.yaml",
    "",
  );
  expect(suppressions).toEqual([]);
});

test("one suppression no match", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "foo.json",
    "suppressions.yaml",
    '- tool: TestTool\n  path: "bar.json"\n  reason: test',
  );
  expect(suppressions).toEqual([]);
});

test("one suppression match", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
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
  const suppressions: Suppression[] = getSuppressionsFromYaml(
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

test("paths match first", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Foo",
    "suppressions.yaml",
    "- tool: TestTool\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["Microsoft.Foo", "Microsoft.Bar"],
      reason: "test",
    },
  ]);
});

test("paths match second", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Bar",
    "suppressions.yaml",
    "- tool: TestTool\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["Microsoft.Foo", "Microsoft.Bar"],
      reason: "test",
    },
  ]);
});

test("paths match none", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Baz",
    "suppressions.yaml",
    "- tool: TestTool\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([]);
});

test("path and paths match first", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
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
  const suppressions: Suppression[] = getSuppressionsFromYaml(
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
  const suppressions: Suppression[] = getSuppressionsFromYaml(
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
  const suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "Microsoft.Baz",
    "suppressions.yaml",
    "- tool: TestTool\n  path: Microsoft.First\n  paths:\n    - Microsoft.Foo\n    - Microsoft.Bar\n  reason: test",
  );
  expect(suppressions).toEqual([]);
});

test("globstar matching", () => {
  const suppressions: Suppression[] = getSuppressionsFromYaml(
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
  const suppressions: Suppression[] = getSuppressionsFromYaml(
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
  let suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "foo/foo.json",
    "bar/suppressions.yaml",
    '- tool: TestTool\n  path: "**"\n  reason: test',
  );
  expect(suppressions).toEqual([]);

  suppressions = getSuppressionsFromYaml(
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
    getSuppressionsFromYaml("TestTool", "foo.json", "suppressions.yaml", "foo"),
  ).toThrowErrorMatchingInlineSnapshot(
    `[Error: ✖ Invalid input: expected array, received string]`,
  );
});

test("yaml array not suppression", () => {
  expect(() => getSuppressionsFromYaml("TestTool", "foo.json", "suppressions.yaml", "- foo: bar"))
    .toThrowErrorMatchingInlineSnapshot(`
    [Error: ✖ Invalid input: expected string, received undefined
      → at [0].tool
    ✖ Invalid input: expected string, received undefined
      → at [0].reason]
  `);
});

test("suppression with rules", () => {
  let suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "foo",
    "suppressions.yaml",
    `
- tool: TestTool
  path: foo
  rules: [my-rule]
  sub-rules:
    - my.option.a
    - my.option.b
  reason: test
    `,
  );
  expect(suppressions).toStrictEqual([
    {
      tool: "TestTool",
      if: undefined,
      paths: ["foo"],
      rules: ["my-rule"],
      subRules: ["my.option.a", "my.option.b"],
      reason: "test",
    },
  ]);
});

test.each([
  { context: { foo: false, bar: false }, expected: ["no-if", "process-version"] },
  {
    context: { foo: true, bar: false },
    expected: ["no-if", "if-foo", "if-foo-or-bar", "process-version"],
  },
  {
    context: { foo: false, bar: true },
    expected: ["no-if", "if-bar", "if-foo-or-bar", "process-version"],
  },
  {
    context: { foo: true, bar: true },
    expected: ["no-if", "if-foo", "if-bar", "if-foo-or-bar", "if-foo-and-bar", "process-version"],
  },
])("if($context)", ({ context, expected }) => {
  const suppressionYaml = `
- tool: TestTool
  path: "**"
  reason: no-if
- tool: TestTool
  path: "**"
  if: foo
  reason: if-foo
- tool: TestTool
  path: "**"
  if: bar
  reason: if-bar
- tool: TestTool
  path: "**"
  if: foo || bar
  reason: if-foo-or-bar
- tool: TestTool
  path: "**"
  if: foo && bar
  reason: if-foo-and-bar
- tool: TestTool
  path: "**"
  if: require("process").version.startsWith("v")
  reason: process-version
`;

  let suppressions: Suppression[] = getSuppressionsFromYaml(
    "TestTool",
    "test-path",
    "suppressions.yaml",
    suppressionYaml,
    context,
  );

  expect(suppressions.map((s) => s.reason).sort()).toEqual(expected.sort());
});

test.each([
  ["invalid javascript", "Unexpected identifier 'javascript'"],
  ["1(1)", "1 is not a function"],
])("if: %s", (ifExpression, expectedException) => {
  expect(() =>
    getSuppressionsFromYaml(
      "TestTool",
      "test-path",
      "suppressions.yaml",
      `- tool: TestTool\n  if: "${ifExpression}"\n  path: "**"\n  reason: test`,
    ),
  ).throws(expectedException);
});
