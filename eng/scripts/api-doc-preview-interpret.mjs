#!/usr/bin/env node 
import { resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";
import { readFile } from "fs/promises";


const __dirname = dirname(fileURLToPath(import.meta.url));

function usage() {
  console.log(`Usage:
npx api-doc-preview-interpret --input <path> --build-start <path>

parameters:
  --report <path>    Path to the build start JSON file. Defaults to "report.json" at repo root.
  --build-start <path> Path to the build start JSON file. Defaults to "buildstart.json" at repo root.
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
    // Strip BOM if present
    if (resultArtifactRaw.charCodeAt(0) === 0xFEFF) {
      resultArtifactRaw = resultArtifactRaw.slice(1);
    }
    if (!resultArtifactRaw.trim()) {
      throw new Error(`File "${resultArtifactPath}" is empty or contains only whitespace.`);
    }
    try {
      resultArtifactData = JSON.parse(resultArtifactRaw);
    } catch (parseError) {
      console.error(`Failed to parse JSON in file "${resultArtifactPath}": ${parseError.message}`);
      console.error("Raw file content:");
      console.error(resultArtifactRaw);
      console.error("Stack trace:");
      console.error(parseError.stack);
      usage();
      process.exitCode = 1;
      return;
    }
  } catch (error) {
    console.error(`Failed to read input file "${resultArtifactPath}": ${error.message}`);
    usage();
    process.exitCode = 1;
    return;
  }

  if (resultArtifactData.status != "Succeeded") {
    console.error(`Build failed: ${resultArtifactData.status}`);
    console.log(`Raw output:\n${resultArtifactRaw}`);
    
    // Read build ID from build start file to provide a link to build details
    const buildStartData = JSON.parse(await readFile(buildStartPath, { encoding: "utf8" }));
    const buildId = buildStartData.id;
    const buildLink = `https://dev.azure.com/apidrop/Content%20CI/_build/results?buildId=${buildId}`;
    console.error(`See build details at: ${buildLink}`);
    console.log(`##[task.logissue type=error]Error in docs build. See build details at: ${buildLink}`);

    process.exitCode = 1;
    return;
  }

  console.log(`Build completed successfully.`);
  const docsPreviewUrl = `https://review.learn.microsoft.com/en-us/rest/api/azure-rest-preview/?branch=${encodeURIComponent(resultArtifactData.branch)}&view=azure-rest-preview`
  // Log a warning to generate some output in the PR check
  console.log(`##[task.logissue type=warning]Docs build completed successfully. See preview docs at: ${docsPreviewUrl}`)
}

await main();
