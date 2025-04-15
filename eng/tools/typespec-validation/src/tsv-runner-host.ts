import { simpleGit } from "simple-git";
import { RuleResult } from "./rule-result.js";
import { IGitOperation, TsvHost } from "./tsv-host.js";
import { gitDiffTopSpecFolder } from "./utils.js";

export class TsvRunnerHost implements TsvHost {
  gitOperation(folder: string): IGitOperation {
    return simpleGit(folder);
  }

  gitDiffTopSpecFolder(host: TsvHost, folder: string): Promise<RuleResult> {
    return gitDiffTopSpecFolder(host, folder);
  }
}
