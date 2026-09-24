export interface RuleResult {
  readonly success: boolean;
  readonly suppressed?: boolean;
  readonly stdOutput?: string;
  readonly errorOutput?: string;
}
