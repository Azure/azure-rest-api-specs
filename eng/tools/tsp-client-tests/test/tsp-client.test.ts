import { execa } from "execa";
import { access, constants, mkdir, rm } from "fs/promises";
import { dirname, join } from "path";
import { ExpectStatic, test } from "vitest";

const repoRoot = join(__dirname, "..", "..", "..", "..");

async function npmExec(...args: string[]) {
  const allArgs = ["exec", "--no", "--"].concat(args);

  console.log(`${repoRoot}$ npm ${allArgs.join(" ")}`);

  return await execa("npm", allArgs, { all: true, cwd: repoRoot, reject: false });
}

async function convert(expect: ExpectStatic, readme: string) {
  const specFolder = dirname(dirname(join(repoRoot, readme)));
  const outputFolder = join(specFolder, "Test.TspClientConvert");

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
      readme.includes("resource-manager") ? "--arm" : "",
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
  expect(() => access(outputFolder)).rejects.toThrowError();
}

test.concurrent("Usage", async ({ expect }) => {
  const { stdout, exitCode } = await npmExec("tsp-client");

  expect(stdout).toContain("Usage");
  expect(exitCode).not.toBe(0);
});

test.concurrent("Convert keyvault/data-plane", async ({ expect }) => {
  await convert(expect, "specification/keyvault/data-plane/readme.md");
});

test.concurrent("Convert sphere/resource-manager", async ({ expect }) => {
  await convert(expect, "specification/sphere/resource-manager/readme.md");
});
