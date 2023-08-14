import path from "path";
import { runCmd, checkFileExists } from "../utils.js";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";

export class CompileRule implements Rule {
  readonly name = "Compile";
  readonly description = "Compile TypeSpec";

  async execute(folder: string): Promise<RuleResult> {
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
