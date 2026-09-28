import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { beforeAll, describe, expect, test } from "vitest";
import { parseDocument, visit, type YAMLMap } from "yaml";

const testDirectory = path.dirname(fileURLToPath(import.meta.url));
const pipelineTemplatePath = path.resolve(
  testDirectory,
  "../../../pipelines/templates/stages/archetype-spec-gen-sdk.yml",
);
const pipelineTemplate = parseDocument(fs.readFileSync(pipelineTemplatePath, "utf8"));
const steps: YAMLMap[] = [];
visit(pipelineTemplate, {
  Map(_key, node) {
    if (node.has("displayName")) steps.push(node);
  },
});

function getStep(displayName: string): YAMLMap {
  const step = steps.find((step) => step.get("displayName") === displayName);
  if (!step) throw new Error(`Pipeline step not found: ${displayName}`);
  return step;
}

describe("SDK PR build-failed labeling pipeline", () => {
  beforeAll(() => {
    expect(pipelineTemplate.errors).toEqual([]);
  });

  test("initializes the optional label before SDK generation", () => {
    const initialization = getStep("Create Run Time Variables");
    const generation = getStep("Generate SDK");

    expect(initialization.get("pwsh")).toContain('$buildFailedLabel = ""');
    expect(initialization.get("pwsh")).toContain(
      'Write-Host "##vso[task.setvariable variable=BuildFailedLabel]$buildFailedLabel"',
    );
    expect(steps.indexOf(initialization)).toBeLessThan(steps.indexOf(generation));
  });

  test("passes the emitted label when creating the SDK pull request", () => {
    const task = getStep("Create pull request");

    expect(task.get("task")).toBe("PowerShell@2");
    expect(task.getIn(["inputs", "filePath"])).toBe(
      "$(SdkRepoDirectory)/eng/common/scripts/Submit-PullRequest.ps1",
    );
    expect(task.getIn(["inputs", "arguments"])).toContain('-PRLabels "$(BuildFailedLabel)"');
    expect(task.getIn(["inputs", "arguments"])).toContain('-AuthToken "$(GH_TOKEN)"');
  });

  test("does not add the build-failed label after pull request creation", () => {
    expect(steps.some((step) => step.get("displayName") === "Add build-failed label")).toBe(false);
    for (const step of steps) {
      const args = step.getIn(["inputs", "arguments"]);
      if (typeof args === "string") expect(args).not.toContain('-Labels "$(BuildFailedLabel)"');
    }
  });
});
