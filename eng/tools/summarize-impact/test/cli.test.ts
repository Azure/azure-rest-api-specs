import { afterEach, beforeEach, describe, expect, it } from "vitest"; //vi

import { execFileSync } from "node:child_process";
import { cpSync, mkdirSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import path from "node:path";

import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import type { ImpactAssessment } from "@azure-tools/specs-shared/impact";
import { PRContext } from "../src/PRContext.ts";
import { evaluateImpact, getRPaaSFolderList } from "../src/impact.ts";

describe("CLI PR comparison", () => {
  let directory: string;
  let sourceDirectory: string;
  let targetDirectory: string;

  function git(...args: string[]): string {
    return execFileSync("git", ["-c", "commit.gpgsign=false", ...args], {
      cwd: sourceDirectory,
      encoding: "utf8",
      stdio: ["ignore", "pipe", "pipe"],
    }).trim();
  }

  function addSwagger(plane: string, version: string) {
    const file = path.join(
      sourceDirectory,
      "specification/contosowidgetmanager",
      plane,
      "Microsoft.Contoso/stable",
      version,
      "contoso.json",
    );
    mkdirSync(path.dirname(file), { recursive: true });
    writeFileSync(file, JSON.stringify({ swagger: "2.0", info: { version }, paths: {} }));
    git("add", ".");
    git("commit", "-m", `Add ${plane} ${version}`);
  }

  beforeEach(() => {
    directory = mkdtempSync(path.join(tmpdir(), "summarize-impact-"));
    sourceDirectory = path.join(directory, "after");
    targetDirectory = path.join(directory, "before");
    cpSync(path.join(__dirname, "fixtures/default/before"), sourceDirectory, { recursive: true });
    git("init", "-b", "main");
    git("config", "user.name", "Test");
    git("config", "user.email", "test@example.com");
    git("add", ".");
    git("commit", "-m", "Initial specs");
    git("checkout", "-b", "pr");
  });

  afterEach(() => {
    rmSync(directory, { recursive: true, force: true });
  });

  it.each([
    { mergeMain: true, plane: "resource-manager" },
    { mergeMain: false, plane: "resource-manager" },
    { mergeMain: true, plane: "data-plane" },
  ])("assesses only PR changes: %o", ({ mergeMain, plane }) => {
    addSwagger(plane, "2026-01-01");
    git("checkout", "main");
    // Including main's unrelated change must alter the machine-readable plane assessment.
    addSwagger(plane === "data-plane" ? "resource-manager" : "data-plane", "2026-02-01");
    const baseSha = git("rev-parse", "HEAD");
    git("checkout", "pr");
    if (mergeMain) {
      git("merge", "--no-ff", "main", "-m", "Merge main");
    } else {
      // The PR's impact must include earlier commits, not just HEAD^..HEAD.
      writeFileSync(path.join(sourceDirectory, "unrelated.txt"), "PR follow-up");
      git("add", ".");
      git("commit", "-m", "PR follow-up");
    }

    const headSha = git("rev-parse", "HEAD");
    const mergeBase = git("merge-base", baseSha, headSha);
    git("worktree", "add", "--detach", targetDirectory, mergeBase);

    execFileSync(
      process.execPath,
      [
        path.resolve(__dirname, "../cmd/summarize-impact.js"),
        "--sourceDirectory",
        sourceDirectory,
        "--targetDirectory",
        targetDirectory,
        "--number",
        "1",
        "--sourceBranch",
        "pr",
        "--targetBranch",
        "main",
        "--sha",
        headSha,
        "--repo",
        "azure-rest-api-specs",
        "--owner",
        "Azure",
      ],
      { cwd: sourceDirectory, encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] },
    );

    const impact = JSON.parse(
      readFileSync(path.join(sourceDirectory, "summary.json"), "utf8"),
    ) as ImpactAssessment;
    expect(impact.services).toEqual([
      expect.objectContaining({
        path: "specification/contosowidgetmanager",
        plane,
        newApiVersions: ["2026-01-01"],
      }),
    ]);
  });
});

describe("Check Changes", () => {
  it.skipIf(!process.env.GITHUB_TOKEN || !process.env.INTEGRATION_TEST)(
    "Integration test 35346",
    async () => {
      const targetDirectory = path.join("/home/semick/repo/rest-s/35346", "before");
      const sourceDirectory = path.join("/home/semick/repo/rest-s/35346", "after");

      // Change to source directory and save original
      const originalCwd = process.cwd();
      process.chdir(sourceDirectory);

      try {
        const changedFileDetails = await getChangedFilesStatuses({
          cwd: sourceDirectory,
          baseCommitish: "origin/main",
        });
        const rpaaSFolderList = getRPaaSFolderList(targetDirectory);

        const prContext = new PRContext(sourceDirectory, targetDirectory, {
          fileList: changedFileDetails,
        });

        const result = await evaluateImpact(prContext, rpaaSFolderList);

        expect(result.services.some((service) => service.typeSpec)).toBe(true);
        expect(result.services.some((service) => service.plane === "data-plane")).toBe(false);
        expect(result.services.some((service) => service.plane === "resource-manager")).toBe(true);
        expect(result.services.some((service) => service.suppressionsChanged)).toBe(true);
        expect(changedFileDetails).toBeDefined();
        expect(changedFileDetails.total).toEqual(293);
      } finally {
        // Restore original directory
        process.chdir(originalCwd);
      }
    },
    60000000,
  );

  it.skipIf(!process.env.GITHUB_TOKEN || !process.env.INTEGRATION_TEST)(
    "Integration test 35982",
    async () => {
      const targetDirectory = path.join("/home/semick/repo/rest-s/35982", "before");
      const sourceDirectory = path.join("/home/semick/repo/rest-s/35982", "after");

      // Change to source directory and save original
      const originalCwd = process.cwd();
      process.chdir(sourceDirectory);

      try {
        const changedFileDetails = await getChangedFilesStatuses({
          cwd: sourceDirectory,
          baseCommitish: "origin/main",
        });
        const prContext = new PRContext(sourceDirectory, targetDirectory, {
          fileList: changedFileDetails,
        });

        const result = await evaluateImpact(prContext, []);
        expect(result.services.some((service) => service.newApiVersions.length > 0)).toBe(true);
        expect(result.services.some((service) => service.typeSpec)).toBe(true);
        expect(result.services.some((service) => service.plane === "resource-manager")).toBe(true);
        expect(result.services.some((service) => service.resourceProvider.usesRpaas)).toBe(true);
      } finally {
        // Restore original directory
        process.chdir(originalCwd);
      }
    },
    60000000,
  );
});
