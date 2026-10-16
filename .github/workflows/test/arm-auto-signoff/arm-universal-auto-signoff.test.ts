import { afterEach, describe, expect, it, vi } from "vitest";
import {
  applyUniversalSignoff,
  getLabelActionImpl,
} from "../../src/arm-auto-signoff/arm-universal-auto-signoff.ts";
import { PASSED_REVIEW_DESCRIPTION } from "../../src/arm-auto-signoff/arm-semantic-review.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

const owner = "Azure";
const repo = "azure-rest-api-specs";
const headSha = "a".repeat(40);
const issueNumber = 123;
const reviewUrl = `https://github.com/${owner}/${repo}/actions/runs/456/attempts/1`;
const none = {
  ARMSignedOff: "none",
  ARMAutoSignedOff: "none",
  ARMManualSignoffRequired: "none",
};
const add = { ...none, ARMSignedOff: "add", ARMAutoSignedOff: "add" };
const remove = { ...none, ARMSignedOff: "remove", ARMAutoSignedOff: "remove" };
const ready = ["ARMReview", "WaitForARMFeedback"];
const statuses = [
  {
    context: "ARM Semantic Review",
    state: "success",
    description: PASSED_REVIEW_DESCRIPTION,
    target_url: reviewUrl,
    updated_at: "2026-01-01",
  },
  { context: "Swagger LintDiff", state: "success", updated_at: "2026-01-01" },
  { context: "Swagger Avocado", state: "success", updated_at: "2026-01-01" },
];
function fixture(labels = ready) {
  const github = createMockGithub();
  const core = createMockCore();
  const pull = {
    state: "open",
    draft: false,
    head: { sha: headSha },
    labels: labels.map((name) => ({ name })),
  };
  github.rest.pulls.get.mockResolvedValue({ data: pull });
  const addLabels = (labels: string[]) => {
    pull.labels = [...new Set([...pull.labels.map((label) => label.name), ...labels])].map(
      (name) => ({ name }),
    );
  };
  github.rest.issues.addLabels.mockImplementation(({ labels }: { labels: string[] }) => {
    addLabels(labels);
    return Promise.resolve({ data: pull.labels });
  });
  github.rest.issues.removeLabel.mockImplementation(({ name }: { name: string }) => {
    pull.labels = pull.labels.filter((label) => label.name !== name);
    return Promise.resolve({ data: pull.labels });
  });
  github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
    data: { statuses, total_count: statuses.length },
  });
  github.rest.actions.getWorkflowRun.mockResolvedValue({
    data: {
      path: ".github/workflows/arm-api-review.lock.yml",
      event: "workflow_dispatch",
      run_attempt: 1,
      run_number: 10,
      status: "completed",
      conclusion: "success",
    },
  });
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: { artifacts: [{ name: `head-sha=${headSha};issue-number=${issueNumber}` }] },
  });
  github.rest.issues.listEvents.mockResolvedValue({
    data: [
      {
        id: 1,
        event: "labeled",
        label: { name: "ARMSignedOff" },
        actor: { login: "github-actions[bot]" },
      },
    ],
  });
  const inputs = { owner, repo, head_sha: headSha, issue_number: issueNumber, github, core };
  const run = () => getLabelActionImpl(inputs);
  const publish = (expectedHead = headSha) => {
    vi.stubEnv("ARM_SIGNOFF_PR_NUMBER", String(issueNumber));
    vi.stubEnv("ARM_SIGNOFF_HEAD_SHA", expectedHead);
    return applyUniversalSignoff({
      github,
      core,
      context: Object.assign(createMockContext(), {
        eventName: "workflow_dispatch",
        repo: { owner, repo },
      }),
    });
  };
  return { github, core, pull, inputs, run, publish, addLabels };
}
afterEach(() => vi.unstubAllEnvs());

