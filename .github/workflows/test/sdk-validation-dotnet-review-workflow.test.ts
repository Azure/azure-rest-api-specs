import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";
import { parse } from "yaml";

const workflowsDirectory = resolve(dirname(fileURLToPath(import.meta.url)), "..");

type WorkflowStep = {
  name?: string;
  uses?: string;
  with?: Record<string, unknown>;
};

type WorkflowJob = {
  needs?: string[];
  steps: WorkflowStep[];
};

describe("generated .NET SDK review workflow", () => {
  it("validates agent output in a fresh trusted job", async () => {
    const workflow = parse(
      await readFile(resolve(workflowsDirectory, "sdk-validation-dotnet-review.lock.yml"), "utf8"),
    ) as { jobs: Record<string, WorkflowJob> };
    const agentSteps = workflow.jobs.agent.steps;
    const validationJob = workflow.jobs["validate-result"];

    expect(validationJob.needs).toContain("agent");
    expect(validationJob.steps).toEqual(
      expect.arrayContaining([
        expect.objectContaining({ name: "Checkout trusted validator" }),
        expect.objectContaining({ name: "Validate SDK review result" }),
        expect.objectContaining({
          name: "Upload validated SDK review result",
          with: expect.objectContaining({
            name: "sdk-review-result-workflow-${{ github.event.workflow_run.id }}",
          }),
        }),
      ]),
    );
    expect(agentSteps).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          name: "Upload raw SDK review result",
          with: expect.objectContaining({
            name: "sdk-review-raw-result-workflow-${{ github.event.workflow_run.id }}",
          }),
        }),
      ]),
    );
    expect(agentSteps.some((step) => step.name === "Validate report-only SDK review result")).toBe(
      false,
    );
  });
});
