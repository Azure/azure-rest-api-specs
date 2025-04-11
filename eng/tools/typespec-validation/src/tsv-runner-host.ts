import { readFile as readFileImpl } from "fs/promises";
import { globby, Options as GlobbyOptions } from "globby";
import { dirname, join } from "path";
import { simpleGit } from "simple-git";
import { getSuppressions as getSuppressionsImpl, Suppression } from "suppressions";
import { RuleResult } from "./rule-result.js";
import { IGitOperation, TsvHost } from "./tsv-host.js";
import {
  checkFileExists,
  gitDiffTopSpecFolder,
  isDirectory,
  normalizePath,
  runFile,
} from "./utils.js";

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
    return readFileImpl(join(folder, "tspconfig.yaml"), "utf-8");
  }

  readFile(path: string): Promise<string> {
    return readFileImpl(path, "utf-8");
  }

  runFile(file: string, args: string[], cwd?: string): Promise<[Error | null, string, string]> {
    return runFile(file, args, cwd);
  }

  runNpm(args: string[], cwd?: string): Promise<[Error | null, string, string]> {
    const [file, defaultArgs] = process.platform === "win32" ?
      // "C:\Program Files\nodejs\node.exe", ["C:\Program Files\nodejs\node_modules\npm\bin\npm-cli.js"]
      [process.execPath, [join(dirname(process.execPath), 'node_modules', 'npm', 'bin', 'npm-cli.js')]] :
      ["npm", []];

      return this.runFile(file, [...defaultArgs, ...args], cwd);
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
