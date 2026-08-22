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

  test("applies the emitted label to the submitted SDK pull request", () => {
    const task = getTask("Add build-failed label");

    expect(task).toContain("filePath: $(SdkRepoDirectory)/eng/common/scripts/Add-IssueLabels.ps1");
    expect(task).toContain('-IssueNumber "$(Submitted.PullRequest.Number)"');
    expect(task).toContain('-Labels "$(BuildFailedLabel)"');
    expect(task).toContain('-AuthToken "$(GH_TOKEN)"');
  });

  test("runs only after an SDK pull request exists and a label was emitted", () => {
    const createPullRequestIndex = pipelineTemplate.indexOf("displayName: Create pull request");
    const buildFailedLabelIndex = pipelineTemplate.indexOf("displayName: Add build-failed label");
    const autoReleaseLabelIndex = pipelineTemplate.indexOf("displayName: Add auto-release label");
    const task = getTask("Add build-failed label");

    expect(buildFailedLabelIndex).toBeGreaterThan(createPullRequestIndex);
    expect(buildFailedLabelIndex).toBeLessThan(autoReleaseLabelIndex);
    expect(task).toContain("succeeded()");
    expect(task).toContain("eq(variables['HasChanges'], 'true')");
    expect(task).toContain("ne(variables['Build.Reason'], 'PullRequest')");
    expect(task).toContain("not(endsWith(variables['SdkRepoName'], '-pr'))");
    expect(task).toContain("ne(variables['BuildFailedLabel'], '')");
  });
});
