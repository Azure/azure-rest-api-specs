export interface TsvHost {
  checkFileExists(file: string): Promise<boolean>;
  isDirectory(path: string): Promise<boolean>;
  gitOperation(folder: string): IGitOperation;
  readTspConfig(folder: string): Promise<string>;
  runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]>;
  normalizePath(folder: string): string;
  globby(patterns: string[]): Promise<string[]>;
}

export interface IGitOperation {
  status(options?: string[]): Promise<{ isClean(): boolean; modified: string[] }>;
  diff(): Promise<string>;
  revparse(option: string): Promise<string>;
}
