import { Options as GlobbyOptions } from "globby";
import { RuleResult } from "./rule-result.js";

export interface TsvHost {
  gitOperation(folder: string): IGitOperation;
  gitDiffTopSpecFolder(host: TsvHost, folder: string): Promise<RuleResult>;
  globby(patterns: string | string[], options?: GlobbyOptions): Promise<string[]>;
}

export interface IGitOperation {
  status(
    options?: string[],
  ): Promise<{ isClean(): boolean; modified: string[]; not_added: string[] }>;
  diff(): Promise<string>;
  revparse(option: string): Promise<string>;
}
