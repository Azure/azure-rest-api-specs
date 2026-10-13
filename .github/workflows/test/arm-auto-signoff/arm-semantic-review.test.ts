import { mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { CommitStatusState, PER_PAGE_MAX } from "../../../shared/src/github.ts";
import {
  ARM_SEMANTIC_REVIEW_STATUS,
  evaluateSemanticReview,
  getSemanticReviewOutcome,
  addSpecificationChanges,
  checkPullRequestSize,
  parseSemanticReviewResult,
  SemanticReviewCompletion,
  SemanticReviewIncompleteReason,
  SemanticReviewOutcome,
  SemanticReviewScope,
  type ChangedFile,
  type SemanticReviewResult,
  type SpecificationTotals,
} from "../../src/arm-auto-signoff/arm-semantic-review.ts";
import publishArmSemanticReviewStatus, {
  finalizeUnpublishedArmSemanticReview,
} from "../../src/arm-auto-signoff/arm-semantic-review-workflow.ts";
import type { GitHubScriptArgs } from "../../src/github.ts";
import { createMockCore, createMockGithub } from "../mocks.ts";

const owner = "Azure";
const repo = "azure-rest-api-specs";
const issueNumber = 123;
const headSha = "0123456789abcdef0123456789abcdef01234567";
const runId = 456;
const runAttempt = 1;
const runUrl = "https://github.com/Azure/azure-rest-api-specs/actions/runs/456";

const passedResult: SemanticReviewResult = {
  blockingCount: 0,
  reviewScope: SemanticReviewScope.Full,
  completion: SemanticReviewCompletion.Complete,
  incompleteReason: SemanticReviewIncompleteReason.None,
};

function agentOutput(result: SemanticReviewResult = passedResult) {
  return {
    items: [
      {
        type: "record_arm_semantic_review",
        blocking_count: String(result.blockingCount),
        scope: result.reviewScope,
        completeness: result.completion,
        incomplete_reason: result.incompleteReason,
      },
    ],
  };
}

const smallPullRequest = { number: issueNumber, changed_files: 1, additions: 10, deletions: 5 };

function createPublisherGithub() {
  const github = createMockGithub();
  github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
    data: {
      artifacts: [{ name: `head-sha=${headSha}` }, { name: `issue-number=${issueNumber}` }],
    },
  });
  // Default: small PR well within automated review limits
  github.rest.pulls.get.mockResolvedValue({ data: smallPullRequest });
  return github;
}

async function runPublisher({
  output = agentOutput(),
  includeOutput = true,
  setOutputPath = true,
  github = createPublisherGithub(),
}: {
  output?: unknown;
  includeOutput?: boolean;
  setOutputPath?: boolean;
  github?: ReturnType<typeof createPublisherGithub>;
} = {}) {
  const directory = await mkdtemp(join(tmpdir(), "arm-semantic-review-"));
  const outputPath = join(directory, "agent_output.json");
  const previousOutputPath = process.env.GH_AW_AGENT_OUTPUT;
  const previousRunAttempt = process.env.GITHUB_RUN_ATTEMPT;
  try {
    if (includeOutput) {
      await writeFile(outputPath, JSON.stringify(output), "utf8");
    }
    if (setOutputPath) {
      process.env.GH_AW_AGENT_OUTPUT = outputPath;
    } else {
      delete process.env.GH_AW_AGENT_OUTPUT;
    }
    process.env.GITHUB_RUN_ATTEMPT = String(runAttempt);
    const core = createMockCore();
    const result = await publishArmSemanticReviewStatus({
      github,
      context: {
        repo: { owner, repo },
        runId,
        serverUrl: "https://github.com",
      },
      core,
    } as unknown as GitHubScriptArgs);
    return { github, result, core };
  } finally {
    if (previousOutputPath === undefined) {
      delete process.env.GH_AW_AGENT_OUTPUT;
    } else {
      process.env.GH_AW_AGENT_OUTPUT = previousOutputPath;
    }
    if (previousRunAttempt === undefined) {
      delete process.env.GITHUB_RUN_ATTEMPT;
    } else {
      process.env.GITHUB_RUN_ATTEMPT = previousRunAttempt;
    }
    await rm(directory, { recursive: true, force: true });
  }
}

