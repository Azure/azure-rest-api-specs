import { RuleResult } from "./rule-result.js";

export interface Rule {
  readonly name: string;
  readonly description: string;
  // TODO: required when all rules apply it
  readonly action?: string;
  // TODO: required when all rules apply it
  readonly link?: string;
  execute(folder: string): Promise<RuleResult>;
}
