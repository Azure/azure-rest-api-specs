import { mkdir, readFile, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { z } from "zod";

const RawProjectSchema = z.object({
  typespecProjectPath: z.string().min(1),
  packageName: z.string().min(1),
  resultsPath: z.string().min(1),
});

const RawBreakingChangeSchema = z.object({
  breakingChange: z.string(),
  category: z.string().optional().default(""),
  resolution: z
    .string()
    .nullable()
    .optional()
    .transform((value) => value ?? ""),
});

export const AnalysisResultSchema = z.object({
  schemaVersion: z.literal(1),
  prNumber: z.number().int().positive(),
  headSha: z.string().regex(/^[0-9a-f]{40}$/i),
  sdkLanguage: z.string().min(1),
  analysisWorkflowUrl: z.string().url(),
  status: z.enum(["success", "failure"]),
  errorMessage: z.string().min(1).optional(),
  projects: z.array(
    z.object({
      typespecProject: z.string().min(1),
      sdkPackage: z.string().min(1),
      breakingChanges: z.array(
        z.object({
          breakingChange: z.string(),
          category: z.string(),
          suggestedFix: z.string(),
        }),
      ),
    }),
  ),
});

export type AnalysisResult = z.infer<typeof AnalysisResultSchema>;

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
  let rawProjects: z.infer<typeof RawProjectSchema>[] = [];
  try {
    rawProjects = z
      .array(RawProjectSchema)
      .parse(await readJson(join(resultsPath, "projects.json")));
  } catch (error) {
    if (status === "success") {
      throw error;
    }
  }

  const projects = await Promise.all(
    rawProjects.map(async (project) => {
      const response = z
        .object({ result: z.object({ breakingChanges: z.array(RawBreakingChangeSchema) }) })
        .parse(await readJson(join(resultsPath, project.resultsPath, "breaking-changes.json")));
      return {
        typespecProject: project.typespecProjectPath,
        sdkPackage: project.packageName,
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
    } catch {}
    errorMessage ||= "SDK breaking-change analysis failed.";
    errorMessage += `\n\n[See analysis workflow](${analysisWorkflowUrl})`;
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
