import { parse as yamlParse, YAMLParseError } from "yaml";
import * as z from "zod";
import { DiagnosticError } from "./rule-result.ts";

const TspConfigSchema = z
  .object({
    emit: z.array(z.string()).nullish(),
    options: z
      .looseObject({
        "@azure-tools/typespec-autorest": z
          .looseObject({
            "azure-resource-provider-folder": z.string().optional(),
          })
          .optional(),
      })
      .catchall(z.looseObject({ flavor: z.string().optional() }))
      .optional(),
    linter: z
      .object({
        extends: z.array(z.string()).optional(),
      })
      .optional(),
  })
  .nullish();

export type TspConfig = z.infer<typeof TspConfigSchema>;

export function parseYaml(src: string, path?: string): unknown {
  try {
    return yamlParse(src, { prettyErrors: false });
  } catch (error) {
    if (!(error instanceof YAMLParseError)) throw error;
    const prefix = src.slice(0, error.pos[0]).split(/\r?\n/);
    throw new DiagnosticError(
      {
        severity: "error",
        code: "invalid-yaml",
        message: error.message,
        path,
        location: { line: prefix.length, column: prefix[prefix.length - 1].length + 1, text: src },
      },
      error,
    );
  }
}

export function parse(src: string, path?: string): TspConfig {
  const parsed = TspConfigSchema.safeParse(parseYaml(src, path));
  if (!parsed.success) {
    throw new DiagnosticError(
      {
        severity: "error",
        code: "invalid-config",
        path,
        message: parsed.error.issues
          .map((issue) => `${issue.path.join(".") || "<root>"}: ${issue.message}`)
          .join("\n"),
      },
      parsed.error,
    );
  }
  return parsed.data;
}
