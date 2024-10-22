import { RuleResult } from "./rule-result.js";

export interface TsvHost {
  checkFileExists(file: string): Promise<boolean>;
  isDirectory(path: string): Promise<boolean>;
  gitOperation(folder: string): IGitOperation;
  readTspConfig(folder: string): Promise<string>;
  runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]>;
  normalizePath(folder: string): string;
  gitDiffTopSpecFolder(host: TsvHost, baseFolder: string, changedFolder: string): Promise<RuleResult>;
  globby(patterns: string[]): Promise<string[]>;
}

export interface IGitOperation {
  diff(options?: string[]): Promise<string>;
}
