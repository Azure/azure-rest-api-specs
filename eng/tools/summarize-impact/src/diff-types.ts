export enum FileTypes {
  ExampleFile = "ExampleFile",
  ReadmeFile = "ReadmeFile",
  SwaggerFile = "SwaggerFile",
  TypeSpecFile = "TypeSpecFile",
}

export enum ChangeTypes {
  Addition = "Addition",
  Deletion = "Deletion",
  Update = "Update",
}

export type PRChange = {
  fileType: FileTypes;
  changeType: ChangeTypes;
  filePath: string;
  additionalInfo?: any;
};

export type ReadmeTag = {
  readme: string;
  tags: DiffResult<string>;
};

export type TagConfigDiff = {
  name: string;
  oldConfig?: any;
  newConfig?: any;
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
