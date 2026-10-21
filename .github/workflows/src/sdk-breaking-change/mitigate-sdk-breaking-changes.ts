import { mkdir, readFile, realpath, stat, writeFile } from "node:fs/promises";
import { dirname, isAbsolute, join, relative, sep } from "node:path";
import { parseAzsdkResponse } from "@azure-tools/spec-gen-sdk-runner";
import { execFile } from "@azure-tools/specs-shared/exec";
import {
  AnalysisResultSchema,
  MitigationResultSchema,
  type MitigationResult,
  type MitigatedChange,
  MarkdownHeadingId,
  SUPPRESSION_GUIDE_URL,
} from "./types.ts";
import type { Core } from "../github.ts";
import {
  escapeMarkdown,
  inlineCode,
  renderMarkdownDoc,
  section,
} from "@azure-tools/specs-shared/markdown";

export interface AzsdkCustomizedCodeUpdateResponse {
  success: boolean;
  specChangeRequired?: string[];
  customCodeChangeRequired?: string[];
  typeSpecChangesSummary?: string[];
  package_name?: string;
  language?: string;
  response_error?: string;
  response_errors?: string[];
}

export interface MitigateSdkBreakingChangesOptions {
  analysisResultPath: string;
  mitigationResultPath: string;
  mitigationWorkflowUrl: string;
  specificationRepositoryPath: string;
  resultDirPath: string;
  azureSdkCliPath: string;
}

function isWithin(parent: string, child: string): boolean {
  const path = relative(parent, child);
  return path !== "" && path !== ".." && !path.startsWith(`..${sep}`) && !isAbsolute(path);
}

async function writeResult(path: string, result: MitigationResult): Promise<void> {
  const validatedResult = MitigationResultSchema.parse(result);
  await writeFile(path, `${JSON.stringify(validatedResult, null, 2)}\n`);
}

function BuildMigratedBreakingChange(
  customizedUpdateResult: AzsdkCustomizedCodeUpdateResponse,
  id: string,
  breakingChange: string,
  suggestedFix: string,
): MitigatedChange {
  return {
    id,
    breakingChange,
    suggestedFix,
    isResolved: customizedUpdateResult.success,
    ...(customizedUpdateResult.typeSpecChangesSummary == null
      ? {}
      : { typespecChangesSummary: customizedUpdateResult.typeSpecChangesSummary }),
  };
}

