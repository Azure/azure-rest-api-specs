import { execPnpmExec } from "@azure-tools/specs-shared/exec";
import { debugLogger } from "@azure-tools/specs-shared/logger";

import { access, constants, mkdtemp, rm } from "fs/promises";
import { join } from "path";
import { test } from "vitest";

const repoRoot = join(import.meta.dirname, "..", "..", "..", "..");

const options = { cwd: repoRoot, logger: debugLogger };

test.concurrent("Usage", async ({ expect }) => {
  await expect(execPnpmExec(["tsp-client"], options)).rejects.toThrow("Usage");
});

test.concurrent("Convert resource-manager fixture", async ({ expect }) => {
  const readme = join(import.meta.dirname, "fixtures", "resource-manager", "readme.md");
  // Keep generated files under the package so compilation resolves the workspace dependencies.
  const outputFolder = await mkdtemp(join(import.meta.dirname, "tsp-client-convert-"));

  try {
    let result = await execPnpmExec(
      [
        "tsp-client",
        "convert",
        "--no-prompt",
        "--swagger-readme",
        readme,
        "-o",
        outputFolder,
        "--arm",
      ],
      options,
    );

    expect(result.stdout).toContain("Converting");

    const tspConfigYaml = join(outputFolder, "tspconfig.yaml");
    await access(tspConfigYaml, constants.R_OK);
    console.log(`File exists: ${tspConfigYaml}`);

    const mainTsp = join(outputFolder, "main.tsp");
    await access(mainTsp, constants.R_OK);
    console.log(`File exists: ${mainTsp}`);

    // Use "--no-emit" to avoid generating output files that would need to be cleaned up
    result = await execPnpmExec(["tsp", "compile", "--no-emit", outputFolder], options);

    expect(result.stdout).toContain("TypeSpec compiler");
  } finally {
    await rm(outputFolder, { recursive: true, force: true, maxRetries: 5, retryDelay: 100 });
  }

  // Ensure outputFolder is deleted
  await expect(() => access(outputFolder)).rejects.toThrowError();
});
