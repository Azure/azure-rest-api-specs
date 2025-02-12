import { RuleResult } from "./rule-result.js";
import { TsvHost } from "./tsv-host.js";
import { join } from "path";
import { parse as yamlParse } from "yaml";

export type ExpectedValueType = string | boolean | RegExp;
export type SkipResult = { shouldSkip: boolean; reason?: string };

export abstract class TspconfigSubRuleBase {
  protected keyToValidate: string;
  protected expectedValue: ExpectedValueType;

  constructor(keyToValidate: string, expectedValue: ExpectedValueType) {
    this.keyToValidate = keyToValidate;
    this.expectedValue = expectedValue;
  }

  public async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    const tspconfigExists = await host.checkFileExists(join(folder, "tspconfig.yaml"));
    if (!tspconfigExists)
      return this.createFailedResult(
        `Failed to find ${join(folder, "tspconfig.yaml")}`,
        "Please add tspconfig.yaml",
      );

    let config = undefined;
    try {
      const configText = await host.readTspConfig(folder);
      config = yamlParse(configText);
    } catch (error) {
      return this.createFailedResult(
        `Failed to parse ${join(folder, "tspconfig.yaml")}`,
        "Please add tspconfig.yaml.",
      );
    }

    const { shouldSkip, reason } = this.skip(config, folder);
    if (shouldSkip)
      return {
        success: true,
        stdOutput: `Validation skipped. ${reason}`,
      };
    return this.validate(config);
  }

  protected skip(_config: any, _folder: string): SkipResult {
    return { shouldSkip: false };
  }

  protected abstract validate(config: any): RuleResult;

  protected validateValue(
    actual: string | boolean | undefined,
    expected: ExpectedValueType,
  ): boolean {
    switch (typeof expected) {
      case "boolean":
      case "string":
        return actual === expected;
      case "object":
        return typeof actual === "string" && expected.test(actual);
      default:
        console.warn("Unsupported expected-value-type for tspconfig.yaml");
        return false;
    }
  }

  protected createFailedResult(error: string, action: string): RuleResult {
    return {
      success: false,
      errorOutput: `- ${error}. ${action}.`,
    };
  }
}

export class TspconfigParameterSubRuleBase extends TspconfigSubRuleBase {
  constructor(keyToValidate: string, expectedValue: ExpectedValueType) {
    super(keyToValidate, expectedValue);
  }

  protected validate(config: any): RuleResult {
    const parameter = config?.parameters?.[this.keyToValidate]?.default;
    if (parameter === undefined)
      return this.createFailedResult(
        `Failed to find "parameters.${this.keyToValidate}.default"`,
        `Please add "parameters.${this.keyToValidate}.default"`,
      );

    if (!this.validateValue(parameter, this.expectedValue))
      return this.createFailedResult(
        `The value of parameters.${this.keyToValidate}.default "${parameter}" does not match "${this.expectedValue}"`,
        `Please update the value of "parameters.${this.keyToValidate}.default" to match "${this.expectedValue}".`,
      );

    return { success: true };
  }
}

export class TspconfigEmitterOptionsSubRuleBase extends TspconfigSubRuleBase {
  private emitterName: string;

  constructor(emitterName: string, keyToValidate: string, expectedValue: ExpectedValueType) {
    super(keyToValidate, expectedValue);
    this.emitterName = emitterName;
  }

  protected validate(config: any): RuleResult {
    let option: Record<string, any> | undefined = config?.options?.[this.emitterName];
    for (const segment of this.keyToValidate.split(".")) {
      if (option && typeof option === "object" && !Array.isArray(option) && segment in option)
        option = option![segment];
      else
        return this.createFailedResult(
          `Failed to find "options.${this.emitterName}.${this.keyToValidate}"`,
          `Please add "options.${this.emitterName}.${this.keyToValidate}"`,
        );
    }

    if (option === undefined)
      return this.createFailedResult(
        `Failed to find "options.${this.emitterName}.${this.keyToValidate}"`,
        `Please add "options.${this.emitterName}.${this.keyToValidate}"`,
      );

    const actualValue = option as unknown as undefined | string | boolean;
    if (!this.validateValue(actualValue, this.expectedValue))
      return this.createFailedResult(
        `The value of options.${this.emitterName}.${this.keyToValidate} "${actualValue}" does not match "${this.expectedValue}"`,
        `Please update the value of "options.${this.emitterName}.${this.keyToValidate}" to match "${this.expectedValue}"`,
      );

    return { success: true };
  }
}
