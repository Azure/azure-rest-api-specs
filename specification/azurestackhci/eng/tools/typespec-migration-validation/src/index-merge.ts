import { sortOpenAPIDocument } from "@azure-tools/typespec-autorest";
import fs from "fs";
import { diff } from "json-diff";
import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import { configuration } from "./configuration.js";
import { processDocument } from "./document.js";
import { generatePrompts } from "./fix/troubleshooting.js";
import { mergeFiles, readFileContent } from "./helper.js";
import { processIgnoreList } from "./ignore.js";
import { logHeader } from "./log.js";
import {
  findChangedPaths,
  findDifferences,
  findModifiedValues,
  formatChangedPathsReport,
  formatDifferenceReport,
  formatModifiedValuesReport,
} from "./summary.js";
import { writeFile } from "fs/promises";

function parseArguments() {
  return yargs(hideBin(process.argv))
    .usage("Usage: $0 [options]")
    .command(
      "add-ignore",
      "Add paths to ignore file",
      (yargs) => {
        return yargs
          .option("path", {
            description: "JSON path to add to ignore file",
            type: "string",
            demandOption: true,
          })
          .option("outputFolder", {
            description: "Output folder containing ignore.json",
            type: "string",
            default: ".",
          });
      },
      (argv) => {
        handleAddIgnore(argv.path, argv.outputFolder);
      }
    )
    .option("oldPath", {
      alias: "o",
      description: "Path to old/original Swagger specification folder",
      type: "string",
    })
    .option("newPath", {
      alias: "n", 
      description: "Path to new/updated Swagger specification folder (will merge all files)",
      type: "string",
    })
    .option("outputFolder", {
      alias: "out",
      description: "Output folder for analysis results",
      type: "string",
    })
    .option("reportFile", {
      alias: "r",
      description: "Path to the report file",
      type: "string",
    })
    .option("ignoreDescription", {
      description: "Ignore description differences",
      type: "boolean",
      default: true,
    })
    .option("ignorePathCase", {
      description: "Set case insensitive for the segments before provider, e.g. resourceGroups",
      type: "boolean",
    })
    .option("ignoreDefinitionCase", {
      description: "Sort definitions case-insensitively. Use this when definitions in Swagger specification is not in PascalCase.",
      type: "boolean",
    })
    .option("jsonOutput", {
      description: "Also output in JSON format",
      type: "boolean",
    })
    .check((argv) => {
      // Skip validation for the add-ignore command
      if (argv._[0] === "add-ignore") {
        return true;
      }

      const positional = argv._;
      if (!argv.oldPath && positional.length > 0) {
        argv.oldPath = positional[0]!.toString();
      }
      if (!argv.newPath && positional.length > 1) {
        argv.newPath = positional[1]!.toString();
      }

      if (!argv.oldPath || !argv.newPath) {
        throw new Error("Both oldPath and newPath are required");
      }

      // Verify paths exist
      if (!fs.existsSync(argv.oldPath)) {
        throw new Error(`oldPath does not exist: ${argv.oldPath}`);
      }

      if (!fs.existsSync(argv.newPath)) {
        throw new Error(`newPath does not exist: ${argv.newPath}`);
      }

      return true;
    })
    .help()
    .alias("help", "h")
    .parseSync();
}

/**
 * Handles the add-ignore command by adding a new path to the ignore.json file
 * @param path JSON path to ignore
 * @param outputFolder Output folder containing ignore.json
 */
function handleAddIgnore(path: string, outputFolder: string) {
  const ignoreFilePath = `${outputFolder}/ignore.json`;
  let ignoreList: string[] = [];

  // Create output folder if it doesn't exist
  if (!fs.existsSync(outputFolder)) {
    fs.mkdirSync(outputFolder, { recursive: true });
  }

  // Read existing ignore file if present
  if (fs.existsSync(ignoreFilePath)) {
    ignoreList = JSON.parse(fs.readFileSync(ignoreFilePath, "utf-8"));
  }

  // Add new path if not already present
  if (!ignoreList.includes(path)) {
    ignoreList.push(path);
    fs.writeFileSync(ignoreFilePath, JSON.stringify(ignoreList, null, 2));
    console.log(`Added path "${path}" to ignore list in ${ignoreFilePath}`);
  } else {
    console.log(`Path "${path}" already exists in ignore list`);
  }

  process.exit(0);
}

/**
 * Sorts the definitions object case-insensitively
 * @param document OpenAPI document to sort definitions for
 * @returns Document with case-insensitively sorted definitions
 */
