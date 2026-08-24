const COMMAND = "/sdk-autogen";
const DEFAULT_BRANCH = "main";
const WRITE_PERMISSIONS = new Set(["admin", "maintain", "write"]);

/** @type {Readonly<Record<string, Readonly<SdkLanguageConfig>>>} */
const LANGUAGE_CONFIGS = Object.freeze({
  javascript: Object.freeze({
    owner: "Azure",
    repository: "azure-sdk-for-js",
    titlePrefix: "ai-projects",
    customAgent: "ai-projects-regen",
    assignmentCheck: "ai-projects-typespec-regen:v1",
  }),
});

/**
 * @typedef {object} SdkLanguageConfig
 * @property {string} owner
 * @property {string} repository
 * @property {string} titlePrefix
 * @property {string} customAgent
 * @property {string} assignmentCheck
 */

/**
 * @param {unknown} body
 * @returns {{ language: string, branch: string }}
 */
export function parseSdkAutogenCommand(body) {
  if (typeof body !== "string" || body.includes("\n") || body.includes("\r")) {
    throw new Error(`Usage: ${COMMAND} <lang> [<lang repo branch>]`);
  }

  const match = body.match(/^\/sdk-autogen(?:[ \t]+([^ \t]+))?(?:[ \t]+([^ \t]+))?[ \t]*$/);
  if (!match || !match[1]) {
    throw new Error(`Usage: ${COMMAND} <lang> [<lang repo branch>]`);
  }

  const language = match[1].toLowerCase();
  if (!Object.hasOwn(LANGUAGE_CONFIGS, language)) {
    throw new Error(`Unsupported SDK language: ${match[1]}. Supported languages: javascript`);
  }

  const branch = match[2] ?? DEFAULT_BRANCH;
  if (!/^[A-Za-z0-9][A-Za-z0-9._/-]*$/.test(branch)) {
    throw new Error(`Invalid SDK repository branch: ${branch}`);
  }

  return { language, branch };
}

/**
 * @param {object} options
 * @param {string} options.language
 * @param {string} options.branch
 * @param {string} options.headSha
 * @param {string} options.pullRequestUrl
 */
export function buildSdkAutogenIssueRequest({ language, branch, headSha, pullRequestUrl }) {
  const config = LANGUAGE_CONFIGS[language];
  if (!config) {
    throw new Error(`Unsupported SDK language: ${language}`);
  }
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
  const { language, branch } = parseSdkAutogenCommand(comment?.body);
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

  const config = LANGUAGE_CONFIGS[language];
  if (!config) {
    throw new Error(`Unsupported SDK language: ${language}`);
  }
  await github.rest.repos.getBranch({
    owner: config.owner,
    repo: config.repository,
    branch,
  });

  const request = buildSdkAutogenIssueRequest({
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
