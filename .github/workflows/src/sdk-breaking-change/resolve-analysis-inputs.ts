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

export function resolveSdkLanguageConfig(input: string | undefined): SdkLanguageConfig {
  const languageConfig = SDK_LANGUAGE_CONFIGS[input?.trim().toLowerCase() ?? ""];
  if (!languageConfig) {
    throw new Error(`Unsupported SDK language: ${input}`);
  }
  return languageConfig;
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
