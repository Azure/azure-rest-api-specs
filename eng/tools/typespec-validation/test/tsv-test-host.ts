import defaultPath, { PlatformPath } from "path";
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

  async runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]> {
    let err = null;
    let stdout = `default ${cmd} at ${cwd}`;
    let stderr = "";

    return [err, stdout, stderr];
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
    let stdout = `Running git diff on folder ${folder}, running default cmd ${host.runCmd("", "")}`;
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

  async globby(patterns: string[]): Promise<string[]> {
    return Promise.resolve(patterns);
  }

  async getSuppressions(_path: string): Promise<Suppression[]> {
    return Promise.resolve([]);
  }
}
