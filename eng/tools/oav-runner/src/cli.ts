#!/usr/bin/env node

import { checkSpecs } from './main.js';
import { outputAnnotatedErrors, outputSummaryReport } from './formatting.js';
import { consoleLogger } from '@azure-tools/specs-shared/logger';

const [ , , targetDir ] = process.argv;
// todo: properly parse arguments.
//   accept a directory that we will git diff within or a list of files.
//   parse a second argument into runSpecs or runExamples
if (!targetDir) {
  consoleLogger.error('Usage: oav-runner <targetDirectory>');
  process.exit(1);
}
else {
    consoleLogger.info(`Running oav-runner on ${targetDir}`);
    const [exitCode, errorList] = await checkSpecs(targetDir);

    if (errorList){
      // print the errors so that they will annotate the files on github UI interface
      outputAnnotatedErrors(errorList);

      // print the errors in a summary report that we can later output to
      outputSummaryReport(errorList);
    }

    process.exit(exitCode);
}