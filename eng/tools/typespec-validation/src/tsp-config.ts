import { parse as yamlParse } from "yaml";
import * as z from "zod";

const TspConfigSchema = z
  .object({
    emit: z.array(z.string()).optional(),
    options: z.record(z.string(), z.record(z.string(), z.string())).optional(),
    linter: z
      .object({
        extends: z.array(z.string()).optional(),
      })
      .optional(),
  })
  .nullish();

export type TspConfig = z.infer<typeof TspConfigSchema>;

export function parse(src: string): TspConfig {
  return TspConfigSchema.parse(yamlParse(src));
}
