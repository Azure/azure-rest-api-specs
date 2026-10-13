import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { expect, test } from "vitest";

const testDirectory = path.dirname(fileURLToPath(import.meta.url));
const pipelineTemplatePath = path.resolve(
  testDirectory,
  "../../../pipelines/templates/stages/archetype-spec-gen-sdk.yml",
);
const pipelineTemplate = fs.readFileSync(pipelineTemplatePath, "utf8");

test("combines configured labels before creating the SDK pull request", () => {
  expect(pipelineTemplate).toContain('"$(BuildFailedLabel)"');
  expect(pipelineTemplate).toContain('"$(ManagementLabel)"');
  expect(pipelineTemplate).toContain('$pullRequestLabels = $pullRequestLabels -join ","');
  expect(pipelineTemplate).toContain('-PRLabels "$(PullRequestLabels)"');
});
