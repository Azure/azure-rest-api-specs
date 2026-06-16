import { join } from "path";
import { expect, test } from "vitest";
import { Suppression, getSuppressions } from "../src/suppressions.js";

/**
 * Returns the suppressions for a tool (default "TestTool") applicable to a path under folder "e2e".
 *
 * @param path Relative path to to file or directory to analyze, under folder "e2e".
 * @param tool Name of tool. Matched against property "tool" in suppressions.yaml.  Defaults to "TestTool".
 * @returns Array of suppressions matching tool and path (may be empty).
 */
async function getTestSuppressions(
  path: string,
  tool: string = "TestTool",
): Promise<Suppression[]> {
  return await getSuppressions(tool, join(__dirname, "e2e", path));
}

test.concurrent("no suppressions.yaml", async () => {
  const suppressions: Suppression[] = await getTestSuppressions("noSuppressionsYaml");
  expect(suppressions).toEqual([]);
});

test.concurrent("empty suppressions.yaml", async () => {
  const suppressions: Suppression[] = await getTestSuppressions("emptySuppressionsYaml");
  expect(suppressions).toEqual([]);
});

test.concurrent("suppress foo.json, get foo.json", async () => {
  const suppressions: Suppression[] = await getTestSuppressions(
    join("suppressFooJson", "foo.json"),
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["foo.json"],
      reason: "test",
    },
  ]);
});

test.concurrent("suppress foo.json, get bar.json", async () => {
  const suppressions: Suppression[] = await getTestSuppressions(
    join("suppressFooJson", "bar.json"),
  );
  expect(suppressions).toEqual([]);
});

test.concurrent("suppress foo.json, get foo.json w/ different tool", async () => {
  const suppressions: Suppression[] = await getTestSuppressions(
    join("suppressFooJson", "foo.json"),
    "TestTool2",
  );
  expect(suppressions).toEqual([]);
});

test.concurrent("merge, get bar.json", async () => {
  const suppressions: Suppression[] = await getTestSuppressions(
    join("merge", "foo", "bar", "bar.json"),
  );
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
  const suppressions: Suppression[] = await getTestSuppressions(join("merge", "foo", "foo.json"));
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

test.concurrent("suppress rules", async () => {
  const suppressions: Suppression[] = await getTestSuppressions(
    join("suppressRules", "foo.json"),
    "TestTool",
  );
  expect(suppressions).toEqual([
    {
      tool: "TestTool",
      paths: ["foo.json"],
      reason: "test",
      rules: ["rule-1"],
      subRules: ["sub-rule-1"],
    },
  ]);
});
