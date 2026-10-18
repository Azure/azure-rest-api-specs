import { appendFile, mkdir, realpath, writeFile } from "node:fs/promises";
import { basename, dirname, join } from "node:path";
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

import type { AnalyzeProjectResult } from "./types.ts";

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

export const SdkLanguage = Object.freeze({
  DotNet: "DotNet",
  Go: "Go",
  Java: "Java",
  JavaScript: "JavaScript",
  Python: "Python",
} as const);

export type SdkLanguage = (typeof SdkLanguage)[keyof typeof SdkLanguage];

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
  await mkdir(resultsDirectory, { recursive: true });
  const errorLogPath = join(resultsDirectory, "error.log");
  await writeFile(
    join(resultsDirectory, "trigger.json"),
    `${JSON.stringify({
      pullNumber,
      sdkLanguage,
      analyzedSha,
      workflowUrl,
    })}\n`,
  );

  const projects: AnalyzeProjectResult[] = [];
  const packageNames = new Set<string>();
  const azureSdkCli = join(azureSdkCliPath, process.platform === "win32" ? "azsdk.exe" : "azsdk");
  await writeFile(join(resultsDirectory, "projects.json"), "[]\n");

  try {
    for (const [index, relativeConfigPath] of typeSpecConfigPaths.entries()) {
      const typeSpecProjectPath = relativeConfigPath.replace(/\/tspconfig\.yaml$/, "");
      const configPath = join(specificationRepositoryPath, relativeConfigPath);

      /* Get typespec metadata for the project */
      const metadata: TypeSpecMetadata = await generateTypeSpecMetadata(dirname(configPath));
      console.log(`Metadata for ${typeSpecProjectPath}:`, metadata);
      const languageKey = resolveLanguageKey(sdkRepoName, metadata.languages);
      if (!languageKey) {
        const message = `No language key found for ${typeSpecProjectPath} and SDK repo ${sdkRepoName}. Skipping this project.`;
        console.error(message);
        await appendFile(errorLogPath, `${message}\n`);
        projects.push({
          typespecProjectPath: typeSpecProjectPath,
          analysisStatus: "skipped",
          errorMessage: message,
        });
        continue;
      }
      const languageMetadata = metadata.languages[languageKey];
      if (!languageMetadata || languageMetadata.length === 0) {
        const message = `No language metadata found for ${typeSpecProjectPath} and language ${sdkLanguage}. Skipping this project.`;
        console.error(message);
        await appendFile(errorLogPath, `${message}\n`);
        projects.push({
          typespecProjectPath: typeSpecProjectPath,
          analysisStatus: "skipped",
          errorMessage: message,
        });
        continue;
      }
      let packagePath = languageMetadata[0].outputDir;
      if (!packagePath) {
        const message = `No output directory found for ${typeSpecProjectPath} and language ${sdkLanguage}. Skipping this project.`;
        console.error(message);
        await appendFile(errorLogPath, `${message}\n`);
        projects.push({
          typespecProjectPath: typeSpecProjectPath,
          analysisStatus: "skipped",
          errorMessage: message,
        });
        continue;
      }
      packagePath = resolvePackagePath(packagePath, localSdkRepositoryPath);
      const packageName = basename(packagePath);
      const resultsPath = packageNames.has(packageName)
        ? `${packageName}-${index + 1}`
        : packageName;
      packageNames.add(packageName);
      const projectResults = join(resultsDirectory, resultsPath);
      await mkdir(projectResults, { recursive: true });

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
        const message = `Failed to generate SDK for ${typeSpecProjectPath}: ${generateResponse.response_error ?? "Unknown error"}. Skipping this project.`;
        console.error(message);
        await appendFile(errorLogPath, `${message}\n`);
        projects.push({
          typespecProjectPath: typeSpecProjectPath,
          analysisStatus: "failure",
          errorMessage: message,
        });
        continue;
      }

      await writeFile(
        join(projectResults, "generate.json"),
        `${JSON.stringify(generateResponse, null, 2)}\n`,
      );

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
          const message = `Failed to build SDK for ${typeSpecProjectPath}: ${buildResponse.response_error ?? "Unknown error"}. Skipping this project.`;
          console.error(message);
          await appendFile(errorLogPath, `${message}\n`);
          projects.push({
            typespecProjectPath: typeSpecProjectPath,
            analysisStatus: "failure",
            errorMessage: message,
          });
          continue;
        }
        await writeFile(
          join(projectResults, "build.json"),
          `${JSON.stringify(buildResponse, null, 2)}\n`,
        );
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
        const message = `Failed to detect breaking changes for ${typeSpecProjectPath}: ${
          breakingChangesResponse.response_error ??
          breakingChangesResponse.response_errors?.join("; ") ??
          "Unknown error"
        }`;
        console.error(message);
        await appendFile(errorLogPath, `${message}\n`);
        projects.push({ typespecProjectPath: typeSpecProjectPath, analysisStatus: "failure" });
        continue;
      }
      await writeFile(
        join(projectResults, "breaking-changes.json"),
        `${JSON.stringify(breakingChangesResponse, null, 2)}\n`,
      );

      projects.push({
        typespecProjectPath: typeSpecProjectPath,
        packageName: packageName,
        resultsPath,
        analysisStatus: "success",
      });
    }
    await writeFile(join(resultsDirectory, "projects.json"), `${JSON.stringify(projects)}\n`);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    await appendFile(join(resultsDirectory, "error.log"), `${message}\n`);
    await writeFile(join(resultsDirectory, "projects.json"), `${JSON.stringify(projects)}\n`);
    throw error;
  }
}
