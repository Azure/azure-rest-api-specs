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
    let errorOutput = "";

    if (await checkFileExists(path.join(folder, "main.tsp"))) {
      let [err, stdout, stderr] = await runCmd(`npx --no tsp compile . --warn-as-error`, folder);
      if (err) {
        success = false;
        errorOutput += err.message;
      }
      stdOutput += stdout;
      errorOutput += stderr;
    }
    if (await checkFileExists(path.join(folder, "client.tsp"))) {
      let [err, stdout, stderr] = await runCmd(
        `npx --no tsp compile client.tsp --no-emit --warn-as-error`,
        folder
      );
      if (err) {
        success = false;
        errorOutput += err.message;
      }
      stdOutput += stdout;
      errorOutput += stderr;
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
