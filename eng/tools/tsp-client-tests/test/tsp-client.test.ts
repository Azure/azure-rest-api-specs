import { execa } from "execa";
import { access, constants, mkdir, rm } from "fs/promises";
import { dirname, join } from "path";
import { ExpectStatic, test } from "vitest";

const repoRoot = join(__dirname, "..", "..", "..", "..");

async function tspClient(...args: string[]) {
  const execArgs = ["exec", "--no", "--", "tsp-client"];
  return await execa("npm", execArgs.concat(args), { cwd: repoRoot, reject: false });
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
    const { stdout, exitCode } = await tspClient(
      "convert",
      "--no-prompt",
      "--swagger-readme",
      readme,
      "-o",
      outputFolder,
    );

    expect(stdout).toContain("Converting");
    expect(exitCode).toBe(0);

    // Ensure generated files tspconfig.yaml and main.tsp exist
    await access(join(outputFolder, "tspconfig.yaml"), constants.R_OK);
    await access(join(outputFolder, "main.tsp"), constants.R_OK);
  } finally {
    await rm(outputFolder, { recursive: true, force: true });
  }
}

test.concurrent("Usage", async ({ expect }) => {
  const { stdout, exitCode } = await tspClient();

  expect(stdout).toContain("Usage");
  expect(exitCode).not.toBe(0);
});

test.concurrent("Convert keyvault/data-plane", async ({ expect }) => {
  await convert(expect, "specification/keyvault/data-plane/readme.md");
});
