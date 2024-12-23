import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class TspConfigJavaNamespaceValidRule implements Rule {
  readonly name = "tspconfig-java-namespace";
  readonly description =
    '"options.@azure-tools/typespec-java.namespace" must match "/^com\.azure(\.\w+)+$/", i.e. start with "com.azure", where each subsequent segment must consist of word characters, separated by dots (.).';
  readonly action =
    'Please update "options.@azure-tools/typespec-java.namespace" to match "/^com\.azure(\.\w+)+$/" in "tspconfig.yaml". For example: "com.azure.test.sample".';
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

    const namespace = javaEmitterOptions?.namespace;
    if (!namespace)
      return this.createFailedResult(
        `Failed to find "options.@azure-tools/typespec-java.namespace"`,
      );

    const pattern = new RegExp(/^com\.azure(\.\w+)+$/);
    if (!pattern.test(namespace)) {
      return this.createFailedResult(`Namespace "${namespace}" does not match "${pattern}"`);
    }
    return { success: true, stdOutput: `[${this.name}]: Validation passed.` };
  }

  createFailedResult(errorMessage: string): RuleResult {
    return {
      success: false,
      errorOutput: `[${this.name}]: ${errorMessage}. ${this.description} ${this.action} For more information and full samples, see ${this.link}.`,
    };
  }
}
