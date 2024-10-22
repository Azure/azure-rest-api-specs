import { access, stat } from "fs/promises";
import { exec } from "child_process";
import defaultPath, { PlatformPath } from "path";
import { TsvHost } from "./tsv-host.js";
import path from "path";
import os from "os";
import fs from "node:fs/promises";
import { fileURLToPath } from "url";

export async function runCmd(cmd: string, cwd: string) {
  console.log(`run command:${cmd} in directory:${cwd}`);
  const { err, stdout, stderr } = (await new Promise((res) =>
    exec(
      cmd,
      { encoding: "utf8", maxBuffer: 1024 * 1024 * 64, cwd: cwd },
      (err: unknown, stdout: unknown, stderr: unknown) =>
        res({ err: err, stdout: stdout, stderr: stderr }),
    ),
  )) as any;

  return [err, stdout, stderr] as [Error | null, string, string];
}

export async function checkFileExists(file: string) {
  return access(file)
    .then(() => true)
    .catch(() => false);
}

export async function isDirectory(path: string) {
  return (await stat(path)).isDirectory();
}

export function normalizePath(folder: string, path: PlatformPath = defaultPath) {
  return path
    .resolve(folder)
    .split(path.sep)
    .join("/")
    .replace(/^([a-z]):/, (_match, driveLetter) => driveLetter.toUpperCase() + ":");
}

export async function gitDiffTopSpecFolder(
  host: TsvHost,
  baseFolder: string,
  compareFolder: string,
) {
  const git = host.gitOperation(baseFolder);
  let stdOutput = `Running git diff on base: ${baseFolder}, compare: ${compareFolder}`;
  let diff = await git.diff(["--no-index", baseFolder, compareFolder]);

  let success = true;
  let errorOutput: string | undefined;

  // diff returns an empty string if there are no changes. simple-git does not
  // return an object indicating success for diff operations.
  if (diff) {
    success = false;
    errorOutput += diff;
  }

  return {
    success: success,
    stdOutput: stdOutput,
    errorOutput: errorOutput,
  };
}

let repoRoot = "";
export async function getRepoRoot(): Promise<string> {
  if (repoRoot) {
    return repoRoot;
  }

  // Walk up the filesystem from this file a .git folder is found
  let currentFolder = fileURLToPath(import.meta.url);

  // Also check for root of the filesystem where traversing up will not work
  while (!(await checkFileExists(path.join(currentFolder, ".git")))) {
    if (currentFolder === path.parse(currentFolder).root) {
      // It's not possible to traverse up from here and there's no .git folder
      // throw an error.
      throw new Error("Could not find .git folder in the filesystem.");
    }
    currentFolder = path.resolve(currentFolder, "../");
  }

  repoRoot = currentFolder;
  return currentFolder;
}

// Gets service root by walking up the filesystem until the current folder's
// parent is 'specification'
// e.g. /repo/specification/service/sub-item1/sub-item2 -> /repo/specification/service
export function getServiceRoot(folder: string): string {
  let currentFolder = folder;
  let parent = path.resolve(currentFolder, "../");
  while (path.parse(parent).base != "specification") {
    currentFolder = parent;
    parent = path.resolve(currentFolder, "../");

    if (path.parse(parent).root === parent) {
      throw new Error("Could not find 'specification/' in the filesystem");
    }
  }

  return currentFolder;
}

export async function cleanWorkspaceDirectory(workspaceDirectory: string) {
  if (workspaceDirectory) {
    // TODO: Ensure this doesn't remove the source of node_modules on
    // both Windows and Linux
    try {
      await fs.rm(workspaceDirectory, { recursive: true, force: true });
    } catch (ex) {
      // Only log, a cleanup error in /tmp is not fatal.
      console.log(`Error cleaning workspace directory: ${ex}`);
    }
  }
}

// TODO: Remove getWorkspaceDirectory
function getTempValidationTarget(folder: string, workspaceDirectory: string) {
  const normalizedFolder = normalizePath(folder);
  if (!normalizedFolder.includes("/specification/")) {
    throw new Error(`Invalid folder ${folder}, must be a subfolder of 'specification/'`);
  }

  const serviceDirectoryStart = normalizedFolder.indexOf("/specification/");
  const serviceDirectory = normalizedFolder.substring(serviceDirectoryStart);

  return path.join(workspaceDirectory, serviceDirectory);
}

export async function setupTempWorkspace(host: TsvHost, folder: string): Promise<string> {
  const randomName = Math.random().toString(36).substring(2, 15);
  const workspaceDirectory = path.join(os.tmpdir(), "tsv-workspace", randomName);

  const workspaceSpecificationDirectory = path.join(workspaceDirectory, "specification");
  const serviceRoot = getServiceRoot(folder);
  // e.g. 'service' from '/repo/specification/service'
  const serviceName = path.parse(serviceRoot).base;
  const repoRoot = await getRepoRoot();

  let folderExists =
    (await checkFileExists(workspaceDirectory)) && (await isDirectory(workspaceDirectory));

  // TODO: More checks?
  if (!folderExists) {
    await fs.mkdir(path.join(workspaceDirectory), { recursive: true });

    // It's possible to symlink node_modules one level up from the workspace
    // folder (e.g. ../node_modules) but since multiple versions of tsv could be
    // running concurrently it's not clear if that node_modules folder is
    // correct for the current executing tsv.
    // TODO: ensure this works on windows (especially when TEMP is in a different drive)
    await fs.symlink(
      path.join(repoRoot, "node_modules"),
      path.join(workspaceDirectory, "node_modules"),
    );

    // TODO: figure this out
    await host.checkFileExists("/");
    // await host.runCmd(`ln -s ${repoRoot}/node_modules ${workspaceDirectory}`, "");

    // Copy the service folder into the workspace (not just the specified folder)
    await fs.mkdir(path.join(workspaceSpecificationDirectory, serviceName), { recursive: true });
    // TODO: ensure that the actual service folder ends up in the workspace properly (right now it's missing the contosowidgetmanager)
    await fs.cp(serviceRoot, path.join(workspaceSpecificationDirectory, serviceName), {
      recursive: true,
    });
  }

  return getTempValidationTarget(folder, workspaceDirectory);
}
