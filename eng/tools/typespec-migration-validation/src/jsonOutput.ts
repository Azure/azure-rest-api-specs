interface ChangeBase {
  category: string;
  path: string;
}

export interface ValueChange extends ChangeBase {
  category: "value-changed";
  oldValue: string;
  newValue: string;
}

export interface AddDeleteChange extends ChangeBase {
  category: "added-or-deleted";
  key: string;
  type: "added" | "deleted";
  value: string;
}

export interface PathChange extends ChangeBase {
  category: "path-changed";
  type: "added" | "deleted";
}

export type Change = ValueChange | AddDeleteChange | PathChange;

export interface Suggestion {
  suggestion: string;
  path?: string;
}
export interface JsonOutput {
  version: "1.0.0";
  suggestions: Suggestion[];
  apiChanges: Change[];
}

export const jsonOutput: JsonOutput = {
  version: "1.0.0",
  suggestions: [],
  apiChanges: [],
};
