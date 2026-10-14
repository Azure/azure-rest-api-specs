import { escapeMarkdown, inlineCode } from "../../../shared/src/markdown.ts";
import type { Core } from "../github.ts";

export function buildMitigationSummary({
  prNumber,
  sdkLanguage,
  mitigationCommit,
  changedCode,
}: {
  prNumber: string;
  sdkLanguage: string;
  mitigationCommit: string;
  changedCode: string;
}): string {
  const customizationCode = changedCode
    ? `\`\`\`\`diff\n${changedCode}\n\`\`\`\``
    : "No mitigation changes were produced.";

  return [
    "## SDK breaking-change mitigation",
    `**Pull request:** #${escapeMarkdown(prNumber)}`,
    `**SDK language:** ${escapeMarkdown(sdkLanguage)}`,
    `**Mitigation upon commit:** ${inlineCode(mitigationCommit)}`,
    "## Customization Code",
    customizationCode,
  ].join("\n\n");
}

export async function publishMitigationSummary({
  core,
  ...options
}: Parameters<typeof buildMitigationSummary>[0] & { core: Core }): Promise<void> {
  await core.summary.addRaw(buildMitigationSummary(options)).write();
}
