import { mkdir, realpath, writeFile } from "node:fs/promises";
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

import { MarkdownHeadingId, type AnalysisResult } from "./types.ts";
import type { Core } from "../github.ts";
import {
  escapeMarkdown,
  inlineCode,
  renderMarkdownDoc,
  section,
} from "@azure-tools/specs-shared/markdown";

export interface AnalyzeSdkProjectsOptions {
  localSdkRepositoryPath: string;
  specificationRepositoryPath: string;
  typeSpecConfigPaths: string[];
  pullNumber: number;
  sdkLanguage: string;
  sdkRepoName: string;
  analyzedSha: string;
  workflowUrl: string;
  resultFilePath: string;
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
  core,
  localSdkRepositoryPath: unresolvedLocalSdkRepositoryPath,
  specificationRepositoryPath,
  typeSpecConfigPaths,
  pullNumber,
  sdkLanguage,
  sdkRepoName,
  analyzedSha,
  workflowUrl,
  resultFilePath,
  azureSdkCliPath,
}: { core: Core } & AnalyzeSdkProjectsOptions): Promise<void> {
  const localSdkRepositoryPath = await realpath(unresolvedLocalSdkRepositoryPath);
  await mkdir(dirname(resultFilePath), { recursive: true });

  const analyzeResult: AnalysisResult = {
    schemaVersion: 1,
    prNumber: pullNumber,
    headSha: analyzedSha,
    sdkLanguage: sdkLanguage,
    analysisWorkflowUrl: workflowUrl,
    status: "success",
    projects: [],
  };
  const azureSdkCli = join(azureSdkCliPath, process.platform === "win32" ? "azsdk.exe" : "azsdk");

  const blocks = [
    "## SDK breaking-change analysis",
    analyzedSha ? `**Analyzed commit:** ${inlineCode(analyzedSha)}` : undefined,
  ];
  try {
    for (const [_index, relativeConfigPath] of typeSpecConfigPaths.entries()) {
      const typeSpecProjectPath = relativeConfigPath.replace(/\/tspconfig\.yaml$/, "");
      blocks.push(`### ${escapeMarkdown(typeSpecProjectPath)}`);
      const configPath = join(specificationRepositoryPath, relativeConfigPath);

      /* Get typespec metadata for the project */
      const metadata: TypeSpecMetadata = await generateTypeSpecMetadata(dirname(configPath));
      console.log(`Metadata for ${typeSpecProjectPath}:`, metadata);
      const languageKey = resolveLanguageKey(sdkRepoName, metadata.languages);
      if (!languageKey) {
        const message = `No language key found for ${typeSpecProjectPath} and SDK repo ${sdkRepoName}. Skipping this project.`;
        console.error(message);

        analyzeResult.projects.push({
          typespecProject: typeSpecProjectPath,
          sdkPackage: "",
          analysisStatus: "skipped",
          breakingChanges: [],
        });
        blocks.push(`**Analysis is skipped:** ${escapeMarkdown(message)}`);
        continue;
      }
      const languageMetadata = metadata.languages[languageKey];
      if (!languageMetadata || languageMetadata.length === 0) {
        const message = `No language metadata found for ${typeSpecProjectPath} and language ${sdkLanguage}. Skipping this project.`;
        console.error(message);

        analyzeResult.projects.push({
          typespecProject: typeSpecProjectPath,
          sdkPackage: "",
          analysisStatus: "skipped",
          breakingChanges: [],
        });
        blocks.push(`**Analysis is skipped:** ${escapeMarkdown(message)}`);
        continue;
      }
      let packagePath = languageMetadata[0].outputDir;
      if (!packagePath) {
        const message = `No output directory found for ${typeSpecProjectPath} and language ${sdkLanguage}. Skipping this project.`;
        console.error(message);
        analyzeResult.projects.push({
          typespecProject: typeSpecProjectPath,
          sdkPackage: "",
          analysisStatus: "skipped",
          breakingChanges: [],
        });
        blocks.push(`**Analysis is skipped:** ${escapeMarkdown(message)}`);
        continue;
      }
      packagePath = resolvePackagePath(packagePath, localSdkRepositoryPath);
      const packageName = basename(packagePath);

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
        analyzeResult.projects.push({
          typespecProject: typeSpecProjectPath,
          sdkPackage: "",
          analysisStatus: "failure",
          breakingChanges: [],
        });
        blocks.push(`**Analysis failed:** ${escapeMarkdown(message)}`);
        continue;
      }
      blocks.push(
        `**generate.json:** \n\n\`\`\`\n${JSON.stringify(generateResponse, null, 2)}\n\`\`\``,
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
          analyzeResult.projects.push({
            typespecProject: typeSpecProjectPath,
            sdkPackage: "",
            analysisStatus: "failure",
            breakingChanges: [],
          });
          blocks.push(`**Analysis failed:** ${escapeMarkdown(message)}`);
          continue;
        }
        blocks.push(
          `**build.json:** \n\n\`\`\`\n${JSON.stringify(buildResponse, null, 2)}\n\`\`\``,
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
        blocks.push(`**Analysis failed:** ${escapeMarkdown(message)}`);
        analyzeResult.projects.push({
          typespecProject: typeSpecProjectPath,
          sdkPackage: "",
          analysisStatus: "failure",
          breakingChanges: [],
        });
        continue;
      }
      blocks.push(`**Analysis succeeded:**`);
      const breakingChangeSection = section(
        "Breaking Changes",
        `\`\`\`\n${JSON.stringify(breakingChangesResponse, null, 2)}\n\`\`\``,
        `${packageName}-${MarkdownHeadingId.BreakingChange}`,
      );
      blocks.push(renderMarkdownDoc(breakingChangeSection));

      analyzeResult.projects.push({
        typespecProject: typeSpecProjectPath,
        sdkPackage: packageName,
        analysisStatus: "success",
        breakingChanges:
          breakingChangesResponse.result?.breakingChanges?.map((change) => {
            const typedChange = change as {
              breakingChange: string;
              category: string;
              resolution?: string;
            };
            return {
              breakingChange: typedChange.breakingChange,
              category: typedChange.category,
              suggestedFix: typedChange.resolution ?? "",
            };
          }) ?? [],
      });
    }
    await writeFile(resultFilePath, `${JSON.stringify(analyzeResult, null, 2)}\n`);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    core.setFailed(message);
    analyzeResult.status = "failure";
    blocks.push(`**Analysis failed:** ${escapeMarkdown(message)}`);
    await writeFile(resultFilePath, `${JSON.stringify(analyzeResult, null, 2)}\n`);
  }

  // summary of the analysis results
  await core.summary.addRaw(blocks.filter((block) => block !== undefined).join("\n\n")).write();
}
