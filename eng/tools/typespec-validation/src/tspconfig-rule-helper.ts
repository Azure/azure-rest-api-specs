import { Rule } from "./rule.js";
import { RuleResult } from "./rule-result.js";
import { TsvHost } from "./tsv-host.js";
import { join } from "path";
import { parse as yamlParse } from "yaml";

type ExpectedValueType = string | boolean | RegExp;

class TspconfigRuleBase implements Rule {
  name: string;
  description: string;

  protected keyToValidate: string;
  protected expectedValue: ExpectedValueType;

  constructor(
    ruleName: string,
    description: string,
    keyToValidate: string,
    expectedValue: ExpectedValueType,
  ) {
    this.name = ruleName;
    this.description = description;
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

    const { shouldSkip, skipResult } = this.skip(config);
    if (shouldSkip) return skipResult;
    return this.validate(config);
  }

  protected skip(_: any): { shouldSkip: boolean; skipResult: RuleResult } {
    return { shouldSkip: false, skipResult: { success: true } };
  }

  protected validate(_: any): RuleResult {
    return { success: true, stdOutput: `Nothing to validate.` };
  }

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

  // NOTE: to avoid huge impact on all sdk automation, since there's no single rules suppress mechanism, we will keep the success as true
  protected createFailedResult(error: string, action: string): RuleResult {
    return {
      success: true,
      stdOutput: `[${this.name}]: ${error}. ${this.description} ${action}.`,
    };
  }
}

export class TspconfigParameterRuleBase extends TspconfigRuleBase {
  constructor(
    ruleName: string,
    description: string,
    keyToValidate: string,
    expectedValue: ExpectedValueType,
  ) {
    super(ruleName, description, keyToValidate, expectedValue);
  }

  protected validate(config: any): RuleResult {
    const parameter = config?.parameters?.[this.keyToValidate]?.default;
    if (!parameter)
      return this.createFailedResult(
        `Failed to find "parameters.${this.keyToValidate}.default"`,
        `Please add "parameters.${this.keyToValidate}.default"`,
      );

    if (this.expectedValue instanceof RegExp) {
      if (!this.validateValue(parameter, this.expectedValue))
        return this.createFailedResult(
          `The value of parameters.${this.keyToValidate}.default "${parameter}" does not match "${this.expectedValue}"`,
          `Please update the value of "parameters.${this.keyToValidate}.default" to match "${this.expectedValue}".`,
        );
    }

    return { success: true, stdOutput: `[${this.name}]: validation passed.` };
  }
}

export class TspconfigEmitterOptionsRuleBase extends TspconfigRuleBase {
  private emitterName: string;

  constructor(
    ruleName: string,
    description: string,
    emitterName: string,
    keyToValidate: string,
    expectedValue: ExpectedValueType,
  ) {
    super(ruleName, description, keyToValidate, expectedValue);
    this.emitterName = emitterName;
  }

  protected validate(config: any): RuleResult {
    const emitterOptions = config?.options?.[this.emitterName];
    if (!emitterOptions)
      return this.createFailedResult(
        `Failed to find "options.@${this.emitterName}"`,
        `Please add "options.@${this.emitterName}"`,
      );

    const value = emitterOptions[this.keyToValidate];
    if (!value)
      return this.createFailedResult(
        `Failed to find "options.@${this.emitterName}.${this.keyToValidate}"`,
        `Please add "options.@${this.emitterName}.${this.keyToValidate}"`,
      );

    if (this.expectedValue instanceof RegExp) {
      if (!this.validateValue(value, this.expectedValue))
        return this.createFailedResult(
          `The value of options.@${this.emitterName}.${this.keyToValidate} "${value}" does not match "${this.expectedValue}"`,
          `Please update the value of "options.@${this.emitterName}.${this.keyToValidate}" to match "${this.expectedValue}".`,
        );
    }

    return { success: true, stdOutput: `[${this.name}]: validation passed.` };
  }
}
