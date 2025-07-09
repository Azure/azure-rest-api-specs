#!/usr/bin/env node
// @ts-check
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";
import { execFile } from "../../.github/shared/src/exec.js";
import { /* @type {string} */ readFile } from "fs/promises";

const __dirname = dirname(fileURLToPath(import.meta.url));

function usage() {
  console.log(`Usage:
node api-doc-preview-wait.mjs --input <path>

parameters:
  --input <path>    Path to the build start JSON file. Defaults to "buildstart.json" at repo root.
`);
}

export async function main() {
  const {
    values: { input: buildStartPath },
  } = parseArgs({
    options: {
      input: {
        type: "string",
        default: resolve(__dirname, "../../buildstart.json"),
      },
    },
    allowPositionals: false,
  });

  let buildStartData, buildId;
  try {
    buildStartData = JSON.parse(
      await readFile(buildStartPath, { encoding: "utf8" }),
    );
    buildId = buildStartData.id;
  } catch (error) {
    console.error(
      `Failed to read or parse input file "${buildStartPath}": ${error.message}`,
    );
    usage();
    process.exitCode = 1;
    return;
  }

  const devOpsIdentifiers = [
    "--organization",
    "https://dev.azure.com/apidrop/",
    "--project",
    "Content CI",
  ];

  while (true) {
    try {
      const { stdout } = await execFile("az", [
        "pipelines",
        "runs",
        "show",
        ...devOpsIdentifiers,
        "--id",
        buildId,
      ]);

      const run = JSON.parse(stdout);
      const status = run.status;

      console.log(`Build ${buildId} status: ${status}`);
      if (status === "completed") {
        break;
      }

      // Sleep 10 seconds to avoid calling the API too frequently
      await new Promise((resolve) => setTimeout(resolve, 10_000));
    } catch (error) {
      console.error(`Failed to check build status: ${error.message}`);
      if (error.stdout) {
        console.error(`Command output:\n${error.stdout}`);
      }
      if (error.stderr) {
        console.error(`Command error output:\n${error.stderr}`);
      }

      throw error;
    }
  }
  console.log(`Build ${buildId} completed.`);

  console.log("Downloading artifact...");
  try {
    await execFile("az", [
      "pipelines",
      "runs",
      "artifact",
      "download",
      ...devOpsIdentifiers,
      "--run-id",
      buildId,
      "--artifact-name",
      "report",
      "--path",
      resolve(__dirname, "../../"),
    ]);
  } catch (error) {
    console.error(`Failed to download artifact: ${error.message}`);
    if (error.stdout) {
      console.error(`Command output:\n${error.stdout}`);
    }
    if (error.stderr) {
      console.error(`Command error output:\n${error.stderr}`);
    }
    process.exitCode = 1;
    return;
  }
}

await main();
