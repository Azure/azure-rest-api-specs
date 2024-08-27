import { join } from "path";
import { readFile } from "fs/promises";
import { IGitOperation, TsvHost } from "./tsv-host.js";
import { globby } from "globby";
import { simpleGit } from "simple-git";
import {
  checkFileExists,
  isDirectory,
  normalizePath,
  runCmd,
  gitDiffTopSpecFolder,
} from "./utils.js";
import { RuleResult } from "./rule-result.js";

export class TsvRunnerHost implements TsvHost {
  checkFileExists(file: string): Promise<boolean> {
    return checkFileExists(file);
  }

  isDirectory(path: string) {
    return isDirectory(path);
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

  gitDiffTopSpecFolder(host: TsvHost, folder: string): Promise<RuleResult> {
    return gitDiffTopSpecFolder(host, folder);
  }

  globby(patterns: string[]): Promise<string[]> {
    return globby(patterns);
  }
}