describe("parseSemanticReviewResult", () => {
  it("parses one valid result", () => {
    expect(parseSemanticReviewResult(agentOutput())).toEqual(passedResult);
  });

  it("ignores model-supplied identifiers", () => {
    const output = agentOutput();
    Object.assign(output.items[0], {
      head_sha: "675718552ce00736684ed7a184bab",
      issue_number: "999",
      run_attempt: "99",
    });

    expect(parseSemanticReviewResult(output)).toEqual(passedResult);
  });

  it("rejects missing or duplicate semantic results", () => {
    expect(() => parseSemanticReviewResult({ items: [] })).toThrow(
      "Expected one ARM semantic review result, found 0",
    );
    expect(() =>
      parseSemanticReviewResult({
        items: [
          ...agentOutput().items,
          ...agentOutput({ ...passedResult, blockingCount: 1 }).items,
        ],
      }),
    ).toThrow("Expected one ARM semantic review result, found 2");
    expect(() => parseSemanticReviewResult({})).toThrow("missing its items array");
  });

  it.each([
    { field: "blocking_count", value: "-1", message: "Invalid ARM semantic review Blocking count" },
    { field: "blocking_count", value: 0, message: "Invalid ARM semantic review Blocking count" },
    { field: "scope", value: "partial", message: "Invalid ARM semantic review scope" },
    { field: "completeness", value: "unknown", message: "Invalid ARM semantic review completion" },
    {
      field: "incomplete_reason",
      value: "unknown",
      message: "Invalid ARM semantic review incomplete reason",
    },
  ])("rejects an invalid $field", ({ field, value, message }) => {
    expect(() =>
      parseSemanticReviewResult({ items: [{ ...agentOutput().items[0], [field]: value }] }),
    ).toThrow(message);
  });

  it("rejects a complete review that carries an incomplete reason", () => {
    expect(() =>
      parseSemanticReviewResult({
        items: [
          {
            ...agentOutput().items[0],
            incomplete_reason: SemanticReviewIncompleteReason.CriticUnavailable,
          },
        ],
      }),
    ).toThrow("completion 'complete' is inconsistent");
  });
});
describe("evaluateSemanticReview", () => {
  it("passes when a full, complete review has no Blocking findings", () => {
    expect(evaluateSemanticReview(passedResult)).toEqual({
      state: CommitStatusState.SUCCESS,
      description: "Passed: full review completed with no Blocking findings",
    });
  });

  it("requests changes when Blocking findings remain", () => {
    expect(evaluateSemanticReview({ ...passedResult, blockingCount: 2 })).toEqual({
      state: CommitStatusState.FAILURE,
      description: "Changes requested: 2 Blocking finding(s)",
    });
  });

  it("requires manual review when the semantic review is scoped", () => {
    const result = { ...passedResult, reviewScope: SemanticReviewScope.Scoped };
    const description = "Manual review required: scoped review requires manual signoff";

    expect(evaluateSemanticReview(result)).toEqual({
      state: CommitStatusState.ERROR,
      description,
    });
  });

  it.each([
    SemanticReviewIncompleteReason.CriticUnavailable,
    SemanticReviewIncompleteReason.RequiredEvidenceUnavailable,
    SemanticReviewIncompleteReason.ToolFailure,
    SemanticReviewIncompleteReason.StaleSha,
    SemanticReviewIncompleteReason.DiscussionDataUnavailable,
  ])("includes incomplete reason %s in the status", (incompleteReason) => {
    const result = {
      ...passedResult,
      completion: SemanticReviewCompletion.Incomplete,
      incompleteReason,
    };

    expect(evaluateSemanticReview(result)).toEqual({
      state: CommitStatusState.ERROR,
      description: `Review incomplete: ${incompleteReason}`,
    });
  });

  it.each([
    {
      name: "scoped with blockers",
      result: { ...passedResult, reviewScope: SemanticReviewScope.Scoped, blockingCount: 2 },
      description: "Manual review required: scoped review requires manual signoff",
    },
    {
      name: "incomplete with blockers",
      result: {
        ...passedResult,
        completion: SemanticReviewCompletion.Incomplete,
        incompleteReason: SemanticReviewIncompleteReason.CriticUnavailable,
        blockingCount: 1,
      },
      description: "Review incomplete: critic-unavailable",
    },
  ])(
    "requires manual review rather than changes requested for $name",
    ({ result, description }) => {
      expect(evaluateSemanticReview(result)).toEqual({
        state: CommitStatusState.ERROR,
        description,
      });
    },
  );

  it("maps commit status states back to semantic outcomes", () => {
    expect(getSemanticReviewOutcome({ state: "pending" })).toBe(SemanticReviewOutcome.Pending);
    expect(getSemanticReviewOutcome({ state: "success" })).toBe(SemanticReviewOutcome.Passed);
    expect(getSemanticReviewOutcome({ state: "failure" })).toBe(
      SemanticReviewOutcome.ChangesRequested,
    );
    expect(getSemanticReviewOutcome({ state: "error" })).toBe(
      SemanticReviewOutcome.ReviewIncomplete,
    );
    expect(
      getSemanticReviewOutcome({
        state: "error",
        description: "Review incomplete: tool-failure",
      }),
    ).toBe(SemanticReviewOutcome.ReviewIncomplete);
    expect(
      getSemanticReviewOutcome({
        state: "error",
        description: "Manual review required: scoped review requires manual signoff",
      }),
    ).toBe(SemanticReviewOutcome.ManualReviewRequired);
    expect(getSemanticReviewOutcome(undefined)).toBeUndefined();
    expect(getSemanticReviewOutcome({ state: "unexpected" })).toBeUndefined();
  });
});

