export interface RuleResult {
  readonly success: boolean;
  readonly stdOutput?: string;
  readonly errorOutput?: string;
}
