import { copyFile, mkdir, mkdtemp, readdir, rm, writeFile } from "fs/promises";
import { tmpdir } from "os";
import { dirname, extname, resolve } from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";
import { execFile } from "../../shared/src/exec.ts";

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

  it("lints enabled tooling and the root test config, excluding unmanaged paths", async () => {
    const root = resolve(workflowsDir, "../..");
    const folder = await mkdtemp(resolve(tmpdir(), "specs-lint-"));
    try {
      await copyFile(resolve(root, ".oxlintrc.json"), resolve(folder, ".oxlintrc.json"));
      const included = [
        ".github",
        ".github/shared",
        ".github/workflows",
        "eng/tools",
        ...[
          "lint-diff",
          "oav-runner",
          "release-plan",
          "sdk-suppressions",
          "spec-gen-sdk-runner",
          "summarize-impact",
          "suppressions",
          "tsp-client-tests",
          "typespec-requirement",
          "typespec-suppressions",
          "typespec-validation",
        ].map((name) => `eng/tools/${name}`),
      ];
      const excluded = [
        ".",
        ".config",
        "specification",
        "eng/common",
        "eng/scripts",
        "scripts",
        ...["openapi-diff-runner", "typespec-migration-validation"].map(
          (name) => `eng/tools/${name}`,
        ),
      ];
      for (const path of [...included, ...excluded]) {
        await mkdir(resolve(folder, path), { recursive: true });
        await writeFile(resolve(folder, path, "index.ts"), "export const value = 1;\n");
      }
      await writeFile(resolve(folder, "vitest.config.mts"), "export const value = 1;\n");
      const { stdout } = await execFile(
        process.execPath,
        [resolve(root, "node_modules/oxlint/bin/oxlint"), ".", "--debug=files"],
        { cwd: folder },
      );
      expect(stdout.trim().replaceAll("\\", "/").split(/\r?\n/).sort()).toEqual(
        [...included.map((path) => `${path}/index.ts`), "vitest.config.mts"].sort(),
      );
    } finally {
      await rm(folder, { recursive: true, force: true });
    }
  });
});