describe("checkPullRequestSize", () => {
  it.each([
    { name: "a small PR", counts: [1, 10, 5], expected: { outcome: "within" } },
    { name: "exactly 50 files", counts: [50, 50, 0], expected: { outcome: "within" } },
    { name: "exactly 5,000 lines", counts: [1, 3_000, 2_000], expected: { outcome: "within" } },
    { name: "51 files", counts: [51, 51, 0], expected: { outcome: "list-files" } },
    { name: "5,001 lines", counts: [1, 5_001, 0], expected: { outcome: "list-files" } },
    {
      // GitHub reports zero counters when the diff is too large for it to compute.
      name: "zero reported files",
      counts: [0, 0, 0],
      expected: { outcome: "manual-review", reason: "GitHub could not compute the PR's size" },
    },
    {
      name: "one file under GitHub's listing cap",
      counts: [2_999, 3_000, 0],
      expected: { outcome: "list-files" },
    },
    {
      // GitHub lists at most 3,000 files and does not say when it cut the list off.
      name: "GitHub's listing cap",
      counts: [3_000, 3_000, 0],
      expected: { outcome: "manual-review", reason: "PR has 3000 or more changed files" },
    },
  ])("$name", ({ counts: [changed_files, additions, deletions], expected }) => {
    expect(checkPullRequestSize({ changed_files, additions, deletions })).toEqual(expected);
  });
});

