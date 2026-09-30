import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { CoreLogger } from "./core-logger.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

const ALLOWED_AUTHORS = new Set(["azure-sdk", "azure-sdk-automation[bot]"]);
const PROTECTED_FILES = new Set([
  ".gitignore",
  "cspell.json",
  "cspell.yaml",
  "package.json",
  "pnpm-lock.yaml",
  "pnpm-workspace.yaml",
]);
const PROTECTED_DIRECTORIES = [".github/", ".vscode/", "eng/"];
const EXCLUDED_SKILLS = /^\.github\/skills\/(?!azsdk-common-).+/i;
const SYNCED_PATHS = [/^\.github\/skills\/azsdk-common-[^/]+(?:\/|$)/i, /^eng\/common(?:\/|$)/i];

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
  const protectedFiles = changedFiles.filter((file) => {
    // Preserve the case-insensitive matching of the original PowerShell check.
    const path = file.toLowerCase();
    return (
      (PROTECTED_FILES.has(path) ||
        PROTECTED_DIRECTORIES.some((directory) => path.startsWith(directory))) &&
      path !== ".github/codeowners" &&
      !EXCLUDED_SKILLS.test(file)
    );
  });

  if (protectedFiles.length === 0) {
    core.info("No changes to protected files.");
    return;
  }

  for (const file of protectedFiles) {
    const message = SYNCED_PATHS.some((pattern) => pattern.test(file))
      ? `File '${file}' is synced from Azure/azure-sdk-tools. Remove this change from your PR and make the change in Azure/azure-sdk-tools instead.`
      : `File '${file}' is repository-managed and outside the scope of a specification contribution. Remove this change from your PR. If a tooling change is needed, open an issue for the repository maintainers.`;
    core.error(message, { file });
  }
  core.setFailed(
    "Remove changes to protected files from your specification PR. See https://aka.ms/ci-fix#protected-files.",
  );
}
