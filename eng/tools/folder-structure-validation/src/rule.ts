import { RuleResult } from "./rule-result.js";

export interface Rule {
  readonly name: string;
  readonly description: string;
  readonly action?: string;
  readonly link?: string;
  execute(folder: string): Promise<RuleResult>;
}
