import { details, escapeMarkdown, inlineCode, link } from "@azure-tools/specs-shared/markdown";

// Shared wording for label-enforcement feedback across the App-bound protected-label
// workflow and the package-name workflow that remains in Actions.

/**
 * Warning posted when an unauthorized actor applies a protected/approval label and it is
 * removed. Shared by protected-labels enforcement (check-label) and package-name approval
 * (validate-approval) so both paths emit the same "label removed" explanation (#46787).
 */
export function buildUnauthorizedApplyComment({
  actor,
  labelName,
  authorizedUsers,
}: {
  actor: string;
  labelName: string;
  authorizedUsers: string[];
}): string {
  const authorizedList = authorizedUsers
    .map((user) => link(escapeMarkdown(user), `https://github.com/${user}`))
    .join(", ");
  return (
    `⚠️ @${actor} is not authorized to apply ${inlineCode(labelName)}. Label removed.\n\n` +
    "Please follow the **Next Steps to Merge** comment on this PR and the " +
    `${link("review and merge process", "https://aka.ms/azsdk/specreview/merge")}.\n\n` +
    details("See allowed approvers", `Only ${authorizedList} can apply this label.`)
  );
}

/**
 * Notice posted when a package name change invalidates earlier approvals and their
 * approval labels are reset to pending (#46786). Distinct from an unauthorized removal:
 * the approver did nothing wrong, the reviewed package name simply changed, so a prior
 * sign-off no longer applies and must be re-given.
 */
export function buildApprovalResetComment({
  resetLanguages,
  approvers,
}: {
  resetLanguages: string[];
  approvers?: string[];
}): string {
  const languages = resetLanguages.join(", ");
  const mentions =
    approvers && approvers.length > 0 ? `${approvers.map((user) => `@${user}`).join(", ")} ` : "";
  return (
    `⚠️ ${mentions}Approvals for ${languages} were cleared because the package name changed, and must be re-applied.\n\n` +
    `Re-apply the ${inlineCode("package-name-<language>-approved")} label after reviewing the new name.`
  );
}
