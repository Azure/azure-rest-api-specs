import { join, dirname, sep } from "path";
import { readFile, readdir } from "fs/promises";
import { pathExists } from "./util.js";
import { specification } from "../../../../.github/src/changed-files.js";

import {
  getAllTags,
  getInputFiles,
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
  const [beforeState, _] = await buildState(changedSpecFiles, beforePath);
  const [afterState, afterSwaggers] = await buildState(changedSpecFiles, afterPath);
  const affectedSwaggers = new Set<string>(afterSwaggers);

  console.log(`affected swaggers: ${[...affectedSwaggers].join(", ")}`);
  const [beforeTagMap, afterTagMap] = reconcileChangedFilesAndTags(beforeState, afterState);

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

  // Get a map of a service's swagger files and their dependencies
  // TODO: Use set or array?
  const affectedSwaggerMap = new Map<string, string[]>();
  for (const serviceDir of affectedServiceDirectories) {
    const changedServiceFiles = existingChangedFiles.filter((file) => file.startsWith(serviceDir));
    const serviceDependencyMap = await getSwaggerDependenciesMap(rootPath, serviceDir);

    affectedSwaggerMap.set(
      serviceDir,
      await getAffectedSwaggers(changedServiceFiles, serviceDependencyMap),
    );
  }

  // Use changedSpecFiles (which might not be present in the branch) to get
  // a set of affected readme files.
  const affectedReadmes = await getAffectedReadmes(changedSpecFiles, rootPath);

  const readmeTags = new Map<string, Set<string>>();
  for (const readme of affectedReadmes) {
    const readmeService = await getService(readme);
    if (!affectedSwaggerMap.has(readmeService)) {
      continue;
    }

    // TODO: The parser is used twice to get tags and input files. This can be
    // made more efficient.
    const readmeContent = await readFile(join(rootPath, readme), { encoding: "utf-8" });
    for (const tag of getAllTags(readmeContent)) {
      const inputFiles = getInputFiles(readmeContent, tag).map((file) =>
        join(dirname(readme), file),
      );
      if (inputFiles === undefined || inputFiles.length === 0) {
        continue;
      }

      // Readme + Tag Combo

      // TODO: ensure ! is correct to do here
      for (const swagger of affectedSwaggerMap.get(readmeService)!) {
        if (inputFiles.includes(swagger)) {
          if (!readmeTags.has(readme)) {
            readmeTags.set(readme, new Set<string>());
          }
          readmeTags.get(readme)?.add(tag);
        }
      }
    }
  }

  // TODO: Deduplicate inside or outside state building? It's possible that
  // later processing like that in reconcileChangedFilesAndTags
  const changedFileAndTagsMap = new Map<string, string[]>();
  for (const [readme, tags] of readmeTags.entries()) {
    const dedupedTags = deduplicateTags(
      await getTagsAndInputFiles(
        [...tags],
        await readFile(join(rootPath, readme), { encoding: "utf-8" }),
      ),
    );

    changedFileAndTagsMap.set(readme, dedupedTags);
  }

  // For readme files that have changed but there are no affected swaggers,
  // add them to the map with no tags
  for (const changedReadme of affectedReadmes) {
    if (!changedFileAndTagsMap.has(changedReadme)) {
      changedFileAndTagsMap.set(changedReadme, []);
    }
  }

  return [changedFileAndTagsMap, Array.from(affectedSwaggerMap.values()).flat()];
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
 * Build a list of swagger dependencies for a given directory. Only list
 * dependencies that are in the same "directory".
 *
 * @param rootPath The root path of the repo
 * @param directory The directory (generally, service directory) to search
 * @returns A map of swagger files to the files upon which they depend
 */
export async function getSwaggerDependenciesMap(
  rootPath: string,
  directory: string,
): Promise<NonNullable<Map<string, Set<string>>>> {
  const swaggerFiles = await enumerateFiles(rootPath, directory, ".json");
  const swaggerDependencies = new Map<string, Set<string>>();
  const rootAndDirectoryPath = join(rootPath, directory);

  for (const file of swaggerFiles) {
    let parsedRefs = await $RefParser.resolve(join(rootPath, file), {
      resolve: { http: false },
    });
    // TODO: filter should exclude URLs
    const refs = parsedRefs
      .paths()
      .filter(
        (ref: string) =>
          ref.startsWith(rootAndDirectoryPath) && // Inside the target directory
          !ref.includes(`/examples/`), // Exclude examples
      )
      // TODO: +1 requires proper handling of trailing slashes
      .map((ref: string) => ref.substring(rootPath.length + 1)) // Relative to rootPath
      .filter((ref: string) => ref !== file); // Exclude self-reference

    swaggerDependencies.set(file, new Set(refs));
  }

  return swaggerDependencies;
}

/**
 * Given a list of changed files and a map of swagger dependencies, return a
 * list of affected swagger files that depend on the given set of changed files.
 * @param changedFiles
 * @param dependencies a map of swagger files to the files upon which those swaggers depend
 * @returns
 */
export function getAffectedSwaggers(
  changedFiles: string[],
  dependencies: Map<string, Set<string>>,
): string[] {
  const affectedSwaggers = new Set<string>(changedFiles);

  for (const changedFile of changedFiles) {
    for (const [file, deps] of dependencies.entries()) {
      if (affectedSwaggers.has(file)) {
        continue;
      }

      if (deps.has(changedFile)) {
        affectedSwaggers.add(file);
      }
    }
  }

  return [...affectedSwaggers];
}

/**
 * Get the list of readme files that are affected by the changed files by
 * searching for readme files in each higher directory up to the "specification/"
 * directory.
 *
 * @param changedFiles List of changed files.
 */
export async function getAffectedReadmes(
  changedFiles: string[],
  repoRoot: string,
): Promise<string[]> {
  // OK to use / because changedFiles comes from git which always uses /
  const changedFilesInSpecDir = changedFiles.filter((file) => file.startsWith(`specification/`));

  const changedReadmeFiles = [];
  for (const file of changedFilesInSpecDir) {
    if (file.toLowerCase().endsWith(`/readme.md`) && (await pathExists(join(repoRoot, file)))) {
      changedReadmeFiles.push(file);
    }
  }

  const changedSpecFiles = changedFilesInSpecDir.filter((f) =>
    [".md", ".json", ".yaml", ".yml"].some((p) => f.toLowerCase().endsWith(p)),
  );

  const readmeFiles = new Set<string>(changedReadmeFiles);
  const visitedFolders = new Set<string>();

  // For each changed spec file, walk up the directory tree collecting readme
  // files until reaching the "specification/" directory (already filtered in
  // changedFilesInSpecDir)
  for (const specFile of changedSpecFiles) {
    let dir = dirname(specFile);
    // Exclude '.' as it is outside the specification folder for purposes of
    // this function (avoid including root readme.md file)
    while (!visitedFolders.has(dir) && dir !== "specification") {
      visitedFolders.add(dir);
      // TODO: Case sensitivity??
      const readmeFile = join(repoRoot, dir, "readme.md");
      if (await pathExists(readmeFile)) {
        readmeFiles.add(join(dir, "readme.md"));
      }
      dir = dirname(dir);
    }
  }

  return [...readmeFiles];
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
 * Given a root path and directory, find all files whose name ends with a given
 * string. (e.g. ".json")
 * @param rootPath Root path of starting directory
 * @param dir Starting directory
 * @param endsWith a file extension to search for
 * @returns A list of files with paths relative to rootPath
 */
async function enumerateFiles(rootPath: string, dir: string, endsWith: string): Promise<string[]> {
  let results: string[] = [];
  let stack: string[] = [dir];

  while (stack.length > 0) {
    const currentDir = stack.pop()!;
    const list = await readdir(join(rootPath, currentDir), { withFileTypes: true });

    for (const file of list) {
      if (file.isDirectory()) {
        stack.push(join(currentDir, file.name));
      } else {
        if (file.name.endsWith(endsWith)) {
          results.push(join(currentDir, file.name));
        }
      }
    }
  }

  return results;
}