function sortDefinitionsCaseInsensitive(document: any): any {
  if (!document.definitions) {
    return document;
  }

  const sortedDefinitions: any = {};
  const definitionKeys = Object.keys(document.definitions);

  // Sort keys case-insensitively
  const sortedKeys = definitionKeys.sort((a, b) =>
    a.toLowerCase().localeCompare(b.toLowerCase())
  );

  // Rebuild definitions object with sorted keys
  for (const key of sortedKeys) {
    sortedDefinitions[key] = document.definitions[key];
  }

  return {
    ...document,
    definitions: sortedDefinitions
  };
}

export async function mainWithMerge() {
  const args = parseArguments();

  // If using add-ignore command, the command handler will exit the process

  const { oldPath, newPath, reportFile, outputFolder, ignoreDescription, ignorePathCase, ignoreDefinitionCase } = args;
  configuration.ignoreDescription = ignoreDescription;
  if (ignorePathCase !== undefined) {
    configuration.ignorePathCase = ignorePathCase;
  }
  if (ignoreDefinitionCase !== undefined) {
    configuration.ignoreDefinitionCase = ignoreDefinitionCase;
  }

  logHeader(`Processing old swagger from: ${oldPath}...`);
  const mergedOldfile = mergeFiles(oldPath!);
  const processedOldFile = processDocument(mergedOldfile);
  let sortedOldFile = sortOpenAPIDocument(processedOldFile);
  if (configuration.ignoreDefinitionCase) {
    sortedOldFile = sortDefinitionsCaseInsensitive(sortedOldFile);
  }

  logHeader(`Processing new swagger from: ${newPath}...`);
  
  // Check if newPath is a file or directory
  const stats = fs.statSync(newPath!);
  let newFile;
  
  if (stats.isDirectory()) {
    logHeader(`Merging all files from directory: ${newPath}`);
    newFile = mergeFiles(newPath!);
  } else {
    logHeader(`Reading single file: ${newPath}`);
    newFile = JSON.parse(readFileContent(newPath!).toString());
  }
  
  const processedNewFile = processDocument(newFile);
  let sortedNewFile = sortOpenAPIDocument(processedNewFile);
  if (configuration.ignoreDefinitionCase) {
    sortedNewFile = sortDefinitionsCaseInsensitive(sortedNewFile);
  }

  logHeader("");
  logHeader("Comparing old and new Swagger files...");

  const differences = diff(sortedOldFile, sortedNewFile);

  // If outputFolder is specified, ensure it exists
  const actualOutputFolder = outputFolder || ".";
  if (!fs.existsSync(actualOutputFolder)) {
    fs.mkdirSync(actualOutputFolder, { recursive: true });
  }

  // Write normalized files to output folder for debugging
  await writeFile(`${actualOutputFolder}/oldNormalizedSwagger.json`, JSON.stringify(sortedOldFile, null, 2));
  await writeFile(`${actualOutputFolder}/newNormalizedSwagger.json`, JSON.stringify(sortedNewFile, null, 2));

  if (differences) {
    await writeFile(`${actualOutputFolder}/diff.json`, JSON.stringify(differences, null, 2));

    const ignoredDifferences = processIgnoreList(differences);

    const modifiedValues = findModifiedValues(ignoredDifferences);
    const changedPaths = findChangedPaths(ignoredDifferences);
    const foundDifferences = findDifferences(ignoredDifferences);

    logHeader("");
    logHeader("Comparing finished.");

    const modifiedValuesReport = formatModifiedValuesReport(modifiedValues);
    const changedPathsReport = formatChangedPathsReport(changedPaths);
    const differenceReport = formatDifferenceReport(foundDifferences);

    const combinedReport = `${modifiedValuesReport}\n${changedPathsReport}\n${differenceReport}`;

    console.log(combinedReport);

    const actualReportFile = reportFile || `${actualOutputFolder}/API_CHANGES.md`;
    await writeFile(actualReportFile, combinedReport);

    if (args.jsonOutput) {
      const jsonReportFile = actualReportFile.replace(/\.md$/, '.json');
      const jsonReport = {
        modifiedValues,
        changedPaths,
        differences: foundDifferences
      };
      await writeFile(jsonReportFile, JSON.stringify(jsonReport, null, 2));
    }

    logHeader("");
    logHeader(`Found ${changedPaths.length} changed paths in the diff.`);
    logHeader("");
    logHeader(`Difference report written to ${actualReportFile}`);

    if (modifiedValues.size > 0 || changedPaths.length > 0 || foundDifferences.length > 0) {
      await generatePrompts(actualOutputFolder);
    }
  } else {
    logHeader("No differences found between the old and new Swagger files.");
  }
}
