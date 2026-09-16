import { execFile } from "node:child_process";
import { mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";
import { expect, it } from "vitest";

it.each(["named", "positional"])(
  "compares identical documents using %s path arguments",
  async (argumentStyle) => {
    const directory = await mkdtemp(join(tmpdir(), "typespec-migration-validation-"));
    try {
      const swagger = {
        swagger: "2.0",
        info: { title: "Widgets", version: "2026-01-01" },
        paths: {
          "/widgets": {
            get: {
              operationId: "Widgets_List",
              responses: { "200": { description: "OK" } },
            },
          },
        },
      };
      const input = join(directory, "swagger.json");
      await writeFile(input, JSON.stringify(swagger));
      const paths =
        argumentStyle === "named"
          ? ["--oldPath", directory, "--newPath", input]
          : [directory, input];
      const { stdout } = await promisify(execFile)(process.execPath, [
        fileURLToPath(new URL("../cmd/tsmv.js", import.meta.url)),
        ...paths,
        "--outputFolder",
        directory,
      ]);

      expect(stdout).toContain("No differences found.");
      const oldNormalized = await readFile(join(directory, "oldNormalizedSwagger.json"), "utf8");
      const newNormalized = await readFile(join(directory, "newNormalizedSwagger.json"), "utf8");
      expect(JSON.parse(oldNormalized)).toEqual(JSON.parse(newNormalized));
      const expected = structuredClone(swagger);
      expected.paths["/widgets"].get.responses["200"].description = "ignore";
      expect(JSON.parse(newNormalized)).toMatchObject(expected);
    } finally {
      await rm(directory, { recursive: true, force: true });
    }
  },
);
