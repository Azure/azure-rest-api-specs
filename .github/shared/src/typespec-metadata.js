import { mkdtemp, readFile, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import * as z from "zod";
import { execNpmExec, isExecError } from "./exec.js";

export const TypeSpecLanguageMetadataSchema = z.looseObject({
  emitterName: z.string(),
  packageName: z.string().optional(),
  namespace: z.string().optional(),
  outputDir: z.string().optional(),
  flavor: z.string().optional(),
  serviceDir: z.string().optional(),
  apiVersion: z.string().optional(),
  sdkType: z.enum(["preview", "stable"]).optional(),
});

export const TypeSpecMetadataSchema = z.looseObject({
  emitterVersion: z.string(),
  generatedAt: z.string(),
  typespec: z.looseObject({
    namespace: z.string(),
    documentation: z.string().optional(),
    type: z.enum(["data", "management"]),
  }),
  languages: z.record(z.string(), z.array(TypeSpecLanguageMetadataSchema)),
  sourceConfigPath: z.string().optional(),
});

/** @typedef {z.infer<typeof TypeSpecLanguageMetadataSchema>} TypeSpecLanguageMetadata */
/** @typedef {z.infer<typeof TypeSpecMetadataSchema>} TypeSpecMetadata */

/**
 * Generates and parses JSON output from the `@azure-tools/typespec-metadata` emitter.
 *
 * @param {string} folder TypeSpec project folder.
 * @param {{ logger?: import("./logger.js").ILogger }} [options]
 * @returns {Promise<TypeSpecMetadata>}
 */
export async function generateTypeSpecMetadata(folder, options = {}) {
  const absoluteFolder = resolve(folder);
  const temporaryDirectory = await mkdtemp(join(tmpdir(), "typespec-metadata-"));
  const metadataFile = join(temporaryDirectory, "typespec-metadata.json");

  try {
    try {
      await execNpmExec(
        [
          "tsp",
          "compile",
          absoluteFolder,
          "--emit",
          "@azure-tools/typespec-metadata",
          "--option",
          `@azure-tools/typespec-metadata.outputFile=${metadataFile}`,
          "--option",
          "@azure-tools/typespec-metadata.format=json",
        ],
        {
          cwd: absoluteFolder,
          logger: options.logger,
          maxBuffer: 64 * 1024 * 1024,
        },
      );
    } catch (error) {
      // The TypeSpec compiler writes its diagnostics to stdout, not stderr.
      const details = isExecError(error) ? [error.stdout, error.stderr].join("").trim() : undefined;

      throw new Error(`Failed to generate TypeSpec metadata: ${details || String(error)}`, {
        cause: error,
      });
    }

    const parsed = TypeSpecMetadataSchema.safeParse(
      JSON.parse(await readFile(metadataFile, "utf8")),
    );
    if (!parsed.success) {
      throw new Error(`TypeSpec metadata has an unexpected format: ${parsed.error.message}`);
    }
    return parsed.data;
  } finally {
    await rm(temporaryDirectory, { recursive: true, force: true });
  }
}
