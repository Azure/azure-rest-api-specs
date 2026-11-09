import { readdir } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { compile, NodeHost } from "@typespec/compiler";
import { describe, expect, it } from "vitest";

const samplesDir = fileURLToPath(new URL("../samples/", import.meta.url));

const sampleFiles = (await readdir(samplesDir)).filter((file) => file.endsWith(".tsp"));

describe("samples", () => {
  it("has at least one sample", () => {
    expect(sampleFiles.length).toBeGreaterThan(0);
  });

  it.each(sampleFiles)("%s compiles without errors", async (file) => {
    const program = await compile(NodeHost, `${samplesDir}${file}`, { noEmit: true });
    const errors = program.diagnostics.filter((diagnostic) => diagnostic.severity === "error");
    expect(errors).toEqual([]);
  });
});
