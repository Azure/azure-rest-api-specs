import { minimatch } from "minimatch";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { inlineCode } from "../../shared/src/markdown.ts";
import { CoreLogger } from "./core-logger.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

// Maintainer entries are based on Azure/azure-rest-api-specs-maintainers; keep access up to date.
const ALLOWED_AUTHORS = new Set(
  [
    "azure-sdk",
    "azure-sdk-automation[bot]",
    "dependabot[bot]",

    "AkhilaIlla",
    "Bubbles4096",
    "MaryGao",
    "MSEvanhi",
    "catalinaperalta",
    "gary-x-li",
    "iscai-msft",
    "lmazuel",
    "markcowl",
    "nikhgup",
    "pshao25",
    "qiaozha",
    "raosuhas",
    "ravimeda",
    "samvaity",
    "tejaswiMinnu",
    "timotheeguerin",
    "tjprescott",
    "vidapour",
    "vikeshi26",
    "xirzec",
  ].map((author) => author.toLowerCase()),
);
const PROTECTED_PATHS = [
  ".gitignore",
  "cspell.json",
  "cspell.yaml",
  "package.json",
  "pnpm-lock.yaml",
  "pnpm-workspace.yaml",
  ".github/**",
  ".vscode/**",
  "eng/**",
];
const EXCLUDED_PATHS = [".github/CODEOWNERS", ".github/skills/*", ".github/skills/*/**"];
const SYNCED_PATHS = [
  ".github/skills/azsdk-common-*",
  ".github/skills/azsdk-common-*/**",
  "eng/common",
  "eng/common/**",
];

interface ProtectedFilesResult {
  conclusion: "success" | "failure";
  title: string;
  summary: string;
}

function matchesAny(file: string, patterns: string[]): boolean {
  // Match hidden files and preserve PowerShell's case-insensitive behavior.
  return patterns.some((pattern) =>
    minimatch(file, pattern, { dot: true, nocase: true, platform: "linux" }),
  );
}

export async function checkProtectedFiles({
  context,
  core,
}: Pick<GitHubScriptArgs, "context" | "core">): Promise<ProtectedFilesResult> {
  if (context.eventName !== "pull_request") {
    throw new Error(`Unsupported event for Protected Files: '${context.eventName}'`);
  }
  const payload = context.payload as WebhookEvent<"pull-request">;
  const author = payload.pull_request?.user?.login;
  if (!author) {
    throw new Error("Protected Files requires a pull request author");
  }

  if (ALLOWED_AUTHORS.has(author.toLowerCase())) {
    core.info(`Account '${author}' is allowed to update protected files`);
    return {
      conclusion: "success",
      title: "Allowed maintainer or automation author",
      summary: `Account ${inlineCode(author)} is allowed to update protected files.`,
    };
  }

  const changedFiles = await getChangedFiles({
    // Include both sides of renames so moving a protected file still fails.
    gitOptions: ["--no-renames"],
    logger: new CoreLogger(core),
  });
  const protectedFiles = changedFiles.filter(
    (file) =>
      matchesAny(file, SYNCED_PATHS) ||
      (matchesAny(file, PROTECTED_PATHS) && !matchesAny(file, EXCLUDED_PATHS)),
  );

  if (protectedFiles.length === 0) {
    core.info("No changes to protected files.");
    return {
      conclusion: "success",
      title: "No changes to protected files",
      summary: "This PR does not change protected files.",
    };
  }

  const messages: string[] = [];
  for (const file of protectedFiles) {
    const message = matchesAny(file, SYNCED_PATHS)
      ? `File '${file}' is synced from Azure/azure-sdk-tools. Remove this change from your PR and make the change in Azure/azure-sdk-tools instead.`
      : `File '${file}' is repository-managed and can only be changed by allowed repository maintainers. Remove this change from your PR. If a tooling change is needed, open an issue for the repository maintainers.`;
    core.error(message, { file });
    const summary = `- ${inlineCode(file)}: ${
      matchesAny(file, SYNCED_PATHS)
        ? "Synced from Azure/azure-sdk-tools; make the change in that repository."
        : "Repository-managed file; only allowed repository maintainers may change it."
    }`;
    messages.push(summary);
  }
  core.setFailed(
    "Only allowed repository maintainers may change protected files. See https://aka.ms/ci-fix#protected-files.",
  );
  return {
    conclusion: "failure",
    title: "Remove changes to protected files",
    summary:
      `${messages.join("\n")}\n\n` +
      "See the [Protected Files guide](https://aka.ms/ci-fix#protected-files). " +
      "Only allowlisted PR authors may change protected files, even in maintenance-only PRs.",
  };
}
