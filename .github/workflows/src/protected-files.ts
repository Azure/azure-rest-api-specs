import { minimatch } from "minimatch";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { CoreLogger } from "./core-logger.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

const ALLOWED_AUTHORS = new Set(["azure-sdk", "azure-sdk-automation[bot]"]);
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

function matchesAny(file: string, patterns: string[]): boolean {
  // Match hidden files and preserve PowerShell's case-insensitive behavior.
  return patterns.some((pattern) =>
    minimatch(file, pattern, { dot: true, nocase: true, platform: "linux" }),
  );
}

export async function checkProtectedFiles({
  context,
  core,
}: Pick<GitHubScriptArgs, "context" | "core">): Promise<void> {
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
    return;
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
    return;
  }

  for (const file of protectedFiles) {
    const message = matchesAny(file, SYNCED_PATHS)
      ? `File '${file}' is synced from Azure/azure-sdk-tools. Remove this change from your PR and make the change in Azure/azure-sdk-tools instead.`
      : `File '${file}' is repository-managed and outside the scope of a specification contribution. Remove this change from your PR. If a tooling change is needed, open an issue for the repository maintainers.`;
    core.error(message, { file });
  }
  core.setFailed(
    "Remove changes to protected files from your specification PR. See https://aka.ms/ci-fix#protected-files.",
  );
}
