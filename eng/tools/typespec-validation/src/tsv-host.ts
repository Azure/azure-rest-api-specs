import { Options as GlobbyOptions } from "globby";
import { Suppression } from "suppressions";
import { RuleResult } from "./rule-result.js";

export interface TsvHost {
  checkFileExists(file: string): Promise<boolean>;
  isDirectory(path: string): Promise<boolean>;
  gitOperation(folder: string): IGitOperation;
  readTspConfig(folder: string): Promise<string>;
  readFile(path: string): Promise<string>;
  runFile(file: string, args: string[], cwd?: string): Promise<[Error | null, string, string]>;
  runNpm(args: string[], cwd?: string): Promise<[Error | null, string, string]>;
  normalizePath(folder: string): string;
  gitDiffTopSpecFolder(host: TsvHost, folder: string): Promise<RuleResult>;
  globby(patterns: string | string[], options?: GlobbyOptions): Promise<string[]>;
  getSuppressions(path: string): Promise<Suppression[]>;
}

export interface IGitOperation {
  status(
    options?: string[],
  ): Promise<{ isClean(): boolean; modified: string[]; not_added: string[] }>;
  diff(): Promise<string>;
  revparse(option: string): Promise<string>;
}
