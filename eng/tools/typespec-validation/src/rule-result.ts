export type RuleResult =
  | {
      readonly success: true;
    }
  | {
      readonly success: false;
      readonly reason: string;
    };
