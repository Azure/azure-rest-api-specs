import { spawn, spawnSync } from "node:child_process";
import path from "node:path";
import fs from "node:fs";
import { LogLevel, logMessage } from "./log.js";

type Dirent = fs.Dirent;

// Common function to find files recursively with case-insensitive matching
export function findFilesRecursive(directory: string, fileName: string): string[] {
  let results: string[] = [];
  const list: Dirent[] = fs.readdirSync(directory, { withFileTypes: true });

  for (const dirent of list) {
    const filePath = path.join(directory, dirent.name);
    if (dirent.isDirectory()) {
      results = [...results, ...findFilesRecursive(filePath, fileName)];
    } else if (dirent.isFile() && dirent.name.toLowerCase() === fileName.toLowerCase()) {
      results.push(getRelativePathFromSpecification(filePath));
    }
  }

  return results;
}

export function findReadmeFiles(directory: string): string[] {
  return findFilesRecursive(directory, "readme.md");
}

export function getArgumentValue(args: string[], flag: string, defaultValue: string): string {
  const index = args.indexOf(flag);
  return index !== -1 && args[index + 1] ? args[index + 1] : defaultValue;
}

export function getRelativePathFromSpecification(absolutePath: string): string {
  const specificationIndex = absolutePath.indexOf("specification/");
  if (specificationIndex !== -1) {
    return absolutePath.slice(Math.max(0, specificationIndex));
  }
  return absolutePath;
}

export async function runSpecGenSdkCommand(specGenSdkCommand: string[]): Promise<void> {
  return new Promise((resolve, reject) => {
    const childProcess = spawn("npx", specGenSdkCommand, {
      shell: false,
      stdio: "inherit",
      env: process.env,
    });
    childProcess.on("error", (error) => {
      reject(new Error(`Failed to start process: ${error.message}`));
    });
    childProcess.on("exit", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Process exited with code ${code}`));
      }
    });
  });
}

export function getAllTypeSpecPaths(specRepoPath: string): string[] {
  const scriptPath = path.resolve(specRepoPath, "eng/scripts/Get-TypeSpec-Folders.ps1");
  const args = [
    "-NoProfile",
    "-ExecutionPolicy",
    "Bypass",
    "-File",
    scriptPath,
    "-CheckAll",
    "$true",
  ];
  const output = runPowerShellScript(args);
  if (!output) {
    logMessage("Error getting type spec paths", LogLevel.Error);
    return [];
  }
  try {
    const specConfigPaths = output.split("\n").map((line) => path.join(line, "tspconfig.yaml"));
    //remove the last element which is 'true' or 'false'
    specConfigPaths.pop();
    return specConfigPaths;
  } catch (error) {
    logMessage(`Error parsing PowerShell output:${error}`, LogLevel.Error);
    return [];
  }
}
export function runPowerShellScript(args: string[]): string | undefined {
  const result = spawnSync("/usr/bin/pwsh", args, { encoding: "utf8" });
  if (result.error) {
    logMessage(`Error executing PowerShell script:${result.error}`, LogLevel.Error);
    return undefined;
  }
  if (result.stderr) {
    logMessage(`PowerShell script error output:${result.stderr}`, LogLevel.Error);
  }
  return result.stdout.trim();
}
