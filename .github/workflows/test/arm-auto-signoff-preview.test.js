import { vol } from "memfs";
import { join } from "path";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { LabelAction } from "../../src/label.js";
import { createMockCore, createMockGithub } from "../../test/mocks.js";
import { getLabelActionImpl } from "../src/arm-auto-signoff-preview.js";
import * as changedFiles from "../src/changed-files.js";
import * as git from "../src/git.js";

vi.mock("fs/promises", async () => {
  const memfs = await import("memfs");
  return {
    ...memfs.fs.promises,
  };
});

const core = createMockCore();

const swaggerTypeSpecGenerated = JSON.stringify({
  info: {
    "x-typespec-generated": [{ emitter: "@azure-tools/typespec-autorest" }],
  },
});

describe("getLabelActionImpl", () => {
  beforeEach(() => {
    // TODO: Reset other global mocks like "core"
    vol.reset();
  });

  it("rejects if inputs null", async () => {
    await expect(getLabelActionImpl({})).rejects.toThrow();
  });

  it("removes label if no changed RM files", async () => {
    vi.spyOn(
      changedFiles,
      "getChangedResourceManagerSwaggerFiles",
    ).mockResolvedValue([]);

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

  it("removes label if a changed file is not typespec-generated", async () => {
    const swaggerPath =
      "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(
      changedFiles,
      "getChangedResourceManagerSwaggerFiles",
    ).mockResolvedValue([swaggerPath]);

    vol.fromJSON({
      [join(process.env.GITHUB_WORKSPACE || "", swaggerPath)]: '"foo"',
    });

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
    const swaggerPath =
      "/specification/contosowidgetmanager2/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

    vi.spyOn(
      changedFiles,
      "getChangedResourceManagerSwaggerFiles",
    ).mockResolvedValue([swaggerPath]);

    vol.fromJSON({
      [join(process.env.GITHUB_WORKSPACE || "", swaggerPath)]:
        swaggerTypeSpecGenerated,
    });

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
    mockContosoTspSwagger();

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

  it("removes label if check failed", async () => {
    mockContosoTspSwagger();

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
    mockContosoTspSwagger();

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

  it("adds label if incremental tsp, labels match, and check succeeded", async () => {
    mockContosoTspSwagger();

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
});

function mockContosoTspSwagger() {
  const swaggerPath =
    "/specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/preview/2021-10-01-preview/contoso.json";

  vi.spyOn(
    changedFiles,
    "getChangedResourceManagerSwaggerFiles",
  ).mockResolvedValue([swaggerPath]);

  vol.fromJSON({
    [join(process.env.GITHUB_WORKSPACE || "", swaggerPath)]:
      swaggerTypeSpecGenerated,
  });

  vi.spyOn(git, "lsTree").mockImplementation(
    async (_treeIsh, _path, _core, options) => {
      return options?.includes("-r --name-only")
        ? swaggerPath.substring(1)
        : "040000 tree abc123 specification/contosowidgetmanager";
    },
  );

  vi.spyOn(git, "show").mockImplementation(async (_treeIsh, _path, _core) => {
    return swaggerTypeSpecGenerated;
  });
}
