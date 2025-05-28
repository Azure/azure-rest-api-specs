#!/usr/bin/env node

// The original ordering of this code is pulled directly from the original at
// openapi-alps#public/rest-api-specs-scripts/src/modelValidationPipeline.ts
import * as oav from "oav";
import * as path from "path";
import * as fs from "fs";

import { consoleLogger } from "@azure-tools/specs-shared/logger";
import {
  example,
  getChangedFiles,
  swagger,
} from "@azure-tools/specs-shared/changed-files"; //getChangedFiles,
import { ReportableOavError } from "./formatting.js";

export async function checkExamples(
  rootDirectory: string,
): Promise<[number, string[], ReportableOavError[]]> {
  let errors: ReportableOavError[] = [];

  const changedFiles = await getChangedFiles({
    cwd: rootDirectory,
  });
  // const changedFiles: string[] = [
  //     "specification/cdn/resource-manager/Microsoft.Cdn/preview/2024-07-22-preview/edgeaction.json",
  //     "specification/cdn/resource-manager/Microsoft.Cdn/stable/2024-09-01/afdx.json",
  //     "specification/cdn/resource-manager/readme.md"
  // ];

  const swaggerFiles = await processFilesToSpecificationList(
    rootDirectory,
    changedFiles,
  );

  for (const swaggerFile of swaggerFiles) {
    try {
      const errorResults = await oav.validateExamples(swaggerFile, undefined);

      for (const error of errorResults || []) {
        errors.push({
          message: error.message,
          errorCode: error.code,
          file: error.exampleUrl,
          line: error.examplePosition?.line,
          column: error.examplePosition?.column,
        } as ReportableOavError);
      }
    } catch (e) {
      if (e instanceof Error) {
        consoleLogger.error(
          `Error validating examples for ${swaggerFile}: ${e.message}`,
        );
        errors.push({
          message: e.message,
          file: swaggerFile,
        } as ReportableOavError);
      } else {
        consoleLogger.error(
          `Error validating examples for ${swaggerFile}: ${e}`,
        );
        errors.push({
          message: `Unhandled error validating ${swaggerFile}: ${e}`,
          file: swaggerFile,
        } as ReportableOavError);
      }
    }
  }

  if (errors.length > 0) {
    return [1, swaggerFiles, errors];
  }
  return [0, swaggerFiles, []];
}

export async function checkSpecs(
  rootDirectory: string,
): Promise<[number, string[], ReportableOavError[]]> {
  let errors: ReportableOavError[] = [];

  const changedFiles = await getChangedFiles({
    cwd: rootDirectory,
  });
  // const changedFiles: string[] = [
  //     "specification/cdn/resource-manager/Microsoft.Cdn/preview/2024-07-22-preview/edgeaction.json",
  //     "specification/cdn/resource-manager/Microsoft.Cdn/stable/2024-09-01/afdx.json",
  //     "specification/cdn/resource-manager/readme.md"
  // ];

  const swaggerFiles = await processFilesToSpecificationList(
    rootDirectory,
    changedFiles,
  );

  for (const swaggerFile of swaggerFiles) {
    try {
      const errorResults = await oav.validateSpec(swaggerFile, undefined);
      if (errorResults.validateSpec && errorResults.validateSpec.errors) {
        for (const error of errorResults.validateSpec.errors) {
          errors.push({
            message: error.message,
            errorCode: error.code,
            file: swaggerFile,
            line: error.position?.line,
            column: error.position?.column,
          } as ReportableOavError);
        }
      }
    } catch (e) {
      if (e instanceof Error) {
        consoleLogger.error(`Error validating ${swaggerFile}: ${e.message}`);
        errors.push({
          message: e.message,
          file: swaggerFile,
        } as ReportableOavError);
      } else {
        consoleLogger.error(`Error validating ${swaggerFile}: ${e}`);
        errors.push({
          message: `Unhandled error validating ${swaggerFile}: ${e}`,
          file: swaggerFile,
        } as ReportableOavError);
      }
    }
  }

  if (errors.length > 0) {
    return [1, swaggerFiles, errors];
  }
  return [0, swaggerFiles, []];
}

export async function processFilesToSpecificationList(
  rootDirectory: string,
  files: string[],
): Promise<string[]> {
  consoleLogger.info(`Processing ${files.length} files:`);
  consoleLogger.info(files.join("\n"));

  let additionalSwaggerFiles: string[] = [];
  let resultFiles = files.filter((file) => {
    // todo: rationalize if this is even necessary given the swagger check
    // I guess this might filter out files that are not swagger files /shrug leave it for now
    if (
      file.match(/.*\/cadl-project.yaml$/gi) !== null ||
      file.match(/.*\/package.json$/gi) !== null ||
      file.match(/.*\/sdk-suppressions.yaml$/gi) !== null ||
      file.match(/.*\/suppressions.yaml$/gi) !== null ||
      file.match(/.*\/tspconfig.yaml$/gi) !== null ||
      file.match(/.*\/cspell.yaml$/gi) !== null ||
      file.match(/.*\/scenarios\/*/gi) !== null ||
      file.match(/.*(json|yaml)$/gi) == null ||
      file.match(/.*specification\/.*/gi) == null ||
      file.match(/.*\/examples\/*/gi) !== null ||
      file.match(/.*\/quickstart-templates\/*/gi) !== null
    ) {
      return false;
    }

    if (example(file)) {
      // if it's an example file, there should be a swagger file associated with it

      // from there, we need to evaluate all the swagger file paths, adding them to a dictionary
      // so we don't have to reparse multiple times as we walk this file list

      // once we have a spec model for each of the swagger files, we simply need to check their refs for the example file
      // and include the swagger file if it references the example file
    }

    const swaggerResult = swagger(file);
    const targetFile = path.join(rootDirectory, file);

    // if it's a swagger file, we should check to see if it exists
    // as a deleted file will also show up in the changed files list
    if (swaggerResult && fs.existsSync(targetFile)) {
      // finally, we should find all swagger files that are AFFECTED by the swagger file, add them to an accompanying list
      return true;
    }
    return false;
  });

  // finally, if we added any AFFECTED swagger files, we should add them to the resultFiles list
  if (additionalSwaggerFiles.length > 0) {
    consoleLogger.info(
      `Adding ${additionalSwaggerFiles.length} additional swagger files:`,
    );
    consoleLogger.info(additionalSwaggerFiles.join("\n"));
    resultFiles = resultFiles.concat(additionalSwaggerFiles);
  }

  return resultFiles;
}
