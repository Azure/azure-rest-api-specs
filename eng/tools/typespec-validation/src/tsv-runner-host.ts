import { Stats } from "fs";
import { readFile, stat as statImpl } from "fs/promises";
import { globby, Options as GlobbyOptions } from "globby";
import { join } from "path";
import { simpleGit } from "simple-git";
import { getSuppressions as getSuppressionsImpl, Suppression } from "suppressions";
import { RuleResult } from "./rule-result.js";
import { IGitOperation, TsvHost } from "./tsv-host.js";
import {
  checkFileExists,
  gitDiffTopSpecFolder,
  isDirectory,
  normalizePath,
  runCmd,
} from "./utils.js";

export class TsvRunnerHost implements TsvHost {
  checkFileExists(file: string): Promise<boolean> {
    return checkFileExists(file);
  }

  isDirectory(path: string) {
    return isDirectory(path);
  }

  stat(path: string): Promise<Stats> {
    return statImpl(path);
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

  globby(patterns: string | string[], options?: GlobbyOptions): Promise<string[]> {
    return globby(patterns, options);
  }

  getSuppressions(path: string): Promise<Suppression[]> {
    return getSuppressionsImpl("TypeSpecValidation", path);
  }
}
