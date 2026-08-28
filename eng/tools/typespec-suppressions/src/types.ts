export interface SourceLocation {
  line: number;
  column: number;
}

export interface RuleMetadata {
  packageName?: string;
  localRuleName?: string;
  description?: string;
  documentationUrl?: string;
  guidelineCodes?: string[];
}

export interface SuppressionRecord {
  specPath: string;
  sourceKind: "inline" | "tspconfig";
  ruleName: string;
  justification: string;
  sourceFile: string;
  anchorPath: string;
  location: SourceLocation;
  rawText: string;
  ruleMetadata?: RuleMetadata;
}

export interface SuppressionChange {
  before: SuppressionRecord;
  after: SuppressionRecord;
}

export interface SpecSuppressionReport {
  specPath: string;
  baseSuppressions: SuppressionRecord[];
  headSuppressions: SuppressionRecord[];
  newSuppressions: SuppressionRecord[];
  removedSuppressions: SuppressionRecord[];
  changedSuppressions: SuppressionChange[];
  unchangedSuppressions: SuppressionRecord[];
}

export interface SuppressionCounts {
  specs: number;
  base: number;
  head: number;
  new: number;
  removed: number;
  changed: number;
  unchanged: number;
}

export interface CheckedSuppressions {
  checkRules: string[];
  requiresApproval: boolean;
  counts: {
    new: number;
    removed: number;
    changed: number;
  };
  newSuppressions: SuppressionRecord[];
  removedSuppressions: SuppressionRecord[];
  changedSuppressions: SuppressionChange[];
}

export interface SuppressionReport {
  repoRoot: string;
  baseRevision: string;
  headRevision: string;
  specPaths: string[];
  checkRules?: string[];
  requiresApproval: boolean;
  counts: SuppressionCounts;
  specs: SpecSuppressionReport[];
  newSuppressions: SuppressionRecord[];
  removedSuppressions: SuppressionRecord[];
  changedSuppressions: SuppressionChange[];
  checkedSuppressions?: CheckedSuppressions;
}

export interface AnalyzeSuppressionsOptions {
  cwd?: string;
  baseRevision: string;
  headRevision: string;
  specPaths: string[];
  checkRules?: string[];
}

export interface AnalyzeSuppressionsDirectoriesOptions {
  baseRoot: string;
  headRoot: string;
  specPaths: string[];
  checkRules?: string[];
}
