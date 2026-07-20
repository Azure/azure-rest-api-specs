import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { describe, expect, it } from "vitest";

/**
 * @typedef {Record<string, string | undefined> & {
 *   name?: string,
 *   run?: string,
 *   uses?: string,
 *   "working-directory"?: string,
 * }} WorkflowStep
 */

/**
 * @typedef {object} SummarizeImpactWorkflow
 * @property {{impact: {steps: WorkflowStep[]}}} jobs
 */

describe("summarize-impact workflow", () => {
  it("bootstraps a preinstalled Node 24 runtime without setup-node", async () => {
    const workflow = /** @type {SummarizeImpactWorkflow} */ (
      yaml.load(
        await readFile(new URL("../../summarize-impact.yaml", import.meta.url), {
          encoding: "utf8",
        }),
      )
    );

    const step = workflow.jobs.impact.steps.find(
      (/** @type {WorkflowStep} */ candidate) => candidate.name === "Setup Node and install deps",
    );

    expect(step).toBeDefined();
    if (!step) {
      throw new Error("Setup Node and install deps step was not found");
    }

    expect(step.uses).toBeUndefined();
    expect(step["working-directory"]).toBe("after");
    expect(step.run).toContain("RUNNER_TOOL_CACHE:-/opt/hostedtoolcache");
    expect(step.run).toContain("node/24.*/x64/bin");
    expect(step.run).toContain("npm ci --no-audit --no-fund --prefer-offline");
  });
});
