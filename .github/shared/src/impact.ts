import * as z from "zod";

export const ServiceImpactSchema = z.object({
  path: z.string(),
  plane: z.enum(["resource-manager", "data-plane", "unknown"]),
  changes: z.array(z.enum(["api", "examples", "sdk-configuration", "readme", "other"])),
  typeSpec: z.boolean(),
  newApiVersions: z.array(z.string()),
  suppressionsChanged: z.boolean(),
  resourceProvider: z.object({
    newNamespaces: z.array(z.string()),
    usesRpaas: z.boolean(),
    hasAddedDefinitions: z.boolean(),
    registered: z.boolean(),
  }),
});

export const ImpactAssessmentSchema = z.object({
  schemaVersion: z.literal(2),
  services: z.array(ServiceImpactSchema),
});

export type ServiceImpact = z.infer<typeof ServiceImpactSchema>;
export type ImpactAssessment = z.infer<typeof ImpactAssessmentSchema>;
