#!/usr/bin/env node

// The original ordering of this code is pulled directly from the original at
// openapi-alps#public/rest-api-specs-scripts/src/modelValidationPipeline.ts
import * as oav from "oav";
import * as path from "path";
import * as fs from "fs";

import { consoleLogger } from "@azure-tools/specs-shared/logger";
import { Swagger } from "@azure-tools/specs-shared/swagger"

import {
  example,
  getChangedFiles,
  specification,
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

async function getFiles(rootDirectory: string, directory: string): Promise<string[]> {
  const target = path.join(rootDirectory, directory);
  const items = await fs.promises.readdir(target, {
    withFileTypes: true,
  })

  return items
    .filter(d => d.isFile() && d.name.endsWith('.json'))
    .map(d => path.join(target, d.name))
    .map(d => d.replace(/^.*?(specification\/.*)$/, '$1'))
    .filter(d => {console.log(d); return specification(d);});
}

export async function processFilesToSpecificationList(
  rootDirectory: string,
  files: string[],
): Promise<string[]> {
  consoleLogger.info(`Processing ${files.length} files:`);
  consoleLogger.info(files.join("\n"));

  const viewedFiles: Map<string, string[]> = new Map();

  let additionalSwaggerFiles: string[] = [];
  let resultFiles = files.filter(async (file) => {
    consoleLogger.info(`Processing file: ${file}`);

    if (example(file)) {
      // the containing directory of the example folder is the target swagger directory
      const swaggerDirectory = path.dirname(path.dirname(file));

      consoleLogger.info(
        `Found example file: ${file}, checking for associated swagger file in directory: ${swaggerDirectory}`);

      const visibleSwaggerFiles = await getFiles(rootDirectory, swaggerDirectory);
      consoleLogger.info(
        `Found ${visibleSwaggerFiles.length} swagger files in directory: ${swaggerDirectory}`,
      );
      consoleLogger.info(visibleSwaggerFiles.join("\n"));

      visibleSwaggerFiles.forEach( async (swaggerFile) => {
        consoleLogger.info(`Checking swagger file: ${swaggerFile}`);

        if (!viewedFiles.has(swaggerFile)) {
          const swaggerModel = new Swagger(path.join(rootDirectory, swaggerFile));
          const exampleSwaggers = await swaggerModel.getExamples();
          const examples = [...exampleSwaggers].map(e => e.path);

          consoleLogger.info(
            `Found ${examples.length} examples in swagger file: ${swaggerFile}`,
          );
          viewedFiles.set(swaggerFile, examples);
        }
        else {
          consoleLogger.info(`Already viewed swagger file: ${swaggerFile}`);
        }

        // const referencedSwaggers = viewedFiles.get(swaggerFile)
        // consoleLogger.info(
        //   `Referenced swagger files for ${swaggerFile}: ${referencedSwaggers?.join("\n")}`
        // );
      });
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
