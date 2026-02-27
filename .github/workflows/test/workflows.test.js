import { readdir } from "fs/promises";
import { dirname, extname, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");

describe("workflow files", () => {
  it("should be named *.yaml", async () => {
    const entries = await readdir(workflowsDir, { withFileTypes: true });

    const nonYamlFiles = entries
      .filter((e) => e.isFile())
      .map((e) => e.name)
      .filter((f) => extname(f) !== ".yaml");

    expect(nonYamlFiles, "workflow files must use extension '.yaml'").toEqual([]);
  });
});
