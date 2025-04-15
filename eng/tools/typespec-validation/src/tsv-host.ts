import { RuleResult } from "./rule-result.js";

export interface TsvHost {
  gitOperation(folder: string): IGitOperation;
  gitDiffTopSpecFolder(host: TsvHost, folder: string): Promise<RuleResult>;
}

export interface IGitOperation {
  status(
    options?: string[],
  ): Promise<{ isClean(): boolean; modified: string[]; not_added: string[] }>;
  diff(): Promise<string>;
  revparse(option: string): Promise<string>;
}
