/* eslint-disable */
// TODO: Enable eslint, fix errors

import { join } from "path";
import { Suppression } from "suppressions";
import { parse as yamlParse } from "yaml";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { fileExists, getSuppressions, readTspConfig } from "../utils.js";

type ExpectedValueType = string | boolean | RegExp;
type SkipResult = { shouldSkip: boolean; reason?: string };

export abstract class TspconfigSubRuleBase {
  protected keyToValidate: string;
  protected expectedValue: ExpectedValueType;

  constructor(keyToValidate: string, expectedValue: ExpectedValueType) {
    this.keyToValidate = keyToValidate;
    this.expectedValue = expectedValue;
  }

  public async execute(folder: string): Promise<RuleResult> {
    const config = await this.loadConfig(folder);
    if (!config) {
      return this.createFailedResult(
        `Failed to load ${join(folder, "tspconfig.yaml")}`,
        "Please ensure tspconfig.yaml exists and is valid",
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

  public async loadConfig(folder: string): Promise<any | undefined> {
    const tspconfigExists = await fileExists(join(folder, "tspconfig.yaml"));
    if (!tspconfigExists) {
      return undefined;
    }

    try {
      const configText = await readTspConfig(folder);
      const config = yamlParse(configText);
      return config;
    } catch (error) {
      console.warn(`Failed to parse tspconfig.yaml in ${folder}: ${error}`);
      return undefined;
    }
  }

  protected skip(_config: any, _folder: string): SkipResult {
    return { shouldSkip: false };
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

  protected createFailedResult(error: string, action: string): RuleResult {
    return {
      success: false,
      errorOutput: `- ${error}. ${action}.`,
    };
  }

  public abstract getPathOfKeyToValidate(): string;
  protected abstract validate(config: any): RuleResult;
}

class TspconfigParameterSubRuleBase extends TspconfigSubRuleBase {
  constructor(keyToValidate: string, expectedValue: ExpectedValueType) {
    super(keyToValidate, expectedValue);
  }

  protected validate(config: any): RuleResult {
    const parameter = config?.parameters?.[this.keyToValidate]?.default;
    if (parameter === undefined)
      return this.createFailedResult(
        `Failed to find "parameters.${this.keyToValidate}.default" with expected value "${this.expectedValue}"`,
        `Please add "parameters.${this.keyToValidate}.default" with expected value "${this.expectedValue}".`,
      );

    if (!this.validateValue(parameter, this.expectedValue))
      return this.createFailedResult(
        `The value of parameters.${this.keyToValidate}.default "${parameter}" does not match "${this.expectedValue}"`,
        `Please update the value of "parameters.${this.keyToValidate}.default" to match "${this.expectedValue}".`,
      );

    return { success: true };
  }

  public getPathOfKeyToValidate() {
    return `parameters.${this.keyToValidate}.default`;
  }
}

class TspconfigEmitterOptionsSubRuleBase extends TspconfigSubRuleBase {
  protected emitterName: string;

  constructor(emitterName: string, keyToValidate: string, expectedValue: ExpectedValueType) {
    super(keyToValidate, expectedValue);
    this.emitterName = emitterName;
  }

  public getEmitterName() {
    return this.emitterName;
  }

  protected tryFindOption(config: any, keyToValidate?: string): Record<string, any> | undefined {
    const key = keyToValidate ?? this.keyToValidate;
    let option: Record<string, any> | undefined = config?.options?.[this.emitterName];
    for (const segment of key.split(".")) {
      if (option && typeof option === "object" && !Array.isArray(option) && segment in option)
        option = option![segment];
      else return undefined;
    }
    return option;
  }

  protected resolveVariables(
    value: string,
    config: Record<string, any>,
  ): { resolved: string; error?: string } {
    let resolvedValue = value;
    const variablePattern = /\{([^}]+)\}/g;
    const maxIterations = 10; // Prevent infinite loops
    let iterations = 0;

    // Keep resolving until no more variables are found or max iterations reached
    while (resolvedValue.includes("{") && iterations < maxIterations) {
      iterations++;
      let hasUnresolvedVariables = false;
      const currentValue = resolvedValue;

      // Reset regex lastIndex for each iteration
      variablePattern.lastIndex = 0;
      let match;

      while ((match = variablePattern.exec(currentValue)) !== null) {
        const variableName = match[1];

        // Try to resolve variable from multiple sources:
        // 1. From the emitter's options (e.g., namespace, package-name)
        // 2. From parameters (e.g., service-dir, output-dir)
        // 3. From global options
        let variableValue: string | undefined;

        // Check emitter options first
        variableValue = config?.options?.[this.emitterName]?.[variableName];

        // If not found, check parameters
        if (!variableValue) {
          variableValue = config?.parameters?.[variableName]?.default;
        }

        // If not found, check global options (for variables like output-dir)
        if (!variableValue) {
          variableValue = config?.[variableName];
        }

        if (variableValue && typeof variableValue === "string") {
          resolvedValue = resolvedValue.replace(`{${variableName}}`, variableValue);
        } else {
          hasUnresolvedVariables = true;
        }
      }

      // If no progress was made in this iteration and there are still unresolved variables, return error
      if (hasUnresolvedVariables && resolvedValue === currentValue) {
        const unresolvedMatch = resolvedValue.match(/\{([^}]+)\}/);
        const unresolvedVar = unresolvedMatch ? unresolvedMatch[1] : "unknown";
        return {
          resolved: resolvedValue,
          error: `Could not resolve variable {${unresolvedVar}}. The variable is not defined in options.${this.emitterName}, parameters, or config`,
        };
      }

      // If no more variables to resolve, break
      if (!resolvedValue.includes("{")) {
        break;
      }
    }

    if (iterations >= maxIterations && resolvedValue.includes("{")) {
      return {
        resolved: resolvedValue,
        error: `Maximum resolution depth reached. Possible circular reference in variable resolution.`,
      };
    }

    return { resolved: resolvedValue };
  }

  protected getPackageDirFromEmitterOutputDir(config: Record<string, any>): {
    resolved: string;
    error?: string;
  } {
    const option = this.tryFindOption(config, "emitter-output-dir");
    if (option === undefined) {
      return {
        resolved: "",
        error: `Failed to find "options.${this.emitterName}.emitter-output-dir"`,
      };
    }

    const actualValue = option as unknown as undefined | string | boolean;
    if (typeof actualValue !== "string") {
      return {
        resolved: "",
        error: `The value of options.${this.emitterName}.emitter-output-dir "${actualValue}" must be a string`,
      };
    }
    // Handle various path formats with different prefixes
    // Format 1: {output-dir}/{service-dir}/azure-mgmt-advisor
    // Format 2: {service-dir}/azure-mgmt-advisor where service-dir might include {output-dir}
    // Format 3: {output-dir}/{service-dir}/azadmin/settings where we need to validate "azadmin/settings"
    // Format 4: {output-dir}/sdk/dellstorage/{xxxx} where we need to validate "{xxxx}"

    let extractedPath: string;
    if (!actualValue.includes("/")) {
      extractedPath = actualValue;
    } else {
      const pathParts = actualValue.split("/");
      const filteredParts = pathParts.filter(
        (part) => !(part === "{output-dir}" || part === "{service-dir}"),
      );

      // If the last part is a variable (e.g., {namespace}, {package-name}, {xxxx}), use it as extractedPath
      const lastPart = pathParts[pathParts.length - 1];
      if (lastPart.startsWith("{") && lastPart.endsWith("}")) {
        extractedPath = lastPart;
      } else {
        extractedPath = filteredParts.join("/");
      }
    }
    // Resolve variables in the extracted path
    return this.resolveVariables(extractedPath, config);
  }

  protected validate(config: any): RuleResult {
    const option = this.tryFindOption(config);
    if (option === undefined)
      return this.createFailedResult(
        `Failed to find "options.${this.emitterName}.${this.keyToValidate}" with expected value "${this.expectedValue}"`,
        `Please add "options.${this.emitterName}.${this.keyToValidate}" with expected value "${this.expectedValue}"`,
      );

    let actualValue = option as unknown as undefined | string | boolean;

    // First try to validate directly
    if (this.validateValue(actualValue, this.expectedValue)) {
      return { success: true };
    }

    // Resolve variables if the value is a string
    if (typeof actualValue === "string" && actualValue.includes("{")) {
      const { resolved, error } = this.resolveVariables(actualValue, config);
      if (error) {
        return this.createFailedResult(
          error,
          `Please define the variable in your configuration or use a direct value`,
        );
      }
      actualValue = resolved;
    }

    if (!this.validateValue(actualValue, this.expectedValue))
      return this.createFailedResult(
        `The value of options.${this.emitterName}.${this.keyToValidate} "${actualValue}" does not match "${this.expectedValue}"`,
        `Please update the value of "options.${this.emitterName}.${this.keyToValidate}" to match "${this.expectedValue}"`,
      );
    return { success: true };
  }

  public getPathOfKeyToValidate() {
    return `options.${this.emitterName}.${this.keyToValidate}`;
  }
}

class TspconfigEmitterOptionsEmitterOutputDirSubRuleBase extends TspconfigEmitterOptionsSubRuleBase {
  constructor(emitterName: string, keyToValidate: string, expectedValue: ExpectedValueType) {
    super(emitterName, keyToValidate, expectedValue);
  }

  protected validate(config: any): RuleResult {
    const result = this.getPackageDirFromEmitterOutputDir(config);
    if (result.error) {
      return this.createFailedResult(
        result.error,
        `Please add "options.${this.emitterName}.${this.keyToValidate}" with a path matching the SDK naming convention "${this.expectedValue}"`,
      );
    }

    // Validate the resolved path
    if (!this.validateValue(result.resolved, this.expectedValue)) {
      return this.createFailedResult(
        `The path part "${result.resolved}" in options.${this.emitterName}.${this.keyToValidate} does not match the required format "${this.expectedValue}"`,
        `Please update the emitter-output-dir path to follow the SDK naming convention`,
      );
    }

    return { success: true };
  }
}

function isManagementSdk(folder: string): boolean {
  return folder.includes("/resource-manager/") || folder.includes(".Management");
}

function skipForDataPlane(folder: string): SkipResult {
  return {
    shouldSkip: !isManagementSdk(folder),
    reason: "This rule is only applicable for management plane SDKs.",
  };
}

function skipForManagementPlane(folder: string): SkipResult {
  return {
    shouldSkip: isManagementSdk(folder),
    reason: "This rule is only applicable for data plane SDKs.",
  };
}

function skipForRestLevelClientOrManagementPlaneInTsEmitter(
  config: any,
  folder: string,
): SkipResult {
  const isRLCClient =
    config?.options?.["@azure-tools/typespec-ts"]?.["is-modular-library"] === false;
  const shouldSkip = isManagementSdk(folder) || isRLCClient;
  const result: SkipResult = {
    shouldSkip: shouldSkip,
  };
  if (result.shouldSkip)
    result.reason = "This rule is only applicable for data plane SDKs with modular client.";
  return result;
}

function skipForModularOrManagementPlaneInTsEmitter(config: any, folder: string): SkipResult {
  const isModularClient =
    config?.options?.["@azure-tools/typespec-ts"]?.["is-modular-library"] !== false;
  const shouldSkip = isManagementSdk(folder) || isModularClient;
  const result: SkipResult = {
    shouldSkip: shouldSkip,
  };
  if (result.shouldSkip)
    result.reason = "This rule is only applicable for data plane SDKs with rest level client.";
  return result;
}

function skipForNonModularOrDataPlaneInTsEmitter(config: any, folder: string): SkipResult {
  // is-modular-library is true by default
  const isModularClient =
    config?.options?.["@azure-tools/typespec-ts"]?.["is-modular-library"] !== false;
  const shouldRun = isManagementSdk(folder) && isModularClient;
  const result: SkipResult = {
    shouldSkip: !shouldRun,
  };
  if (result.shouldSkip)
    result.reason = "This rule is only applicable for management SDKs with modular client.";
  return result;
}

// ----- common sub rules -----
export class TspConfigCommonAzServiceDirMatchPatternSubRule extends TspconfigParameterSubRuleBase {
  constructor() {
    super("service-dir", /^(\{output-dir\}\/)?sdk\/[^\/]*$/);
  }
}

// ----- Java sub rules -----
export class TspConfigJavaAzEmitterOutputDirMatchPatternSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-java", "emitter-output-dir", new RegExp(/^azure(-\w+)+$/));
  }
}

