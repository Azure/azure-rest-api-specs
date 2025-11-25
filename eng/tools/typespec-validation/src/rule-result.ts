export enum RuleFailureType {
  NotFind = "not_find",
  Mismatch = "mismatch",
  ParseError = "parse_error",
  TypeError = "type_error"
}

export interface RuleResult {
  readonly success: boolean;
  readonly type?: RuleFailureType;
  readonly stdOutput?: string;
  readonly errorOutput?: string;
}
