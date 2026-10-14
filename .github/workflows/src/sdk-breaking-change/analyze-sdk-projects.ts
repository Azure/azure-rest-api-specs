import { appendFile, mkdir, realpath, rename, writeFile } from "node:fs/promises";
import { basename, dirname, isAbsolute, join, relative, sep } from "node:path";
import {
  parseAzsdkResponse,
  resolveLanguageKey,
  resolvePackagePath,
  type AzsdkBuildResponse,
  type AzsdkDetectBreakingChangeResponse,
  type AzsdkGenerateResponse,
} from "@azure-tools/spec-gen-sdk-runner";
import { execFile } from "@azure-tools/specs-shared/exec";
import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { SdkLanguage } from "./resolve-analysis-inputs.ts";

interface ProjectResult {
  typespecProjectPath: string;
  packageName: string;
  resultsPath: string;
}

export interface AnalyzeSdkProjectsOptions {
  localSdkRepositoryPath: string;
  specificationRepositoryPath: string;
  typeSpecConfigPaths: string[];
  pullNumber: number;
  sdkLanguage: string;
  sdkRepoName: string;
  analyzedSha: string;
  workflowUrl: string;
  resultDir: string;
  azureSdkCliPath: string;
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
  sdkRepoName,
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
      const generateResponse: AzsdkGenerateResponse =
        parseAzsdkResponse<AzsdkGenerateResponse>(stdout);
      if (generateResponse.result !== "succeeded") {
        throw new Error(
          `Failed to generate SDK for ${typeSpecProjectPath}: ${generateResponse.response_error ?? "Unknown error"}`,
        );
      }
      await writeFile(generationResult, stdout);

      const metadata: TypeSpecMetadata = await generateTypeSpecMetadata(dirname(configPath));
      console.log(`Metadata for ${typeSpecProjectPath}:`, metadata);
      const languageKey = resolveLanguageKey(sdkRepoName, metadata.languages);
      if (!languageKey) {
        throw new Error(
          `Expected language key for ${typeSpecProjectPath} and SDK repo ${sdkRepoName}, but none was found.`,
        );
      }
      const languageMetadata = metadata.languages[languageKey];
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
      packagePath = resolvePackagePath(packagePath, localSdkRepositoryPath);

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

      /* Build the SDK package, skip for Python — interpreted language, no compilation needed */
      if (sdkLanguage !== SdkLanguage.Python) {
        const buildArgs = ["package", "build", "--package-path", packagePath, "--output", "json"];
        // Optional: Add any additional build arguments here for .NET SDK projects
        if (sdkLanguage === SdkLanguage.DotNet) {
          // Example: Add a hypothetical .NET-specific build argument
          buildArgs.push("--additional-arguments", "/p:RunApiCompat=false");
        }

        const { stdout: buildStdout } = await execFile(azureSdkCli, buildArgs);
        const buildResponse: AzsdkBuildResponse = parseAzsdkResponse(buildStdout);
        if (buildResponse.result !== "succeeded") {
          throw new Error(
            `Failed to build SDK for ${typeSpecProjectPath}: ${buildResponse.response_error ?? "Unknown error"}`,
          );
        }
        await writeFile(join(projectResults, "build.json"), `${JSON.stringify(buildResponse)}\n`);
      }

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
      console.log("breakingChangesStdout: " + breakingChangesStdout);
      const breakingChangesResponse: AzsdkDetectBreakingChangeResponse =
        parseAzsdkResponse(breakingChangesStdout);
      if (
        typeof breakingChangesResponse.result !== "object" ||
        breakingChangesResponse.response_error ||
        breakingChangesResponse.response_errors?.length
      ) {
        throw new Error(
          `Failed to detect breaking changes for ${typeSpecProjectPath}: ${
            breakingChangesResponse.response_error ??
            breakingChangesResponse.response_errors?.join("; ") ??
            "Unknown error"
          }`,
        );
      }
      await writeFile(
        join(projectResults, "breaking-changes.json"),
        `${JSON.stringify(breakingChangesResponse)}\n`,
      );

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
