import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Format parent folder to include shared files
    let [err, stdout, stderr] = await host.runCmd(`npx tsp format "../**/*.tsp"`, folder);
    if (err) {
      success = false;
      errorOutput += err.message;
    }
    stdOutput += stdout;
    errorOutput += stderr;

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
