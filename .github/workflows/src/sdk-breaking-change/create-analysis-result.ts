import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { z } from "zod";
import {
  type AnalysisResult,
  AnalyzeProjectSchema,
  RawBreakingChangeSchema,
  AnalysisResultSchema,
} from "./types.ts";

async function readJson(path: string): Promise<unknown> {
  return JSON.parse(await readFile(path, "utf8"));
}

export async function createAnalysisResult({
  resultsPath,
  prNumber,
  headSha,
  sdkLanguage,
  analysisWorkflowUrl,
  status,
}: {
  resultsPath: string;
  prNumber: number;
  headSha: string;
  sdkLanguage: string;
  analysisWorkflowUrl: string;
  status: "success" | "failure";
}): Promise<AnalysisResult> {
  await mkdir(resultsPath, { recursive: true });
  let rawProjects: z.infer<typeof AnalyzeProjectSchema>[] = [];
  try {
    rawProjects = z
      .array(AnalyzeProjectSchema)
      .parse(await readJson(join(resultsPath, "projects.json")));
  } catch (error) {
    if (status === "success") {
      throw error;
    }
  }

  const projects = await Promise.all(
    rawProjects.map(async (project) => {
      if (project.analysisStatus !== "success" || !project.resultsPath) {
        return {
          typespecProject: project.typespecProjectPath ?? "",
          sdkPackage: project.packageName ?? "",
          status: project.analysisStatus,
          analysisStatus: project.analysisStatus ?? "skipped",
          breakingChanges: [],
        };
      }
      const response = z
        .object({ result: z.object({ breakingChanges: z.array(RawBreakingChangeSchema) }) })
        .parse(await readJson(join(resultsPath, project.resultsPath, "breaking-changes.json")));
      return {
        typespecProject: project.typespecProjectPath ?? "",
        sdkPackage: project.packageName ?? "",
        status: project.analysisStatus,
        analysisStatus: project.analysisStatus ?? "skipped",
        breakingChanges: response.result.breakingChanges.map((change) => ({
          breakingChange: change.breakingChange,
          category: change.category,
          suggestedFix: change.resolution,
        })),
      };
    }),
  );

  let errorMessage: string | undefined;
  if (status === "failure") {
    try {
      errorMessage = (await readFile(join(resultsPath, "error.log"), "utf8")).trim();
    } catch (error) {
      if (!(error instanceof Error && "code" in error && error.code === "ENOENT")) {
        throw error;
      }
    }
    errorMessage ||= "SDK breaking-change analysis failed.";
  }

  const result = AnalysisResultSchema.parse({
    schemaVersion: 1,
    prNumber,
    headSha,
    sdkLanguage,
    analysisWorkflowUrl,
    status,
    errorMessage,
    projects,
  });
  await writeFile(
    join(resultsPath, "sdk-breaking-change-analysis.json"),
    `${JSON.stringify(result, null, 2)}\n`,
  );
  return result;
}
