import { describe, expect, it, vi } from "vitest";
import { LabelAction } from "../../src/label.js";
import { createMockCore, createMockGithub } from "../../test/mocks.js";
import { getLabelActionImpl } from "../src/arm-auto-signoff-preview.js";
import * as changedFiles from "../src/changed-files.js";
import * as git from "../src/git.js";

const core = createMockCore();

describe("getLabelActionImpl", () => {
  it("rejects if inputs null", async () => {
    await expect(getLabelActionImpl({})).rejects.toThrow();
  });

  it("removes label if no changed RM files", async () => {
    vi.spyOn(changedFiles, "getChangedSwaggerFiles").mockResolvedValue([
      "/specification/contosowidgetmanager/data-plane/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ]);

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: null,
        core: core,
      }),
    ).resolves.toBe(LabelAction.Remove);
  });

  it("removes label if changed files add a new RP", async () => {
    vi.spyOn(changedFiles, "getChangedSwaggerFiles").mockResolvedValue([
      "/specification/contosowidgetmanager2/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ]);

    // "git ls-tree" returns "" if the spec folder doesn't exist in the base branch
    vi.spyOn(git, "lsTree").mockResolvedValue("");

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: null,
        core: core,
      }),
    ).resolves.toBe(LabelAction.Remove);
  });

  it.each([
    { labels: [] },
    { labels: ["ARMReview", "NotReadyForARMReview"] },
    { labels: ["ARMReview", "SuppressionReviewRequired"] },
  ])("removes label if not all labels match ($labels)", async ({ labels }) => {
    vi.spyOn(changedFiles, "getChangedSwaggerFiles").mockResolvedValue([
      "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ]);

    vi.spyOn(git, "lsTree").mockResolvedValue(
      "040000 tree abc123 specification/contosowidgetmanager",
    );

    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: labels.map((name) => ({ name })),
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.Remove);

    expect(github.rest.issues.listLabelsOnIssue).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
    });
  });

  it("adds label if check succeeded", async () => {
    vi.spyOn(changedFiles, "getChangedSwaggerFiles").mockResolvedValue([
      "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ]);

    vi.spyOn(git, "lsTree").mockResolvedValue(
      "040000 tree abc123 specification/contosowidgetmanager",
    );

    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });
    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "completed",
            conclusion: "success",
          },
        ],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.Add);

    expect(github.rest.issues.listLabelsOnIssue).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
    });

    expect(github.rest.checks.listForRef).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      ref: "abc123",
    });
  });

  it("removes label if check failed", async () => {
    vi.spyOn(changedFiles, "getChangedSwaggerFiles").mockResolvedValue([
      "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ]);

    vi.spyOn(git, "lsTree").mockResolvedValue(
      "040000 tree abc123 specification/contosowidgetmanager",
    );

    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });
    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "completed",
            conclusion: "failure",
          },
        ],
      },
    });

    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.Remove);

    expect(github.rest.issues.listLabelsOnIssue).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
    });

    expect(github.rest.checks.listForRef).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      ref: "abc123",
    });
  });

  it("no-ops if check not found or not completed", async () => {
    vi.spyOn(changedFiles, "getChangedSwaggerFiles").mockResolvedValue([
      "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ]);

    vi.spyOn(git, "lsTree").mockResolvedValue(
      "040000 tree abc123 specification/contosowidgetmanager",
    );

    const github = createMockGithub();
    github.rest.issues.listLabelsOnIssue.mockResolvedValue({
      data: [{ name: "ARMReview" }],
    });

    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [],
      },
    });
    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.None);

    github.rest.checks.listForRef.mockResolvedValue({
      data: {
        check_runs: [
          {
            name: "Swagger LintDiff",
            status: "in_progress",
            conclusion: null,
          },
        ],
      },
    });
    await expect(
      getLabelActionImpl({
        owner: "TestOwner",
        repo: "TestRepo",
        issue_number: 123,
        head_sha: "abc123",
        github: github,
        core: core,
      }),
    ).resolves.toBe(LabelAction.None);

    expect(github.rest.issues.listLabelsOnIssue).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      issue_number: 123,
    });

    expect(github.rest.checks.listForRef).toBeCalledWith({
      owner: "TestOwner",
      repo: "TestRepo",
      ref: "abc123",
    });
  });
});
