export interface TSVRule {
  readonly name: string;
  readonly description: string;
  execute(folder?: string): Promise<TSVRuleResult>;
}

export interface TSVRuleResult {
  readonly success: boolean;
  readonly stdOutput?: string;
  readonly errorOutput?: string;
}