export class TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-java",
      "emitter-output-dir",
      new RegExp(/^azure-resourcemanager(-\w+)+$/),
    );
  }

  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder); // Ensures this rule only applies to management plane SDKs
  }
}

export class TspConfigJavaMgmtNamespaceFormatSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-java",
      "namespace",
      new RegExp(/^com\.azure\.resourcemanager(\.[a-z0-9_]+)+$/), // Matches "com.azure.resourcemanager.<service-name>" allowing a-z, 0-9, and _ in each segment
    );
  }

  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder); // Ensures this rule only applies to management plane SDKs
  }
}

// ----- TS management modular sub rules -----
export class TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "experimental-extensible-enums", true);
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMgmtModularEmitterOutputDirSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "emitter-output-dir", new RegExp(/^arm-[^\/]+$/));
  }

  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMgmtModularPackageNameMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-ts",
      "package-details.name",
      new RegExp(/^\@azure\/arm(?:-[a-z]+)+$/),
    );
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

// ----- TS data plane sub rules -----
export class TspConfigTsDpEmitterOutputDirSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "emitter-output-dir", new RegExp(/^(?:[a-z]+-)*rest$/));
  }
  protected skip(config: any, folder: string) {
    return skipForModularOrManagementPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsRlcDpPackageNameMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-ts",
      "package-details.name",
      new RegExp(/^\@azure-rest\/[a-z]+(?:-[a-z]+)*$/),
    );
  }

  protected skip(config: any, folder: string) {
    return skipForModularOrManagementPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMlcDpPackageNameMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-ts",
      "package-details.name",
      new RegExp(/^@azure\/(?:[a-z]+-)*[a-z]+$/),
    );
  }

  protected skip(config: any, folder: string) {
    return skipForRestLevelClientOrManagementPlaneInTsEmitter(config, folder);
  }
}

