import path from "path";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class CompileRule implements Rule {
  readonly name = "Compile";
  readonly description = "Compile TypeSpec";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    if (await host.checkFileExists(path.join(folder, "main.tsp"))) {
      let [err, stdout, stderr] = await host.runCmd(
        `npx --no tsp compile . --warn-as-error`,
        folder,
      );
      if (
        stdout.toLowerCase().includes("no emitter was configured") ||
        stdout.toLowerCase().includes("no output was generated")
      ) {
        success = false;
        errorOutput += "No emitter was configured and/or no output was generated.";
      }
      if (err) {
        success = false;
        errorOutput += err.message;
      }
      stdOutput += stdout;
      errorOutput += stderr;
    }
    if (await host.checkFileExists(path.join(folder, "client.tsp"))) {
      let [err, stdout, stderr] = await host.runCmd(
        `npx --no tsp compile client.tsp --no-emit --warn-as-error`,
        folder,
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
