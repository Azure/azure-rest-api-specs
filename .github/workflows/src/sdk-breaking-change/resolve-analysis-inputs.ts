import { detectChangedSpecConfigFromChangedFiles } from "@azure-tools/spec-gen-sdk-runner";
import { isFullGitSha } from "@azure-tools/specs-shared/git";
import { getSdkLanguage, SdkName } from "@azure-tools/specs-shared/sdk-types";
import type { GitHubScriptArgs, WebhookEvent } from "../github.ts";
import { publishStatus } from "./status.ts";
import { sdkLabels } from "../summarize-checks/labelling.ts";

interface PullRequestFile {
  filename: string;
  previous_filename?: string;
}

function getWorkflowDispatchInput(payload: unknown, name: string): string | undefined {
  if (typeof payload !== "object" || payload === null || !("inputs" in payload)) {
    return undefined;
  }
  const { inputs } = payload;
  if (typeof inputs !== "object" || inputs === null || !(name in inputs)) {
    return undefined;
  }
  const value = (inputs as Record<string, unknown>)[name];
  return typeof value === "string" ? value : undefined;
}

export async function resolveAnalysisTrigger({
  github,
  context,
  core,
  statusArtifactPath,
}: GitHubScriptArgs & {
  statusArtifactPath: string;
}): Promise<void> {
  let shouldRun = "false";
  try {
    if (context.eventName === "workflow_dispatch") {
      const pullNumberInput = getWorkflowDispatchInput(context.payload, "pr_number");
      const sdkLanguageInput = getWorkflowDispatchInput(context.payload, "sdk_language");
      const pullNumber = Number(pullNumberInput);
      if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
        throw new Error(`Invalid pull request number: ${pullNumberInput}`);
      }
      if (!sdkLanguageInput || !(sdkLanguageInput in SdkName)) {
        throw new Error(`Invalid SDK language input: ${sdkLanguageInput}`);
      }
      const { data: pull } = await github.rest.pulls.get({
        ...context.repo,
        pull_number: pullNumber,
      });
      validateAnalysisSource({
        expectedRepository: `${context.repo.owner}/${context.repo.repo}`,
        actualRepository: pull.head.repo.full_name,
        actualSha: pull.head.sha,
      });

      core.setOutput("pr-number", pullNumber);
      core.setOutput("head-repository", pull.head.repo.full_name);
      core.setOutput("head-sha", pull.head.sha);
      core.setOutput(
        "sdk-language",
        normalizedSdkLanguage[sdkLanguageInput.toLowerCase()] ?? sdkLanguageInput,
      );
      core.setOutput("sdk-repository", SdkName[sdkLanguageInput as keyof typeof SdkName]);
      shouldRun = "true";
      return;
    }

    const { workflow_run: workflowRun } = context.payload as WebhookEvent<
      "workflow-run",
      "completed"
    >;
    if (workflowRun?.conclusion !== "success") {
      core.notice("The SDK Breaking Change Labels workflow did not succeed.");
      return;
    }

    const artifacts = await github.paginate(github.rest.actions.listWorkflowRunArtifacts, {
      ...context.repo,
      run_id: workflowRun.id,
      per_page: 100,
    });
    const artifactNames = artifacts.map(({ name }) => name);
    const artifactValue = (key: string): string | undefined => {
      const prefix = `${key}=`;
      return artifactNames.find((name) => name.startsWith(prefix))?.slice(prefix.length);
    };
    const breakingChangeLabels = Object.values(sdkLabels)
      .map((labels) => labels.breakingChange)
      .filter((label): label is string => label !== undefined);
    const labelArtifacts = artifactNames.flatMap((name) => {
      const match = /^label-(.+)=(true|false)$/.exec(name);
      return match && breakingChangeLabels.includes(match[1])
        ? [{ artifactName: match[0], labelName: match[1], labelValue: match[2] }]
        : [];
    });
    if (labelArtifacts.length === 0) {
      core.notice("No supported SDK breaking-change label artifact was published.");
      return;
    }
    if (labelArtifacts.length > 1) {
      throw new Error(
        `Expected one SDK breaking-change label artifact, found: ${labelArtifacts.map(({ artifactName }) => artifactName).join(", ")}`,
      );
    }

    const [labelArtifact] = labelArtifacts;
    const issueNumber = artifactValue("issue-number");
    const headSha = artifactValue("head-sha");
    if (!issueNumber || !/^[1-9]\d*$/.test(issueNumber)) {
      throw new Error(`Invalid issue-number artifact: ${issueNumber}`);
    }
    if (!headSha || !isFullGitSha(headSha)) {
      throw new Error(`Invalid head-sha artifact: ${headSha}`);
    }

    const pullNumber = Number(issueNumber);
    const { data: pull } = await github.rest.pulls.get({
      ...context.repo,
      pull_number: pullNumber,
    });
    validateAnalysisSource({
      expectedRepository: `${context.repo.owner}/${context.repo.repo}`,
      actualRepository: pull.head.repo.full_name,
      expectedSha: headSha,
      actualSha: pull.head.sha,
    });

    const repoName = Object.entries(sdkLabels).find(
      ([, labels]) => labels.breakingChange === labelArtifact.labelName,
    )?.[0];

    let sdkLanguage = getSdkLanguage(repoName as SdkName);
    if (!sdkLanguage) {
      throw new Error(`Unable to determine SDK language for repository: ${repoName}`);
    }
    sdkLanguage = normalizedSdkLanguage[sdkLanguage.toLowerCase()] ?? sdkLanguage;
    core.setOutput("pr-number", issueNumber);
    core.setOutput("head-repository", pull.head.repo.full_name);
    core.setOutput("head-sha", pull.head.sha);
    core.setOutput("sdk-language", sdkLanguage);
    core.setOutput("sdk-repository", repoName);
    shouldRun = labelArtifact.labelValue;
  } finally {
    await publishStatus({
      core,
      statusArtifactPath,
      shouldRun,
    });
  }
}

