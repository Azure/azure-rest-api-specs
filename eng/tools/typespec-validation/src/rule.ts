import { RuleResult } from "./rule-result.js";
import { TsvHost } from "./tsv-host.js";

export interface Rule {
  readonly name: string;
  readonly description: string;
  execute(host?: TsvHost, folder?: string): Promise<RuleResult>;
}
