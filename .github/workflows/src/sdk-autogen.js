import { aiProjectsLibrary } from "./sdk-autogen/ai-projects.js";

const COMMAND = "/sdk-autogen";
const DEFAULT_BRANCH = "main";
const WRITE_PERMISSIONS = new Set(["admin", "maintain", "write"]);
const USAGE = `${COMMAND} <library> <lang> [<lang repo branch>]`;

/** @typedef {import("./sdk-autogen/ai-projects.js").SdkLibraryConfig} SdkLibraryConfig */

/** @type {Readonly<Record<string, Readonly<SdkLibraryConfig>>>} */
const LIBRARY_CONFIGS = Object.freeze({
  [aiProjectsLibrary.name]: aiProjectsLibrary,
});

/**
 * @param {string} library
 * @returns {Readonly<SdkLibraryConfig>}
 */
function getLibraryConfig(library) {
  const config = LIBRARY_CONFIGS[library];
  if (!config) {
    throw new Error(
      `Unsupported SDK library: ${library}. Supported libraries: ${Object.keys(LIBRARY_CONFIGS).join(", ")}`,
    );
  }
  return config;
}

/**
 * @param {Readonly<SdkLibraryConfig>} libraryConfig
 * @param {string} library
 * @param {string} language
 * @returns {Readonly<import("./sdk-autogen/ai-projects.js").SdkLanguageConfig>}
 */
function getLanguageConfig(libraryConfig, library, language) {
  const config = libraryConfig.languages[language];
  if (!config) {
    throw new Error(
      `Unsupported SDK language for ${library}: ${language}. Supported languages: ${Object.keys(libraryConfig.languages).join(", ")}`,
    );
  }
  return config;
}

/**
 * @param {unknown} body
 * @returns {{ library: string, language: string, branch: string }}
 */
export function parseSdkAutogenCommand(body) {
  if (typeof body !== "string" || body.includes("\n") || body.includes("\r")) {
    throw new Error(`Usage: ${USAGE}`);
  }

  const match = body.match(
    /^\/sdk-autogen(?:[ \t]+([^ \t]+))?(?:[ \t]+([^ \t]+))?(?:[ \t]+([^ \t]+))?[ \t]*$/,
  );
  if (!match || !match[1] || !match[2]) {
    throw new Error(`Usage: ${USAGE}`);
  }

  const library = match[1].toLowerCase();
  const libraryConfig = getLibraryConfig(library);
  const language = match[2].toLowerCase();
  getLanguageConfig(libraryConfig, library, language);

  const branch = match[3] ?? DEFAULT_BRANCH;
  if (!/^[A-Za-z0-9][A-Za-z0-9._/-]*$/.test(branch)) {
    throw new Error(`Invalid SDK repository branch: ${branch}`);
  }

  return { library, language, branch };
}

/**
 * @param {object} options
 * @param {string} options.library
 * @param {string} options.language
 * @param {string} options.branch
 * @param {string} options.headSha
 * @param {string} options.pullRequestUrl
 */
export function buildSdkAutogenIssueRequest({
  library,
  language,
  branch,
  headSha,
  pullRequestUrl,
}) {
  const libraryConfig = getLibraryConfig(library);
  const config = getLanguageConfig(libraryConfig, library, language);
  if (!/^[0-9a-f]{40}$/.test(headSha)) {
    throw new Error(`Invalid pull request head commit: ${headSha}`);
  }

  const targetRepository = `${config.owner}/${config.repository}`;
  const title = `[${config.titlePrefix}] regen from ${headSha} against ${branch}`;
  const body = [
    "### TypeSpec commit",
    headSha,
    "",
    "### Base branch",
    branch,
    "",
    "### Assignment check",
    "",
    `- [x] ${config.assignmentCheck} - The title, base branch field, and Copilot starting branch all match.`,
    "",
    "### Source pull request",
    pullRequestUrl,
  ].join("\n");

  return {
    owner: config.owner,
    repo: config.repository,
    title,
    body,
    assignees: ["copilot-swe-agent[bot]"],
    agent_assignment: {
      target_repo: targetRepository,
      base_branch: branch,
      custom_instructions: "",
      custom_agent: config.customAgent,
      model: "",
    },
    headers: {
      accept: "application/vnd.github+json",
      "X-GitHub-Api-Version": "2022-11-28",
    },
  };
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} args
 */
export async function runSdkAutogen({ github, context, core }) {
  if (context.eventName !== "issue_comment" || !context.payload.issue?.pull_request) {
    throw new Error(`${COMMAND} can only be invoked from a pull request comment`);
  }

  const comment = /** @type {{ body?: unknown, user?: { login?: unknown } } | undefined} */ (
    context.payload.comment
  );
  const { library, language, branch } = parseSdkAutogenCommand(comment?.body);
  const username = comment?.user?.login;
  if (typeof username !== "string" || !username) {
    throw new Error("Unable to identify the command author");
  }

  const { data: collaborator } = await github.rest.repos.getCollaboratorPermissionLevel({
    ...context.repo,
    username,
  });
  const canWrite =
    WRITE_PERMISSIONS.has(collaborator.permission) || collaborator.user?.permissions?.push === true;
  if (!canWrite) {
    throw new Error(`${username} must have write access to invoke ${COMMAND}`);
  }

  const pullNumber = context.payload.issue.number;
  const { data: pullRequest } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: pullNumber,
  });
  if (pullRequest.state !== "open") {
    throw new Error(`${COMMAND} can only be invoked on an open pull request`);
  }

  const libraryConfig = getLibraryConfig(library);
  const config = getLanguageConfig(libraryConfig, library, language);
  await github.rest.repos.getBranch({
    owner: config.owner,
    repo: config.repository,
    branch,
  });

  const request = buildSdkAutogenIssueRequest({
    library,
    language,
    branch,
    headSha: pullRequest.head.sha,
    pullRequestUrl: pullRequest.html_url,
  });
  const { data: issue } = await github.request("POST /repos/{owner}/{repo}/issues", request);

  core.info(`Created and assigned ${issue.html_url}`);
  core.setOutput("issue-url", issue.html_url);
  return { issueNumber: issue.number, issueUrl: issue.html_url };
}
