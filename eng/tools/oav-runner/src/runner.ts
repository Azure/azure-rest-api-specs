#!/usr/bin/env node

import * as fs from "fs";
import * as oav from "oav";
import * as path from "path";

import {
  example,
  getChangedFiles,
  preview,
  stable,
  swagger,
} from "@azure-tools/specs-shared/changed-files";
import { untilLastSegment } from "@azure-tools/specs-shared/path";
import { Swagger } from "@azure-tools/specs-shared/swagger";
import { ReportableOavError } from "./formatting.js";

export async function preCheckFiltering(
  rootDirectory: string,
  fileList?: string[],
): Promise<string[]> {
  const changedFiles =
    fileList ?? (await getChangedFiles({ cwd: rootDirectory, paths: ["specification"] }));

  const swaggerFiles = await processFilesToSpecificationList(rootDirectory, changedFiles);

  console.log("oav-runner is checking the following specification rooted files:");
  swaggerFiles.forEach((file) => console.log(`- ${file}`));

  return swaggerFiles;
}

export async function checkExamples(
  rootDirectory: string,
  fileList?: string[],
): Promise<[number, string[], ReportableOavError[]]> {
  let errors: ReportableOavError[] = [];

  const swaggerFiles = await preCheckFiltering(rootDirectory, fileList);

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
        console.log(`Error validating examples for ${swaggerFile}: ${e.message}`);
        errors.push({
          message: e.message,
          file: swaggerFile,
        } as ReportableOavError);
      } else {
        console.log(`Error validating examples for ${swaggerFile}: ${e}`);
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
  fileList?: string[],
): Promise<[number, string[], ReportableOavError[]]> {
  let errors: ReportableOavError[] = [];

  const swaggerFiles = await preCheckFiltering(rootDirectory, fileList);

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
        console.log(`Error validating ${swaggerFile}: ${e.message}`);
        errors.push({
          message: e.message,
          file: swaggerFile,
        } as ReportableOavError);
      } else {
        console.log(`Error validating ${swaggerFile}: ${e}`);
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

  let items: fs.Dirent[];
  try {
    items = await fs.promises.readdir(target, {
      withFileTypes: true,
    });
  } catch (error) {
    if ((error as NodeJS.ErrnoException)?.code === "ENOENT") {
      console.log(`Skipping deleted directory '${target}'`);
      return [];
    } else {
      throw error;
    }
  }

  return items
    .filter((d) => d.isFile() && d.name.endsWith(".json"))
    .map((d) => path.join(target, d.name))
    .map((d) => d.replace(/^.*?(specification[\/\\].*)$/, "$1"))
    .filter((d) => d.includes("specification" + path.sep));
}

export async function processFilesToSpecificationList(
  rootDirectory: string,
  files: string[],
): Promise<string[]> {
  const cachedSwaggerSpecs = new Map<string, string[]>();
  const resultFiles: string[] = [];
  const additionalSwaggerFiles: string[] = [];

  // files from get-changed-files are relative to the root of the repo,
  // though that context is passed into this from cli arguments.
  for (const file of files) {
    const absoluteFilePath = path.join(rootDirectory, file);

    // if the file is an example, under "preview" or "stable" (but not the TypeSpec source folder),
    // we need to find the swagger file that references it
    if (example(file) && (preview(file) || stable(file))) {
      /*
        The `examples` folder is traditionally populated with example.json files related to the owning spec.
        However, these examples might be contained within subdirectories of the examples folder.

        path/to/swagger/2024-01-01/examples/example.json                        <-- valid example path
        path/to/swagger/2024-01-01/examples/subdirectory1/example.json <-- also valid example path
        path/to/swagger/2024-01-01/swagger.json <-- we need to identify this file if it references the example
        path/to/swagger/2024-01-01/swagger2.json <-- and do nothing with this one
      */
      const swaggerDir = path.relative(
        rootDirectory,
        untilLastSegment(absoluteFilePath, "examples"),
      );

      const visibleSwaggerFiles = await getFiles(rootDirectory, swaggerDir);

      for (const swaggerFile of visibleSwaggerFiles) {
        if (!cachedSwaggerSpecs.has(swaggerFile)) {
          const swaggerModel = new Swagger(path.join(rootDirectory, swaggerFile));
          try {
            const exampleSwaggers = await swaggerModel.getExamples();
            const examples = [...exampleSwaggers.keys()];
            cachedSwaggerSpecs.set(swaggerFile, examples);
          } catch (e) {
            console.log(
              `Error getting examples for ${swaggerFile}: ${e instanceof Error ? e.message : String(e)}`,
            );
            // if we can't get the examples, we just skip this file
            continue;
          }
        }
        const referencedExamples = cachedSwaggerSpecs.get(swaggerFile);

        // the resolved files are absolute paths, so to compare them to the file we're looking at, we need
        // to use the absolute path version of the example file.
        if (referencedExamples?.indexOf(absoluteFilePath) !== -1) {
          // unfortunately, we get lists of files in posix format from get-changed-files. because of this, when are are grabbing a
          // resolved swagger file, we need to ensure we are using the posix version of the path as well. If we do not do this,
          // if we change an example and a spec, we will end up resolving the changed spec twice, one with the posix path (from changed-files)
          // and one with the windows path (resolved from the swagger model which we pulled refs from to determine which example belonged to which swagger)
          additionalSwaggerFiles.push(swaggerFile.replace(/\\/g, "/"));
        }
      }
    }

    // finally handle our base case where the file we're examining is itself a swagger file
    if (swagger(file) && fs.existsSync(absoluteFilePath)) {
      resultFiles.push(file);
    }
  }

  // combine and make the results unique
  return Array.from(new Set([...resultFiles, ...additionalSwaggerFiles]));
}
