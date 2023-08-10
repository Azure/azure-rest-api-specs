import { access } from "fs/promises";
import path from "path";
import { runCmd } from "./RunCmd.js";
import { TSVRule, TSVRuleResult } from "./TSVRule.js";

export class CompileRule implements TSVRule {
  readonly name = "Compile";
  readonly description = "Compile TypeSpec";

  async execute(folder: string): Promise<TSVRuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput: string | undefined;

    if (await checkFileExists(path.join(folder, "main.tsp"))) {
      let [std, err] = await runCmd(`npx --no tsp compile . --warn-as-error`, folder);
      stdOutput += std;
      if (err == null) {
        success = false;
        errorOutput += err;
      }
    }
    if (await checkFileExists(path.join(folder, "client.tsp"))) {
      let [std, err] = await runCmd(
        `npx --no tsp compile client.tsp --no-emit --warn-as-error`,
        folder
      );
      stdOutput += std;
      if (err == null) {
        success = false;
        errorOutput += err;
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}

async function checkFileExists(file: string) {
  return access(file)
    .then(() => true)
    .catch(() => false);
}
