import type { GitHubScriptArgs } from "./github.ts";
import { reportWorkflowFailure } from "./report-workflow-failure.ts";

export async function reportLabelSyncFailure(args: GitHubScriptArgs) {
  return reportWorkflowFailure(args, {
    marker: "<!-- sync-repo-labels-failure -->",
    title: "Repository label synchronization is failing",
    description: "Repository label synchronization failed.",
    guidance:
      "Inspect the failed job logs and any `label-audit-before` / `label-audit-outcome` " +
      "artifacts on that run. Resolve the failure and rerun synchronization; label cleanup " +
      "may be incomplete until it succeeds.",
  });
}
