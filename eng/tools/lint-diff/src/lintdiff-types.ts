import { Readme } from "@azure-tools/specs-shared/readme";
import { ExecException } from "node:child_process";

// TODO: Reduce to minimal set of properties
export type AutorestRunResult = {
  rootPath: string;
  readme: Readme;
  tag: string;

  error: ExecException | null;
  stdout: string;
  stderr: string;
};

export interface AutoRestMessage {
  level: "information" | "warning" | "error" | "debug" | "verbose" | "fatal";
  code?: any;
  message: string;
  readme?: string;
  tag?: string;
  groupName?: string;
}

// TODO: Name
export type BeforeAfter = {
  // TODO: This is nullable
  before: AutorestRunResult | null;
  after: AutorestRunResult;
};

export type Source = {
  document: string;
  position: {
    line: number;
    // TODO: this is misspelled in momentOfTruthUtils.ts. Is this value ever
    // properly populated?
    colomn: number;
  };
};

export type LintingResultMessage = {
  level: string;
  code: string;
  message: string;
  source: Source[];
  validationCategory?: string;
  details: {
    jsonpath: (string | number)[];
    validationCategory?: string;
  };
};

export type LintDiffViolation = LintingResultMessage & {
  groupName?: string;
  filePath?: string;
  lineNumber?: number;
  armRpcs?: string[];
};

export type ReadmeAffectedTags = {
  readme: Readme;
  changedTags: Set<string>;
};
