#!/usr/bin/env node
// @ts-check
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";
import { readFile } from "fs/promises";


const __dirname = dirname(fileURLToPath(import.meta.url));

function usage() {
  console.log(`Usage:
npx api-doc-preview-interpret --input <path> --build-start <path>

parameters:
  --report <path>       Path to the build start JSON file. Defaults to "report.json" at repo root.
  --build-start <path>  Path to the build start JSON file. Defaults to "buildstart.json" at repo root.
`);
}

export async function main() {
  const {
    values: {
      "report": resultArtifactPath,
      "build-start": buildStartPath,
    },
  } = parseArgs({
    options: {
      "report": { 
        type: "string",
        default: resolve(__dirname, "../../report.json"),
      },
      "build-start": {
        type: "string",
        default: resolve(__dirname, "../../buildstart.json"),
      },
    },
    allowPositionals: false,
  });

  let resultArtifactData, resultArtifactRaw;
  try {
    // TODO: CLEANUP
    resultArtifactRaw = await readFile(resultArtifactPath, { encoding: "utf8" });
    // Use .trim() to remove BOM which can be present in the JSON file
    resultArtifactData = JSON.parse(resultArtifactRaw.trim());

  } catch (error) {
    console.error(`Failed to read input file "${resultArtifactPath}": ${error.message}`);
    usage();
    process.exitCode = 1;
    return;
  }

  // Read build ID from build start file to provide a link to build details
  const buildStartRaw = await readFile(buildStartPath, { encoding: "utf8" });
  const buildStartData = JSON.parse(buildStartRaw.trim());
  const buildId = buildStartData.id;
  const buildLink = `https://dev.azure.com/apidrop/Content%20CI/_build/results?buildId=${buildId}`;
  console.log(`Build Details: ${buildLink}`);

  if (resultArtifactData.status != "Succeeded") {
    console.log(`Build failed: ${resultArtifactData.status}`);

    console.log(`##[task.setvariable variable=CheckUrl]${buildLink}`);
    console.log("##[task.setvariable variable=CheckDescription]Docs build failed");
    console.log(`##[task.setvariable variable=CheckState]failure`);
    console.log(`Raw output:\n${resultArtifactRaw}`);
    console.log(`Build details: ${buildLink}`);
    return;
  }

  console.log(`Build completed successfully.`);

  const docsPreviewUrl = `https://review.learn.microsoft.com/en-us/rest/api/azure-rest-preview/?branch=${encodeURIComponent(resultArtifactData.branch)}&view=azure-rest-preview`
  console.log(`##[task.setvariable variable=CheckUrl]${docsPreviewUrl}`);
  console.log("##[task.setvariable variable=CheckDescription]Docs build succeeded");
  console.log(`##[task.setvariable variable=CheckState]success`);
  console.log(`Docs preview URL: ${docsPreviewUrl}`);
}

await main();