const normalizedSdkLanguage: Record<string, string> = {
  js: "JavaScript",
  javascript: "JavaScript",
  typescript: "JavaScript",
  python: "Python",
  java: "Java",
  net: "DotNet",
  ".net": "DotNet",
  csharp: "DotNet",
  go: "Go",
};
export function validateAnalysisSource({
  expectedRepository,
  actualRepository,
  expectedSha,
  actualSha,
}: {
  expectedRepository: string;
  actualRepository: string;
  expectedSha?: string;
  actualSha: string;
}): void {
  if (actualRepository !== expectedRepository) {
    throw new Error(`SDK breaking-change analysis does not run for fork ${actualRepository}.`);
  }
  if (expectedSha && actualSha !== expectedSha) {
    throw new Error(`Pull request head changed from ${expectedSha} to ${actualSha}.`);
  }
}

export async function resolveChangedTypeSpecConfigPathsFromPullRequest({
  github,
  context,
  core,
  pullNumber,
  localSpecRepoPath,
}: GitHubScriptArgs & {
  pullNumber: number;
  localSpecRepoPath: string;
}): Promise<string[]> {
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error(`Invalid pull request number: ${pullNumber}`);
  }
  const { data: pull } = await github.rest.pulls.get({
    ...context.repo,
    pull_number: pullNumber,
  });
  const headSha = pull.head.sha;
  if (!headSha || !isFullGitSha(headSha)) {
    throw new Error(`Invalid HEAD_SHA: ${headSha}`);
  }

  const files: PullRequestFile[] = await github.paginate(github.rest.pulls.listFiles, {
    ...context.repo,
    pull_number: pullNumber,
    per_page: 100,
  });
  const changedFiles = files.flatMap(({ filename, previous_filename }) =>
    [filename, previous_filename].filter((path): path is string => path !== undefined),
  );

  const configPaths = detectChangedSpecConfigFromChangedFiles(localSpecRepoPath, changedFiles);
  if (configPaths.length === 0) {
    throw new Error("No tspconfig.yaml could be resolved from the changed TypeSpec files.");
  }
  const sortedConfigPaths = configPaths
    .map((config) => config.typespecProject)
    .filter((path): path is string => path !== undefined)
    .map((path) => path.replaceAll("\\", "/"))
    .sort();
  core.setOutput("tsp-config-paths", JSON.stringify(sortedConfigPaths));
  return sortedConfigPaths;
}