// ----- Go common sub rules -----
export class TspConfigGoModuleMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-go",
      "module",
      new RegExp(/^github.com\/Azure\/azure-sdk-for-go\/.*$/),
    );
  }
  protected validate(config: any): RuleResult {
    const module = config?.options?.[this.emitterName]?.["module"];
    const containingModule = config?.options?.[this.emitterName]?.["containing-module"];
    if (module === undefined && containingModule === undefined) {
      return this.createFailedResult(
        `Neither "options.${this.emitterName}.module" nor "options.${this.emitterName}.containing-module" is defined`,
        `Please add either "options.${this.emitterName}.module" or "options.${this.emitterName}.containing-module" with a value matching the pattern "${this.expectedValue}"`,
      );
    }
    if (module === undefined) return { success: true };
    return super.validate(config);
  }
}

export class TspConfigGoContainingModuleMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-go",
      "containing-module",
      new RegExp(/^github.com\/Azure\/azure-sdk-for-go\/.*$/),
    );
  }
  protected validate(config: any): RuleResult {
    const module = config?.options?.[this.emitterName]?.["module"];
    const containingModule = config?.options?.[this.emitterName]?.["containing-module"];
    if (module === undefined && containingModule === undefined) {
      return this.createFailedResult(
        `Neither "options.${this.emitterName}.module" nor "options.${this.emitterName}.containing-module" is defined`,
        `Please add either "options.${this.emitterName}.module" or "options.${this.emitterName}.containing-module" with a value matching the pattern "${this.expectedValue}"`,
      );
    }
    if (containingModule === undefined) return { success: true };
    return super.validate(config);
  }
}

