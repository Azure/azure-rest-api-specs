export interface PRSummaryOptions {
  number: number;
  owner: string;
  repo: string;
  outputFile?: string;
}

export interface FileChange {
  filename: string;
  status: "added" | "removed" | "modified" | "renamed";
  additions: number;
  deletions: number;
  changes: number;
  patch?: string;
}

export interface FileCategory {
  name: string;
  files: FileChange[];
  totalAdditions: number;
  totalDeletions: number;
  totalChanges: number;
}

export interface PRSummary {
  number: number;
  title: string;
  body: string;
  author: string;
  state: string;
  createdAt: string;
  updatedAt: string;
  additions: number;
  deletions: number;
  changedFiles: number;
  commits: number;
  categories: FileCategory[];
}