describe("universal production signoff", () => {
  it("grants production signoff and its ownership marker, not a pilot-only label", async () => {
    const { github, publish } = fixture();
    expect((await publish()).labelActions).toEqual(add);
    expect(github.rest.issues.addLabels).toHaveBeenCalledExactlyOnceWith({
      owner,
      repo,
      issue_number: issueNumber,
      labels: ["ARMSignedOff", "ARMAutoSignedOff"],
    });
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("keeps successful automatic signoff without redundant writes", async () => {
    const { github, publish } = fixture(["ARMReview", "ARMSignedOff", "ARMAutoSignedOff"]);
    expect((await publish()).labelActions).toEqual(none);
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it.each(["failure", "pending", "error", "missing", "unrecognized-success"])(
    "withholds approval for %s semantic review",
    async (state) => {
      const { github, run } = fixture();
      const changed =
        state === "missing"
          ? statuses.slice(1)
          : [
              {
                ...statuses[0],
                state: state === "unrecognized-success" ? "success" : state,
                description: "",
              },
              ...statuses.slice(1),
            ];
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: { statuses: changed, total_count: changed.length },
      });
      expect((await run()).labelActions).toEqual(none);
      expect(github.rest.actions.getWorkflowRun).not.toHaveBeenCalled();
    },
  );

  it("requires sticky manual review for scoped/oversized results", async () => {
    const { github, run } = fixture();
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          {
            ...statuses[0],
            state: "error",
            description: "Manual review required: scoped review requires manual signoff",
          },
        ],
        total_count: 1,
      },
    });
    expect((await run()).labelActions).toEqual({ ...none, ARMManualSignoffRequired: "add" });
  });

  it.each([
    "skip-arm-review",
    "NotReadyForARMReview",
    "ARMChangesRequested",
    "ARMManualSignoffRequired",
    "ARMModelingReviewRequired",
    "VersioningReviewRequired",
    "BreakingChangeReviewRequired",
    "CI-NewRPNamespaceWithoutRPaaS",
    "CI-RpaaSRPNotInPrivateRepo",
    "SuppressionReviewRequired",
    "typespec-suppressions-review-required",
  ])("honors raw %s holds even before summary updates readiness", async (label) => {
    const { github, run } = fixture([...ready, label]);
    expect((await run()).labelActions).toEqual(none);
    expect(github.rest.repos.getCombinedStatusForRef).not.toHaveBeenCalled();
  });

  it.each([
    ["VersioningReviewRequired", "Versioning-Approved-Previously"],
    ["BreakingChangeReviewRequired", "BreakingChange-Approved-Benign"],
    ["CI-NewRPNamespaceWithoutRPaaS", "RPaaSException"],
    ["CI-RpaaSRPNotInPrivateRepo", "RPaaSException"],
    ["SuppressionReviewRequired", "Approved-Suppression"],
    ["typespec-suppressions-review-required", "typespec-suppressions-approved"],
  ])(
    "accepts the existing %s exception without bypassing semantic review",
    async (hold, approval) => {
      const { run } = fixture([...ready, hold, approval]);
      expect((await run()).labelActions).toEqual(add);
    },
  );

  it("leaves modeling lease signoff semantics alone", async () => {
    expect((await fixture([...ready, "ARMModelingAutoSignedOff"]).run()).labelActions).toEqual(add);
    expect(
      (await fixture([...ready, "ARMModelingSignedOff", "ARMModelingReviewRequired"]).run())
        .labelActions,
    ).toEqual(none);
  });

  it.each(["Swagger LintDiff", "Swagger Avocado"])("requires %s to succeed", async (name) => {
    const { github, run } = fixture();
    for (const state of ["missing", "pending", "failure", "error"]) {
      const changed = statuses.flatMap((status) =>
        status.context !== name ? [status] : state === "missing" ? [] : [{ ...status, state }],
      );
      github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
        data: { statuses: changed, total_count: changed.length },
      });
      expect((await run()).labelActions).toEqual(none);
    }
  });

  it("matches status context casing and ignores unrelated failures", async () => {
    const { github, run } = fixture();
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: {
        statuses: [
          ...statuses.map((status) => ({ ...status, context: status.context.toUpperCase() })),
          { context: "unrelated", state: "failure" },
        ],
        total_count: 4,
      },
    });
    expect((await run()).labelActions).toEqual(add);
  });

  it.each(["closed", "stale", "draft", "not-queued", "no-arm-review"])(
    "withholds signoff for a %s PR",
    async (condition) => {
      const { github, pull, run } = fixture();
      github.rest.pulls.get.mockResolvedValue({
        data: {
          ...pull,
          state: condition === "closed" ? "closed" : "open",
          draft: condition === "draft",
          head: { sha: condition === "stale" ? "b".repeat(40) : headSha },
          labels:
            condition === "not-queued"
              ? [{ name: "ARMReview" }]
              : condition === "no-arm-review"
                ? []
                : pull.labels,
        },
      });
      expect((await run()).labelActions).toEqual(none);
    },
  );

  it("does nothing without trusted head correlation", async () => {
    const { inputs, github } = fixture();
    expect((await getLabelActionImpl({ ...inputs, head_sha: "" })).labelActions).toEqual(none);
    expect(github.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("removes only bot-owned automatic signoff when the current head does not pass", async () => {
    const { github, publish } = fixture(["ARMReview", "ARMSignedOff", "ARMAutoSignedOff"]);
    github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
      data: { statuses: [], total_count: 0 },
    });
    expect((await publish()).labelActions).toEqual(remove);
    expect(github.rest.issues.removeLabel).toHaveBeenNthCalledWith(
      1,
      expect.objectContaining({ name: "ARMSignedOff" }),
    );
    expect(github.rest.issues.removeLabel).toHaveBeenNthCalledWith(
      2,
      expect.objectContaining({ name: "ARMAutoSignedOff" }),
    );
  });

  it.each([false, true])(
    "preserves manual signoff, including when an old marker exists: %s",
    async (marker) => {
      const { github, publish } = fixture([
        "ARMReview",
        "ARMChangesRequested",
        "ARMSignedOff",
        ...(marker ? ["ARMAutoSignedOff"] : []),
      ]);
      github.rest.issues.listEvents.mockResolvedValue({
        data: [
          {
            id: 1,
            event: "labeled",
            label: { name: "ARMSignedOff" },
            actor: { login: "human-reviewer" },
          },
        ],
      });
      expect((await publish()).labelActions).toEqual(none);
      expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    },
  );

  it.each(["queued", "in_progress", "failure", "cancelled", "rerun", "wrong-workflow"])(
    "does not trust a %s reviewer run behind a passing status",
    async (condition) => {
      const { github, run } = fixture();
      github.rest.actions.getWorkflowRun.mockResolvedValue({
        data: {
          path:
            condition === "wrong-workflow"
              ? ".github/workflows/other.yaml"
              : ".github/workflows/arm-api-review.lock.yml",
          event: "workflow_dispatch",
          run_attempt: condition === "rerun" ? 2 : 1,
          run_number: 10,
          status: ["queued", "in_progress"].includes(condition) ? condition : "completed",
          conclusion: ["failure", "cancelled"].includes(condition) ? condition : "success",
        },
      });
      expect((await run()).labelActions).toEqual(none);
    },
  );

  it("rejects an older same-head pass as soon as a newer review is queued", async () => {
    const { github, run } = fixture();
    github.rest.actions.listWorkflowRuns.mockResolvedValue({
      data: {
        workflow_runs: [
          {
            run_number: 11,
            display_title: "ARM API Review #123 (workflow_dispatch)",
            status: "queued",
            conclusion: null,
          },
        ],
      },
    });
    expect((await run()).labelActions).toEqual(none);
  });

  it("does not confuse unrelated or skipped runs with a newer review", async () => {
    const { github, run } = fixture();
    github.rest.actions.listWorkflowRuns.mockResolvedValue({
      data: {
        workflow_runs: [
          {
            run_number: 12,
            display_title: "ARM API Review #123 (issue_comment)",
            conclusion: "skipped",
          },
          {
            run_number: 11,
            display_title: "ARM API Review #999 (workflow_dispatch)",
            conclusion: null,
          },
        ],
      },
    });
    expect((await run()).labelActions).toEqual(add);
  });

  it.each(["sha", "pr"])(
    "rejects a result whose trusted artifact has the wrong %s",
    async (field) => {
      const { github, run } = fixture();
      github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
        data: {
          artifacts: [
            {
              name: `head-sha=${field === "sha" ? "b".repeat(40) : headSha};issue-number=${field === "pr" ? 999 : issueNumber}`,
            },
          ],
        },
      });
      expect((await run()).labelActions).toEqual(none);
    },
  );

  it.each(["head", "hold", "draft", "human-signoff"])(
    "does not publish an evaluated approval after %s changes",
    async (change) => {
      const { github, pull, publish } = fixture();
      github.rest.pulls.get.mockResolvedValueOnce({ data: pull }).mockResolvedValue({
        data: {
          ...pull,
          head: { sha: change === "head" ? "b".repeat(40) : headSha },
          draft: change === "draft",
          labels: [
            ...pull.labels,
            ...(change === "hold"
              ? [{ name: "ARMChangesRequested" }]
              : change === "human-signoff"
                ? [{ name: "ARMSignedOff" }]
                : []),
          ],
        },
      });
      expect((await publish()).labelActions).toEqual(none);
      expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    },
  );

  it("checks the live head once more after status and workflow API calls", async () => {
    const { github, pull, publish } = fixture();
    github.rest.pulls.get
      .mockResolvedValueOnce({ data: pull })
      .mockResolvedValueOnce({ data: pull })
      .mockResolvedValue({ data: { ...pull, head: { sha: "b".repeat(40) } } });
    expect((await publish()).labelActions).toEqual(none);
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it("does not publish a pass when a newer attempt appears during evaluation", async () => {
    const { github, publish } = fixture();
    const valid = await github.rest.actions.getWorkflowRun({ owner, repo, run_id: 456 });
    github.rest.actions.getWorkflowRun
      .mockResolvedValueOnce(valid)
      .mockResolvedValue({ data: { ...valid.data, run_attempt: 2 } });
    expect((await publish()).labelActions).toEqual(none);
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it("does not publish a cached pass after semantic review becomes pending", async () => {
    const { github, publish } = fixture();
    github.rest.repos.getCombinedStatusForRef
      .mockResolvedValueOnce({ data: { statuses, total_count: statuses.length } })
      .mockResolvedValue({
        data: {
          statuses: [{ ...statuses[0], state: "pending" }, ...statuses.slice(1)],
          total_count: statuses.length,
        },
      });
    expect((await publish()).labelActions).toEqual(none);
    expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
  });

  it.each(["head", "hold", "draft", "newer-review", "pending", "deterministic-failure"])(
    "compensates a stale write after the competing %s reconciliation has already finished",
    async (change) => {
      const { github, pull, publish, addLabels } = fixture();
      github.rest.issues.addLabels.mockImplementationOnce(
        async ({ labels }: { labels: string[] }) => {
          if (change === "head") {
            pull.head.sha = "b".repeat(40);
            github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
              data: { statuses: [], total_count: 0 },
            });
          } else if (change === "hold") {
            addLabels(["ARMChangesRequested"]);
          } else if (change === "draft") {
            pull.draft = true;
          } else if (change === "newer-review") {
            github.rest.actions.listWorkflowRuns.mockResolvedValue({
              data: {
                workflow_runs: [
                  {
                    run_number: 11,
                    display_title: "ARM API Review #123 (workflow_dispatch)",
                    status: "queued",
                    conclusion: null,
                  },
                ],
              },
            });
          } else {
            const changed = statuses.map((status) =>
              status.context === (change === "pending" ? "ARM Semantic Review" : "Swagger Avocado")
                ? { ...status, state: change === "pending" ? "pending" : "failure" }
                : status,
            );
            github.rest.repos.getCombinedStatusForRef.mockResolvedValue({
              data: { statuses: changed, total_count: changed.length },
            });
          }
          expect((await publish(pull.head.sha)).labelActions).toEqual(none);
          addLabels(labels);
          return { data: pull.labels };
        },
      );
      expect((await publish()).labelActions).toEqual(remove);
      expect(pull.labels.map((label) => label.name)).not.toContain("ARMSignedOff");
      expect(pull.labels.map((label) => label.name)).not.toContain("ARMAutoSignedOff");
      if (change === "hold") {
        expect(pull.labels.map((label) => label.name)).toContain("ARMChangesRequested");
      }
      expect(github.rest.issues.addLabels).toHaveBeenCalledTimes(1);
    },
  );

  it("compensates even when the diagnostic marker disappeared during the write", async () => {
    const { github, pull, publish, addLabels } = fixture();
    github.rest.issues.addLabels.mockImplementationOnce(({ labels }: { labels: string[] }) => {
      addLabels(labels.filter((label) => label !== "ARMAutoSignedOff"));
      pull.head.sha = "b".repeat(40);
      return Promise.resolve({ data: pull.labels });
    });
    expect((await publish()).labelActions).toEqual({ ...none, ARMSignedOff: "remove" });
    expect(pull.labels.map((label) => label.name)).not.toContain("ARMSignedOff");
  });

  it("preserves a human's replacement signoff while compensating the automatic write", async () => {
    const { github, pull, publish, addLabels } = fixture();
    github.rest.issues.addLabels.mockImplementationOnce(({ labels }: { labels: string[] }) => {
      addLabels([...labels, "ARMChangesRequested"]);
      github.rest.issues.listEvents.mockResolvedValue({
        data: [
          {
            id: 2,
            event: "labeled",
            label: { name: "ARMSignedOff" },
            actor: { login: "human-reviewer" },
          },
        ],
      });
      return Promise.resolve({ data: pull.labels });
    });
    expect((await publish()).labelActions).toEqual(none);
    expect(pull.labels.map((label) => label.name)).toContain("ARMSignedOff");
    expect(pull.labels.map((label) => label.name)).toContain("ARMChangesRequested");
    expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
  });

  it("rolls back locally without depending on an available reconciliation dispatch", async () => {
    const { github, pull, publish, addLabels } = fixture();
    github.rest.actions.createWorkflowDispatch.mockRejectedValue(new Error("Dispatch unavailable"));
    github.rest.issues.addLabels.mockImplementationOnce(({ labels }: { labels: string[] }) => {
      addLabels(labels);
      pull.head.sha = "b".repeat(40);
      return Promise.resolve({ data: pull.labels });
    });
    expect((await publish()).labelActions).toEqual(remove);
    expect(github.rest.actions.createWorkflowDispatch).not.toHaveBeenCalled();
    expect(pull.labels.map((label) => label.name)).not.toContain("ARMSignedOff");
  });

  it("compensates a successful write before surfacing failed post-write verification", async () => {
    const { github, core, pull, publish, addLabels } = fixture();
    const error = new Error("Status API unavailable");
    github.rest.issues.addLabels.mockImplementationOnce(({ labels }: { labels: string[] }) => {
      addLabels(labels);
      github.rest.repos.getCombinedStatusForRef.mockRejectedValue(error);
      return Promise.resolve({ data: pull.labels });
    });
    await expect(publish()).rejects.toBe(error);
    expect(pull.labels.map((label) => label.name)).not.toContain("ARMSignedOff");
    expect(core.setOutput).toHaveBeenCalledWith("head_sha", headSha);
    expect(core.setOutput).toHaveBeenCalledWith("issue_number", issueNumber);
  });

  it("never reports success if both post-write verification and compensation fail", async () => {
    const { github, publish, addLabels, pull } = fixture();
    const verificationError = new Error("Status API unavailable");
    const compensationError = new Error("Label API unavailable");
    github.rest.issues.addLabels.mockImplementationOnce(({ labels }: { labels: string[] }) => {
      addLabels(labels);
      github.rest.repos.getCombinedStatusForRef.mockRejectedValue(verificationError);
      github.rest.issues.removeLabel.mockRejectedValue(compensationError);
      return Promise.resolve({ data: pull.labels });
    });
    await expect(publish()).rejects.toMatchObject({
      message: "ARM approval verification and compensation both failed",
      errors: [verificationError, compensationError],
    });
  });
});
