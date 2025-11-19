import { execNpmExec } from "@azure-tools/specs-shared/exec";
import { debugLogger } from "@azure-tools/specs-shared/logger";

import { access, constants, mkdir, rm } from "fs/promises";
import { dirname, join } from "path";
import { ExpectStatic, test } from "vitest";

const repoRoot = join(__dirname, "..", "..", "..", "..");

const options = { cwd: repoRoot, logger: debugLogger };

async function convert(expect: ExpectStatic, readme: string) {
  const resMan = readme.includes("resource-manager");
  const specFolder = dirname(dirname(join(repoRoot, readme)));
  const tspFolder = "Test.TspClientConvert" + (resMan ? ".Management" : "");
  const outputFolder = join(specFolder, tspFolder);

  try {
    await mkdir(outputFolder);
  } catch {
    // Delete and retry
    await rm(outputFolder, { recursive: true, force: true });
    await mkdir(outputFolder);
  }

  try {
    let result = await execNpmExec(
      [
        "tsp-client",
        "convert",
        "--no-prompt",
        "--swagger-readme",
        readme,
        "-o",
        outputFolder,
        resMan ? "--arm" : "",
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
    result = await execNpmExec(["tsp", "compile", "--no-emit", outputFolder], options);

    expect(result.stdout).toContain("TypeSpec compiler");
  } finally {
    await rm(outputFolder, { recursive: true, force: true });
  }

  // Ensure outputFolder is deleted
  await expect(() => access(outputFolder)).rejects.toThrowError();
}

test.concurrent("Usage", async ({ expect }) => {
  await expect(execNpmExec(["tsp-client"], options)).rejects.toThrow("Usage");
});

// Disabled since tsp-client is failing on data-plane
test.skip.concurrent("Convert contosowidgetmanager/data-plane", async ({ expect }) => {
  await convert(expect, "specification/contosowidgetmanager/data-plane/readme.md");
});

test.concurrent("Convert contosowidgetmanager/resource-manager", async ({ expect }) => {
  await convert(expect, "specification/contosowidgetmanager/resource-manager/readme.md");
});
