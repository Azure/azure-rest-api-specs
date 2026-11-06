import { readFile } from "node:fs/promises";
import { minimatch } from "minimatch";
import { parse } from "yaml";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import { inlineCode } from "../../shared/src/markdown.ts";
import type { Core, GitHubScriptArgs, WebhookEvent } from "./github.ts";

const APPROVAL_LABEL = "protectedfiles-approved";
const APPROVABLE_PATH = "eng/typespec-rulesets/index.ts";

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

export function checkProtectedFiles({
  author,
  changedFiles,
  approvedBy,
  core,
}: {
  author: string;
  changedFiles: string[];
  approvedBy?: string;
  core: Core;
}): ProtectedFilesResult {
  if (ALLOWED_AUTHORS.has(author.toLowerCase())) {
    core.info(`Account '${author}' is allowed to update protected files`);
    return {
      conclusion: "success",
      title: "Allowed maintainer or automation author",
      summary: `Account ${inlineCode(author)} is allowed to update protected files.`,
    };
  }

  const protectedFiles = changedFiles.filter(
    (file) =>
      matchesAny(file, SYNCED_PATHS) ||
      (!file.startsWith("specification/") && !matchesAny(file, EXCLUDED_PATHS)),
  );

  if (protectedFiles.length === 0) {
    core.info("No changes to protected files.");
    return {
      conclusion: "success",
      title: "No changes to protected files",
      summary: "This PR does not change protected files.",
    };
  }

  const blockedFiles = protectedFiles.filter((file) => !approvedBy || file !== APPROVABLE_PATH);
  if (approvedBy && blockedFiles.length === 0) {
    core.info(`${APPROVAL_LABEL} applied by '${approvedBy}' approves ${APPROVABLE_PATH}`);
    return {
      conclusion: "success",
      title: "TypeSpec ruleset change approved",
      summary: `${inlineCode(APPROVAL_LABEL)} applied by ${inlineCode(approvedBy)} approves changes to ${inlineCode(APPROVABLE_PATH)}. Other merge requirements still apply.`,
    };
  }

  const messages: string[] = [];
  for (const file of blockedFiles) {
    const message = matchesAny(file, SYNCED_PATHS)
      ? `File '${file}' is synced from Azure/azure-sdk-tools. Remove this change from your PR and make the change in Azure/azure-sdk-tools instead.`
      : file === APPROVABLE_PATH
        ? `File '${file}' requires an allowed author or authorized '${APPROVAL_LABEL}' approval on public main. See https://aka.ms/ci-fix#protected-files.`
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
    "Protected file changes require an allowed author or scoped approval. See https://aka.ms/ci-fix#protected-files.",
  );
  return {
    conclusion: "failure",
    title: "Remove changes to protected files",
    summary:
      `${messages.join("\n")}\n\n` +
      "See the [Protected Files guide](https://aka.ms/ci-fix#protected-files). " +
      `Only allowlisted PR authors may change protected files, except for authorized ${inlineCode(APPROVAL_LABEL)} approval of ${inlineCode(APPROVABLE_PATH)} on public main.`,
  };
}

