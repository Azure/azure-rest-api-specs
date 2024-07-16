import { expect, test } from "vitest";
import { Suppression, getSuppressions } from "../src/suppressions.js";
import { join } from "path";

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
