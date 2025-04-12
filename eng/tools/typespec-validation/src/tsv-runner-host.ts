import { globby, Options as GlobbyOptions } from "globby";
import { dirname, join } from "path";
import { simpleGit } from "simple-git";
import { RuleResult } from "./rule-result.js";
import { IGitOperation, TsvHost } from "./tsv-host.js";
import { gitDiffTopSpecFolder, runFile } from "./utils.js";

export class TsvRunnerHost implements TsvHost {
  gitOperation(folder: string): IGitOperation {
    return simpleGit(folder);
  }

  runFile(file: string, args: string[], cwd?: string): Promise<[Error | null, string, string]> {
    return runFile(file, args, cwd);
  }

  runNpm(args: string[], cwd?: string): Promise<[Error | null, string, string]> {
    const [file, defaultArgs] =
      process.platform === "win32"
        ? [
            // Only way I could find to run "npm" on Windows, without using the shell (e.g. "cmd /c npm ...")
            //
            // "node.exe", ["--", "npm-cli.js", ...args]
            //
            // The "--" MUST come BEFORE "npm-cli.js", to ensure args are sent to the script unchanged.
            // If the "--" comes after "npm-cli.js", the args sent to the script will be ["--", ...args],
            // which is NOT equivalent, and can break if args itself contains another "--".

            // example: "C:\Program Files\nodejs\node.exe"
            process.execPath,

            // example: "C:\Program Files\nodejs\node_modules\npm\bin\npm-cli.js"
            ["--", join(dirname(process.execPath), "node_modules", "npm", "bin", "npm-cli.js")],
          ]
        : ["npm", []];

    return this.runFile(file, [...defaultArgs, ...args], cwd);
  }

  gitDiffTopSpecFolder(host: TsvHost, folder: string): Promise<RuleResult> {
    return gitDiffTopSpecFolder(host, folder);
  }

  globby(patterns: string | string[], options?: GlobbyOptions): Promise<string[]> {
    return globby(patterns, options);
  }
}
