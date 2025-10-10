import { sortOpenAPIDocument } from "@azure-tools/typespec-autorest";
import fs from "fs";
import { diff } from "json-diff";
import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import { configuration } from "./configuration.js";
import { processDocument } from "./document.js";
import { generatePrompts } from "./fix/troubleshooting.js";
import { mergeFiles, readFileContent } from "./helper.js";
import { addIgnorePath, processIgnoreList } from "./ignore.js";
import { jsonOutput } from "./jsonOutput.js";
import { logError, logHeader, logWarning } from "./log.js";
import {
  findChangedPaths,
  findDifferences,
  findModifiedValues,
  formatChangedPathsReport,
  formatDifferenceReport,
  formatModifiedValuesReport,
} from "./summary.js";
import { compareDocuments, printDiff } from "./compare.js";
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
            alias: "p",
            describe: "JSON path to ignore",
            type: "string",
            demandOption: true,
          })
          .option("outputFolder", {
            alias: "out",
            describe: "Output folder containing ignore.json",
            type: "string",
            demandOption: true,
          });
      },
      (argv) => {
        handleAddIgnore(argv.path as string, argv.outputFolder as string);
      },
    )
    .example(
      "$0 --oldPath ./old-spec-folder --newPath ./new-spec-file",
      "Compare two swagger specs",
    )
    .example("$0 oldSpecPath newSpecPath", "Compare using positional arguments")
    .example(
      "$0 --oldPath ./old-spec --newPath ./new-spec --reportFile ./custom-report.md",
      "Compare specs with custom report file",
    )
    .example(
      "$0 --oldPath ./old-spec --newPath ./new-spec --outputFolder ./validation-results",
      "Compare specs with custom output folder",
    )
    .example(
      "$0 --oldPath ./old-spec --newPath ./new-spec --ignoreDefinitionCase",
      "Compare specs with case-insensitive definition sorting",
    )
    .example(
      "$0 add-ignore --path \"paths['/api/resource'].put.parameters[0].required__added\" --outputFolder ./results",
      "Add a path to ignore file",
    )
    .option("oldPath", {
      alias: "o",
      describe: "Path to old/original Swagger specification folder",
      type: "string",
    })
    .option("newPath", {
      alias: "n",
      describe: "Path to new/updated Swagger specification file",
      type: "string",
    })
    .option("outputFolder", {
      alias: "out",
      describe: "Output folder for analysis results",
      type: "string",
    })    
    .option("reportFile", {
      alias: "r",
      describe: "Path to the report file",
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

export async function main() {
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
  const newFile = JSON.parse(readFileContent(newPath!).toString());
  const processedNewFile = processDocument(newFile);
  let sortedNewFile = sortOpenAPIDocument(processedNewFile);
  if (configuration.ignoreDefinitionCase) {
    sortedNewFile = sortDefinitionsCaseInsensitive(sortedNewFile);
  }

  logHeader("Comparing old and new Swagger files...");
  if (outputFolder) {
    const ignoreFilePath = `${outputFolder}/ignore.json`;
    if (fs.existsSync(ignoreFilePath)) {
      logHeader(`Processing ignore file...`);
      const ignoreFileContent = JSON.parse(fs.readFileSync(ignoreFilePath, "utf-8"));
      for (const path of ignoreFileContent) {
        addIgnorePath(path);
      }

      processIgnoreList(sortedOldFile, sortedNewFile);
    }

    fs.writeFileSync(
      `${outputFolder}/oldNormalizedSwagger.json`,
      JSON.stringify(sortedOldFile, null, 2),
    );
    fs.writeFileSync(
      `${outputFolder}/newNormalizedSwagger.json`,
      JSON.stringify(sortedNewFile, null, 2),
    );
  }
  logHeader("Comparing finished.");

  let outputMarkdown = "";
  const compareResult = compareDocuments(
    mergedOldfile,
    newFile,
  );
  if (compareResult.length === 0) {
    logHeader("No differences found.");
  }
  else {
    outputMarkdown += "| Type | Level | Message |\n";
    outputMarkdown += "| ---- | ----- | ------- |\n";
    for (const diff of compareResult) {
      outputMarkdown += printDiff(diff);
    }
    console.log(outputMarkdown);
  }  

  if (outputFolder) {
    let report: string = "";
    const diffForFile = diff(sortedOldFile, sortedNewFile);
    if (diffForFile === undefined || Object.keys(diffForFile).length === 0) {
      return;
    }      

    // // TO-DELETE: Read the diff file from disk
    // const diffForFile = JSON.parse(fs.readFileSync(`C:/Users/pashao/GIT/azure-rest-api-specs/specification/agrifood/validation-results/diff.json`, 'utf-8'));

    const changedPaths = findChangedPaths(diffForFile);
    if (changedPaths.length > 0) {
      logWarning(
        `Found ${changedPaths.length} changed paths in the diff.`,
      );
      const changedPathsReport = formatChangedPathsReport(changedPaths);
      report += changedPathsReport;
    }

    const differences = findDifferences(diffForFile);
    const differencesReport = formatDifferenceReport(differences);
    report += differencesReport;

    const modifiedValues = findModifiedValues(diffForFile);
    const modifiedValuesReport = formatModifiedValuesReport(modifiedValues);
    report += modifiedValuesReport;

    if (diffForFile) {
      fs.writeFileSync(`${outputFolder}/diff.json`, JSON.stringify(diffForFile, null, 2));
      fs.writeFileSync(`${outputFolder}/API_CHANGES.md`, report);
      logHeader(`Difference report written to ${outputFolder}/API_CHANGES.md`);

      const suggestedPrompt = generatePrompts(diffForFile);
      if (suggestedPrompt.length > 0) {
        logWarning(`Considering these suggested prompts for the diff:`);
        suggestedPrompt.forEach((prompt) => {
          console.log(prompt);
        });
      }
    }
    
    if (args.jsonOutput) {
      fs.writeFileSync(`${outputFolder}/tsmv_output.json`, JSON.stringify(jsonOutput, null, 2));
      logHeader(`JSON output written to ${outputFolder}/tsmv_output.json`);
      console.log(
        `---- Start of Json Output ----\n${JSON.stringify(jsonOutput, null, 2)}\n---- End of Json Output ----`,
      );
    }
  }
  else if (reportFile) {
    if (compareResult.length > 0) {
      await writeFile(reportFile, outputMarkdown);
    }
    if (compareResult.filter((x) => x.level === "error").length > 0) {
      logError("Differences found. Please fix the issues before proceeding.");
      process.exit(1);
    }
  }
}
