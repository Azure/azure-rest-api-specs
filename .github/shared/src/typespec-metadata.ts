import { existsSync } from "node:fs";
import { mkdtemp, readFile, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";
import * as z from "zod";
import { execNodeBin, isExecError } from "./exec.ts";

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

export type TypeSpecLanguageMetadata = z.infer<typeof TypeSpecLanguageMetadataSchema>;
export type TypeSpecMetadata = z.infer<typeof TypeSpecMetadataSchema>;

/**
 * Generates and parses JSON output from the `@azure-tools/typespec-metadata` emitter.
 * @param folder TypeSpec project folder.
 */
export async function generateTypeSpecMetadata(
  folder: string,
  options: { logger?: import("./logger.ts").ILogger } = {},
): Promise<TypeSpecMetadata> {
  const absoluteFolder = resolve(folder);
  const temporaryDirectory = await mkdtemp(join(tmpdir(), "typespec-metadata-"));
  const metadataFile = join(temporaryDirectory, "typespec-metadata.json");

  const mainTspPath = join(absoluteFolder, "main.tsp");
  const clientTspPath = join(absoluteFolder, "client.tsp");
  let tspCompileTarget = absoluteFolder;
  if (!existsSync(mainTspPath) && existsSync(clientTspPath)) {
    tspCompileTarget = clientTspPath;
  }

  try {
    try {
      await execNodeBin(
        "@typespec/compiler",
        [
          "tsp",
          "compile",
          tspCompileTarget,
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
