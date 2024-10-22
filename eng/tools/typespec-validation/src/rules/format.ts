import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";
import { setupTempWorkspace, getServiceRoot } from "../utils.js";

export class FormatRule implements Rule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const workspaceDirectory = await setupTempWorkspace(host, folder);
    let [err, stdout, stderr] = await host.runCmd(
      'npm exec --no -- tsp format "../**/*.tsp"', // Format parent folder to include shared files
      workspaceDirectory,
    );
    if (err) {
      success = false;
      errorOutput += err.message;
    }
    stdOutput += stdout;
    errorOutput += stderr;

    [err, stdout, stderr] = await host.runCmd(
      "npm exec --no -- prettier --write tspconfig.yaml",
      folder,
    );
    if (err) {
      success = false;
      errorOutput += err.message;
    }
    stdOutput += stdout;
    errorOutput += stderr;

    if (success) {
      const gitDiffResult = await host.gitDiffTopSpecFolder(
        host,
        getServiceRoot(folder),
        getServiceRoot(workspaceDirectory),
      );
      stdOutput += gitDiffResult.stdOutput;
      if (!gitDiffResult.success) {
        success = false;
        errorOutput += gitDiffResult.errorOutput;
        errorOutput += `\nFiles have been changed after \`tsp format\`. Run \`tsp format\` and ensure all files are included in your change.`;
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
