import { describe, it, expect } from "vitest"; //vi

import path from "path";

import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { PRContext, LabelContext } from "../src/types.js";
import { evaluateImpact } from "../src/runner.js";

// const REPOROOT = path.resolve(__dirname, "..", "..", "..", "..");

describe("Check Changes", () => {
    it("Should return true when the file has changes", async () => {
        const targetDirectory = path.join("/home/semick/repo/rest-s/35346", "before");
        const sourceDirectory = path.join("/home/semick/repo/rest-s/35346", "after");

        const changedFileDetails = await getChangedFilesStatuses({ cwd: sourceDirectory, baseCommitish: "origin/main" });
        const labelContext: LabelContext = {
            present: new Set(),
            toAdd: new Set(),
            toRemove: new Set()
        };

        const prContext = new PRContext(sourceDirectory, targetDirectory, labelContext, {
            sha: "ad7c74cb27d2cf3ba83996aaea36b07caa4d16c8",
            sourceBranch: "dev/nandiniy/DTLTypeSpec",
            targetBranch: "main",
            repo: "azure-rest-api-specs",
            prNumber: "35346",
            owner: "Azure",
            fileList: changedFileDetails,
            isDraft: false
        });

        const result = await evaluateImpact(prContext, labelContext);

        expect(result).toBeDefined();
        expect(changedFileDetails).toBeDefined();
        expect(changedFileDetails.total).toEqual(293);
    });
});
