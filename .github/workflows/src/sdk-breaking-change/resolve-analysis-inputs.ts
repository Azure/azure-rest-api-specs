import type { AsyncFunctionArguments } from "@actions/github-script";
import { existsSync, realpathSync } from "node:fs";
import { dirname, isAbsolute, relative, resolve, sep } from "node:path";

type PullRequestFile = {
  filename: string;
  previous_filename?: string;
};

export type SdkLanguageConfig = {
  language: "Cpp" | "DotNet" | "Go" | "Java" | "JavaScript" | "Python" | "Rust";
  repository: string;
};

const SDK_LANGUAGE_CONFIGS: Readonly<Record<string, SdkLanguageConfig>> = {
  cpp: { language: "Cpp", repository: "azure-sdk-for-cpp" },
  csharp: { language: "DotNet", repository: "azure-sdk-for-net" },
  ".net": { language: "DotNet", repository: "azure-sdk-for-net" },
  dotnet: { language: "DotNet", repository: "azure-sdk-for-net" },
  go: { language: "Go", repository: "azure-sdk-for-go" },
  java: { language: "Java", repository: "azure-sdk-for-java" },
  javascript: { language: "JavaScript", repository: "azure-sdk-for-js" },
  js: { language: "JavaScript", repository: "azure-sdk-for-js" },
  python: { language: "Python", repository: "azure-sdk-for-python" },
  rust: { language: "Rust", repository: "azure-sdk-for-rust" },
  typescript: { language: "JavaScript", repository: "azure-sdk-for-js" },
  ts: { language: "JavaScript", repository: "azure-sdk-for-js" },
};

const SDK_LABELS = [
  "BreakingChange-.Net-Sdk",
  "BreakingChange-Go-Sdk",
  "BreakingChange-Java-Sdk",
  "BreakingChange-JavaScript-Sdk",
  "BreakingChange-Python-Sdk",
] as const;

const SDK_LANGUAGES_BY_LABEL = new Map<(typeof SDK_LABELS)[number], string>([
  ["BreakingChange-.Net-Sdk", ".NET"],
  ["BreakingChange-Go-Sdk", "Go"],
  ["BreakingChange-Java-Sdk", "Java"],
  ["BreakingChange-JavaScript-Sdk", "JavaScript"],
  ["BreakingChange-Python-Sdk", "Python"],
]);

export async function resolveAnalysisTrigger({
  github,
  context,
  core,
}: Pick<AsyncFunctionArguments, "github" | "context" | "core">): Promise<void> {
  if (context.eventName === "workflow_dispatch") {
    core.setOutput("pr-number", process.env.PR_NUMBER_INPUT);
    core.setOutput("head-sha", "");
    core.setOutput("sdk-language", process.env.SDK_LANGUAGE_INPUT);
    core.setOutput("should-run", "true");
    return;
  }

  const workflowRun = context.payload.workflow_run;
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

  core.setOutput("pr-number", issueNumber);
  core.setOutput("head-sha", headSha);
  core.setOutput(
    "sdk-language",
    SDK_LANGUAGES_BY_LABEL.get(labelArtifact.labelName as (typeof SDK_LABELS)[number]),
  );
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

function validateRepositoryPath(path: string): void {
  const segments = path.split("/");
  if (
    isAbsolute(path) ||
    !path.startsWith("specification/") ||
    segments.includes("") ||
    segments.includes(".") ||
    segments.includes("..")
  ) {
    throw new Error(`Invalid changed TypeSpec file path: ${path}`);
  }
}

export function resolveChangedTypeSpecConfigPaths(
  repositoryPath: string,
  changedFiles: string[],
): string[] {
  const specificationRoot = realpathSync(resolve(repositoryPath, "specification"));
  const configPaths = new Set<string>();

  for (const changedFile of changedFiles) {
    const normalizedPath = changedFile.replaceAll("\\", "/");
    if (!normalizedPath.endsWith(".tsp") && !normalizedPath.endsWith("/tspconfig.yaml")) {
      continue;
    }

    validateRepositoryPath(normalizedPath);
    let directory = resolve(repositoryPath, dirname(normalizedPath));

    while (directory.startsWith(`${specificationRoot}${sep}`)) {
      const candidate = resolve(directory, "tspconfig.yaml");
      if (existsSync(candidate)) {
        const resolvedConfig = realpathSync(candidate);
        if (!resolvedConfig.startsWith(`${specificationRoot}${sep}`)) {
          throw new Error(`TypeSpec config resolves outside specification/: ${normalizedPath}`);
        }
        configPaths.add(toPosixPath(relative(repositoryPath, resolvedConfig)));
        break;
      }
      directory = dirname(directory);
    }
  }

  return [...configPaths].sort();
}

export async function resolveChangedTypeSpecProjects({
  github,
  context,
  core,
}: Pick<AsyncFunctionArguments, "github" | "context" | "core">): Promise<string[]> {
  const pullNumber = Number(process.env.PR_NUMBER);
  const repositoryPath = process.env.SPEC_REPOSITORY_PATH;
  if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
    throw new Error(`Invalid pull request number: ${process.env.PR_NUMBER}`);
  }
  if (!repositoryPath) {
    throw new Error("SPEC_REPOSITORY_PATH is required.");
  }

  const files: PullRequestFile[] = await github.paginate(github.rest.pulls.listFiles, {
    ...context.repo,
    pull_number: pullNumber,
    per_page: 100,
  });
  const changedFiles = files.flatMap(({ filename, previous_filename }) =>
    [filename, previous_filename].filter((path): path is string => path !== undefined),
  );
  const configPaths = resolveChangedTypeSpecConfigPaths(repositoryPath, changedFiles);

  if (configPaths.length === 0) {
    throw new Error("No tspconfig.yaml could be resolved from the changed TypeSpec files.");
  }

  core.setOutput("tsp-config-paths", JSON.stringify(configPaths));
  return configPaths;
}
