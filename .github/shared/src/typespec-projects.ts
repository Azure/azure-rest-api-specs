import { stat } from "node:fs/promises";
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
  const directories = [
    ...new Set(
      changedFiles.flatMap((file) => {
        const match = /^specification\/[^/]+\//.exec(file);
        return match ? [match[0].slice(0, -1)] : [];
      }),
    ),
  ].sort();
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