export async function runProtectedFiles({ github, context, core }: GitHubScriptArgs) {
  if (context.eventName !== "pull_request_target") {
    throw new Error(`Unsupported event for Protected Files: '${context.eventName}'`);
  }
  const payload = context.payload as WebhookEvent<"pull-request">;
  if (!payload.pull_request?.head?.sha || !payload.pull_request.number) {
    throw new Error("Protected Files requires a pull request number and head SHA");
  }
  if (
    (payload.action === "labeled" || payload.action === "unlabeled") &&
    payload.label?.name !== APPROVAL_LABEL
  ) {
    return;
  }

  const { owner, repo } = context.repo;
  const pull_number = payload.pull_request.number;
  let sha = payload.pull_request.head.sha;
  const setStatus = (state: "pending" | "success" | "failure", description: string) =>
    github.rest.repos.createCommitStatus({
      owner,
      repo,
      sha,
      context: "Protected Files",
      state,
      description,
      target_url: `${context.serverUrl}/${owner}/${repo}/actions/runs/${context.runId}`,
    });

  await setStatus("pending", "Evaluating protected files and approval");
  try {
    const { data: pr } = await github.rest.pulls.get({ owner, repo, pull_number });
    if (pr.head.sha !== sha) {
      sha = pr.head.sha;
      await setStatus("pending", "Evaluating current PR head");
    }

    let result: ProtectedFilesResult;
    if (ALLOWED_AUTHORS.has(pr.user.login.toLowerCase())) {
      result = checkProtectedFiles({ author: pr.user.login, changedFiles: [], core });
    } else {
      const files = await github.paginate(github.rest.pulls.listFiles, {
        owner,
        repo,
        pull_number,
        per_page: PER_PAGE_MAX,
      });
      // The REST endpoint returns at most 3,000 files. Never approve a partial diff.
      if (files.length !== pr.changed_files) {
        throw new Error("Incomplete PR file list; refusing to evaluate protected files");
      }
      const changedFiles = files.flatMap((file) =>
        file.previous_filename ? [file.previous_filename, file.filename] : [file.filename],
      );
      let approvedBy: string | undefined;
      if (
        owner === "Azure" &&
        repo === "azure-rest-api-specs" &&
        pr.base.ref === "main" &&
        changedFiles.includes(APPROVABLE_PATH) &&
        pr.labels.some((label) => label.name === APPROVAL_LABEL)
      ) {
        const policy: unknown = parse(
          await readFile(new URL("../../protected-labels.yml", import.meta.url), "utf8"),
        );
        if (!policy || typeof policy !== "object") {
          throw new Error("Invalid protected-labels.yml: expected an object");
        }
        const globalApprovers: unknown = Reflect.get(policy, "global-approvers");
        const labelApprovers: unknown = Reflect.get(policy, APPROVAL_LABEL);
        const isLoginList = (value: unknown): value is string[] =>
          Array.isArray(value) &&
          value.every((login) => typeof login === "string" && login.length > 0);
        if (!isLoginList(globalApprovers) || !isLoginList(labelApprovers)) {
          throw new Error("Protected Files requires explicit global and label approver lists");
        }
        const approvers = new Set(
          [...globalApprovers, ...labelApprovers].map((login) => login.toLowerCase()),
        );
        const events = await github.paginate(github.rest.issues.listEvents, {
          owner,
          repo,
          issue_number: pull_number,
          per_page: PER_PAGE_MAX,
        });
        const latest = events
          .filter(
            (event) =>
              (event.event === "labeled" || event.event === "unlabeled") &&
              event.label?.name === APPROVAL_LABEL,
          )
          .sort((a, b) => b.id - a.id)[0];
        if (
          latest?.event === "labeled" &&
          latest.actor?.login &&
          approvers.has(latest.actor.login.toLowerCase())
        ) {
          approvedBy = latest.actor.login;
        } else {
          core.warning(
            `${APPROVAL_LABEL} has no authorized current application; ignoring the label`,
          );
        }
      }
      result = checkProtectedFiles({ author: pr.user.login, changedFiles, approvedBy, core });
    }

    const { data: current } = await github.rest.pulls.get({ owner, repo, pull_number });
    if (
      current.state !== "open" ||
      current.head.sha !== sha ||
      current.base.sha !== pr.base.sha ||
      current.base.ref !== pr.base.ref ||
      current.labels.some((label) => label.name === APPROVAL_LABEL) !==
        pr.labels.some((label) => label.name === APPROVAL_LABEL)
    ) {
      throw new Error("PR changed during evaluation; wait for its next Protected Files run");
    }
    await setStatus(result.conclusion, result.title);
    await core.summary.addRaw(`## ${result.title}\n\n${result.summary}`).write();
  } catch (error) {
    core.error(error instanceof Error ? error : String(error));
    core.setFailed("Unable to evaluate Protected Files; see the workflow log");
    await setStatus("failure", "Unable to evaluate protected files");
    throw error;
  }
}
