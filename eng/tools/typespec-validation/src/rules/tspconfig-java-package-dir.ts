import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class TspConfigJavaPackageDirectoryRule implements Rule {
  pattern = new RegExp(/^azure(-\w+)+$/);

  readonly name = "tspconfig-java-package-dir";
  readonly description = `"options.@azure-tools/typespec-java.package-dir" must match ${this.pattern}.`;
  readonly action = `Please update "options.@azure-tools/typespec-java.package-dir" to start with "azure", followed by one or more "-<word>" segments. Each segment can contains letters, digits, or underscores. For example: "azure-test".`;
  // TODO: provide link to the rule details and full sample
  readonly link = "";
  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    const tspconfigExists = await host.checkFileExists(join(folder, "tspconfig.yaml"));
    if (!tspconfigExists)
      return this.createFailedResult(`Failed to find ${join(folder, "tspconfig.yaml")}`);

    let config = undefined;
    try {
      const configText = await host.readTspConfig(folder);
      config = yamlParse(configText);
    } catch (error) {
      // TODO: append content " Check tpsconfig-file-exists rule for more details." when it's ready
      return this.createFailedResult(`Failed to parse ${join(folder, "tspconfig.yaml")}`);
    }

    const javaEmitterOptions = config?.options?.["@azure-tools/typespec-java"];

    if (!javaEmitterOptions)
      return this.createFailedResult(`Failed to find "options.@azure-tools/typespec-java"`);

    const packageDir = javaEmitterOptions?.["package-dir"];
    if (!packageDir)
      return this.createFailedResult(
        `Failed to find "options.@azure-tools/typespec-java.package-dir"`,
      );

    if (!this.pattern.test(packageDir)) {
      return this.createFailedResult(
        `package-dir "${packageDir}" does not match "${this.pattern}"`,
      );
    }
    return { success: true, stdOutput: `[${this.name}]: validation passed.` };
  }

  createFailedResult(errorMessage: string): RuleResult {
    return {
      success: false,
      errorOutput: `[${this.name}]: ${errorMessage}. ${this.description} ${this.action} For more information and full samples, see ${this.link}.`,
    };
  }
}
