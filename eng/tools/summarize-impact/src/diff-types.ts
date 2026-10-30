export type ReadmeTag = {
  readme: string;
  tags: DiffResult<string>;
};

export type TagConfigDiff = {
  name: string;
  oldConfig?: unknown;
  newConfig?: unknown;
  difference?: unknown;
  changedInputFiles?: string[];
};

export type TagDiff = {
  readme: string;
  changes: string[];
  insertions: string[];
  deletions: string[];
  differences?: TagConfigDiff[];
};

export type DiffResult<T> = {
  additions?: T[];
  deletions?: T[];
  changes?: T[];
};
