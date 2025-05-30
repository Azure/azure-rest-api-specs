#!/usr/bin/env node

import { checkSpecs, checkExamples } from "./runner.js";
import {
  outputAnnotatedErrors,
  outputErrorSummary,
  outputSuccessSummary,
  ReportableOavError,
} from "./formatting.js";
import { consoleLogger } from "@azure-tools/specs-shared/logger";

import { parseArgs, ParseArgsConfig } from "node:util";

export async function main() {
  const config: ParseArgsConfig = {
    options: {},
    allowPositionals: true,
  };

  const { positionals } = parseArgs(config);

  const [targetDirectory, runType] = positionals;

  if (!targetDirectory) {
    console.error("Error: <targetDirectory> is required.");
    process.exit(1);
  }

  if (runType !== "specs" && runType !== "examples") {
    console.error("Error: <runType> must be either 'specs' or 'examples'.");
    process.exit(1);
  }

  consoleLogger.info(
    `Running oav-runner against ${runType} within ${targetDirectory}.`,
  );

  let exitCode = 0;
  let scannedSwaggerFiles: string[] = [];
  let errorList: ReportableOavError[] = [];
  let reportName = "";

  if (runType === "specs") {
    [exitCode, scannedSwaggerFiles, errorList] =
      await checkSpecs(targetDirectory);
    reportName = "Swagger Specifications Validation";
  } else if (runType === "examples") {
    [exitCode, scannedSwaggerFiles, errorList] =
      await checkExamples(targetDirectory);
    reportName = "Swagger Examples Validation";
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
