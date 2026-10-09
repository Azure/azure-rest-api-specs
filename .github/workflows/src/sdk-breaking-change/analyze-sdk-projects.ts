import { appendFile, mkdir, realpath, rename, writeFile } from "node:fs/promises";
import { basename, dirname, isAbsolute, join, relative, sep } from "node:path";
import { execFile } from "../../../shared/src/exec.ts";
import { SdkLanguage } from "./resolve-analysis-inputs.ts";
import { generateTypeSpecMetadata } from "../../../shared/src/typespec-metadata.ts";

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
  azureSdkCliPath: string;
};

const Lang_METADATA_LANG_MAP: Record<string, string> = {
  dotnet: "dotnet",
  ".net": "dotnet",
  java: "java",
  python: "python",
  typescript: "typescript",
  js: "typescript",
  javascript: "typescript",
  go: "go",
};

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
  azureSdkCliPath,
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
  const azureSdkCli = join(azureSdkCliPath, process.platform === "win32" ? "azsdk.exe" : "azsdk");
  await writeFile(join(resultsDirectory, "projects.json"), "[]\n");

  try {
    for (const [index, relativeConfigPath] of typeSpecConfigPaths.entries()) {
      const typeSpecProjectPath = relativeConfigPath.replace(/\/tspconfig\.yaml$/, "");
      const configPath = join(specificationRepositoryPath, relativeConfigPath);
      const generationResult = join(resultDir, "sdk-generation-result.json");

      /* Generate the SDK package */
      const { stdout } = await execFile(azureSdkCli, [
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

      const metadata = await generateTypeSpecMetadata(dirname(configPath));
      console.log(`Metadata for ${typeSpecProjectPath}:`, metadata);
      const languageMetadata =
        metadata.languages[Lang_METADATA_LANG_MAP[sdkLanguage.toLowerCase()]];
      if (!languageMetadata || languageMetadata.length === 0) {
        throw new Error(
          `Expected language metadata for ${typeSpecProjectPath} and language ${sdkLanguage}, but none was found.`,
        );
      }
      let packagePath = languageMetadata[0].outputDir;
      if (!packagePath) {
        throw new Error(
          `Expected output directory for ${typeSpecProjectPath} and language ${sdkLanguage}, but none was found.`,
        );
      }
      packagePath = packagePath.replace("{output-dir}", localSdkRepositoryPath);

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
      const buildArgs = ["package", "build", "--package-path", packagePath, "--output", "json"];
      // Optional: Add any additional build arguments here for .NET SDK projects
      if (sdkLanguage === SdkLanguage.DotNet) {
        // Example: Add a hypothetical .NET-specific build argument
        buildArgs.push("--additional-arguments", "/p:RunApiCompat=false");
      }

      const { stdout: buildStdout } = await execFile(azureSdkCli, buildArgs);
      await writeFile(join(projectResults, "build.json"), buildStdout);

      /* Detect breaking changes */
      const { stdout: breakingChangesStdout } = await execFile(azureSdkCli, [
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
