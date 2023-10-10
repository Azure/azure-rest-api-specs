import { RuleResult } from "./rule-result.js";
import { TsvHost } from "./tsv-host.js";

export interface Rule {
  readonly name: string;
  readonly description: string;
  execute(folder?: string, host?: TsvHost): Promise<RuleResult>;
}