describe("addSpecificationChanges", () => {
  const spec = (name: string, lines = 1): ChangedFile => ({
    filename: `specification/foo/${name}.json`,
    additions: lines,
    deletions: 0,
  });
  const other = (name: string): ChangedFile => ({
    filename: `documentation/${name}.md`,
    additions: 100,
    deletions: 0,
  });
  const renamed = (from: string, to: string): ChangedFile => ({
    filename: to,
    previous_filename: from,
    additions: 0,
    deletions: 0,
  });
  const times = <T>(count: number, build: (i: number) => T) =>
    Array.from({ length: count }, (_, i) => build(i));
  const add = (files: ChangedFile[]) => {
    const totals: SpecificationTotals = { files: 0, lines: 0 };
    return { over: addSpecificationChanges(totals, files), totals };
  };

  it("is false at exactly the limits and true just over", () => {
    expect(add(times(50, (i) => spec(`f${i}`))).over).toBe(false);
    expect(add(times(51, (i) => spec(`f${i}`))).over).toBe(true);
    expect(add([spec("big", 5_000)]).over).toBe(false);
    expect(add([spec("big", 5_001)]).over).toBe(true);
  });

  it("does not count files or lines outside specification/", () => {
    const { over, totals } = add([spec("a"), ...times(500, (i) => other(`d${i}`))]);

    expect(over).toBe(false);
    expect(totals).toEqual({ files: 1, lines: 1 });
  });

  it("accumulates across pages", () => {
    const totals: SpecificationTotals = { files: 0, lines: 0 };

    expect(
      addSpecificationChanges(
        totals,
        times(30, (i) => spec(`a${i}`)),
      ),
    ).toBe(false);
    expect(
      addSpecificationChanges(
        totals,
        times(21, (i) => spec(`b${i}`)),
      ),
    ).toBe(true);
    expect(totals.files).toBe(51);
  });

  it.each([
    { name: "moved into specification/", from: "eng", to: "specification/foo" },
    { name: "moved out of specification/", from: "specification/foo", to: "archive" },
    { name: "renamed within specification/", from: "specification/foo", to: "specification/bar" },
  ])("counts a file $name once", ({ from, to }) => {
    const { over, totals } = add(
      times(51, (i) => renamed(`${from}/f${i}.json`, `${to}/f${i}.json`)),
    );

    expect(over).toBe(true);
    expect(totals.files).toBe(51);
  });

  it("ignores a rename that never touches specification/", () => {
    const { over, totals } = add(times(51, (i) => renamed(`eng/a${i}.json`, `docs/a${i}.json`)));

    expect(over).toBe(false);
    expect(totals.files).toBe(0);
  });
});
describe("publishArmSemanticReviewStatus", () => {
  it("publishes Passed for a clean reviewer result", async () => {
    const { github, result } = await runPublisher();

    expect(result).toEqual({ headSha, issueNumber, statusPublished: true });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith({
      owner,
      repo,
      sha: headSha,
      state: CommitStatusState.SUCCESS,
      context: ARM_SEMANTIC_REVIEW_STATUS,
      description: "Passed: full review completed with no Blocking findings",
      target_url: `${runUrl}/attempts/${runAttempt}`,
    });
    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledOnce();
    expect(github.rest.actions.listWorkflowRunArtifacts).toHaveBeenCalledWith({
      owner,
      repo,
      run_id: runId,
      per_page: PER_PAGE_MAX,
    });
  });

  it("publishes Changes requested for Blocking findings", async () => {
    const { github } = await runPublisher({
      output: agentOutput({ ...passedResult, blockingCount: 3 }),
    });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.FAILURE,
        description: "Changes requested: 3 Blocking finding(s)",
      }),
    );
  });

  it("publishes Manual review required for a scoped clean review", async () => {
    const { github } = await runPublisher({
      output: agentOutput({ ...passedResult, reviewScope: SemanticReviewScope.Scoped }),
    });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Manual review required: scoped review requires manual signoff",
      }),
    );
  });

  describe("PR size limits", () => {
    const OVER_LIMITS =
      "Manual review required: specification/ changes exceed 50 files or 5000 lines";
    const spec = (name: string, lines = 1) => ({
      filename: `specification/foo/${name}.json`,
      additions: lines,
      deletions: 0,
    });
    const doc = (name: string) => ({
      filename: `documentation/${name}.md`,
      additions: 1,
      deletions: 0,
    });
    const times = <T>(count: number, build: (i: number) => T) =>
      Array.from({ length: count }, (_, i) => build(i));

    /** Publishes for a PR with the given totals; `files` is what `pulls.listFiles` returns. */
    async function publish(
      totals: { changed_files: number; additions: number; deletions: number },
      files: unknown[] = [],
    ) {
      const github = createPublisherGithub();
      github.rest.pulls.get.mockResolvedValue({ data: { number: issueNumber, ...totals } });
      github.rest.pulls.listFiles.mockResolvedValue({ data: files });
      return (await runPublisher({ github })).github;
    }
    const published = (github: ReturnType<typeof createPublisherGithub>) =>
      github.rest.repos.createCommitStatus.mock.calls[0][0] as {
        state: string;
        description: string;
      };
    const publishedState = (github: ReturnType<typeof createPublisherGithub>) =>
      published(github).state;
    const publishedDescription = (github: ReturnType<typeof createPublisherGithub>) =>
      published(github).description;

    it.each([
      { name: "a small PR", totals: { changed_files: 1, additions: 10, deletions: 5 } },
      { name: "exactly 50 files", totals: { changed_files: 50, additions: 50, deletions: 0 } },
      {
        name: "exactly 5,000 lines",
        totals: { changed_files: 1, additions: 3_000, deletions: 2_000 },
      },
    ])("does not list files for $name", async ({ totals }) => {
      const github = await publish(totals);

      expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
      expect(publishedState(github)).toBe(CommitStatusState.SUCCESS);
    });

    it.each([
      {
        name: "zero reported files",
        changed_files: 0,
        reason: "GitHub could not compute the PR's size",
      },
      // GitHub lists at most 3,000 files and does not say when it truncated the list.
      {
        name: "3,000 or more files",
        changed_files: 3_000,
        reason: "PR has 3000 or more changed files",
      },
    ])(
      "requires manual review without listing files for $name",
      async ({ changed_files, reason }) => {
        const github = await publish({ changed_files, additions: 0, deletions: 0 });

        expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
        expect(publishedDescription(github)).toBe(`Manual review required: ${reason}`);
      },
    );

    it("lists the files of the trusted PR when the totals are over the limits", async () => {
      const github = await publish({ changed_files: 51, additions: 51, deletions: 0 }, [spec("a")]);

      expect(github.rest.pulls.listFiles).toHaveBeenCalledWith(
        expect.objectContaining({ owner, repo, pull_number: issueNumber }),
      );
    });

    it("passes when only files outside specification/ push the PR over the limits", async () => {
      const files = [spec("a"), ...times(60, (i) => doc(`d${i}`))];
      const github = await publish({ changed_files: 61, additions: 61, deletions: 0 }, files);

      expect(publishedState(github)).toBe(CommitStatusState.SUCCESS);
    });

    it.each([
      { name: "too many specification files", files: times(51, (i) => spec(`f${i}`)) },
      { name: "too many specification lines", files: [spec("big", 5_001)] },
    ])("requires manual review for $name", async ({ files }) => {
      const additions = files.reduce((total, file) => total + file.additions, 0);
      const github = await publish({ changed_files: 51, additions, deletions: 0 }, files);

      expect(publishedDescription(github)).toBe(OVER_LIMITS);
    });

    it("overrides a Changes requested result when the PR is over the limits", async () => {
      // The model claimed a full review of an oversized PR, so its Blocking count is not trusted.
      const github = createPublisherGithub();
      github.rest.pulls.get.mockResolvedValue({
        data: { number: issueNumber, changed_files: 51, additions: 51, deletions: 0 },
      });
      github.rest.pulls.listFiles.mockResolvedValue({ data: times(51, (i) => spec(`f${i}`)) });

      const { github: g } = await runPublisher({
        github,
        output: agentOutput({ ...passedResult, blockingCount: 2 }),
      });
      expect(publishedDescription(g)).toBe(OVER_LIMITS);
    });

    it.each([
      {
        name: "a scoped review",
        result: { ...passedResult, reviewScope: SemanticReviewScope.Scoped },
        description: "Manual review required: scoped review requires manual signoff",
      },
      {
        name: "an incomplete review",
        result: {
          ...passedResult,
          completion: SemanticReviewCompletion.Incomplete,
          incompleteReason: SemanticReviewIncompleteReason.ToolFailure,
        },
        description: "Review incomplete: tool-failure",
      },
    ])(
      "skips the size check for $name, which already withholds signoff",
      async ({ result, description }) => {
        const github = createPublisherGithub();
        github.rest.pulls.get.mockResolvedValue({
          data: { number: issueNumber, changed_files: 500, additions: 9_000, deletions: 0 },
        });

        const { github: g } = await runPublisher({ github, output: agentOutput(result) });
        expect(g.rest.pulls.get).not.toHaveBeenCalled();
        expect(g.rest.pulls.listFiles).not.toHaveBeenCalled();
        expect(publishedDescription(g)).toBe(description);
      },
    );

    it("logs each step of the size decision", async () => {
      const github = createPublisherGithub();
      github.rest.pulls.get.mockResolvedValue({
        data: { number: issueNumber, changed_files: 61, additions: 61, deletions: 0 },
      });
      github.rest.pulls.listFiles.mockResolvedValue({
        data: [spec("a"), ...times(60, (i) => doc(`d${i}`))],
      });

      const { core } = await runPublisher({ github });
      const logged = core.info.mock.calls.map(([message]) => String(message));
      expect(logged).toEqual(
        expect.arrayContaining([
          expect.stringContaining("Reviewer reported: scope=full, completeness=complete"),
          expect.stringContaining("size: 61 files, +61 -0 lines"),
          expect.stringContaining("counting only the specification/ changes"),
          expect.stringContaining("page 1: 1 specification/ files, 1 lines so far"),
          expect.stringContaining("specification/ changes are within the limits: 1 files, 1 lines"),
        ]),
      );
    });

    describe("paginating the file list", () => {
      const PAGE_SIZE = 100;
      const page = (start: number, count: number, prefix: string) =>
        Array.from({ length: count }, (_, i) => ({
          filename: `${prefix}/f${start + i}.json`,
          additions: 1,
          deletions: 0,
        }));

      /** Serves `pages` through paginate's map function, honouring `done()` like Octokit does. */
      function withPages(pages: ReturnType<typeof page>[], changedFiles: number) {
        const github = createPublisherGithub();
        github.rest.pulls.get.mockResolvedValue({
          data: {
            number: issueNumber,
            changed_files: changedFiles,
            additions: changedFiles,
            deletions: 0,
          },
        });
        const requested: number[] = [];
        const originalPaginate = github.paginate;
        type MapPage = (response: { data: unknown[] }, done: () => void) => unknown[];
        github.paginate = (async (fn: unknown, params: unknown, mapFn?: MapPage) => {
          if (fn !== github.rest.pulls.listFiles || !mapFn) {
            return originalPaginate(fn as never, params as never);
          }
          const result: unknown[] = [];
          let stopped = false;
          for (const [index, data] of pages.entries()) {
            requested.push(index);
            result.push(...mapFn({ data }, () => (stopped = true)));
            if (stopped) break;
          }
          return result;
        }) as typeof github.paginate;
        return { github, requested };
      }

      it("stops after the first page when its specification/ files already exceed the limits", async () => {
        const { github, requested } = withPages(
          [
            page(0, PAGE_SIZE, "specification/foo"),
            page(PAGE_SIZE, PAGE_SIZE, "specification/foo"),
            page(2 * PAGE_SIZE, 50, "specification/foo"),
          ],
          250,
        );

        const { github: g } = await runPublisher({ github });
        expect(requested).toEqual([0]);
        expect(publishedDescription(g)).toBe(OVER_LIMITS);
      });

      it("keeps paginating while the specification/ files seen are still within the limits", async () => {
        // 250 files, but only 10 are under specification/, so no page can settle the answer early.
        const { github, requested } = withPages(
          [
            page(0, PAGE_SIZE, "documentation"),
            page(PAGE_SIZE, PAGE_SIZE, "documentation"),
            [...page(2 * PAGE_SIZE, 40, "documentation"), ...page(0, 10, "specification/foo")],
          ],
          250,
        );

        const { github: g } = await runPublisher({ github });
        expect(requested).toEqual([0, 1, 2]);
        expect(publishedState(g)).toBe(CommitStatusState.SUCCESS);
      });
    });
  });
  it.each([
    {
      name: "missing agent output",
      options: { includeOutput: false },
      logged: "ENOENT",
    },
    {
      name: "missing semantic item",
      options: { output: { items: [] } },
      logged: "Expected one ARM semantic review result, found 0",
    },
    {
      name: "invalid Blocking count",
      options: {
        output: {
          items: [{ ...agentOutput().items[0], blocking_count: "not-a-number" }],
        },
      },
      logged: "Invalid ARM semantic review Blocking count",
    },
  ])("publishes Review incomplete for $name", async ({ options, logged }) => {
    const { github, core } = await runPublisher(options);

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: result could not be validated",
      }),
    );
    // The details go to the run log, not the public status description.
    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining(logged));
  });

  it("publishes Review incomplete when the output path is not set", async () => {
    const { github } = await runPublisher({ setOutputPath: false });

    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: result could not be validated",
      }),
    );
  });

  it("logs a thrown value that is not an Error", async () => {
    const github = createPublisherGithub();
    github.rest.pulls.get.mockRejectedValue("plain string failure");

    const { github: g, core } = await runPublisher({ github });
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: CommitStatusState.ERROR }),
    );
    expect(core.warning).toHaveBeenCalledWith("plain string failure");
  });

  it("publishes Review incomplete without exposing the error when the PR cannot be read", async () => {
    const github = createPublisherGithub();
    github.rest.pulls.get.mockRejectedValue(new Error("boom: /home/runner/work/_temp/secret"));

    const { github: g, core } = await runPublisher({ github });
    expect(g.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({
        state: CommitStatusState.ERROR,
        description: "Review incomplete: result could not be validated",
      }),
    );
    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining("boom"));
  });

  it("does nothing when trusted PR/SHA correlation is missing", async () => {
    const github = createPublisherGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({
      data: { artifacts: [] },
    });

    const execution = await runPublisher({ github });
    expect(execution.result).toEqual({
      headSha: "",
      issueNumber: 0,
      statusPublished: false,
    });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });
});

