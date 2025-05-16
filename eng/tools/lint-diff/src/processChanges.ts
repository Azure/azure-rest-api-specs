import { join, relative, resolve, sep } from "path";
import { readFile } from "fs/promises";
import { pathExists } from "./util.js";
import { specification, readme, swagger } from "@azure-tools/specs-shared/changed-files";
import { SpecModel } from "@azure-tools/specs-shared/spec-model"
import deepEqual from "deep-eql"

import {
  getTagsAndInputFiles,
  deduplicateTags,
} from "./markdown-utils.js";
import $RefParser from "@apidevtools/json-schema-ref-parser";

export async function getRunList(
  beforePath: string,
  afterPath: string,
  changedFilesPath: string,
): Promise<[Map<string, string[]>, Map<string, string[]>, Set<string>]> {
  // Forward slashes are OK list coming from changedFilesPath is from git which
  // always uses forward slashes as path separators

  // Read changed files, exclude any files that should be ignored
  const ignoreFilesWith = ["/examples/", "/quickstart-templates/", "/scenarios/"];
  const changedSpecFiles = (await readFileList(changedFilesPath)).filter((file) => {
    // File is in specification/ folder
    if (!specification(file)) {
      return false;
    }

    // File is not ignored
    for (const ignore of ignoreFilesWith) {
      if (file.includes(ignore)) {
        return false;
      }
    }
    return true;
  });

  // In the future, the loop involving [beforePath, afterPath] can be eliminated
  // as well as beforeState
  const [beforeState, ] = await buildState(changedSpecFiles, beforePath);
  const [afterState, afterSwaggers] = await buildState(changedSpecFiles, afterPath);
  const affectedSwaggerCandidates = new Set<string>(afterSwaggers);
  const [beforeTagMap, afterTagMap] = reconcileChangedFilesAndTags(beforeState, afterState);


  const affectedSwaggers = await getChangedSwaggers(beforePath, afterPath, affectedSwaggerCandidates);

  console.log("Before readme and tags:");
  console.table([...beforeTagMap].map(([readme, tags]) => ({ readme, tags })), ['readme', 'tags']);
  console.log("\n");

  console.log("After readme and tags:");
  console.table([...afterTagMap].map(([readme, tags]) => ({ readme, tags })), ['readme', 'tags']);
  console.log("\n");

  console.log("Affected swaggers:"); 
  console.table([...affectedSwaggers].map((swagger) => ({ swagger })), ['swagger']);
  console.log("\n");

  return [beforeTagMap, afterTagMap, affectedSwaggers];
}

export async function buildState(
  changedSpecFiles: string[],
  rootPath: string,
): Promise<[Map<string, string[]>, string[]]> {
  // Filter changed files to include only those that exist in the rootPath
  const existingChangedFiles = [];
  for (const file of changedSpecFiles) {
    if (await pathExists(join(rootPath, file))) {
      existingChangedFiles.push(file);
    }
  }

  // Get affected services from changed files
  // e.g. specification/service1/readme.md -> specification/service1
  const affectedServiceDirectories = await getAffectedServices(existingChangedFiles);

  // Build service models of affected services
  const specModels = new Map<string, SpecModel>();
  for (const serviceDir of affectedServiceDirectories) {
    const specModel = new SpecModel(resolve(rootPath, serviceDir));
    specModels.set(serviceDir, specModel);
  }

  const readmeTags = new Map<string, Set<string>>();
  for (const changedSwagger of existingChangedFiles.filter(swagger)) {
    const readmeTagMapForChangedFile = 
      await specModels.get(getService(changedSwagger))!.getAffectedReadmeTags(resolve(rootPath, changedSwagger));
    
    for (const [readmePath, tags] of readmeTagMapForChangedFile) {
      if (!readmeTags.has(readmePath)) {
        readmeTags.set(readmePath, new Set<string>());
      }
      for (const tagName of tags.keys()) {
        readmeTags.get(readmePath)?.add(tagName);
      }
    }
  }

  const changedFileAndTagsMap = new Map<string, string[]>();
  for (const [readmeFile, tags] of readmeTags.entries()) {
    const dedupedTags = deduplicateTags(
      await getTagsAndInputFiles(
        [...tags],
        await readFile(readmeFile, { encoding: "utf-8" }),
      ),
    );

    changedFileAndTagsMap.set(relative(rootPath, readmeFile), dedupedTags);
  }

  // For readme files that have changed but there are no affected swaggers,
  // add them to the map with no tags
  for (const changedReadme of existingChangedFiles.filter(readme)) {
    if (!changedFileAndTagsMap.has(changedReadme)) {
      changedFileAndTagsMap.set(changedReadme, []);
    }
  }

  const affectedSwaggers = new Set<string>();
  for (const changedSwagger of existingChangedFiles.filter(swagger)) {
    const service = getService(changedSwagger);
    const swaggerSet = await specModels.get(service)!.getAffectedSwaggers(resolve(rootPath, changedSwagger));
    for (const swaggerPath of swaggerSet.keys()) {
      affectedSwaggers.add(relative(rootPath, swaggerPath));
    }
  }

  // Return list of affected swagger files
  return [changedFileAndTagsMap, [...affectedSwaggers]];
}

