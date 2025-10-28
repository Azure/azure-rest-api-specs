#!/usr/bin/env node

import {
  outputAnnotatedErrors,
  outputErrorSummary,
  outputSuccessSummary,
  ReportableOavError,
} from "./formatting.js";
import { checkExamples, checkSpecs } from "./runner.js";

import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import fs from "node:fs/promises";
import { parseArgs, ParseArgsConfig } from "node:util";
import { resolve } from "path";

export async function main() {
  const config: ParseArgsConfig = {
    options: {
      targetDirectory: {
        type: "string",
        short: "d",
        multiple: false,
        default: process.cwd(),
      },
      fileList: {
        type: "string",
        short: "f",
        multiple: false,
        default: undefined,
      },
    },
    allowPositionals: true,
  };

  const { values: opts, positionals } = parseArgs(config);
  // this option has a default value of process.cwd(), so we can assume it is always defined
  // just need to resolve that here to make ts aware of it
  const targetDirectory = opts.targetDirectory as string;

  const resolvedGitRoot = await getRootFolder(targetDirectory);

  let fileList: string[] | undefined = undefined;
  if (opts.fileList !== undefined) {
    const fileListPath = resolve(opts.fileList as string);
    try {
      const fileContent = await fs.readFile(fileListPath, { encoding: "utf-8" });
      fileList = fileContent
        .split("\n")
        .map((line) => line.trim())
        .filter((line) => line.length > 0);
      console.log(`Loaded ${fileList.length} files from ${opts.fileList}`);
    } catch (error) {
      console.error(
        `Error reading file list from ${opts.fileList}: ${error instanceof Error ? error.message : String(error)}`,
      );
      console.error("User provided file list that is not found.");
      console.error(
        "Please ensure the file exists and is readable, or do not provide the option 'fileList'",
      );
      process.exit(1);
    }
  }

  // first positional is runType
  const [runType] = positionals;

  if (runType !== "specs" && runType !== "examples") {
    console.error("Error: <runType> must be either 'specs' or 'examples'.");
    process.exit(1);
  }

  console.log(`Running oav-runner against ${runType} within ${resolvedGitRoot}.`);

  let exitCode = 0;
  let scannedSwaggerFiles: string[] = [];
  let errorList: ReportableOavError[] = [];
  let reportName = "";

  if (runType === "specs") {
    [exitCode, scannedSwaggerFiles, errorList] = await checkSpecs(resolvedGitRoot, fileList);
    reportName = "Swagger SemanticValidation";
  } else if (runType === "examples") {
    [exitCode, scannedSwaggerFiles, errorList] = await checkExamples(resolvedGitRoot, fileList);
    reportName = "Swagger ModelValidation";
  }

  if (errorList.length > 0) {
    // print the errors so that they will annotate the files on github UI interface
    outputAnnotatedErrors(errorList);

    // print the errors in a summary report that we can later output to
    outputErrorSummary(errorList, reportName);
  } else {
    outputSuccessSummary(scannedSwaggerFiles, reportName);
  }

  process.exit(exitCode);
}
