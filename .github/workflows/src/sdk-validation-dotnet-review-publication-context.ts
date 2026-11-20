import { isFullGitSha } from "../../shared/src/git.ts";

export const SDK_REVIEW_PUBLICATION_CONTEXT_FILE_NAME =
  "sdk-review-publication-context.json" as const;

export type SdkReviewPublicationContext = {
  schemaVersion: 1;
  source: {
    specPrNumber: number;
    specHeadSha: string;
    specBaseRef: string;
    specMergeBaseSha: string;
  };
  handoff: {
    adoBuildId: string;
    workflowRunId: number;
    workflowRunAttempt: number;
  };
};

export function requireSdkReviewPublicationContext(value: unknown): SdkReviewPublicationContext {
  const context = value as Partial<SdkReviewPublicationContext>;
  const source = context?.source;
  const handoff = context?.handoff;
  if (
    context?.schemaVersion !== 1 ||
    !Number.isSafeInteger(source?.specPrNumber) ||
    Number(source?.specPrNumber) <= 0 ||
    typeof source?.specHeadSha !== "string" ||
    !isFullGitSha(source.specHeadSha) ||
    typeof source.specBaseRef !== "string" ||
    source.specBaseRef.length === 0 ||
    typeof source.specMergeBaseSha !== "string" ||
    !isFullGitSha(source.specMergeBaseSha) ||
    typeof handoff?.adoBuildId !== "string" ||
    !/^\d+$/.test(handoff.adoBuildId) ||
    !Number.isSafeInteger(handoff.workflowRunId) ||
    Number(handoff.workflowRunId) <= 0 ||
    !Number.isSafeInteger(handoff.workflowRunAttempt) ||
    Number(handoff.workflowRunAttempt) <= 0
  ) {
    throw new Error("SDK review publication context has invalid trusted identity");
  }
  return context as SdkReviewPublicationContext;
}
