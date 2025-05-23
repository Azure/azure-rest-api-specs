#!/usr/bin/env node

import { checkSpecs } from './runner.js';
import { outputAnnotatedErrors, outputErrorSummary, outputSuccessSummary } from './formatting.js';
import { consoleLogger } from '@azure-tools/specs-shared/logger';

export async function main() {
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
        const [exitCode, swaggerFiles, errorList] = await checkSpecs(targetDir);

        if (errorList.length > 0){
          // print the errors so that they will annotate the files on github UI interface
          outputAnnotatedErrors(errorList);

          // print the errors in a summary report that we can later output to
          outputErrorSummary(errorList);
        }
        else {
            outputSuccessSummary(swaggerFiles);
        }

        process.exit(exitCode);
    }
}
