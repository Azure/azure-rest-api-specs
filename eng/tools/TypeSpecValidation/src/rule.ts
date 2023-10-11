import { RuleResult } from "./rule-result.js";

export interface Rule {
  readonly name: string;
  readonly description: string;
  execute(folder?: string): Promise<RuleResult>;
}
