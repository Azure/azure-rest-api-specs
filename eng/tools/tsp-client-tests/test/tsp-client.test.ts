import { execa } from "execa";
import { access, constants, mkdir, rm } from "fs/promises";
import { dirname, join } from "path";
import { ExpectStatic, test } from "vitest";

const repoRoot = join(__dirname, "..", "..", "..", "..");

async function npmExec(...args: string[]) {
  const allArgs = ["exec", "--no", "--"].concat(args);
  console.log(`${repoRoot}$ npm ${allArgs.join(" ")}`);

  const result = await execa("npm", allArgs, { all: true, cwd: repoRoot, reject: false });
  console.log(result.all);
  return result;
}

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
    let { stdout, all, exitCode } = await npmExec(
      "tsp-client",
      "convert",
      "--no-prompt",
      "--swagger-readme",
      readme,
      "-o",
      outputFolder,
      resMan ? "--arm" : "",
    );

    expect(stdout).toContain("Converting");
    expect(exitCode, all).toBe(0);

    const tspConfigYaml = join(outputFolder, "tspconfig.yaml");
    await access(tspConfigYaml, constants.R_OK);
    console.log(`File exists: ${tspConfigYaml}`);

    const mainTsp = join(outputFolder, "main.tsp");
    await access(mainTsp, constants.R_OK);
    console.log(`File exists: ${mainTsp}`);

    // Use "--no-emit" to avoid generating output files that would need to be cleaned up
    ({ stdout, all, exitCode } = await npmExec("tsp", "compile", "--no-emit", outputFolder));

    expect(stdout).toContain("TypeSpec compiler");
    expect(exitCode, all).toBe(0);
  } finally {
    await rm(outputFolder, { recursive: true, force: true });
  }

  // Ensure outputFolder is deleted
  await expect(() => access(outputFolder)).rejects.toThrowError();
}

test.concurrent("Usage", async ({ expect }) => {
  const { all, exitCode } = await npmExec("tsp-client");

  expect(all).toContain("Usage");
  expect(exitCode).not.toBe(0);
});

// Disabled since tsp-client is failing on data-plane
test.skip.concurrent("Convert contosowidgetmanager/data-plane", async ({ expect }) => {
  await convert(expect, "specification/contosowidgetmanager/data-plane/readme.md");
});

test.concurrent("Convert contosowidgetmanager/resource-manager", async ({ expect }) => {
  await convert(expect, "specification/contosowidgetmanager/resource-manager/readme.md");
});
