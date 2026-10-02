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
  [
    "_reusable-set-check-status.yaml",
    "set-status",
    "pull_request_target",
    "typespec-suppressions-approved",
  ],
  ["summarize-checks.yaml", "run-summarize-checks", "pull_request_target", "any-label"],
  [
    "typespec-suppressions-status.yaml",
    "post-comment",
    "pull_request_target",
    "typespec-suppressions-approved",
  ],
  ["arm-auto-signoff-status.yaml", "arm-auto-signoff-status", "pull_request_target", "ARMReview"],
  [
    "arm-universal-auto-signoff.yaml",
    "arm-universal-auto-signoff",
    "pull_request_target",
    "ARMReview",
  ],
  ["arm-modeling-review.yaml", "arm-modeling-review", "pull_request", "ARMModelingSignedOff"],
  [
    "typespec-migration-validation.yaml",
    "typespec-migration-validation",
    "pull_request",
    "typespec-conversion-w",
  ],
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
  const expression = condition
    .replace(/^\s*\$\{\{([\s\S]*?)\}\}\s*$/, "$1")
    .replace("github.event.pull_request.labels.*.name", "labelNames");
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

  it.each(directJobs)(
    "%s does not reevaluate checks after a closed PR's labels change",
    async (file, job, name, label) => {
      for (const action of ["labeled", "unlabeled"]) {
        expect(
          await shouldRun(file, job, {
            name,
            state: "closed",
            action,
            label,
          }),
        ).toBe(false);
      }
    },
  );

  it.each(directJobs)(
    "%s reevaluates an open PR when a relevant label is added or removed",
    async (file, job, name, label) => {
      for (const action of ["labeled", "unlabeled"]) {
        expect(await shouldRun(file, job, { name, state: "open", action, label })).toBe(true);
      }
    },
  );

  it.each([
    ["_reusable-set-check-status.yaml", "set-status"],
    ["summarize-checks.yaml", "run-summarize-checks"],
    ["arm-universal-auto-signoff.yaml", "arm-universal-auto-signoff"],
  ])("%s still evaluates new commits and reopened PRs without a label event", async (file, job) => {
    for (const action of ["opened", "synchronize", "reopened"]) {
      expect(
        await shouldRun(file, job, { name: "pull_request_target", state: "open", action }),
      ).toBe(true);
    }
  });

  it.each([
    ["package-name-approval-validation.yaml", "validate-approval"],
    ["typespec-suppressions-status.yaml", "post-comment"],
  ])(
    "%s does not run reviews when stale-label maintenance touches an open PR",
    async (file, job) => {
      expect(
        await shouldRun(file, job, {
          name: "pull_request_target",
          state: "open",
          action: "unlabeled",
          label: "no-recent-activity",
        }),
      ).toBe(false);
    },
  );

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