// ----- Go data plane sub rules -----
export class TspConfigGoDpModuleMatchPatternSubRule extends TspConfigGoModuleMatchPatternSubRule {
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

export class TspConfigGoDpContainingModuleMatchPatternSubRule extends TspConfigGoContainingModuleMatchPatternSubRule {
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

export class TspConfigGoDpServiceDirMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "service-dir", new RegExp(/^(\{output-dir\}\/)?sdk\/.*$/));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
  protected validate(config: any): RuleResult {
    let serviceDir = config?.options?.[this.emitterName]?.["service-dir"];
    if (serviceDir === undefined) return { success: true };
    return super.validate(config);
  }
}

export class TspConfigGoDpEmitterOutputDirMatchPatternSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "emitter-output-dir", new RegExp(/^az.*$/));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

// ----- Go Mgmt plane sub rules -----
export class TspConfigGoMgmtModuleMatchPatternSubRule extends TspConfigGoModuleMatchPatternSubRule {
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtContainingModuleMatchPatternSubRule extends TspConfigGoContainingModuleMatchPatternSubRule {
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtServiceDirMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-go",
      "service-dir",
      new RegExp(/^(\{output-dir\}\/)?sdk\/resourcemanager\/[^\/]*$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
  protected validate(config: any): RuleResult {
    let serviceDir = config?.options?.[this.emitterName]?.["service-dir"];
    if (serviceDir === undefined) return { success: true };
    return super.validate(config);
  }
}

export class TspConfigGoMgmtEmitterOutputDirMatchPatternSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "emitter-output-dir", new RegExp(/^arm[^\/]*$/));
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtGenerateSamplesTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "generate-samples", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtHeadAsBooleanTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "head-as-boolean", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtGenerateFakesTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "generate-fakes", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtInjectSpansTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "inject-spans", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

// ----- Python management plane sub rules -----
export class TspConfigPythonMgmtEmitterOutputDirSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-python",
      "emitter-output-dir",
      new RegExp(/^azure[-.]mgmt([-.][a-z]+){1,2}$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigPythonMgmtPackageGenerateTestTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "generate-test", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigPythonMgmtPackageGenerateSampleTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "generate-sample", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigPythonMgmtNamespaceSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "namespace", new RegExp(/^azure\.mgmt(\.[a-z]+){1,2}$/));
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigPythonNamespaceMatchesEmitterOutputDirSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "namespace", "derived from emitter-output-dir");
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
  protected validate(config: any): RuleResult {
    const resolvedSegmentResult = this.getPackageDirFromEmitterOutputDir(config);
    if (resolvedSegmentResult.error) {
      return this.createFailedResult(
        resolvedSegmentResult.error,
        `Please add "options.${this.emitterName}.emitter-output-dir" with a path matching the SDK naming convention`,
      );
    }
    const derivedNamespace = resolvedSegmentResult.resolved.replace(/-/g, ".");
    const namespaceOption = this.tryFindOption(config);
    const namespace = namespaceOption as unknown as undefined | string;
    if (derivedNamespace !== namespace)
      return this.createFailedResult(
        `The value of options.${this.emitterName}.namespace "${namespace}" does not match the value derived from options.${this.emitterName}.emitter-output-dir "${derivedNamespace}"`,
        `Please update "options.${this.emitterName}.namespace" to "${derivedNamespace}" or adjust "options.${this.emitterName}.emitter-output-dir" so the derived namespace matches`,
      );

    return { success: true };
  }
}

