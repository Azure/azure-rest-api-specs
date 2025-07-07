#!/usr/bin/env node 
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";
import { execFile } from "../../.github/shared/src/exec.js";
import { readFile } from "fs";

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
    values: {
      "input": buildStartPath,
    },
  } = parseArgs({
    options: {
      "input": { 
        type: "string",
        default: resolve(__dirname, "../../buildstart.json"),
      },
    },
    allowPositionals: false,
  });

  let buildStartData, buildId;
  try { 
    buildStartData = JSON.parse(await readFile(buildStartPath, "utf8"));
    buildId = buildStartData.id;
  } catch (error) { 
    console.error(`Failed to read or parse input file "${buildStartPath}": ${error.message}`);
    usage();
    process.exitCode = 1;
    return;
  }

  const buildIdentifiers = [ 
    "--organization", "https://dev.azure.com/apidrop/",
    "--project", "Content CI",
    "--id", buildId,
  ];
  let status = null;

  while (status !== "completed") {
    try {
      // TODO: Query?
      const { stdout, } = await execFile(
        "az", 
        [
          "pipelines", "runs", "show",
          ...buildIdentifiers,
        ],
      );

      const run = JSON.parse(stdout);
      status = run.status;

      console.log(`Build ${buildId} status: ${status}`);

      // Sleep 10 seconds to avoid calling the API too frequently
      await new Promise(resolve => setTimeout(resolve, 10_000));

    } catch (error) {
      console.error(`Failed to check build status: ${error.message}`);
      if (error.stdout) {
        console.error(`Command output:\n${error.stdout}`);
      }
      if (error.stderr) {
        console.error(`Command error output:\n${error.stderr}`);
      }
    }
  }
  console.log(`Build ${buildId} completed.`);

  console.log("Downloading artifact...");
  try {
    await execFile(
      "az",
      [
        "pipelines", "runs", "artifact", "download",
        ...buildIdentifiers,
        "--artifact-name", "report",
        "--path", resolve(__dirname, "../../"),
      ],
    );
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

  console.log("##vso[task.setvariable variable=DocsBuildFinished;]true");
}

await main();
