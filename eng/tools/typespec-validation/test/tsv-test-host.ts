import { Options as GlobbyOptions } from "globby";
import defaultPath, { dirname, join, PlatformPath } from "path";
import { Suppression } from "suppressions";
import { RuleResult } from "../src/rule-result.js";
import { IGitOperation, TsvHost } from "../src/tsv-host.js";
import { normalizePath } from "../src/utils.js";

export { IGitOperation } from "../src/tsv-host.js";

export class TsvTestHost implements TsvHost {
  path: PlatformPath;

  constructor(path: PlatformPath = defaultPath) {
    this.path = path;
  }

  static get folder() {
    return "specification/foo/Foo";
  }

  gitOperation(_folder: string): IGitOperation {
    return {
      status: () => {
        return Promise.resolve({
          modified: [],
          not_added: [],
          isClean: () => true,
        });
      },
      diff: () => {
        return Promise.resolve("");
      },
      revparse: () => {
        return Promise.resolve("");
      },
    };
  }

  async runFile(file: string, args: string[], cwd?: string): Promise<[Error | null, string, string]> {
    let err = null;
    let stdout = `default ${file} ${args.join(" ")} at ${cwd}`;
    let stderr = "";

    return [err, stdout, stderr];
  }

  async runNpm(args: string[], cwd?: string): Promise<[Error | null, string, string]> {
    const [file, defaultArgs] = process.platform === "win32" ?
      // Only way I could find to run "npm" on Windows, without using the shell (e.g. "cmd /c npm ...")
      // "C:\Program Files\nodejs\node.exe", ["C:\Program Files\nodejs\node_modules\npm\bin\npm-cli.js"]
      [process.execPath, [join(dirname(process.execPath), 'node_modules', 'npm', 'bin', 'npm-cli.js')]] :
      ["npm", []];

    return this.runFile(file, [...defaultArgs, ...args], cwd);
  }

  async checkFileExists(_file: string): Promise<boolean> {
    return true;
  }

  async isDirectory(_path: string): Promise<boolean> {
    return true;
  }

  normalizePath(folder: string): string {
    return normalizePath(folder, this.path);
  }

  async gitDiffTopSpecFolder(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdout = `Running git diff on folder ${folder}, running default cmd ${host.runFile("", [], "")}`;
    let stderr = "";

    return {
      success: success,
      stdOutput: stdout,
      errorOutput: stderr,
    };
  }

  async readTspConfig(_folder: string): Promise<string> {
    // Sample config that should cause all rules to succeed
    return `
emit:
  - "@azure-tools/typespec-autorest"
linter:
  extends:
    - "@azure-tools/typespec-azure-rulesets/data-plane"
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
    emitter-output-dir: "{project-root}/.."
    examples-directory: "examples"
    output-file: "{azure-resource-provider-folder}/{service-name}/{version-status}/{version}/openapi.json"
`;
  }

  async readFile(_path: string): Promise<string> {
    return '{"info": {"x-typespec-generated": true}}';
  }

  async globby(patterns: string | string[], _options?: GlobbyOptions): Promise<string[]> {
    return Promise.resolve(Array.isArray(patterns) ? patterns : [patterns]);
  }

  async getSuppressions(_path: string): Promise<Suppression[]> {
    return Promise.resolve([]);
  }
}
