import { join } from "path";
import { readFile } from "fs/promises";
import { IGitOperation, TsvHost } from "./tsv-host.js";
import { globby } from "globby";
import { simpleGit } from "simple-git";
import { checkFileExists, normalizePath, runCmd } from "./utils.js";

export class TsvRunnerHost implements TsvHost {
  checkFileExists(file: string): Promise<boolean> {
    return checkFileExists(file);
  }

  gitOperation(folder: string): IGitOperation {
    return simpleGit(folder);
  }

  readTspConfig(folder: string): Promise<string> {
    return readFile(join(folder, "tspconfig.yaml"), "utf-8");
  }

  runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]> {
    return runCmd(cmd, cwd);
  }

  normalizePath(folder: string): string {
    return normalizePath(folder);
  }

  globby(patterns: string[]): Promise<string[]> {
    return globby(patterns);
  }
}
