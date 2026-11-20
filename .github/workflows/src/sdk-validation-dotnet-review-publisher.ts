import { readFile } from "node:fs/promises";
import path from "node:path";
import type { GitHubScriptArgs } from "./github.ts";
import {
  buildSdkReviewFailureSummary,
  buildSdkReviewStaleComparisonSummary,
  buildSdkReviewSummary,
  publishSdkReviewSummary,
  type PublishableRemediationFinding,
} from "./sdk-validation-dotnet-review-comments.ts";
import {
  requireSdkReviewPublicationContext,
  type SdkReviewPublicationContext,
} from "./sdk-validation-dotnet-review-publication-context.ts";
import { validateSdkReviewResult } from "./sdk-validation-dotnet-review-result.ts";
import { validateTypeSpecRemediationResult } from "./sdk-validation-typespec-remediation-result.ts";

type RemediationResult = {
  findings: PublishableRemediationFinding[];
};

async function readJson(filePath: string): Promise<unknown> {
  return JSON.parse(await readFile(filePath, "utf8"));
}

export async function readSdkReviewPublicationContext(
  publicationContextPath: string,
): Promise<SdkReviewPublicationContext> {
  return requireSdkReviewPublicationContext(await readJson(publicationContextPath));
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
  publicationContext: SdkReviewPublicationContext,
): void {
  const reviewContext = reviewContextValue as Partial<SdkReviewPublicationContext>;
  if (
    reviewContext?.source?.specPrNumber !== publicationContext.source.specPrNumber ||
    reviewContext?.source?.specHeadSha !== publicationContext.source.specHeadSha
  ) {
    throw new Error("SDK review result source does not match the trusted publication context");
  }
}

function validateTypeSpecContextSource(
  typeSpecContextValue: unknown,
  publicationContext: SdkReviewPublicationContext,
): void {
  const typeSpecContext = typeSpecContextValue as Partial<SdkReviewPublicationContext>;
  const source = typeSpecContext?.source;
  if (
    source?.specPrNumber !== publicationContext.source.specPrNumber ||
    source.specHeadSha !== publicationContext.source.specHeadSha ||
    source.specBaseRef !== publicationContext.source.specBaseRef ||
    source.specMergeBaseSha !== publicationContext.source.specMergeBaseSha
  ) {
    throw new Error("TypeSpec review context does not match the trusted publication context");
  }
}

export async function publishSdkReviewResult(params: {
  githubScript: GitHubScriptArgs;
  publicationContextPath: string;
  resultRootPath: string;
  trustedContextRootPath: string;
  validatedResultAvailable: boolean;
  workflowConclusion: string;
  workflowRunUrl: string;
}): Promise<void> {
  const {
    githubScript,
    publicationContextPath,
    resultRootPath,
    trustedContextRootPath,
    validatedResultAvailable,
    workflowConclusion,
    workflowRunUrl,
  } = params;
  const { github, context, core } = githubScript;
  const publicationContext = await readSdkReviewPublicationContext(publicationContextPath);
  const { specPrNumber, specHeadSha, specBaseRef, specMergeBaseSha } = publicationContext.source;
  let remediationResult: RemediationResult | undefined;
  if (workflowConclusion === "success" && validatedResultAvailable) {
    const reviewContextPath = path.join(
      trustedContextRootPath,
      "sdk-review-workspaces",
      "sdk-review-context.json",
    );
    const typeSpecContextPath = path.join(
      trustedContextRootPath,
      "sdk-review-input",
      "typespec-review-context.json",
    );
    const rawResultPath = path.join(resultRootPath, "sdk-review-result.json");
    const remediationResultPath = path.join(resultRootPath, "typespec-remediation-result.json");
    const remediationReportPath = path.join(resultRootPath, "typespec-remediation-result.md");
    const [reviewContext, typeSpecContext, rawResult, remediationResultValue, remediationReport] =
      await Promise.all([
        readJson(reviewContextPath),
        readJson(typeSpecContextPath),
        readJson(rawResultPath),
        readJson(remediationResultPath),
        readFile(remediationReportPath, "utf8"),
      ]);
    validateResultSource(reviewContext, publicationContext);
    validateTypeSpecContextSource(typeSpecContext, publicationContext);
    validateSdkReviewResult(reviewContext, rawResult);
    validateTypeSpecRemediationResult(
      reviewContext,
      rawResult,
      typeSpecContext,
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
  if (pullRequest.state !== "open" || pullRequest.head.sha !== specHeadSha) {
    core.info(
      `Skipping generated SDK review publication because PR #${specPrNumber} is closed or moved from head ${specHeadSha}.`,
    );
    return;
  }
  if (pullRequest.base.ref !== specBaseRef) {
    await publishSdkReviewSummary(
      githubScript,
      specPrNumber,
      buildSdkReviewStaleComparisonSummary(specHeadSha, workflowRunUrl),
    );
    return;
  }
  const { data: comparison } = await github.rest.repos.compareCommitsWithBasehead({
    owner: context.repo.owner,
    repo: context.repo.repo,
    basehead: `${pullRequest.base.sha}...${specHeadSha}`,
  });
  if (comparison.merge_base_commit?.sha !== specMergeBaseSha) {
    await publishSdkReviewSummary(
      githubScript,
      specPrNumber,
      buildSdkReviewStaleComparisonSummary(specHeadSha, workflowRunUrl),
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
