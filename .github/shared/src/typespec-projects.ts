import { readdir, stat } from "node:fs/promises";
import { dirname, join, resolve } from "pathe";
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

export interface ChangedTypeSpecProjectsOptions {
  /** Service scope includes every project; project scope searches ancestors of changed paths. */
  scope: "project" | "service";
  logger?: ILogger;
}

/**
 * Maps absolute project directories to associated repository-relative POSIX changed paths.
 * Project scope selects the nearest tspconfig.yaml in the old layout, or all ancestors in the
 * resource-manager/data-plane layout. Service scope includes every sibling and nested project,
 * including invalid config extensions. Neither scope inspects imports or shared libraries.
 * Git comparison and core-file/all-project policies belong to the caller.
 */
export async function findChangedTypeSpecProjects(
  root: string,
  changedFiles: readonly string[],
  options: ChangedTypeSpecProjectsOptions,
): Promise<Map<string, string[]>> {
  const logger = options.logger ?? defaultLogger;
  const files = changedFiles.filter((file) => /^specification\/[^/]+\//.test(file));
  const projects = new Map<string, string[]>();
  if (options.scope === "project") {
    for (const [directory, directoryFiles] of Map.groupBy(files, dirname)) {
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
        if (
          entries.includes("tspconfig.yaml") &&
          (await stat(join(folder, "tspconfig.yaml"))).isFile()
        ) {
          const associatedFiles = projects.get(folder);
          if (associatedFiles) {
            associatedFiles.push(...directoryFiles);
          } else {
            projects.set(folder, [...directoryFiles]);
          }
          if (!findAll) break;
        }
        current = dirname(current);
      }
    }
  } else {
    const services = Map.groupBy(files, (file) => file.split("/").slice(0, 2).join("/"));
    for (const [directory, serviceFiles] of [...services.entries()].sort(([left], [right]) =>
      left < right ? -1 : 1,
    )) {
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
        projects.set(project, [...serviceFiles]);
      }
    }
  }

  return new Map([...projects.entries()].sort(([left], [right]) => (left < right ? -1 : 1)));
}
