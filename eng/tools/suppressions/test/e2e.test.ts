import { expect, test } from "vitest";
import { getSuppressions } from "../src/suppressions.js";
import { join } from "path";

async function getTestSuppressions(path: string, tool: string = "TestTool") {
  return await getSuppressions(tool, join(__dirname, "e2e", path));
}

test.concurrent("no suppressions.yaml", async () => {
  const suppressions = await getTestSuppressions("noSuppressionsYaml");
  expect(suppressions).toEqual([]);
});

test.concurrent("empty suppressions.yaml", async () => {
  const suppressions = await getTestSuppressions("emptySuppressionsYaml");
  expect(suppressions).toEqual([]);
});

test.concurrent("suppress foo.json, get foo.json", async () => {
  const suppressions = await getTestSuppressions(join("suppressFooJson", "foo.json"));
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["foo.json"],
      reason: "test",
    },
  ]);
});

test.concurrent("suppress foo.json, get bar.json", async () => {
  const suppressions = await getTestSuppressions(join("suppressFooJson", "bar.json"));
  expect(suppressions).toEqual([]);
});

test.concurrent("suppress foo.json, get foo.json w/ different tool", async () => {
  const suppressions = await getTestSuppressions(join("suppressFooJson", "foo.json"), "TestTool2");
  expect(suppressions).toEqual([]);
});

test.concurrent("merge, get bar.json", async () => {
  const suppressions = await getTestSuppressions(join("merge", "foo", "bar", "bar.json"));
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["**"],
      reason: "bar-globstar",
    },
    {
      tool: "TestTool",
      paths: ["*"],
      reason: "bar-star",
    },
    {
      tool: "TestTool",
      paths: ["bar.json"],
      reason: "bar-exact",
    },
    {
      tool: "TestTool",
      paths: ["**"],
      reason: "foo-globstar",
    },
    {
      tool: "TestTool",
      paths: ["bar/**"],
      reason: "foo-bar-globstar",
    },
    {
      tool: "TestTool",
      paths: ["bar/*"],
      reason: "foo-bar-star",
    },
    {
      tool: "TestTool",
      paths: ["bar/bar.json"],
      reason: "foo-bar-exact",
    },
    {
      tool: "TestTool",
      paths: ["foo/**"],
      reason: "root-foo-globstar",
    },
    {
      tool: "TestTool",
      paths: ["foo/bar/**"],
      reason: "root-foo-bar-globstar",
    },
    {
      tool: "TestTool",
      paths: ["foo/bar/*"],
      reason: "root-foo-bar-star",
    },
    {
      tool: "TestTool",
      paths: ["foo/bar/bar.json"],
      reason: "root-foo-bar-exact",
    },
  ]);
});

test.concurrent("merge, get foo.json", async () => {
  const suppressions = await getTestSuppressions(join("merge", "foo", "foo.json"));
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["**"],
      reason: "foo-globstar",
    },
    {
      tool: "TestTool",
      paths: ["*"],
      reason: "foo-star",
    },
    {
      tool: "TestTool",
      paths: ["foo.json"],
      reason: "foo-exact",
    },
    {
      tool: "TestTool",
      paths: ["foo/**"],
      reason: "root-foo-globstar",
    },
    {
      tool: "TestTool",
      paths: ["foo/*"],
      reason: "root-foo-star",
    },
    {
      tool: "TestTool",
      paths: ["foo/foo.json"],
      reason: "root-foo-exact",
    },
  ]);
});
