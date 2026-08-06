import { parse as yamlParse } from "yaml";
import * as z from "zod";

const ServiceYamlVersionSchema = z.looseObject({
  version: z.string(),
  source: z.string().optional(),
  "swagger-files": z.array(z.string()).optional(),
});

const ServiceYamlSchema = z.looseObject({
  versions: z.array(ServiceYamlVersionSchema),
});

export type ServiceYamlVersion = z.infer<typeof ServiceYamlVersionSchema>;
export type ServiceYaml = z.infer<typeof ServiceYamlSchema>;

export type ParseServiceYamlResult =
  | { success: true; value: ServiceYaml }
  | { success: false; error: string };

/**
 * Parses the content of a `service.yaml` manifest.
 *
 * This deliberately only models the parts of the manifest the rule needs (the version list and its
 * swagger paths) and ignores everything else, rather than depending on the emitter's schema — tsv
 * stays free of a `@azure-tools/typespec-autorest` dependency, and validating the full shape is the
 * emitter's job. Returns a readable error instead of throwing.
 */
export function parseServiceYaml(src: string): ParseServiceYamlResult {
  let raw: unknown;
  try {
    raw = yamlParse(src);
  } catch (error) {
    return { success: false, error: `service.yaml is not valid YAML: ${(error as Error).message}` };
  }

  const parsed = ServiceYamlSchema.safeParse(raw);
  if (!parsed.success) {
    const details = parsed.error.issues
      .map((issue) => `  - ${issue.path.join(".") || "<root>"}: ${issue.message}`)
      .join("\n");
    return {
      success: false,
      error: `service.yaml does not match the expected format:\n${details}`,
    };
  }

  return { success: true, value: parsed.data };
}
