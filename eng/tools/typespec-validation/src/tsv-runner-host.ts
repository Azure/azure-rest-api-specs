import { join } from "path";
import { readFile } from "fs/promises";
import { IGitOperation, TsvHost } from "./tsv-host.js";
import { simpleGit } from "simple-git";
import { runCmd, checkFileExists } from "./utils.js";

export class TsvRunnerHost implements TsvHost {
  checkFileExists(file: string): Promise<boolean> {
    return checkFileExists(file);
  }

  gitOperation(folder: string): IGitOperation {
    return simpleGit(folder);
  }

  readTspConfig(folder: string): Promise<string> {
    return readFile(join(folder, "tspconfig.yaml"), "utf-8");
  }

  runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]> {
    return runCmd(cmd, cwd);
  }
}
