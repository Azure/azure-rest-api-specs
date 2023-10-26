export interface TsvHost {
  gitOperation(folder: string): IGitOperation;
  runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]>;
  checkFileExists(file: string): Promise<boolean>;
}

export interface IGitOperation {
  status(options?: string[]): Promise<{ isClean(): boolean; modified: string[] }>;
  diff(): Promise<string>;
  revparse(option: string): Promise<string>;
}