export async function mitigateSdkBreakingChanges({
  core,
  analysisResultPath,
  mitigationResultPath,
  mitigationWorkflowUrl,
  specificationRepositoryPath: unresolvedSpecificationRepositoryPath,
  resultDirPath,
  azureSdkCliPath,
}: { core: Core } & MitigateSdkBreakingChangesOptions): Promise<void> {
  const analysisResult = AnalysisResultSchema.parse(
    JSON.parse(await readFile(analysisResultPath, "utf8")),
  );
  const analyzedProjects = analysisResult.projects.filter(
    (project) => project.analysisStatus === "success",
  );
  const blocks = [
    "## SDK breaking-change mitigation",
    analysisResult.headSha
      ? `**Analyzed commit:** ${inlineCode(analysisResult.headSha)}`
      : undefined,
  ];
  try {
    const specificationRepositoryPath = await realpath(unresolvedSpecificationRepositoryPath);
    const specificationRoot = await realpath(join(specificationRepositoryPath, "specification"));
    await mkdir(dirname(mitigationResultPath), { recursive: true });

    const mitigationResult: MitigationResult = {
      schemaVersion: 1,
      prNumber: analysisResult.prNumber,
      headSha: analysisResult.headSha,
      sdkLanguage: analysisResult.sdkLanguage,
      mitigationWorkflowUrl,
      status: "success",
      customizationCode: "",
      projects: analyzedProjects.map((project) => ({
        typespecProject: project.typespecProject,
        sdkPackage: project.sdkPackage,
        breakingChanges: [],
      })),
    };

    for (const [projectIndex, project] of analyzedProjects.entries()) {
      if (project.breakingChanges.length === 0) {
        console.log(`No SDK breaking changes found for ${project.typespecProject}.`);
        continue;
      }

      const typeSpecProjectPath = await realpath(
        join(specificationRepositoryPath, project.typespecProject),
      );
      if (
        !(await stat(typeSpecProjectPath)).isDirectory() ||
        !isWithin(specificationRoot, typeSpecProjectPath)
      ) {
        throw new Error(`Invalid TypeSpec project path: ${project.typespecProject}`);
      }

      for (const [changeIndex, change] of project.breakingChanges.entries()) {
        console.log(
          `Mitigating SDK breaking change ${changeIndex + 1} of ${project.breakingChanges.length} for ${project.typespecProject}.`,
        );
        const commandResultPath = join(resultDirPath, `sdk-mitigation-result-${changeIndex}.json`);
        let mitigatedChange: MitigatedChange = {
          id: change.id,
          breakingChange: change.breakingChange,
          suggestedFix: change.suggestedFix,
          isResolved: false,
        };
        try {
          const { stdout } = await execFile(
            join(azureSdkCliPath, process.platform === "win32" ? "azsdk.exe" : "azsdk"),
            [
              "typespec",
              "client",
              "customized-update",
              "--tsp-project-path",
              typeSpecProjectPath,
              "--customization-request",
              `Resolve this SDK breaking change: ${JSON.stringify({
                breakingChange: change.breakingChange,
                category: change.category,
                suggestedFix: change.suggestedFix,
              })}`,
              "--edit-scope",
              "2",
              "--output",
              "json",
            ],
          );
          await writeFile(commandResultPath, stdout);

          try {
            mitigatedChange = BuildMigratedBreakingChange(
              parseAzsdkResponse<AzsdkCustomizedCodeUpdateResponse>(stdout),
              change.id,
              change.breakingChange,
              change.suggestedFix,
            );
          } catch {
            mitigatedChange = {
              id: change.id,
              breakingChange: change.breakingChange,
              suggestedFix: change.suggestedFix,
              isResolved: false,
            };
          }
        } catch (error) {
          console.error(
            `Failed to mitigate SDK breaking change ${changeIndex + 1} for ${project.typespecProject}:`,
            error,
          );
          mitigatedChange = {
            id: change.id,
            breakingChange: change.breakingChange,
            suggestedFix: change.suggestedFix,
            isResolved: false,
          };
        }
        mitigationResult.projects[projectIndex].breakingChanges.push(mitigatedChange);
        const suppresionSection = section(
          "Suppression",
          `Follow the [suppression guideline](${SUPPRESSION_GUIDE_URL}) to add follow breaking change items to sdk-suppression.yaml.\n\n\`\`\`yaml\n${change.originBreaks.join("\n")}\n\`\`\``,
        );
        const breakingChangeSection = section(
          `Breaking Change ${change.id}`,
          suppresionSection,
          `breaking-change-${escapeMarkdown(change.id)}-${MarkdownHeadingId.Mitigation}`,
        );
        blocks.push(renderMarkdownDoc(breakingChangeSection, 2));
      }
    }
    await writeResult(mitigationResultPath, mitigationResult);
  } catch (error) {
    console.error("SDK breaking-change mitigation failed.", error);
    const failureResult: MitigationResult = {
      schemaVersion: 1,
      status: "failure",
      prNumber: analysisResult.prNumber,
      headSha: analysisResult.headSha,
      sdkLanguage: analysisResult.sdkLanguage,
      mitigationWorkflowUrl: mitigationWorkflowUrl,
      errorMessage: (error as Error).message,
      projects: [],
      customizationCode: "",
    };
    await writeResult(mitigationResultPath, failureResult);
  }

  // summary of the mitigation
  await core.summary.addRaw(blocks.filter((block) => block !== undefined).join("\n\n")).write();
}
