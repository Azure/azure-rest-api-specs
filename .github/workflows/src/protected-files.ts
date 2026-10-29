import { minimatch } from "minimatch";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { inlineCode } from "../../shared/src/markdown.ts";
import { CoreLogger } from "./core-logger.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";
import { evaluateLabelAuthorization } from "./label-authorization.ts";

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
const APPROVAL_LABEL = "protected-files-approved";
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

async function getProtectedFilesApprover(
  { github, context, core }: GitHubScriptArgs,
  issueNumber: number,
): Promise<string | undefined> {
  const params = { ...context.repo, issue_number: issueNumber, per_page: PER_PAGE_MAX };
  const labels = await github.paginate(github.rest.issues.listLabelsOnIssue, params);
  if (!labels.some((label) => label.name.toLowerCase() === APPROVAL_LABEL)) {
    return undefined;
  }

  const events = await github.paginate(github.rest.issues.listEvents, params);
  const application = events.findLast(
    (event) =>
      (event.event === "labeled" || event.event === "unlabeled") &&
      "label" in event &&
      event.label?.name.toLowerCase() === APPROVAL_LABEL,
  );
  const approver = application?.actor?.login;
  if (application?.event !== "labeled" || !approver) {
    core.warning(`Cannot verify who applied '${APPROVAL_LABEL}'; ignoring the label.`);
    return undefined;
  }
  const authorization = evaluateLabelAuthorization({
    actor: approver,
    approvers: [...ALLOWED_AUTHORS],
  });
  if (authorization.status !== "authorized") {
    core.warning(
      `Account '${approver}' is not allowed to approve protected files; ignoring '${APPROVAL_LABEL}'.`,
    );
    return undefined;
  }
  return approver;
}

export async function checkProtectedFiles({
  github,
  context,
  core,
}: GitHubScriptArgs): Promise<ProtectedFilesResult> {
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

  const baseSha = payload.pull_request.base?.sha;
  const mergeSha = context.sha;
  if (!baseSha || !mergeSha) {
    throw new Error("Protected Files requires pull request base and merge SHAs");
  }
  const changedFiles = await getChangedFiles({
    baseCommitish: baseSha,
    headCommitish: mergeSha,
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

  const approver = await getProtectedFilesApprover(
    { github, context, core },
    payload.pull_request.number,
  );
  if (approver) {
    core.info(`Protected file changes approved by '${approver}' via '${APPROVAL_LABEL}'`);
    return {
      conclusion: "success",
      title: "Protected file changes approved",
      summary: `Account ${inlineCode(approver)} applied ${inlineCode(APPROVAL_LABEL)} to approve changes to protected files.`,
    };
  }

  const messages: string[] = [];
  for (const file of protectedFiles) {
    const message = matchesAny(file, SYNCED_PATHS)
      ? `File '${file}' is synced from Azure/azure-sdk-tools. Remove this change from your PR and make the change in Azure/azure-sdk-tools instead.`
      : `File '${file}' is repository-managed and can only be changed by allowed repository maintainers. Remove this change from your PR or ask an allowed maintainer to apply '${APPROVAL_LABEL}'.`;
    core.error(message, { file });
    const summary = `- ${inlineCode(file)}: ${
      matchesAny(file, SYNCED_PATHS)
        ? "Synced from Azure/azure-sdk-tools; make the change in that repository."
        : `Repository-managed file; an allowed maintainer must author the PR or apply ${inlineCode(APPROVAL_LABEL)}.`
    }`;
    messages.push(summary);
  }
  core.setFailed(
    `Protected file changes require an allowed PR author or '${APPROVAL_LABEL}' applied by an allowed maintainer. See https://aka.ms/ci-fix#protected-files.`,
  );
  return {
    conclusion: "failure",
    title: "Remove changes to protected files",
    summary:
      `${messages.join("\n")}\n\n` +
      "See the [Protected Files guide](https://aka.ms/ci-fix#protected-files). " +
      `An allowlisted maintainer may authorize this PR by applying ${inlineCode(APPROVAL_LABEL)}. ` +
      "The check verifies who most recently applied the label; a review approval or rerun alone does not bypass it.",
  };
}
