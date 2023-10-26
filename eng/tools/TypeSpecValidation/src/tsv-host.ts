export interface TsvHost {
  checkFileExists(file: string): Promise<boolean>;
  gitOperation(folder: string): IGitOperation;
  runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]>;
}

export interface IGitOperation {
  status(options?: string[]): Promise<{ isClean(): boolean; modified: string[] }>;
  diff(): Promise<string>;
  revparse(option: string): Promise<string>;
}
