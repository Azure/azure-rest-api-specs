import { appendFile, mkdir, readdir, realpath, rename, stat, writeFile } from "node:fs/promises";
import { basename, dirname, isAbsolute, join, relative, sep } from "node:path";
import { execFile } from "../../../shared/src/exec.ts";
import { SdkLanguage } from "./resolve-analysis-inputs.ts";

type ProjectResult = {
  typespecProjectPath: string;
  packageName: string;
  resultsPath: string;
};

export type AnalyzeSdkProjectsOptions = {
  localSdkRepositoryPath: string;
  specificationRepositoryPath: string;
  typeSpecConfigPaths: string[];
  pullNumber: number;
  sdkLanguage: string;
  analyzedSha: string;
  workflowUrl: string;
  resultDir: string;
};

async function findFiles(directory: string, name: string): Promise<string[]> {
  const entries = await readdir(directory, { withFileTypes: true });
  const matches = await Promise.all(
    entries.map(async (entry): Promise<string[]> => {
      const path = join(directory, entry.name);
      if (entry.isDirectory()) {
        return findFiles(path, name);
      }
      return entry.isFile() && entry.name === name ? [path] : [];
    }),
  );
  return matches.flat();
}

async function findGeneratedConfigs(repositoryPath: string, startedAt: number): Promise<string[]> {
  const configs = await findFiles(repositoryPath, "tsp-location.yaml");
  const generated = await Promise.all(
    configs.map(async (path) => ((await stat(path)).mtimeMs >= startedAt ? path : undefined)),
  );
  return generated.filter((path): path is string => path !== undefined);
}

function isWithin(parent: string, child: string): boolean {
  const path = relative(parent, child);
  return path !== "" && path !== ".." && !path.startsWith(`..${sep}`) && !isAbsolute(path);
}

export async function analyzeSdkProjects({
  localSdkRepositoryPath: unresolvedLocalSdkRepositoryPath,
  specificationRepositoryPath,
  typeSpecConfigPaths,
  pullNumber,
  sdkLanguage,
  analyzedSha,
  workflowUrl,
  resultDir,
}: AnalyzeSdkProjectsOptions): Promise<void> {
  const localSdkRepositoryPath = await realpath(unresolvedLocalSdkRepositoryPath);
  const resultsDirectory = join(resultDir, "sdk-breaking-change-results");
  const analysisLog = join(resultsDirectory, "analysis.log");
  await mkdir(resultsDirectory, { recursive: true });
  await writeFile(analysisLog, "");
  await writeFile(
    join(resultsDirectory, "trigger.json"),
    `${JSON.stringify({
      pullNumber,
      sdkLanguage,
      analyzedSha,
      workflowUrl,
    })}\n`,
  );

  const projects: ProjectResult[] = [];
  const packageNames = new Set<string>();
  await writeFile(join(resultsDirectory, "projects.json"), "[]\n");

  try {
    for (const [index, relativeConfigPath] of typeSpecConfigPaths.entries()) {
      const typeSpecProjectPath = relativeConfigPath.replace(/\/tspconfig\.yaml$/, "");
      const configPath = join(specificationRepositoryPath, relativeConfigPath);
      const generationResult = join(resultDir, "sdk-generation-result.json");
      const generationStartedAt = Date.now();

      /* Generate the SDK package */
      const { stdout } = await execFile("azsdk", [
        "package",
        "generate",
        "--local-sdk-repo-path",
        localSdkRepositoryPath,
        "--tsp-config-path",
        configPath,
        "--output",
        "json",
      ]);
      await writeFile(generationResult, stdout);
      const generatedConfigs = await findGeneratedConfigs(
        localSdkRepositoryPath,
        generationStartedAt,
      );
      if (generatedConfigs.length !== 1) {
        throw new Error(
          `Expected exactly one generated tsp-location.yaml for ${typeSpecProjectPath}, found ${generatedConfigs.length}.`,
        );
      }

      const packagePath = await realpath(dirname(generatedConfigs[0]));
      if (!isWithin(localSdkRepositoryPath, packagePath)) {
        throw new Error(`Invalid generated package path: ${packagePath}`);
      }
      const packageName = basename(packagePath);
      const resultsPath = packageNames.has(packageName)
        ? `${packageName}-${index + 1}`
        : packageName;
      packageNames.add(packageName);
      const projectResults = join(resultsDirectory, resultsPath);
      await mkdir(projectResults, { recursive: true });
      await rename(generationResult, join(projectResults, "generate.json"));

      /* Build the SDK package */
      const buildArgs = [
        "package",
        "build",
        "--package-path",
        packagePath,
        "--output",
        "json",
      ];
      // Optional: Add any additional build arguments here for .NET SDK projects
      if (sdkLanguage === SdkLanguage.DotNet) {
        // Example: Add a hypothetical .NET-specific build argument
        buildArgs.push("--additional-arguments", "/p:RunApiCompat=false");
      }

      const { stdout: buildStdout } = await execFile("azsdk", buildArgs);
      await writeFile(join(projectResults, "build.json"), buildStdout);

      /* Detect breaking changes */
      const { stdout: breakingChangesStdout } = await execFile("azsdk", [
        "package",
        "detect-breaking-change",
        "--package-path",
        packagePath,
        "--tsp-config-path",
        configPath,
        "--output",
        "json",
      ]);
      await writeFile(join(projectResults, "breaking-changes.json"), breakingChangesStdout);

      projects.push({ typespecProjectPath: typeSpecProjectPath, packageName, resultsPath });
      await writeFile(join(resultsDirectory, "projects.json"), `${JSON.stringify(projects)}\n`);
    }
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    await appendFile(analysisLog, `${message}\n`);
    await writeFile(join(resultsDirectory, "error.log"), `${message}\n`);
    throw error;
  }
}
