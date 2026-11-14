import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";
import { CLIENT_CUSTOMIZATION_APPROVED_LABEL, LabelAction } from "./label.ts";

/**
 * Resets the client customization approval when a push changes the PR's diff.
 * Rebases that leave the diff unchanged keep the approval.
 */
export default async function resetClientCustomizationApproval({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<LabelAction> {
  const {
    before,
    after,
    pull_request: pr,
  } = context.payload as WebhookEvent<"pull-request", "synchronize">;
  if (!pr.labels.some((label) => label.name === CLIENT_CUSTOMIZATION_APPROVED_LABEL)) {
    return LabelAction.None;
  }

  const diff = async (head: string) => {
    const { data } = await github.rest.repos.compareCommitsWithBasehead({
      ...context.repo,
      basehead: `${pr.base.sha}...${head}`,
    });
    return JSON.stringify(data.files?.map((file) => [file.filename, file.status, file.patch]));
  };

  try {
    if ((await diff(before)) === (await diff(after))) {
      core.info("PR diff is unchanged; keeping client customization approval.");
      return LabelAction.None;
    }
  } catch (error) {
    core.warning(`Could not compare pushes: ${String(error)}`);
  }
  core.info("PR diff changed; removing client customization approval.");
  return LabelAction.Remove;
}
