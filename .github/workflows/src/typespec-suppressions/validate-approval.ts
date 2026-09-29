import { extractInputs } from "../context.ts";
import type { GitHubScriptArgs, WebhookEvent } from "../github.ts";
import { TYPESPEC_SUPPRESSIONS_APPROVED_LABEL } from "../label.ts";
import { removeLabelIfPresent } from "../package-name-approval/labels.ts";
import {
  evaluateLabelAuthorization,
  loadProtectedLabelsConfig,
} from "../protected-labels/authorization.ts";

export default async function validateApproval({ github, context, core }: GitHubScriptArgs) {
  const payload = context.payload as WebhookEvent<"pull-request", "labeled">;
  const labelName = payload.label?.name;
  if (labelName !== TYPESPEC_SUPPRESSIONS_APPROVED_LABEL) {
    core.info(`${labelName ?? "Missing label"} is not a TypeSpec suppressions approval label.`);
    return;
  }

  const { owner, repo, issue_number } = await extractInputs(github, context, core);
  const actor = payload.sender.login;
  const config = await loadProtectedLabelsConfig();
  const prLabels = payload.pull_request.labels.map((label: { name: string }) => label.name);
  const authorization = evaluateLabelAuthorization({
    config,
    labelName,
    actor,
    prLabels,
  });

  if (authorization.status === "authorized" || authorization.status === "trusted-bot") {
    core.info(`${actor} is authorized to apply "${labelName}".`);
    return;
  }

  if (authorization.status !== "unauthorized") {
    throw new Error(
      `Cannot validate "${labelName}" authorization: policy returned ${authorization.status}.`,
    );
  }

  core.warning(`${actor} is not authorized to apply "${labelName}", removing.`);
  await removeLabelIfPresent(github, owner, repo, issue_number, labelName);
}
