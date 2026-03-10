import { readdir } from "fs/promises";
import { dirname, extname, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";

const __dirname = dirname(fileURLToPath(import.meta.url));
const workflowsDir = resolve(__dirname, "..");

describe("workflow files", () => {
  it("should be named *.yaml or *.md", async () => {
    const entries = await readdir(workflowsDir, { withFileTypes: true });

    const disallowedFiles = entries
      .filter((e) => e.isFile())
      .map((e) => e.name)
      .filter((f) => {
        const extension = extname(f);
        return extension !== ".yaml" && extension !== ".yml" && extension !== ".md";
      });

    expect(disallowedFiles, "workflow files must use extension '.yaml' or '.md'").toEqual([]);
  });
});
