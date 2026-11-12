import type { ILogger } from "@azure-tools/specs-shared/logger";
import { type RuleResult } from "./rule-result.ts";

export interface RuleExecutionOptions {
  /** Allow rules to apply fixes instead of only checking files. */
  readonly fix?: boolean;
}

export interface Rule {
  readonly name: string;
  readonly description: string;
  // TODO: required when all rules apply it
  readonly action?: string;
  // TODO: required when all rules apply it
  readonly link?: string;
  /** When true, the rule runner automatically skips this rule if a matching suppression exists. */
  readonly suppressable?: boolean;
  execute(folder: string, logger: ILogger, options?: RuleExecutionOptions): Promise<RuleResult>;
}
