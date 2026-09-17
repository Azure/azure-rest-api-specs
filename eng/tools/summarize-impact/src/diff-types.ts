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
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  additionalInfo?: any;
};

export type ReadmeTag = {
  readme: string;
  tags: DiffResult<string>;
};

export type TagConfigDiff = {
  name: string;
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  oldConfig?: any;
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  newConfig?: any;
  // oxlint-disable-next-line typescript/no-explicit-any -- Existing lint debt
  difference?: any;
  changedInputFiles?: string[];
};

export type TagDiff = {
  readme: string;
  changes: string[];
  insertions: string[];
  deletions: string[];
  differences?: TagConfigDiff[];
};

export type ChangeHandler = {
  [key in FileTypes]?: (event: PRChange) => void | Promise<void>;
};

export type DiffResult<T> = {
  additions?: T[];
  deletions?: T[];
  changes?: T[];
};