/**
 * Build mappings of changed readmes and tags to scan by examining state of the
 * repo before and after the change.
 * @param before before the change
 * @param after after the change
 * @returns maps of readme files and tags to scan
 */
export function reconcileChangedFilesAndTags(
  before: Map<string, string[]>,
  after: Map<string, string[]>,
): Map<string, string[]>[] {
  const beforeFinal = new Map<string, string[]>();
  const afterFinal = new Map<string, string[]>();

  // Clone the maps so that changes to maps do not affect original object
  for (const [readme, tags] of before.entries()) {
    beforeFinal.set(readme, [...tags]);
  }
  for (const [readme, tags] of after.entries()) {
    afterFinal.set(readme, [...tags]);
  }

  // If a tag is deleted in after and exists in before, do NOT scan the tag
  for (const [readme, tags] of beforeFinal.entries()) {
    // TODO: A deleted readme might also be cause to remove from scanning,
    // which this currently does not do.
    if (!afterFinal.has(readme)) {
      continue;
    }

    const afterTags = new Set(afterFinal.get(readme)!);
    beforeFinal.set(
      readme,
      tags.filter((tag) => afterTags.has(tag)),
    );
  }

  return [beforeFinal, afterFinal];
}

/**
 * Given the path to a file return an array of strings where each entry in the
 * array is a line in the file
 *
 * @param changedFilesPath Path to the file containing the list of changed files with one on each line
 * @returns
 */
export async function readFileList(changedFilesPath: string): Promise<string[]> {
  const data = await readFile(changedFilesPath, { encoding: "utf-8" });
  return data
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.length > 0);
}

/**
 * Given a list of changed files return a set of services which the changed
 * files impact (assumes no references across services).
 * For example:
 *  - "specification/service1/file1.json", "specification/service1/file2.json" -> "specification/service1"
 *  - "specification/service1/file1.json", "specification/service2/file1.json" -> "specification/service1", "specification/service2"
 *
 * @param changedFiles a list of changed files
 * @returns A list of "services" that are affected by the changed files
 */
export async function getAffectedServices(changedFiles: string[]) {
  const affectedServices = new Set<string>();
  for (const file of changedFiles) {
    const service = await getService(file);
    if (service) {
      affectedServices.add(service);
    }
  }
  return affectedServices;
}

/**
 * Returns the service of a file path of the form "specification/<service>"
 * @param filePath Path to a file of the form "specification/<service>/.../file.json"
 * @returns Service path of the form "specification/<service>"
 */
export function getService(filePath: string): string {
  // TODO: Ensure sep is used appropriately here
  const splitPath = filePath.split(sep).filter((part) => part);
  if (splitPath.length >= 2) {
    // TODO: Verify result is a directory or remove async
    return splitPath.slice(0, 2).join(sep);
  }
  throw new Error(`Could not find service for file path: ${filePath}`);
}

/**
 * Return true if the path contains "/examples/"
 * @param path 
 * @returns 
 */
const excludeExamples = (path: string) => path.includes("/examples/");

/**
 * Given a list of swagger files relatve to before and after root paths,
 * return a set of swagger files that have changed. Changes can be directly in 
 * the swagger file or in part of a referenced file that is included. Not all 
 * changes to a file in a $ref will affect a given swagger file.
 * @param beforeRoot 
 * @param afterRoot 
 * @param affectedSwaggerCandidates 
 * @returns 
 */
export async function getChangedSwaggers(
  beforeRoot: string,
  afterRoot: string,
  affectedSwaggerCandidates: Set<string>,
) {
  const affectedSwaggers = new Set<string>();

  for (const swagger of affectedSwaggerCandidates) {
    const beforeSwagger = join(beforeRoot, swagger);
    if (!(await pathExists(beforeSwagger))) {
      affectedSwaggers.add(swagger);
      continue;
    }

    const afterSwagger = join(afterRoot, swagger);

    // Using dereference which supports excluding $ref paths (in this case, examples)
    const derefBefore = await $RefParser.dereference(
      beforeSwagger, 
      { dereference: { excludedPathMatcher: excludeExamples}},
    );
    const derefAfter = await $RefParser.dereference(
      afterSwagger, 
      { dereference: { excludedPathMatcher: excludeExamples}},
    );

    // Compare the dereferenced objects
    if (!deepEqual(derefBefore, derefAfter)) {
      affectedSwaggers.add(swagger);
    }
  }

  return affectedSwaggers;
}
