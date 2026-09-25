import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";
import { ConsoleLogger } from "@azure-tools/specs-shared/logger";
import { stat } from "node:fs/promises";
import { dirname, join, relative, resolve, sep } from "node:path";
import { globFiles } from "./glob.ts";

export interface ChangedProjectsOptions {
  baseCommitish: string;
  headCommitish: string;
  ignoreCoreFiles?: boolean;
}

const coreFiles = new Set([
  ".gitattributes",
  ".oxfmtrc.json",
  ".prettierrc.json",
  "pnpm-lock.yaml",
  "pnpm-workspace.yaml",
  "package.json",
  "tsconfig.json",
  "specification/suppressions.yaml",
]);

function isCoreFile(file: string): boolean {
  return (
    coreFiles.has(file) ||
    (file.startsWith(".github/") && !file.startsWith(".github/arm-leases/")) ||
    (file.startsWith("eng/") && !file.startsWith("eng/common/")) ||
    file.startsWith("specification/common-types/")
  );
}

/** Find project folders, including invalid config extensions so validation can report them. */
export async function findProjects(root: string): Promise<string[]> {
  const configs = await globFiles("**/tspconfig.*", {
    cwd: root,
    exclude: ["**/node_modules/**"],
  });
  const folders = [
    ...new Set(configs.map((config) => dirname(config).split(sep).join("/"))),
  ].sort();
  return folders.map((folder) => resolve(root, folder));
}

export async function findChangedProjects(
  root: string,
  options: ChangedProjectsOptions,
): Promise<{ projects: string[]; checkingAllSpecs: boolean }> {
  const changedFiles = (
    await getChangedFiles({
      cwd: root,
      gitConfig: ["core.quotepath=false"],
      baseCommitish: options.baseCommitish,
      headCommitish: options.headCommitish,
      logger: new ConsoleLogger(),
    })
  ).filter((file) => !file.includes("ChangedFiles-Functions"));

  if (!options.ignoreCoreFiles && changedFiles.some(isCoreFile)) {
    console.log("Found changes to core eng or root files so checking all specs.");
    return {
      projects: await findProjects(join(root, "specification")),
      checkingAllSpecs: true,
    };
  }

  // Match Get-TypeSpec-Folders.ps1: select the entire service folder, including
  // sibling and nested projects. Deleted files still affect surviving services.
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
      console.log(`Cannot find directory ${directory}`);
      continue;
    }
    for (const project of await findProjects(folder)) {
      projects.add(relative(root, project).split(sep).join("/"));
    }
  }

  return {
    projects: [...projects].sort().map((project) => resolve(root, project)),
    checkingAllSpecs: false,
  };
}
