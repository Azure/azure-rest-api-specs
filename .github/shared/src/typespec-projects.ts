import { readdir, stat } from "node:fs/promises";
import { dirname, relative, resolve } from "pathe";
import { globFiles } from "./glob.ts";
import { defaultLogger, type ILogger } from "./logger.ts";

/** Finds sorted, unique absolute project directories, including invalid config extensions. */
export async function findTypeSpecProjects(root: string): Promise<string[]> {
  const configs = await globFiles("**/tspconfig.*", {
    cwd: root,
    exclude: ["**/node_modules/**"],
  });
  const folders = [...new Set(configs.map((config) => dirname(config)))].sort();
  return folders.map((folder) => resolve(root, folder));
}

function groupChangedFilesByService(changedFiles: readonly string[]): Map<string, string[]> {
  const services = new Map<string, string[]>();
  for (const file of changedFiles) {
    const match = /^specification\/[^/]+\//.exec(file);
    if (!match) continue;

    const service = match[0].slice(0, -1);
    const files = services.get(service) ?? [];
    files.push(file);
    services.set(service, files);
  }
  return services;
}

/**
 * Finds every project in services touched by repository-relative POSIX changed paths.
 * Includes sibling and nested projects even for deleted files; missing services are skipped.
 * Git comparison and core-file/all-project policies belong to the caller.
 */
export async function findTypeSpecProjectsInChangedServices(
  root: string,
  changedFiles: readonly string[],
  logger: ILogger = defaultLogger,
): Promise<string[]> {
  const directories = [...groupChangedFilesByService(changedFiles).keys()].sort();
  const projects = new Set<string>();
  for (const directory of directories) {
    const folder = resolve(root, directory);
    let isDirectory: boolean;
    try {
      isDirectory = (await stat(folder)).isDirectory();
    } catch (error) {
      if (error instanceof Error && "code" in error && error.code === "ENOENT") {
        isDirectory = false;
      } else {
        throw error;
      }
    }
    if (!isDirectory) {
      logger.debug(`Cannot find directory ${directory}`);
      continue;
    }
    for (const project of await findTypeSpecProjects(folder)) {
      projects.add(relative(root, project));
    }
  }

  return [...projects].sort().map((project) => resolve(root, project));
}

/**
 * Maps absolute project directories to associated repository-relative POSIX changed paths.
 * Searches upward for the nearest tspconfig.yaml in the old layout, or all ancestors in the
 * resource-manager/data-plane layout. Does not inspect imports or shared libraries.
 */
export async function findTypeSpecProjectsForChangedFiles(
  root: string,
  changedFiles: readonly string[],
  logger: ILogger = defaultLogger,
): Promise<Map<string, string[]>> {
  const projects = new Map<string, string[]>();
  for (const serviceFiles of groupChangedFilesByService(changedFiles).values()) {
    for (const [directory, directoryFiles] of Map.groupBy(serviceFiles, dirname)) {
      const findAll = directory.includes("resource-manager") || directory.includes("data-plane");
      let current = directory;
      while (current !== "specification" && current !== ".") {
        const folder = resolve(root, current);
        let entries: string[];
        try {
          entries = await readdir(folder);
        } catch (error) {
          if (error instanceof Error && "code" in error && error.code === "ENOENT") {
            logger.warning(`Cannot find directory ${current}`);
            break;
          }
          throw error;
        }
        if (entries.includes("tspconfig.yaml")) {
          const associatedFiles = projects.get(folder) ?? [];
          associatedFiles.push(...directoryFiles);
          projects.set(folder, associatedFiles);
          if (!findAll) break;
        }
        current = dirname(current);
      }
    }
  }

  return new Map([...projects.entries()].sort(([left], [right]) => (left < right ? -1 : 1)));
}
