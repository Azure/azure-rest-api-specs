import { RuleResult } from "./rule-result.js";
import { TsvHost } from "./tsv-host.js";

export interface Rule {
  readonly name: string;
  readonly description: string;
  // TODO: required when all rules apply it
  readonly action?: string;
  // TODO: required when all rules apply it
  readonly link?: string;
  execute(host?: TsvHost, folder?: string): Promise<RuleResult>;
}
