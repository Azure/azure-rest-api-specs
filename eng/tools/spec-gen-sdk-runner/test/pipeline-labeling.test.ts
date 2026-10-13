import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, test } from "vitest";

const testDirectory = path.dirname(fileURLToPath(import.meta.url));
const pipelineTemplatePath = path.resolve(
  testDirectory,
  "../../../pipelines/templates/stages/archetype-spec-gen-sdk.yml",
);
const pipelineTemplate = fs.readFileSync(pipelineTemplatePath, "utf8");

function getTask(displayName: string): string {
  const displayNameIndex = pipelineTemplate.indexOf(`displayName: ${displayName}`);
  expect(displayNameIndex).toBeGreaterThanOrEqual(0);

  const taskStart = pipelineTemplate.lastIndexOf("        - task:", displayNameIndex);
  const taskEnd = pipelineTemplate.indexOf("\n        - ", displayNameIndex);
  expect(taskStart).toBeGreaterThanOrEqual(0);
  expect(taskEnd).toBeGreaterThan(displayNameIndex);

  return pipelineTemplate.slice(taskStart, taskEnd);
}

describe("SDK PR build-failed labeling pipeline", () => {
  test("initializes the optional label before SDK generation", () => {
    const initialization =
      'Write-Host "##vso[task.setvariable variable=BuildFailedLabel]$buildFailedLabel"';
    const initializationIndex = pipelineTemplate.indexOf(initialization);
    const generationIndex = pipelineTemplate.indexOf("displayName: 'Generate SDK'");

    expect(pipelineTemplate).toContain('$buildFailedLabel = ""');
    expect(initializationIndex).toBeGreaterThanOrEqual(0);
    expect(initializationIndex).toBeLessThan(generationIndex);
  });

  test("passes the emitted label when creating the SDK pull request", () => {
    const task = getTask("Create pull request");

    expect(task).toContain(
      "filePath: $(SdkRepoDirectory)/eng/common/scripts/Submit-PullRequest.ps1",
    );
    expect(task).toContain('-PRLabels "$(BuildFailedLabel)"');
    expect(task).toContain('-AuthToken "$(GH_TOKEN)"');
  });

  test("does not add the build-failed label after pull request creation", () => {
    expect(pipelineTemplate).not.toContain("displayName: Add build-failed label");
    expect(pipelineTemplate).not.toContain('-Labels "$(BuildFailedLabel)"');
  });
});
