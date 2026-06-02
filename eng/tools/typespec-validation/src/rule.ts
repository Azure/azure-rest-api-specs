import { RuleResult } from "./rule-result.js";

export interface Rule {
  readonly name: string;
  readonly description: string;
  // TODO: required when all rules apply it
  readonly action?: string;
  // TODO: required when all rules apply it
  readonly link?: string;
  /** When true, the rule runner automatically skips this rule if a matching suppression exists. */
  readonly suppressable?: boolean;
  execute(folder: string): Promise<RuleResult>;
}