// ----- Python data plane sub rules -----
export class TspConfigPythonDpEmitterOutputDirSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-python",
      "emitter-output-dir",
      new RegExp(/^azure(-[a-z]+){1,3}$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

// ----- CSharp sub rules -----
export class TspConfigCsharpDpEmitterOutputDirSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super("@azure-typespec/http-client-csharp", "emitter-output-dir", new RegExp(/^Azure\./));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

export class TspConfigCsharpDpNamespaceSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-typespec/http-client-csharp", "namespace", new RegExp(/^Azure\./));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

export class TspConfigCsharpMgmtEmitterOutputDirSubRule extends TspconfigEmitterOptionsEmitterOutputDirSubRuleBase {
  constructor() {
    super(
      "@azure-typespec/http-client-csharp-mgmt",
      "emitter-output-dir",
      new RegExp(/^Azure\.ResourceManager\./),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigCsharpMgmtNamespaceSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-typespec/http-client-csharp-mgmt",
      "namespace",
      new RegExp(/^Azure\.ResourceManager\./),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

// ----- Rust sub rules -----
export class TspConfigRustMgmtCrateNameSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-rust",
      "crate-name",
      new RegExp(/^azure_resourcemanager_(?:[a-z0-9]+_)*[a-z0-9]+$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigRustAzEmitterOutputDirSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-rust",
      "emitter-output-dir",
      new RegExp(/^{output-dir}\/{service-dir}\/{crate-name}$/),
    );
  }
}

/**
 * Required rules: When a tspconfig.yaml exists, any applicable rule in the requiredRules array
 * that fails validation will cause the entire SdkTspConfigValidationRule to fail. For example,
 * if a Rust emitter is configured in tspconfig.yaml but doesn't meet the required validation
 * criteria, the validation will fail.
 */
export const requiredRules = [
  new TspConfigCommonAzServiceDirMatchPatternSubRule(),
  new TspConfigJavaAzEmitterOutputDirMatchPatternSubRule(),
  new TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule(),
  new TspConfigJavaMgmtNamespaceFormatSubRule(),
  new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule(),
  new TspConfigTsMgmtModularEmitterOutputDirSubRule(),
  new TspConfigTsMgmtModularPackageNameMatchPatternSubRule(),
  new TspConfigTsDpEmitterOutputDirSubRule(),
  new TspConfigTsRlcDpPackageNameMatchPatternSubRule(),
  new TspConfigTsMlcDpPackageNameMatchPatternSubRule(),
  new TspConfigGoMgmtServiceDirMatchPatternSubRule(),
  new TspConfigGoMgmtEmitterOutputDirMatchPatternSubRule(),
  new TspConfigGoMgmtGenerateSamplesTrueSubRule(),
  new TspConfigGoMgmtGenerateFakesTrueSubRule(),
  new TspConfigGoMgmtHeadAsBooleanTrueSubRule(),
  new TspConfigGoMgmtInjectSpansTrueSubRule(),
  new TspConfigGoMgmtModuleMatchPatternSubRule(),
  new TspConfigGoMgmtContainingModuleMatchPatternSubRule(),
  new TspConfigPythonMgmtEmitterOutputDirSubRule(),
  new TspConfigPythonMgmtNamespaceSubRule(),
  new TspConfigPythonDpEmitterOutputDirSubRule(),
  new TspConfigPythonNamespaceMatchesEmitterOutputDirSubRule(),
  new TspConfigPythonMgmtPackageGenerateSampleTrueSubRule(),
  new TspConfigPythonMgmtPackageGenerateTestTrueSubRule(),
];

/**
 * Optional rules: Validate language-specific emitter configurations.
 * All rules in this array inherit from TspconfigEmitterOptionsSubRuleBase and only run when
 * their corresponding emitter is configured in tspconfig.yaml. When the emitter is not configured,
 * the rule is skipped and does not affect the validation result. When the emitter is configured,
 * validation failures will affect the overall validation result.
 */
export const optionalRules: TspconfigEmitterOptionsSubRuleBase[] = [
  new TspConfigCsharpDpEmitterOutputDirSubRule(),
  new TspConfigCsharpDpNamespaceSubRule(),
  new TspConfigCsharpMgmtNamespaceSubRule(),
  new TspConfigCsharpMgmtEmitterOutputDirSubRule(),
  new TspConfigGoDpServiceDirMatchPatternSubRule(),
  new TspConfigGoDpEmitterOutputDirMatchPatternSubRule(),
  new TspConfigGoDpModuleMatchPatternSubRule(),
  new TspConfigGoDpContainingModuleMatchPatternSubRule(),
  new TspConfigRustMgmtCrateNameSubRule(),
  new TspConfigRustAzEmitterOutputDirSubRule(),
];

export class SdkTspConfigValidationRule implements Rule {
  private requiredRules: TspconfigSubRuleBase[] = [];
  private optionalRules: TspconfigEmitterOptionsSubRuleBase[] = [];
  private suppressedKeyPaths: Set<string> = new Set();
  name = "SdkTspConfigValidation";
  description = "Validate the SDK tspconfig.yaml file";

  constructor(
    requiredSubRules: TspconfigSubRuleBase[] = requiredRules,
    optionalSubRules: TspconfigEmitterOptionsSubRuleBase[] = optionalRules,
  ) {
    this.requiredRules = requiredSubRules;
    this.optionalRules = optionalSubRules;
  }

  async execute(folder: string): Promise<RuleResult> {
    const tspConfigPath = join(folder, "tspconfig.yaml");
    const suppressions = await getSuppressions(tspConfigPath);

    const shouldSuppressEntireRule = suppressions.some(
      (s) => s.rules?.includes(this.name) === true && (!s.subRules || s.subRules.length === 0),
    );
    if (shouldSuppressEntireRule)
      return { success: true, stdOutput: `[${this.name}]: validation skipped.` };

    this.setSuppressedKeyPaths(suppressions);

    const failedResults = [];
    let success = true;

    // Execute required rules
    for (const subRule of this.requiredRules) {
      // Check for both direct matches and wildcard patterns
      if (this.isKeyPathSuppressed(subRule.getPathOfKeyToValidate())) continue;

      const result = await subRule.execute(folder!);
      if (!result.success) failedResults.push(result);

      success &&= result.success;
    }

    // Execute optional rules (failures don't affect overall success)
    for (const subRule of this.optionalRules) {
      if (this.isKeyPathSuppressed(subRule.getPathOfKeyToValidate())) continue;

      // Skip if emitter is not configured
      const config = await subRule.loadConfig(folder);
      const emitterName = subRule.getEmitterName();
      if (config && this.skipIfEmitterNotConfigured(config, emitterName)) {
        console.warn(
          `Optional rule ${subRule.constructor.name} skipped because emitter ${emitterName} is not configured.`,
        );
        continue;
      }

      const result = await subRule.execute(folder!);
      if (!result.success) failedResults.push(result);
      // Optional rules affect overall success when emitter is configured
      success &&= result.success;
    }

    const stdOutputFailedResults =
      failedResults.length > 0
        ? `${failedResults.map((r) => r.errorOutput).join("\n")}\nPlease see https://aka.ms/azsdk/spec-gen-sdk-config for more info.\nFor additional information on TypeSpec validation, please refer to https://aka.ms/azsdk/specs/typespec-validation\nFor exception requests, please refer to https://eng.ms/docs/products/azure-developer-experience/onboard/request-exception`
        : "";

    return {
      success,
      stdOutput: `[${this.name}]: validation ${success ? "passed" : "failed"}.\n${stdOutputFailedResults}`,
    };
  }

  private skipIfEmitterNotConfigured(config: any, emitterName: string): boolean {
    const isConfigured = config?.options?.[emitterName] !== undefined;
    return !isConfigured;
  }

  private setSuppressedKeyPaths(suppressions: Suppression[]) {
    this.suppressedKeyPaths = new Set<string>();
    for (const suppression of suppressions) {
      if (!suppression.rules?.includes(this.name)) continue;
      for (const ignoredKey of suppression.subRules ?? []) {
        this.suppressedKeyPaths.add(ignoredKey);
        console.warn(`Skip validation on ${ignoredKey}.`);
      }
    }
  }

  private isKeyPathSuppressed(keyPath: string): boolean {
    // Direct match
    if (this.suppressedKeyPaths.has(keyPath)) {
      return true;
    }

    // Only check for wildcard at the end (format: prefix.*)
    for (const suppressedPath of this.suppressedKeyPaths) {
      if (suppressedPath.endsWith(".*")) {
        const prefix = suppressedPath.slice(0, -2); // Remove the '.*' at the end
        if (keyPath.startsWith(prefix)) {
          return true;
        }
      }
    }

    return false;
  }
}