describe("finalizeUnpublishedArmSemanticReview", () => {
  const ownedPending = {
    context: ARM_SEMANTIC_REVIEW_STATUS,
    state: CommitStatusState.PENDING,
    target_url: `${runUrl}/attempts/${runAttempt}`,
    updated_at: "2026-01-01T00:00:00Z",
  };

  async function runFinalizer(statuses: unknown[], github = createPublisherGithub()) {
    github.rest.repos.listCommitStatusesForRef.mockResolvedValue({ data: statuses });
    const previousRunAttempt = process.env.GITHUB_RUN_ATTEMPT;
    process.env.GITHUB_RUN_ATTEMPT = String(runAttempt);
    try {
      const result = await finalizeUnpublishedArmSemanticReview({
        github,
        context: { repo: { owner, repo }, runId, serverUrl: "https://github.com" },
        core: createMockCore(),
      } as unknown as GitHubScriptArgs);
      return { github, result };
    } finally {
      if (previousRunAttempt === undefined) {
        delete process.env.GITHUB_RUN_ATTEMPT;
      } else {
        process.env.GITHUB_RUN_ATTEMPT = previousRunAttempt;
      }
    }
  }

  it("resolves a Pending status owned by this run as Review incomplete", async () => {
    const { github, result } = await runFinalizer([ownedPending]);

    expect(result).toEqual({ statusPublished: true });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith({
      owner,
      repo,
      sha: headSha,
      state: CommitStatusState.ERROR,
      context: ARM_SEMANTIC_REVIEW_STATUS,
      description: "Review incomplete: reviewer did not publish a result",
      target_url: `${runUrl}/attempts/${runAttempt}`,
    });
  });

  it("never publishes a manual-review hold for an unpublished result", async () => {
    const { github } = await runFinalizer([ownedPending]);

    const status = github.rest.repos.createCommitStatus.mock.calls[0]?.[0] as {
      description: string;
    };
    expect(getSemanticReviewOutcome({ state: "error", description: status.description })).toBe(
      SemanticReviewOutcome.ReviewIncomplete,
    );
  });

  it.each([
    { name: "there is no status", statuses: [] },
    {
      name: "the record job already published a result",
      statuses: [
        {
          ...ownedPending,
          state: CommitStatusState.SUCCESS,
          updated_at: "2026-01-01T00:00:01Z",
        },
        ownedPending,
      ],
    },
    {
      name: "a newer run owns the newest status",
      statuses: [
        {
          ...ownedPending,
          target_url: "https://github.com/Azure/azure-rest-api-specs/actions/runs/789/attempts/1",
          updated_at: "2026-01-01T00:00:01Z",
        },
        ownedPending,
      ],
    },
    {
      name: "a newer attempt of this run owns the newest status",
      statuses: [
        {
          ...ownedPending,
          target_url: `${runUrl}/attempts/2`,
          updated_at: "2026-01-01T00:00:01Z",
        },
        ownedPending,
      ],
    },
  ])("leaves the status unchanged when $name", async ({ statuses }) => {
    const { github, result } = await runFinalizer(statuses);

    expect(result).toEqual({ statusPublished: false });
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("leaves the status unchanged when the run has no trusted head SHA", async () => {
    const github = createPublisherGithub();
    github.rest.actions.listWorkflowRunArtifacts.mockResolvedValue({ data: { artifacts: [] } });

    const { result } = await runFinalizer([ownedPending], github);

    expect(result).toEqual({ statusPublished: false });
    expect(github.rest.repos.listCommitStatusesForRef).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });
});
