import { z } from "zod";

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
