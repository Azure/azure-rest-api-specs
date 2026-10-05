import { minimatch } from "minimatch";
import { simpleGit } from "simple-git";
import { getChangedFiles } from "../../shared/src/changed-files.ts";
import { inlineCode } from "../../shared/src/markdown.ts";
import { CoreLogger } from "./core-logger.ts";
import type { GitHubScriptArgs, WebhookEvent } from "./github.ts";

const ALLOWED_AUTHORS = new Set(["azure-sdk", "azure-sdk-automation[bot]"]);
// Mirror Azure/azure-rest-api-specs-maintainers; update when team membership changes.
// cspell:disable
const MAINTAINER_AUTHORS = new Set(
  [
    "AkhilaIlla",
    "AlitzelMendez",
    "Bubbles4096",
    "catalinaperalta",
    "chrisradek",
    "gary-x-li",
    "iscai-msft",
    "lmazuel",
    "markcowl",
    "MaryGao",
    "MSEvanhi",
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
// cspell:enable
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

export async function checkProtectedFiles(
  { context, core }: Pick<GitHubScriptArgs, "context" | "core">,
  diff?: { baseCommitish: string; headCommitish: string },
): Promise<ProtectedFilesResult> {
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
      title: "Trusted automation author",
      summary: `Account ${inlineCode(author)} is allowed to update protected files.`,
    };
  }

  const changedFiles = await getChangedFiles({
    ...diff,
    // Include both sides of renames so moving a protected file still fails.
    gitOptions: ["--no-renames"],
    logger: new CoreLogger(core),
  });
  if (
    MAINTAINER_AUTHORS.has(author.toLowerCase()) &&
    !changedFiles.some((file) => matchesAny(file, ["specification", "specification/**"]))
  ) {
    core.info(
      `Maintainer '${author}' is allowed to update protected files in a maintenance-only PR`,
    );
    return {
      conclusion: "success",
      title: "Maintainer maintenance-only PR",
      summary:
        `Maintainer ${inlineCode(author)} is allowed to update protected files because ` +
        "this PR does not change `specification/`. All other merge requirements still apply.",
    };
  }
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
      : `File '${file}' is repository-managed and outside the scope of a specification contribution. Remove this change from your PR. If a tooling change is needed, open an issue for the repository maintainers.`;
    core.error(message, { file });
    const summary = `- ${inlineCode(file)}: ${
      matchesAny(file, SYNCED_PATHS)
        ? "Synced from Azure/azure-sdk-tools; make the change in that repository."
        : "Repository-managed file; remove this change from your specification PR."
    }`;
    messages.push(summary);
  }
  core.setFailed(
    "Remove changes to protected files from your specification PR. See https://aka.ms/ci-fix#protected-files.",
  );
  return {
    conclusion: "failure",
    title: "Remove changes to protected files",
    summary:
      `${messages.join("\n")}\n\n` +
      "See the [Protected Files guide](https://aka.ms/ci-fix#protected-files). " +
      "Maintainer exemptions apply only to PRs without changes to `specification/`.",
  };
}

/** Reads the PR merge as git data without checking out or executing its files. */
export async function readProtectedFilesDiff({
  pullNumber,
  headSha,
  baseSha,
  token,
  cwd,
}: {
  pullNumber: number;
  headSha: string;
  baseSha: string;
  token: string;
  cwd?: string;
}): Promise<{ baseCommitish: string; headCommitish: string }> {
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error("Protected Files requires a valid PR number");
  }
  if (![headSha, baseSha].every((sha) => /^[a-f0-9]{40}$/.test(sha)) || !token) {
    throw new Error("Protected Files requires pinned PR commits and a git authentication token");
  }
  const git = simpleGit({
    baseDir: cwd,
    config: [
      `http.extraheader=AUTHORIZATION: basic ${Buffer.from(`x-access-token:${token}`).toString("base64")}`,
    ],
  });
  await git.fetch([
    "--no-tags",
    "--filter=blob:none",
    "--depth=2",
    "origin",
    `refs/pull/${pullNumber}/merge`,
  ]);
  const mergeSha = (await git.revparse(["FETCH_HEAD"])).trim();
  const parents = (await git.raw(["show", "--no-patch", "--format=%P", mergeSha]))
    .trim()
    .split(" ");
  if (parents.length !== 2 || parents[0] !== baseSha || parents[1] !== headSha) {
    throw new Error("PR merge does not match the evaluated base and head; rerun Protected Files");
  }
  return { baseCommitish: baseSha, headCommitish: mergeSha };
}

/** Evaluates the pinned PR merge using read-only repository access. */
export async function runProtectedFiles(
  { github, context, core }: GitHubScriptArgs,
  token: string,
): Promise<ProtectedFilesResult> {
  if (context.eventName !== "pull_request") {
    throw new Error(`Unsupported event for Protected Files: '${context.eventName}'`);
  }
  const payload = context.payload as WebhookEvent<"pull-request">;
  const pullNumber = payload.pull_request?.number;
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error("Protected Files requires a valid PR number");
  }
  const headSha = payload.pull_request?.head?.sha;
  const baseSha = payload.pull_request?.base?.sha;
  if (!headSha || !baseSha) {
    throw new Error("Protected Files requires the PR base and head commits");
  }
  const { data: pr } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: pullNumber,
  });
  function verifyCurrent(current: typeof pr) {
    if (current.state !== "open" || current.head.sha !== headSha || current.base.sha !== baseSha) {
      throw new Error("PR changed during evaluation; rerun Protected Files");
    }
  }
  verifyCurrent(pr);
  core.setSecret(Buffer.from(`x-access-token:${token}`).toString("base64"));
  const diff = await readProtectedFilesDiff({
    pullNumber,
    headSha,
    baseSha,
    token,
  });
  const result = await checkProtectedFiles(
    {
      core,
      context: {
        ...context,
        repo: context.repo,
        issue: context.issue,
        payload: { pull_request: { number: pr.number, user: { login: pr.user.login } } },
      },
    },
    diff,
  );
  const { data: latest } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: pullNumber,
  });
  verifyCurrent(latest);
  await core.summary.addRaw(`## ${result.title}\n\n${result.summary}`).write();
  return result;
}
