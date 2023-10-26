export interface TsvHost {
  gitOperation(folder: string): IGitOperation;
  runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]>;
  checkFileExists(file: string): Promise<boolean>;
  // TODO: Other functions that need mocks
}

export interface IGitOperation {
  status(options?: string[]): Promise<{ isClean(): boolean; modified: string[] }>;
  diff(): Promise<string>;
  revparse(option: string): Promise<string>;
}
