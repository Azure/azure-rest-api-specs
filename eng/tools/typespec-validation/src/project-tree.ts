import { glob, stat } from "node:fs/promises";
import { dirname, resolve } from "pathe";
import { getFormatScope } from "./format-scope.ts";

export interface TypeSpecProject {
  readonly path: string;
  readonly parent?: string;
  readonly children: readonly string[];
  readonly formatFiles: readonly string[];
}

export interface TypeSpecProjectTree {
  readonly projects: ReadonlyMap<string, TypeSpecProject>;
  /** Files selected for formatting and the projects whose formatting scopes select them. */
  readonly formatFiles: ReadonlyMap<string, readonly string[]>;
}

/**
 * Capture project nesting and formatting scopes for an already-selected set of projects.
 * The result is a filesystem snapshot, not an import or compilation dependency graph.
 */
export async function buildProjectTree(folders: readonly string[]): Promise<TypeSpecProjectTree> {
  const paths = [...new Set(folders.map((folder) => resolve(folder)))].sort();
  const projectPaths = new Set(paths);
  const children = new Map(paths.map((path) => [path, [] as string[]]));
  const parents = new Map<string, string>();
  const sourcesByScope = new Map<string, Promise<string[]>>();
  const projects = new Map<string, TypeSpecProject>();
  const fileProjects = new Map<string, string[]>();

  for (const path of paths) {
    let ancestor = dirname(path);
    while (true) {
      if (projectPaths.has(ancestor)) {
        parents.set(path, ancestor);
        children.get(ancestor)!.push(path);
        break;
      }
      const next = dirname(ancestor);
      if (next === ancestor) break;
      ancestor = next;
    }

    const { patterns, exclude } = getFormatScope(path);
    let sources = sourcesByScope.get(patterns[0]);
    if (!sources) {
      sources = findFormatFiles([patterns[0]], exclude);
      sourcesByScope.set(patterns[0], sources);
    }
    const configPatterns = await expandConfigPattern(patterns[1]);
    const formatFiles = [
      ...new Set([...(await sources), ...(await findFormatFiles(configPatterns, exclude))]),
    ].sort();
    for (const file of formatFiles) {
      const users = fileProjects.get(file) ?? [];
      users.push(path);
      fileProjects.set(file, users);
    }
    projects.set(path, {
      path,
      parent: parents.get(path),
      children: children.get(path)!,
      formatFiles,
    });
  }

  return {
    projects,
    formatFiles: new Map([...fileProjects].sort(([a], [b]) => a.localeCompare(b))),
  };
}

async function expandConfigPattern(path: string): Promise<string[]> {
  try {
    if ((await stat(path)).isDirectory()) return [path, `${path}/**/*`];
  } catch (error) {
    if (!(error instanceof Error && "code" in error && error.code === "ENOENT")) throw error;
  }
  return [path];
}

async function findFormatFiles(patterns: string[], exclude: string[]): Promise<string[]> {
  const files: string[] = [];
  for await (const entry of glob(patterns, {
    withFileTypes: true,
    exclude: ["**/node_modules", ...exclude],
  })) {
    if (entry.isFile()) files.push(resolve(entry.parentPath, entry.name));
  }
  return files;
}
