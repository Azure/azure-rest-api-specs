import { mkdtemp, mkdir, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import { afterEach, describe, expect, it } from "vitest";
import { publishSdkReviewResult } from "../src/sdk-validation-dotnet-review-publisher.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const HEAD_SHA = "1".repeat(40);
const SKILL_REVISION = "2".repeat(40);
const REMEDIATION_SKILL_REVISION = "3".repeat(40);
const BASELINE_SHA = "4".repeat(40);
const SPEC_FILE = "specification/widget/Widget.Management/models.tsp";
const temporaryDirectories: string[] = [];

async function writeJson(filePath: string, value: unknown): Promise<void> {
  await mkdir(path.dirname(filePath), { recursive: true });
  await writeFile(filePath, JSON.stringify(value));
}

async function createFixture(): Promise<{
  publicationContextPath: string;
  resultRootPath: string;
}> {
  const root = await mkdtemp(path.join(os.tmpdir(), "sdk-review-publisher-"));
  temporaryDirectories.push(root);
  const resultRootPath = path.join(root, "results");
  const publicationContextPath = path.join(root, "publication", "typespec-review-context.json");
  await mkdir(resultRootPath, { recursive: true });
  const source = { specPrNumber: 42, specHeadSha: HEAD_SHA };
  const reviewContext = {
    source,
    canonicalSkill: { skillRevision: SKILL_REVISION },
    remediationSkill: { skillRevision: REMEDIATION_SKILL_REVISION },
    workspaces: [
      {
        baselineCommitSha: BASELINE_SHA,
        packages: [
          {
            packageName: "Azure.Widget",
            changedFiles: ["sdk/widget/Azure.Widget/src/Generated/Widget.cs"],
          },
        ],
      },
    ],
  };
  const rawResult = {
    schemaVersion: 1,
    status: "completed",
    skillRevision: SKILL_REVISION,
    source,
    reviews: [
      {
        baselineCommitSha: BASELINE_SHA,
        packages: ["Azure.Widget"],
        findings: [
          {
            severity: "high",
            file: "sdk/widget/Azure.Widget/src/Generated/Widget.cs",
            line: 12,
            title: "Generic model name",
            description: "The generated model lacks service context.",
          },
        ],
      },
    ],
  };
  const typeSpecContext = {
    schemaVersion: 1,
    source: { ...source, specBaseSha: "5".repeat(40) },
    projects: [],
    files: [
      {
        path: SPEC_FILE,
        roles: ["changed"],
        content: "model Widget {\n  name: string;\n}\n",
        patch: "@@ -1,3 +1,3 @@\n-model OldWidget {\n+model Widget {\n   name: string;\n }",
      },
    ],
  };
  const remediationResult = {
    schemaVersion: 1,
    status: "completed",
    skillRevision: REMEDIATION_SKILL_REVISION,
    source,
    findings: [
      {
        reviewIndex: 0,
        findingIndex: 0,
        severity: "high",
        generatedLocation: {
          file: rawResult.reviews[0].findings[0].file,
          line: 12,
        },
        category: "naming",
        title: "Generic model name",
        evidence: "The generated model lacks service context.",
        remediation: {
          target: "client.tsp",
          languageScopes: ["csharp"],
          suggestion: "Add a C#-scoped @@clientName decorator.",
          confidence: "high",
          sourceLocation: { file: SPEC_FILE, line: 1 },
        },
      },
    ],
  };
  await Promise.all([
    writeJson(publicationContextPath, typeSpecContext),
    writeJson(
      path.join(resultRootPath, "sdk-review-workspaces", "sdk-review-context.json"),
      reviewContext,
    ),
    writeJson(path.join(resultRootPath, "sdk-review-result.json"), rawResult),
    writeFile(path.join(resultRootPath, "sdk-review-result.md"), "# SDK review\n"),
    writeJson(
      path.join(resultRootPath, "sdk-review-input", "typespec-review-context.json"),
      typeSpecContext,
    ),
    writeJson(path.join(resultRootPath, "typespec-remediation-result.json"), remediationResult),
    writeFile(
      path.join(resultRootPath, "typespec-remediation-result.md"),
      "# TypeSpec remediation\n",
    ),
  ]);
  return { publicationContextPath, resultRootPath };
}

afterEach(async () => {
  const { rm } = await import("node:fs/promises");
  await Promise.all(
    temporaryDirectories
      .splice(0)
      .map((directory) => rm(directory, { recursive: true, force: true })),
  );
});

describe("publishSdkReviewResult", () => {
  it("does not mutate a PR after its head changes", async () => {
    const fixture = await createFixture();
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: "9".repeat(40) } },
    });

    await publishSdkReviewResult({
      githubScript: { github, context: createMockContext(), core: createMockCore() },
      ...fixture,
      workflowConclusion: "success",
      workflowRunUrl: "https://github.com/owner/repo/actions/runs/1",
    });

    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(github.rest.pulls.createReviewComment).not.toHaveBeenCalled();
  });

  it("publishes failure guidance without reading result artifacts", async () => {
    const fixture = await createFixture();
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: HEAD_SHA } },
    });

    await publishSdkReviewResult({
      githubScript: { github, context: createMockContext(), core: createMockCore() },
      ...fixture,
      resultRootPath: path.join(fixture.resultRootPath, "missing"),
      workflowConclusion: "failure",
      workflowRunUrl: "https://github.com/owner/repo/actions/runs/1",
    });

    const failureComment = github.rest.issues.createComment.mock.calls[0]?.[0] as unknown as {
      issue_number: number;
      body: string;
    };
    expect(failureComment.issue_number).toBe(42);
    expect(failureComment.body).toContain("did not finish");
    expect(github.rest.pulls.createReviewComment).not.toHaveBeenCalled();
  });

  it("revalidates and publishes successful results", async () => {
    const fixture = await createFixture();
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: HEAD_SHA } },
    });

    await publishSdkReviewResult({
      githubScript: { github, context: createMockContext(), core: createMockCore() },
      ...fixture,
      workflowConclusion: "success",
      workflowRunUrl: "https://github.com/owner/repo/actions/runs/1",
    });

    expect(github.rest.pulls.createReviewComment).toHaveBeenCalledTimes(1);
    const summaryComment = github.rest.issues.createComment.mock.calls[0]?.[0] as unknown as {
      issue_number: number;
      body: string;
    };
    expect(summaryComment.issue_number).toBe(42);
    expect(summaryComment.body).toContain("Posted 1 exact changed-line comment");
  });

  it("rejects results for a different source than the trusted publication context", async () => {
    const fixture = await createFixture();
    const reviewContextPath = path.join(
      fixture.resultRootPath,
      "sdk-review-workspaces",
      "sdk-review-context.json",
    );
    const reviewContext = JSON.parse(
      await (await import("node:fs/promises")).readFile(reviewContextPath, "utf8"),
    ) as { source: { specPrNumber: number } };
    reviewContext.source.specPrNumber = 99;
    await writeJson(reviewContextPath, reviewContext);
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: { state: "open", head: { sha: HEAD_SHA } },
    });

    await expect(
      publishSdkReviewResult({
        githubScript: { github, context: createMockContext(), core: createMockCore() },
        ...fixture,
        workflowConclusion: "success",
        workflowRunUrl: "https://github.com/owner/repo/actions/runs/1",
      }),
    ).rejects.toThrow("trusted publication context");

    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    expect(github.rest.pulls.createReviewComment).not.toHaveBeenCalled();
  });

  it("validates exact-line mappings against the protected pre-agent context", async () => {
    const fixture = await createFixture();
    const remediationResultPath = path.join(
      fixture.resultRootPath,
      "typespec-remediation-result.json",
    );
    const remediationResult = JSON.parse(
      await (await import("node:fs/promises")).readFile(remediationResultPath, "utf8"),
    ) as {
      findings: Array<{
        remediation: { sourceLocation: { line: number } };
      }>;
    };
    remediationResult.findings[0].remediation.sourceLocation.line = 2;
    await writeJson(remediationResultPath, remediationResult);
    const resultContextPath = path.join(
      fixture.resultRootPath,
      "sdk-review-input",
      "typespec-review-context.json",
    );
    const resultContext = JSON.parse(
      await (await import("node:fs/promises")).readFile(resultContextPath, "utf8"),
    ) as { files: Array<{ patch: string }> };
    resultContext.files[0].patch =
      "@@ -1,3 +1,3 @@\n model Widget {\n-  oldName: string;\n+  name: string;\n }";
    await writeJson(resultContextPath, resultContext);
    const github = createMockGithub();

    await expect(
      publishSdkReviewResult({
        githubScript: { github, context: createMockContext(), core: createMockCore() },
        ...fixture,
        workflowConclusion: "success",
        workflowRunUrl: "https://github.com/owner/repo/actions/runs/1",
      }),
    ).rejects.toThrow("is not changed by the spec PR");

    expect(github.rest.pulls.get).not.toHaveBeenCalled();
    expect(github.rest.pulls.createReviewComment).not.toHaveBeenCalled();
  });
});
