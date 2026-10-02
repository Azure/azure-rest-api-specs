import { readFile } from "node:fs/promises";
import { runInNewContext } from "node:vm";
import { load } from "js-yaml";
import { describe, expect, it } from "vitest";
import { z } from "zod";

const statusJobs = [
  ["_reusable-set-check-status.yaml", "set-status"],
  ["summarize-checks.yaml", "run-summarize-checks"],
  ["package-name-approval-status.yaml", "post-results"],
  ["typespec-suppressions-status.yaml", "post-comment"],
] as const;
const labelJobs = [
  ["arm-auto-signoff-status.yaml", "arm-auto-signoff-status"],
  ["arm-universal-auto-signoff.yaml", "arm-universal-auto-signoff"],
  ["breaking-change-add-label-artifacts.yaml", "breaking-change-add-label-artifacts"],
  ["update-labels.yaml", "update-labels"],
] as const;
const directJobs = [
  ["_reusable-set-check-status.yaml", "set-status", "typespec-suppressions-approved"],
  ["summarize-checks.yaml", "run-summarize-checks", "any-label"],
  ["typespec-suppressions-status.yaml", "post-comment", "typespec-suppressions-approved"],
  ["arm-auto-signoff-status.yaml", "arm-auto-signoff-status", "ARMReview"],
  ["arm-universal-auto-signoff.yaml", "arm-universal-auto-signoff", "ARMReview"],
  ["arm-modeling-review.yaml", "arm-modeling-review", "ARMModelingSignedOff"],
  ["typespec-migration-validation.yaml", "typespec-migration-validation", "typespec-conversion-w"],
] as const;

async function shouldRun(
  file: string,
  job: string,
  event: {
    name: string;
    state?: string;
    action?: string;
    label?: string;
    conclusion?: string;
  },
): Promise<boolean> {
  const workflow = z
    .object({
      jobs: z.record(z.string(), z.object({ if: z.string().optional() })),
    })
    .parse(load(await readFile(new URL(`../${file}`, import.meta.url), "utf8")));
  const condition = workflow.jobs[job].if ?? "true";
  // These job guards use JS-compatible logical operators and the helpers provided below.
  const expression = condition.replace("github.event.pull_request.labels.*.name", "labelNames");
  return Boolean(
    runInNewContext(expression, {
      github: {
        event_name: event.name,
        event: {
          action: event.action,
          pull_request: { state: event.state, labels: [{ name: event.label }] },
          label: { name: event.label },
          workflow_run: { conclusion: event.conclusion },
          check_run: { name: "", check_suite: { app: { name: "" } } },
        },
      },
      inputs: { overriding_label: "typespec-suppressions-approved" },
      labelNames: [event.label],
      join: (values: string[], separator: string) => values.join(separator),
      contains: (value: string, search: string) => value.includes(search),
      startsWith: (value: string, prefix: string) => value.startsWith(prefix),
    }),
  );
}

describe("workflow job guards", () => {
  it.each([...statusJobs, ...labelJobs])("%s ignores skipped upstream runs", async (file, job) => {
    expect(await shouldRun(file, job, { name: "workflow_run", conclusion: "skipped" })).toBe(false);
    for (const conclusion of ["success", "failure"]) {
      expect(await shouldRun(file, job, { name: "workflow_run", conclusion })).toBe(true);
    }
  });

  it.each(labelJobs)("%s ignores cancelled upstream runs", async (file, job) => {
    expect(await shouldRun(file, job, { name: "workflow_run", conclusion: "cancelled" })).toBe(
      false,
    );
  });

  it.each(statusJobs)("%s still reports cancelled upstream runs", async (file, job) => {
    expect(await shouldRun(file, job, { name: "workflow_run", conclusion: "cancelled" })).toBe(
      true,
    );
  });

  it.each(directJobs)("%s ignores label events on closed PRs", async (file, job, label) => {
    for (const action of ["labeled", "unlabeled"]) {
      expect(
        await shouldRun(file, job, {
          name: "pull_request_target",
          state: "closed",
          action,
          label,
        }),
      ).toBe(false);
    }
  });

  it.each(directJobs)("%s still handles relevant labels on open PRs", async (file, job, label) => {
    expect(
      await shouldRun(file, job, {
        name: "pull_request_target",
        state: "open",
        action: "labeled",
        label,
      }),
    ).toBe(true);
  });

  it.each([
    ["package-name-approval-validation.yaml", "validate-approval"],
    ["typespec-suppressions-status.yaml", "post-comment"],
  ])("%s ignores unrelated label changes", async (file, job) => {
    expect(
      await shouldRun(file, job, {
        name: "pull_request_target",
        state: "open",
        action: "unlabeled",
        label: "no-recent-activity",
      }),
    ).toBe(false);
  });

  it("still evaluates SDK status when an open PR is reopened", async () => {
    for (const state of ["open", "closed"]) {
      expect(
        await shouldRun("spec-gen-sdk-status.yaml", "sdk-validation-status", {
          name: "pull_request_target",
          state,
          action: "reopened",
        }),
      ).toBe(state === "open");
    }
  });

  it("still enforces package approval authorization on closed PRs", async () => {
    for (const action of ["labeled", "unlabeled"]) {
      expect(
        await shouldRun("package-name-approval-validation.yaml", "validate-approval", {
          name: "pull_request_target",
          state: "closed",
          action,
          label: "package-name-approved-all",
        }),
      ).toBe(true);
    }
  });

  it("still enforces protected label authorization on closed PRs", async () => {
    expect(
      await shouldRun("protected-labels.yaml", "check-label", {
        name: "pull_request_target",
        state: "closed",
        action: "labeled",
        label: "typespec-suppressions-approved",
      }),
    ).toBe(true);
  });
});
