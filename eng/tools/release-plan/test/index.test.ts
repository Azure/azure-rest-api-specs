import { existsSync, mkdtempSync, readFileSync, rmSync } from "node:fs";
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
  vi.resetAllMocks();
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
  vi.restoreAllMocks();
  rmSync(workspace, { recursive: true, force: true });
});

describe("release plan CLI", () => {
  it.each(["client.tsp", "main.tsp", "tspconfig.yaml"])(
    "creates a release plan for %s changes without checking a new-api-version label",
    async (file) => {
      const discovery: CommitProjectInfoResult = {
        projectInfo: {
          tspProjectPath: projectPath,
          apiVersion: "2026-01-01",
          isPreview: false,
        },
        changedFiles: [{ filename: `${projectPath}/${file}`, status: "modified" }],
        prNumber: 47691,
      };
      mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(discovery);
      const actual =
        await vi.importActual<typeof import("../src/release-plan.ts")>("../src/release-plan.ts");
      mocks.ensureReleasePlan.mockImplementation(actual.ensureReleasePlan);
      const plan = {
        outcome: "created",
        ReleasePlanId: 123,
        release_plan_link: "https://example.com/plan/123",
        release_plan_details: {
          ReleasePlanId: 123,
          APISpecProjectPath: projectPath,
          SpecAPIVersion: "2026-01-01",
          Status: "In Progress",
        },
      };
      mocks.runner.mockImplementation((args: string[]) => ({
        exitCode: 0,
        stdout: JSON.stringify(args[1] === "get" ? { outcome: "not_found" } : plan),
        stderr: "",
      }));

      await main();

      expect(mocks.ensureReleasePlan).toHaveBeenCalledExactlyOnceWith(
        expect.objectContaining({ tspProjectPath: projectPath }),
        mocks.runner,
      );
      expect(mocks.runner).toHaveBeenCalledTimes(2);
      expect(mocks.runner).toHaveBeenLastCalledWith(
        expect.arrayContaining(["release-plan", "create", "--pull-request"]),
      );
      expect(JSON.parse(readFileSync(outputFile, "utf8"))).toMatchObject({
        outcome: "created",
        releasePlan: plan,
      });
      expect(mocks.createComment).toHaveBeenCalledOnce();
      const [comment] = mocks.createComment.mock.calls[0];
      expect(comment.issue_number).toBe(47691);
      expect(comment.body).toContain("Release Plan Created");
      expect(comment.body).not.toContain("Manual Release Plan Required");
    },
  );

  it.each(["skip-label", "no-typespec-files", "no-project"])(
    "keeps the %s no-op free of manual-action guidance",
    async (reason) => {
      const warn = vi.spyOn(console, "warn").mockImplementation(() => {});
      mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue({
        projectInfo: null,
        changedFiles:
          reason === "no-project"
            ? [{ filename: `${projectPath}/client.tsp` }]
            : [{ filename: `${projectPath}/custom-tspconfig.yaml` }],
        prNumber: 42,
        skipReleasePlanAutomation: reason === "skip-label",
      } satisfies CommitProjectInfoResult);

      await main();

      expect(mocks.ensureReleasePlan).not.toHaveBeenCalled();
      expect(mocks.createComment).not.toHaveBeenCalled();
      expect(existsSync(outputFile)).toBe(false);
      expect(warn).not.toHaveBeenCalled();
    },
  );

  it.each(["In Progress", "Finished"])(
    "does not guess a Compute API version from an existing blank-version %s plan",
    async (status) => {
      const warn = vi.spyOn(console, "warn").mockImplementation(() => {});
      const computePath = "specification/compute/resource-manager/Microsoft.Compute/Compute";
      mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue({
        projectInfo: {
          tspProjectPath: computePath,
          apiVersion: "multiple-versions",
          isPreview: false,
        },
        changedFiles: [{ filename: `${computePath}/client.tsp` }],
        prNumber: 47691,
      } satisfies CommitProjectInfoResult);
      const actual =
        await vi.importActual<typeof import("../src/release-plan.ts")>("../src/release-plan.ts");
      mocks.ensureReleasePlan.mockImplementation(actual.ensureReleasePlan);
      mocks.runner.mockReturnValue({
        exitCode: 0,
        stdout: JSON.stringify({
          outcome: "existing",
          release_plan_details: { SpecAPIVersion: "", Status: status },
        }),
        stderr: "",
      });

      await main();

      expect(mocks.runner).not.toHaveBeenCalled();
      expect(JSON.parse(readFileSync(outputFile, "utf8"))).toMatchObject({
        outcome: "manual_required",
        releasePlan: null,
      });
      expect(mocks.createComment.mock.calls[0][0].body).toContain("Manual Release Plan Required");
      expect(mocks.createComment.mock.calls[0][0].body).toContain("ReleasePlanId");
      expect(warn).toHaveBeenCalledWith(expect.stringContaining("Manual release plan required"));
    },
  );

  it.each(["In Progress", "Finished"])(
    "does not request manual action for an existing %s plan",
    async (status) => {
      const warn = vi.spyOn(console, "warn").mockImplementation(() => {});
      mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue({
        projectInfo: {
          tspProjectPath: projectPath,
          apiVersion: "2026-01-01-preview",
          isPreview: true,
        },
        changedFiles: [{ filename: `${projectPath}/client.tsp` }],
        prNumber: 42,
      } satisfies CommitProjectInfoResult);
      const result: EnsureReleasePlanResult = {
        outcome: "existing_by_path",
        releasePlan: { release_plan_details: { ReleasePlanId: 123, Status: status } },
        details: { releasePlanId: "123" },
      };
      mocks.ensureReleasePlan.mockReturnValue(result);

      await main();

      expect(JSON.parse(readFileSync(outputFile, "utf8"))).toEqual(result);
      expect(mocks.createComment).not.toHaveBeenCalled();
      expect(warn).not.toHaveBeenCalled();
    },
  );

  it("reports lookup errors and manual recovery steps for TypeSpec-only changes", async () => {
    const error = vi.spyOn(console, "error").mockImplementation(() => {});
    const warn = vi.spyOn(console, "warn").mockImplementation(() => {});
    const exit = vi.spyOn(process, "exit").mockImplementation(() => {
      throw new Error("process.exit");
    });
    mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue({
      projectInfo: {
        tspProjectPath: projectPath,
        apiVersion: "2026-01-01-preview",
        isPreview: true,
      },
      changedFiles: [{ filename: `${projectPath}/client.tsp` }],
      prNumber: 42,
    } satisfies CommitProjectInfoResult);
    mocks.ensureReleasePlan.mockImplementation(() => {
      throw new Error("Release plan get failed. Access denied");
    });

    await expect(main()).rejects.toThrow("process.exit");

    expect(exit).toHaveBeenCalledWith(1);
    expect(error).toHaveBeenCalledWith(expect.stringContaining("Access denied"));
    expect(existsSync(outputFile)).toBe(false);
    expect(mocks.createComment).toHaveBeenCalledOnce();
    expect(mocks.createComment.mock.calls[0][0].body).toContain("Release Plan Processing Failed");
    expect(mocks.createComment.mock.calls[0][0].body).toContain("Access denied");
    expect(mocks.createComment.mock.calls[0][0].body).toContain("2026-01-01-preview");
    expect(mocks.createComment.mock.calls[0][0].body).toContain("fix the error before rerunning");
    expect(warn).toHaveBeenCalledWith(
      expect.stringContaining("##vso[task.logissue type=warning]Release plan processing failed"),
    );
  });

  it("keeps the created plan artifact when its comment fails", async () => {
    const warn = vi.spyOn(console, "warn").mockImplementation(() => {});
    mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue({
      projectInfo: {
        tspProjectPath: projectPath,
        apiVersion: "2026-01-01-preview",
        isPreview: true,
      },
      changedFiles: [{ filename: `${projectPath}/client.tsp` }],
      prNumber: 42,
    } satisfies CommitProjectInfoResult);
    mocks.ensureReleasePlan.mockReturnValue({
      outcome: "created",
      releasePlan: { ReleasePlanId: 123 },
      details: { releasePlanId: "123" },
    } satisfies EnsureReleasePlanResult);
    mocks.createComment.mockRejectedValueOnce(new Error("GitHub unavailable"));

    await main();

    expect(existsSync(outputFile)).toBe(true);
    expect(warn).toHaveBeenCalledWith(
      expect.stringContaining("Failed to post comment on PR: Failed to post release plan comment"),
    );
  });

  it("only comments when multiple projects remain, without creating a plan or SDK artifact", async () => {
    const paths = [projectPath, "specification/other/Other"];
    const result: CommitProjectInfoResult = {
      projectInfo: null,
      changedFiles: [{ filename: `${projectPath}/tspconfig.yaml`, status: "modified" }],
      multipleProjectPaths: paths,
      prNumber: 42,
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
        expect(comment.body).toContain("Release Plan Processing Failed");
        expect(comment.body).toContain(message);
        expect(comment.body).toContain(projectPath);
      }
    },
  );

  it.each(["all", "multiple-versions"])(
    "requires manual version selection for private-preview metadata %s",
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
      };
      mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(discovery);
      const actual =
        await vi.importActual<typeof import("../src/release-plan.ts")>("../src/release-plan.ts");
      mocks.ensureReleasePlan.mockImplementation(actual.ensureReleasePlan);

      await main();

      expect(mocks.ensureReleasePlan).toHaveBeenCalledExactlyOnceWith(
        expect.objectContaining({ apiVersion, apiReleaseType: "Private Preview" }),
        mocks.runner,
      );
      expect(existsSync(outputFile)).toBe(true);
      expect(mocks.createComment).toHaveBeenCalledOnce();
      expect(mocks.runner).not.toHaveBeenCalled();
      expect(mocks.createComment.mock.calls[0][0].body).toContain("Manual Release Plan Required");
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
    };
    const plan: EnsureReleasePlanResult = {
      outcome: "created",
      releasePlan: {
        release_plan_details: { ReleasePlanId: 123 },
        release_plan_link: "https://example.com/plan/123",
      },
      details: { releasePlanId: "123" },
    };
    mocks.getTypeSpecProjectInfoFromCommit.mockResolvedValue(discovery);
    mocks.ensureReleasePlan.mockReturnValue(plan);

    await main();

    expect(mocks.ensureReleasePlan).toHaveBeenCalledExactlyOnceWith(
      expect.objectContaining({ tspProjectPath: projectPath }),
      mocks.runner,
    );
    expect(mocks.createComment).toHaveBeenCalledOnce();
    const [comment] = mocks.createComment.mock.calls[0];
    expect(comment).toMatchObject({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      issue_number: 42,
    });
    expect(comment.body).toContain(`| **TypeSpec Project** | \`${projectPath}\` |`);
    expect(comment.body).toContain("| **Release Plan ID** | 123 |");
    expect(existsSync(outputFile)).toBe(true);
  });
});
