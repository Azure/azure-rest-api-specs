import { describe, expect, it } from "vitest"; //vi

import path from "path";

import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { Octokit } from "@octokit/rest";
import { PRContext } from "../src/PRContext.js";
import { evaluateImpact, getRPaaSFolderList } from "../src/impact.js";
import { LabelContext } from "../src/labelling-types.js";

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
        const labelContext: LabelContext = {
          present: new Set(),
          toAdd: new Set(),
          toRemove: new Set(),
        };

        const github = new Octokit({
          ...(process.env.GITHUB_TOKEN && { auth: process.env.GITHUB_TOKEN }),
        });
        const rpaaSFolderList = await getRPaaSFolderList(github, "Azure", "azure-rest-api-specs");

        const prContext = new PRContext(sourceDirectory, targetDirectory, labelContext, {
          sha: "ad7c74cb27d2cf3ba83996aaea36b07caa4d16c8",
          sourceBranch: "dev/nandiniy/DTLTypeSpec",
          targetBranch: "main",
          repo: "azure-rest-api-specs",
          prNumber: "35346",
          owner: "Azure",
          fileList: changedFileDetails,
          isDraft: false,
        });

        const result = await evaluateImpact(prContext, labelContext, rpaaSFolderList);

        expect(result).toBeDefined();
        expect(result.typeSpecChanged).toBeTruthy();
        expect(result.dataPlaneRequired).toBeFalsy();
        expect(result.resourceManagerRequired).toBeTruthy();
        expect(result.suppressionReviewRequired).toBeTruthy();
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
        const labelContext: LabelContext = {
          present: new Set(),
          toAdd: new Set(),
          toRemove: new Set(),
        };

        const prContext = new PRContext(sourceDirectory, targetDirectory, labelContext, {
          sha: "2bd8350d465081401a0f4f03e633eca41f0991de",
          sourceBranch: "features/users/deepika/cosmos-connectors-confluent",
          targetBranch: "main",
          repo: "azure-rest-api-specs",
          prNumber: "35982",
          owner: "Azure",
          fileList: changedFileDetails,
          isDraft: false,
        });

        const result = await evaluateImpact(prContext, labelContext, []);
        expect(result.isNewApiVersion).toBeTruthy();
        expect(result.typeSpecChanged).toBeTruthy();
        expect(result.resourceManagerRequired).toBeTruthy();
        expect(result.isNewApiVersion).toBeTruthy();
        expect(result.rpaasChange).toBeTruthy();
        expect(result).toBeDefined();
      } finally {
        // Restore original directory
        process.chdir(originalCwd);
      }
    },
    60000000,
  );
});
