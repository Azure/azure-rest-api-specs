import { Options as GlobbyOptions } from "globby";
import defaultPath, { PlatformPath } from "path";
import { RuleResult } from "../src/rule-result.js";
import { IGitOperation, TsvHost } from "../src/tsv-host.js";

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

  async gitDiffTopSpecFolder(_host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdout = `Running git diff on folder ${folder}}`;
    let stderr = "";

    return {
      success: success,
      stdOutput: stdout,
      errorOutput: stderr,
    };
  }

  async globby(patterns: string | string[], _options?: GlobbyOptions): Promise<string[]> {
    return Promise.resolve(Array.isArray(patterns) ? patterns : [patterns]);
  }
}
