import fs from "fs";
import path from "path";
import { afterEach, beforeEach, describe, expect, it } from "vitest"; //vi
import { PRContext } from "../src/PRContext.js";
import { evaluateImpact } from "../src/impact.js";
import { LabelContext } from "../src/labelling-types.js";

const FIXTURE_DIRECTORY = path.join(__dirname, "fixtures");
const BEFORE_REPO_FIXTURE = path.join(FIXTURE_DIRECTORY, "default", "before");
const AFTER_REPO_FIXTURE = path.join(FIXTURE_DIRECTORY, "default", "after");

const DEFAULT_MAIN_SPEC_FOLDERS: string[] = fs
  .readdirSync(path.join(BEFORE_REPO_FIXTURE, "specification"), { withFileTypes: true })
  .filter((d) => d.isDirectory())
  .map((d) => path.join(BEFORE_REPO_FIXTURE, "specification", d.name));

describe("Impact Detection - default fixture", () => {
  let originalCwd: string;

  beforeEach(() => {
    // Save the original working directory
    originalCwd = process.cwd();
    // Change to the 'after' fixture directory
    process.chdir(AFTER_REPO_FIXTURE);
  });

  afterEach(() => {
    // Restore the original working directory
    process.chdir(originalCwd);
  });

  const testCases = [
    {
      description: "Should properly handle no changes",
      changedFileDetails: {
        additions: [],
        modifications: [],
        deletions: [],
        renames: [],
        total: 0,
      },
      expectedImpact: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: false,
        dataPlaneRequired: false,
        typeSpecChanged: false,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "Should properly identify typespec changes",
      changedFileDetails: {
        additions: [],
        modifications: ["specification/contosowidgetmanager/Contoso.WidgetManager/main.tsp"],
        deletions: [],
        renames: [],
        total: 1,
      },
      expectedImpact: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: false,
        dataPlaneRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "Should properly identify when suppression review is required",
      changedFileDetails: {
        additions: [],
        modifications: ["specification/contosowidgetmanager/resource-manager/readme.md"],
        deletions: [],
        renames: [],
        total: 1,
      },
      expectedImpact: {
        suppressionReviewRequired: true,
        rpaasChange: true,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        typeSpecChanged: false,
        isNewApiVersion: false,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "Should properly identify a new API Version",
      changedFileDetails: {
        additions: [
          "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2024-12-01/widgets.json",
        ],
        modifications: [],
        deletions: [],
        renames: [],
        total: 1,
      },
      expectedImpact: {
        suppressionReviewRequired: false,
        rpaasChange: false,
        newRP: false,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: false,
        dataPlaneRequired: true,
        typeSpecChanged: true,
        isNewApiVersion: true,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "Should properly identify an RP that wasn't present before",
      changedFileDetails: {
        additions: [
          "specification/contosowidgermanager2/resource-manager/readme.md",
          "specification/contosowidgermanager2/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
        ],
        modifications: [],
        deletions: [],
        renames: [],
        total: 1,
      },
      expectedImpact: {
        suppressionReviewRequired: true,
        rpaasChange: true,
        newRP: true,
        rpaasRPMissing: false,
        rpaasRpNotInPrivateRepo: true,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: true,
        isDraft: false,
        targetBranch: "main",
      },
    },
    {
      description: "should properly identify a new RP that isn't of rpaas subtype",
      changedFileDetails: {
        additions: [
          "specification/contosowidgermanager3/resource-manager/readme.md",
          "specification/contosowidgermanager3/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
        ],
        modifications: [],
        deletions: [],
        renames: [],
        total: 1,
      },
      expectedImpact: {
        suppressionReviewRequired: true,
        rpaasChange: false,
        newRP: true,
        rpaasRPMissing: true,
        rpaasRpNotInPrivateRepo: false,
        resourceManagerRequired: true,
        dataPlaneRequired: false,
        typeSpecChanged: true,
        isNewApiVersion: true,
        isDraft: false,
        targetBranch: "main",
      },
    },
  ];
  it.each(testCases)("$description", async ({ changedFileDetails, expectedImpact }) => {
    const labelContext: LabelContext = {
      present: new Set(),
      toAdd: new Set(),
      toRemove: new Set(),
    };

    const prContext = new PRContext(AFTER_REPO_FIXTURE, BEFORE_REPO_FIXTURE, labelContext, {
      sha: "2bd8350d465081401a0f4f03e633eca41f0991de",
      sourceBranch: "contosotest",
      targetBranch: expectedImpact.targetBranch,
      repo: "azure-rest-api-specs",
      prNumber: "1",
      owner: "Azure",
      fileList: changedFileDetails,
      isDraft: false,
    });

    const actualImpact = await evaluateImpact(prContext, labelContext, DEFAULT_MAIN_SPEC_FOLDERS);
    expect(actualImpact).toEqual(expectedImpact);
  });
});
