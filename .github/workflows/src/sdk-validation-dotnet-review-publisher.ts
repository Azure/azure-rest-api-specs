import { readFile } from "node:fs/promises";
import path from "node:path";
import { isFullGitSha } from "../../shared/src/git.ts";
import type { GitHubScriptArgs } from "./github.ts";
import {
  buildSdkReviewFailureSummary,
  buildSdkReviewSummary,
  publishSdkReviewSummary,
  type PublishableRemediationFinding,
} from "./sdk-validation-dotnet-review-comments.ts";
import { validateSdkReviewResult } from "./sdk-validation-dotnet-review-result.ts";
import { validateTypeSpecRemediationResult } from "./sdk-validation-typespec-remediation-result.ts";

type PublicationContext = {
  schemaVersion: 1;
  source: {
    specPrNumber: number;
    specHeadSha: string;
    specBaseSha: string;
  };
};

type RemediationResult = {
  findings: PublishableRemediationFinding[];
};

async function readJson(filePath: string): Promise<unknown> {
  return JSON.parse(await readFile(filePath, "utf8"));
}

function requirePublicationContext(value: unknown): PublicationContext {
  const context = value as Partial<PublicationContext>;
  const pullNumber = context?.source?.specPrNumber;
  const headSha = context?.source?.specHeadSha;
  const baseSha = context?.source?.specBaseSha;
  if (
    context?.schemaVersion !== 1 ||
    !Number.isSafeInteger(pullNumber) ||
    Number(pullNumber) <= 0 ||
    typeof headSha !== "string" ||
    !isFullGitSha(headSha) ||
    typeof baseSha !== "string" ||
    !isFullGitSha(baseSha)
  ) {
    throw new Error("SDK review publication context has invalid source identity");
  }
  return context as PublicationContext;
}

export async function readSdkReviewPublicationContext(
  publicationContextPath: string,
): Promise<PublicationContext> {
  return requirePublicationContext(await readJson(publicationContextPath));
}

function requireRemediationResult(value: unknown): RemediationResult {
  const result = value as Partial<RemediationResult>;
  if (!Array.isArray(result?.findings)) {
    throw new Error("SDK review remediation result is missing findings");
  }
  return result as RemediationResult;
}

function validateResultSource(
  reviewContextValue: unknown,
  publicationContext: PublicationContext,
): void {
  const reviewContext = reviewContextValue as Partial<PublicationContext>;
  if (
    reviewContext?.source?.specPrNumber !== publicationContext.source.specPrNumber ||
    reviewContext?.source?.specHeadSha !== publicationContext.source.specHeadSha
  ) {
    throw new Error("SDK review result source does not match the trusted publication context");
  }
}

export async function publishSdkReviewResult(params: {
  githubScript: GitHubScriptArgs;
  publicationContextPath: string;
  resultRootPath: string;
  validatedResultAvailable: boolean;
  workflowConclusion: string;
  workflowRunUrl: string;
}): Promise<void> {
  const {
    githubScript,
    publicationContextPath,
    resultRootPath,
    validatedResultAvailable,
    workflowConclusion,
    workflowRunUrl,
  } = params;
  const { github, context, core } = githubScript;
  const publicationContext = await readSdkReviewPublicationContext(publicationContextPath);
  const { specPrNumber, specHeadSha, specBaseSha } = publicationContext.source;
  let remediationResult: RemediationResult | undefined;
  if (workflowConclusion === "success" && validatedResultAvailable) {
    const reviewContextPath = path.join(
      resultRootPath,
      "sdk-review-workspaces",
      "sdk-review-context.json",
    );
    const rawResultPath = path.join(resultRootPath, "sdk-review-result.json");
    const remediationResultPath = path.join(resultRootPath, "typespec-remediation-result.json");
    const remediationReportPath = path.join(resultRootPath, "typespec-remediation-result.md");
    const [reviewContext, rawResult, remediationResultValue, remediationReport] = await Promise.all(
      [
        readJson(reviewContextPath),
        readJson(rawResultPath),
        readJson(remediationResultPath),
        readFile(remediationReportPath, "utf8"),
      ],
    );
    validateResultSource(reviewContext, publicationContext);
    validateSdkReviewResult(reviewContext, rawResult);
    validateTypeSpecRemediationResult(
      reviewContext,
      rawResult,
      publicationContext,
      remediationResultValue,
      remediationReport,
    );
    remediationResult = requireRemediationResult(remediationResultValue);
  }

  const { data: pullRequest } = await github.rest.pulls.get({
    owner: context.repo.owner,
    repo: context.repo.repo,
    pull_number: specPrNumber,
  });
  if (
    pullRequest.state !== "open" ||
    pullRequest.head.sha !== specHeadSha ||
    pullRequest.base.sha !== specBaseSha
  ) {
    core.info(
      `Skipping generated SDK review publication because PR #${specPrNumber} is closed or moved from ${specBaseSha}...${specHeadSha}.`,
    );
    return;
  }
  if (!remediationResult) {
    await publishSdkReviewSummary(
      githubScript,
      specPrNumber,
      buildSdkReviewFailureSummary(specHeadSha, workflowRunUrl),
    );
    return;
  }

  await publishSdkReviewSummary(
    githubScript,
    specPrNumber,
    buildSdkReviewSummary({
      findings: remediationResult.findings,
      headSha: specHeadSha,
      repositoryUrl: `${context.serverUrl}/${context.repo.owner}/${context.repo.repo}`,
      workflowRunUrl,
    }),
  );
}
