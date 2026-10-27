import { existsSync, mkdtempSync, rmSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type {
  CommitProjectInfoResult,
  EnsureReleasePlanResult,
  OctokitLike,
} from "../src/types.ts";

const mocks = vi.hoisted(() => ({
  parseCliArguments: vi.fn(),
  getTypeSpecProjectInfoFromCommit: vi.fn(),
  createComment: vi.fn<NonNullable<OctokitLike["rest"]["issues"]>["createComment"]>(),
  ensureReleasePlan: vi.fn(),
  runner: vi.fn(),
}));

vi.mock("../src/args.ts", () => ({ parseCliArguments: mocks.parseCliArguments }));
vi.mock("../src/typespec-project.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/typespec-project.ts")>()),
  createOctokit: () => ({ rest: { issues: { createComment: mocks.createComment } } }),
  getTypeSpecProjectInfoFromCommit: mocks.getTypeSpecProjectInfoFromCommit,
}));
vi.mock("../src/release-plan.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/release-plan.ts")>()),
  createAzdskRunner: () => mocks.runner,
  ensureReleasePlan: mocks.ensureReleasePlan,
}));

import { main } from "../src/index.ts";

let workspace: string;
let outputFile: string;
const projectPath = "specification/security/resource-manager/Microsoft.Security/Security";

beforeEach(() => {
  vi.clearAllMocks();
  workspace = mkdtempSync(join(tmpdir(), "release-plan-main-"));
  outputFile = join(workspace, "release-plan.json");
  mocks.parseCliArguments.mockReturnValue({
    commitSha: "abc123",
    owner: "Azure",
    repo: "azure-rest-api-specs",
    workspace,
    outputFile,
    testReleasePlan: false,
  });
  mocks.createComment.mockResolvedValue(undefined);
});

afterEach(() => {
  rmSync(workspace, { recursive: true, force: true });
});

describe("release plan CLI", () => {
  it("only comments when multiple projects remain, without creating a plan or SDK artifact", async () => {
    const paths = [projectPath, "specification/other/Other"];
    const result: CommitProjectInfoResult = {
      projectInfo: null,
      changedFiles: [{ filename: `${projectPath}/tspconfig.yaml`, status: "modified" }],
      multipleProjectPaths: paths,
      prNumber: 42,
      hasNewApiVersionLabel: true,
    };
    mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(result);

    await main();

    expect(mocks.ensureReleasePlan).not.toHaveBeenCalled();
    expect(mocks.runner).not.toHaveBeenCalled();
    expect(existsSync(outputFile)).toBe(false);
    expect(mocks.createComment).toHaveBeenCalledOnce();
    const [comment] = mocks.createComment.mock.calls[0];
    expect(comment).toMatchObject({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 42,
    });
    const body = comment.body;
    expect(body).toContain("Release Plan Creation Skipped");
    for (const path of paths) {
      expect(body).toContain(path);
    }
  });

  it("skips ambiguous commits without trying to comment when no PR is associated", async () => {
    const result: CommitProjectInfoResult = {
      projectInfo: null,
      changedFiles: [],
      multipleProjectPaths: [projectPath, "specification/other/Other"],
      hasNewApiVersionLabel: false,
    };
    mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(result);

    await main();

    expect(mocks.createComment).not.toHaveBeenCalled();
    expect(mocks.ensureReleasePlan).not.toHaveBeenCalled();
    expect(existsSync(outputFile)).toBe(false);
  });

  it.each([true, false])(
    "reports a missing API version without creating a plan (associated PR: %s)",
    async (hasPr) => {
      const message =
        "No API version found in TypeSpec metadata. Configure api-version in tspconfig.yaml emitter options.";
      const discovery: CommitProjectInfoResult = {
        projectInfo: null,
        changedFiles: [{ filename: `${projectPath}/tspconfig.yaml`, status: "modified" }],
        projectError: { tspProjectPath: projectPath, message },
        prNumber: hasPr ? 42 : undefined,
        hasNewApiVersionLabel: false,
      };
      mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(discovery);

      await main();

      expect(mocks.ensureReleasePlan).not.toHaveBeenCalled();
      expect(mocks.runner).not.toHaveBeenCalled();
      expect(existsSync(outputFile)).toBe(false);
      expect(mocks.createComment).toHaveBeenCalledTimes(hasPr ? 1 : 0);
      if (hasPr) {
        const [comment] = mocks.createComment.mock.calls[0];
        expect(comment.issue_number).toBe(42);
        expect(comment.body).toContain("Release Plan Creation Failed");
        expect(comment.body).toContain(message);
        expect(comment.body).toContain(projectPath);
      }
    },
  );

  it.each(["all", "multiple-versions"])(
    "allows private-preview plan processing for version %s",
    async (apiVersion) => {
      mocks.parseCliArguments.mockReturnValue({
        commitSha: "abc123",
        owner: "Azure",
        repo: "azure-rest-api-specs-pr",
        workspace,
        outputFile,
        testReleasePlan: false,
      });
      const discovery: CommitProjectInfoResult = {
        projectInfo: { tspProjectPath: projectPath, apiVersion, isPreview: false },
        changedFiles: [{ filename: `${projectPath}/tspconfig.yaml`, status: "modified" }],
        prNumber: 42,
        hasNewApiVersionLabel: false,
      };
      const plan: EnsureReleasePlanResult = {
        outcome: "created",
        releasePlan: { ReleasePlanId: 123 },
        details: { releasePlanId: "123" },
      };
      mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(discovery);
      mocks.ensureReleasePlan.mockReturnValue(plan);

      await main();

      expect(mocks.ensureReleasePlan).toHaveBeenCalledExactlyOnceWith(
        expect.objectContaining({ apiVersion, apiReleaseType: "Private Preview" }),
        mocks.runner,
        true,
      );
      expect(existsSync(outputFile)).toBe(true);
      expect(mocks.createComment).toHaveBeenCalledOnce();
      expect(mocks.createComment.mock.calls[0][0].body).toContain(`\`${apiVersion}\``);
    },
  );

  it("includes the resolved project path in a successful creation comment", async () => {
    const discovery: CommitProjectInfoResult = {
      projectInfo: {
        tspProjectPath: projectPath,
        apiVersion: "2026-01-01-preview",
        isPreview: true,
      },
      changedFiles: [{ filename: `${projectPath}/tspconfig.yaml`, status: "modified" }],
      prNumber: 42,
      hasNewApiVersionLabel: false,
    };
    const plan: EnsureReleasePlanResult = {
      outcome: "created",
      releasePlan: { ReleasePlanId: 123, release_plan_link: "https://example.com/plan/123" },
      details: { releasePlanId: "123" },
    };
    mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(discovery);
    mocks.ensureReleasePlan.mockReturnValue(plan);

    await main();

    expect(mocks.ensureReleasePlan).toHaveBeenCalledExactlyOnceWith(
      expect.objectContaining({ tspProjectPath: projectPath }),
      mocks.runner,
      true,
    );
    expect(mocks.createComment).toHaveBeenCalledOnce();
    const [comment] = mocks.createComment.mock.calls[0];
    expect(comment).toMatchObject({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 42,
    });
    expect(comment.body).toContain(`| **TypeSpec Project** | \`${projectPath}\` |`);
    expect(existsSync(outputFile)).toBe(true);
  });
});
