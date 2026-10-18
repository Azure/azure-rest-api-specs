import { z } from "zod";

export const AnalyzeProjectSchema = z.object({
  typespecProjectPath: z.string().min(1),
  packageName: z.string().optional(),
  resultsPath: z.string().optional(),
  analysisStatus: z.enum(["success", "failure", "skipped"]),
  errorMessage: z.string().optional(),
});

export type AnalyzeProjectResult = z.infer<typeof AnalyzeProjectSchema>;

export const RawBreakingChangeSchema = z.object({
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
    z
      .object({
        typespecProject: z.string().min(1),
        sdkPackage: z.string(),
        status: z.enum(["success", "failure", "skipped"]),
        analysisStatus: z.enum(["success", "failure", "skipped"]),
        breakingChanges: z.array(
          z.object({
            breakingChange: z.string(),
            category: z.string(),
            suggestedFix: z.string(),
          }),
        ),
      })
      .refine((project) => project.analysisStatus !== "success" || project.sdkPackage.length > 0, {
        message: "Successful analysis requires an SDK package name.",
        path: ["sdkPackage"],
      }),
  ),
});

export type AnalysisResult = z.infer<typeof AnalysisResultSchema>;

const MitigatedChangeSchema = z.object({
  breakingChange: z.string(),
  suggestedFix: z.string(),
  isResolved: z.boolean(),
  typespecChangesSummary: z.array(z.string()).optional(),
});

export type MitigatedChange = z.infer<typeof MitigatedChangeSchema>;

export const MitigationResultSchema = z.object({
  schemaVersion: z.literal(1),
  prNumber: z.number().int().positive(),
  headSha: z.string().regex(/^[0-9a-f]{40}$/i),
  sdkLanguage: z.string().min(1),
  mitigationWorkflowUrl: z.string().url(),
  status: z.enum(["success", "failure"]),
  customizationCode: z.string(),
  projects: z.array(
    z.object({
      typespecProject: z.string().min(1),
      sdkPackage: z.string().min(1),
      breakingChanges: z.array(MitigatedChangeSchema),
    }),
  ),
  errorMessage: z.string().min(1).optional(),
});

export type MitigationResult = z.infer<typeof MitigationResultSchema>;
