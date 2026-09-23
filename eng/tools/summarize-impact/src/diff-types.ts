export const FileTypes = {
  ExampleFile: "ExampleFile",
  ReadmeFile: "ReadmeFile",
  SwaggerFile: "SwaggerFile",
  TypeSpecFile: "TypeSpecFile",
} as const;
export type FileTypes = (typeof FileTypes)[keyof typeof FileTypes];

export const ChangeTypes = {
  Addition: "Addition",
  Deletion: "Deletion",
  Update: "Update",
} as const;
export type ChangeTypes = (typeof ChangeTypes)[keyof typeof ChangeTypes];

export type PRChange = {
  fileType: FileTypes;
  changeType: ChangeTypes;
  filePath: string;
  additionalInfo?: unknown;
};

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

export type ChangeHandler<T = void> = {
  [key in FileTypes]?: (event: PRChange) => T;
};

export type DiffResult<T> = {
  additions?: T[];
  deletions?: T[];
  changes?: T[];
};
