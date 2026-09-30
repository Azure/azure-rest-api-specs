import { existsSync, realpathSync } from "node:fs";
import { dirname, isAbsolute, relative, resolve, sep } from "node:path";
import type { GitHubScriptArgs, WebhookEvent } from "../github.ts";
import { detectChangedSpecConfigFromChangedFiles } from "@azure-tools/spec-gen-sdk-runner";

type PullRequestFile = {
  filename: string;
  previous_filename?: string;
};

export const SdkLanguage = Object.freeze({
  DotNet: "DotNet",
  Go: "Go",
  Java: "Java",
  JavaScript: "JavaScript",
  Python: "Python",
} as const);

export type SdkLanguage = (typeof SdkLanguage)[keyof typeof SdkLanguage];

export type SdkLanguageConfig = {
  language: SdkLanguage;
  repository: string;
};

const SDK_LANGUAGE_CONFIGS: Readonly<Record<string, SdkLanguageConfig>> = {
  ".net": { language: SdkLanguage.DotNet, repository: "azure-sdk-for-net" },
  dotnet: { language: SdkLanguage.DotNet, repository: "azure-sdk-for-net" },
  go: { language: SdkLanguage.Go, repository: "azure-sdk-for-go" },
  java: { language: SdkLanguage.Java, repository: "azure-sdk-for-java" },
  javascript: { language: SdkLanguage.JavaScript, repository: "azure-sdk-for-js" },
  js: { language: SdkLanguage.JavaScript, repository: "azure-sdk-for-js" },
  python: { language: SdkLanguage.Python, repository: "azure-sdk-for-python" },
};

const SDK_LABELS = [
  "BreakingChange-.Net-Sdk",
  "BreakingChange-Go-Sdk",
  "BreakingChange-Java-Sdk",
  "BreakingChange-JavaScript-Sdk",
  "BreakingChange-Python-Sdk",
] as const;

const SDK_LANGUAGES_BY_LABEL = new Map<(typeof SDK_LABELS)[number], SdkLanguage>([
  ["BreakingChange-.Net-Sdk", SdkLanguage.DotNet],
  ["BreakingChange-Go-Sdk", SdkLanguage.Go],
  ["BreakingChange-Java-Sdk", SdkLanguage.Java],
  ["BreakingChange-JavaScript-Sdk", SdkLanguage.JavaScript],
  ["BreakingChange-Python-Sdk", SdkLanguage.Python],
]);

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
}: GitHubScriptArgs): Promise<void> {
  if (context.eventName === "workflow_dispatch") {
    const pullNumberInput = getWorkflowDispatchInput(context.payload, "pr_number");
    const sdkLanguageInput = getWorkflowDispatchInput(context.payload, "sdk_language");
    const pullNumber = Number(pullNumberInput);
    if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
      throw new Error(`Invalid pull request number: ${pullNumberInput}`);
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
    const languageConfig = resolveSdkLanguageConfig(sdkLanguageInput);
    core.setOutput("pr-number", pullNumber);
    core.setOutput("head-repository", pull.head.repo.full_name);
    core.setOutput("head-sha", pull.head.sha);
    core.setOutput("sdk-language", languageConfig.language);
    core.setOutput("sdk-repository", languageConfig.repository);
    core.setOutput("should-run", "true");
    return;
  }

  const { workflow_run: workflowRun } = context.payload as WebhookEvent<
    "workflow-run",
    "completed"
  >;
  if (workflowRun?.conclusion !== "success") {
    core.notice("The SDK Breaking Change Labels workflow did not succeed.");
    core.setOutput("should-run", "false");
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
  const labelArtifacts = artifactNames.flatMap((name) => {
    const match = /^label-(.+)=(true|false)$/.exec(name);
    return match && SDK_LABELS.includes(match[1] as (typeof SDK_LABELS)[number])
      ? [{ artifactName: match[0], labelName: match[1], labelValue: match[2] }]
      : [];
  });
  if (labelArtifacts.length === 0) {
    core.notice("No supported SDK breaking-change label artifact was published.");
    core.setOutput("should-run", "false");
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
  if (!headSha || !/^[0-9a-f]{40}$/i.test(headSha)) {
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

  const language = SDK_LANGUAGES_BY_LABEL.get(
    labelArtifact.labelName as (typeof SDK_LABELS)[number],
  );
  const languageConfig = resolveSdkLanguageConfig(language);

  core.setOutput("pr-number", issueNumber);
  core.setOutput("head-repository", pull.head.repo.full_name);
  core.setOutput("head-sha", pull.head.sha);
  core.setOutput("sdk-language", languageConfig.language);
  core.setOutput("sdk-repository", languageConfig.repository);
  core.setOutput("should-run", labelArtifact.labelValue);
}

export function resolveSdkLanguageConfig(input: string | undefined): SdkLanguageConfig {
  const languageConfig = SDK_LANGUAGE_CONFIGS[input?.trim().toLowerCase() ?? ""];
  if (!languageConfig) {
    throw new Error(`Unsupported SDK language: ${input}`);
  }
  return languageConfig;
}

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

function toPosixPath(path: string): string {
  return path.split(sep).join("/");
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
  if (!headSha || !/^[0-9a-f]{40}$/i.test(headSha)) {
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
    .map(toPosixPath)
    .sort();
  core.setOutput("tsp-config-paths", JSON.stringify(sortedConfigPaths));
  return sortedConfigPaths;
}
