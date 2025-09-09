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
    const tspconfigExists = await fileExists(join(folder, "tspconfig.yaml"));
    if (!tspconfigExists)
      return this.createFailedResult(
        `Failed to find ${join(folder, "tspconfig.yaml")}`,
        "Please add tspconfig.yaml",
      );

    let config = undefined;
    try {
      const configText = await readTspConfig(folder);
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

  protected tryFindOption(config: any): Record<string, any> | undefined {
    let option: Record<string, any> | undefined = config?.options?.[this.emitterName];
    for (const segment of this.keyToValidate.split(".")) {
      if (option && typeof option === "object" && !Array.isArray(option) && segment in option)
        option = option![segment];
      else return undefined;
    }
    return option;
  }

  protected validate(config: any): RuleResult {
    const option = this.tryFindOption(config);
    if (option === undefined)
      return this.createFailedResult(
        `Failed to find "options.${this.emitterName}.${this.keyToValidate}" with expected value "${this.expectedValue}"`,
        `Please add "options.${this.emitterName}.${this.keyToValidate}" with expected value "${this.expectedValue}"`,
      );

    const actualValue = option as unknown as undefined | string | boolean;
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
    config?.options?.["@azure-tools/typespec-ts"]?.["is-modular-library"] !== true;
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
    config?.options?.["@azure-tools/typespec-ts"]?.["is-modular-library"] === true;
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
export class TspConfigJavaAzEmitterOutputDirMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-java",
      "emitter-output-dir",
      new RegExp(/^(\{output-dir\}\/)?\{service-dir\}\/azure(-\w+)+$/),
    );
  }

  protected validate(config: any): RuleResult {
    const option = this.tryFindOption(config);
    if (option === undefined) {
      // at present, we don't require service use emitter-output-dir
      return { success: true };
    }
    return super.validate(config);
  }
}

export class TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-java",
      "emitter-output-dir",
      new RegExp(/^(\{output-dir\}\/)?\{service-dir\}\/azure-resourcemanager(-\w+)+$/),
    );
  }

  protected validate(config: any): RuleResult {
    const option = this.tryFindOption(config);
    if (option === undefined) {
      // at present, we don't require service use emitter-output-dir
      return { success: true };
    }
    return super.validate(config);
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

export class TspConfigTsMgmtModularPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "package-dir", new RegExp(/^arm-[^\/]+$/));
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
export class TspConfigTsDpPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "package-dir", new RegExp(/^(?:[a-z]+-)*rest$/));
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
// ----- Go data plane sub rules -----
export class TspConfigGoDpServiceDirMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "service-dir", new RegExp(/^sdk\/.*$/));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

export class TspConfigGoDpPackageDirectoryMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "package-dir", new RegExp(/^az.*$/));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

export class TspConfigGoDpModuleMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-go",
      "module",
      new RegExp(/^github.com\/Azure\/azure-sdk-for-go\/.*$/),
    );
  }
  protected validate(config: any): RuleResult {
    let module = config?.options?.[this.emitterName]?.module;
    if (module === undefined) return { success: true };
    return super.validate(config);
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

// ----- Go Mgmt plane sub rules -----
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
}

export class TspConfigGoMgmtPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "package-dir", new RegExp(/^arm[^\/]*$/));
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtModuleEqualStringSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-go",
      "module",
      "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
    );
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

// ----- Go az sub rules -----

export class TspConfigGoAzInjectSpansTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "inject-spans", true);
  }
}

// ----- Python management plane sub rules -----
export class TspConfigPythonMgmtPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "package-dir", new RegExp(/^azure-mgmt(-[a-z]+){1,2}$/));
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

// ----- Python data plane sub rules -----
export class TspConfigPythonDpPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "package-dir", new RegExp(/^azure(-[a-z]+){1,3}$/));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

// ----- CSharp sub rules -----
export class TspConfigCsharpAzNamespaceSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-csharp", "namespace", new RegExp(/^Azure\./));
  }
}

export class TspConfigCsharpAzClearOutputFolderTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-csharp", "clear-output-folder", true);
  }
}

export class TspConfigCsharpMgmtNamespaceSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-csharp", "namespace", new RegExp(/^Azure\.ResourceManager\./));
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export const defaultRules = [
  new TspConfigCommonAzServiceDirMatchPatternSubRule(),
  new TspConfigJavaAzEmitterOutputDirMatchPatternSubRule(),
  new TspConfigJavaMgmtEmitterOutputDirMatchPatternSubRule(),
  new TspConfigJavaMgmtNamespaceFormatSubRule(),
  new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule(),
  new TspConfigTsMgmtModularPackageDirectorySubRule(),
  new TspConfigTsMgmtModularPackageNameMatchPatternSubRule(),
  new TspConfigTsDpPackageDirectorySubRule(),
  new TspConfigTsRlcDpPackageNameMatchPatternSubRule(),
  new TspConfigTsMlcDpPackageNameMatchPatternSubRule(),
  new TspConfigGoMgmtServiceDirMatchPatternSubRule(),
  new TspConfigGoMgmtPackageDirectorySubRule(),
  new TspConfigGoMgmtModuleEqualStringSubRule(),
  new TspConfigGoMgmtGenerateSamplesTrueSubRule(),
  new TspConfigGoMgmtGenerateFakesTrueSubRule(),
  new TspConfigGoMgmtHeadAsBooleanTrueSubRule(),
  new TspConfigGoAzInjectSpansTrueSubRule(),
  new TspConfigGoDpServiceDirMatchPatternSubRule(),
  new TspConfigGoDpPackageDirectoryMatchPatternSubRule(),
  new TspConfigGoDpModuleMatchPatternSubRule(),
  new TspConfigPythonMgmtPackageDirectorySubRule(),
  new TspConfigPythonMgmtNamespaceSubRule(),
  new TspConfigPythonDpPackageDirectorySubRule(),
  new TspConfigPythonMgmtPackageGenerateSampleTrueSubRule(),
  new TspConfigPythonMgmtPackageGenerateTestTrueSubRule(),
  new TspConfigCsharpAzNamespaceSubRule(),
  new TspConfigCsharpAzClearOutputFolderTrueSubRule(),
  new TspConfigCsharpMgmtNamespaceSubRule(),
];

export class SdkTspConfigValidationRule implements Rule {
  private subRules: TspconfigSubRuleBase[] = [];
  private suppressedKeyPaths: Set<string> = new Set();
  name = "SdkTspConfigValidation";
  description = "Validate the SDK tspconfig.yaml file";

  constructor(subRules: TspconfigSubRuleBase[] = defaultRules) {
    this.subRules = subRules;
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
    for (const subRule of this.subRules) {
      // Check for both direct matches and wildcard patterns
      if (this.isKeyPathSuppressed(subRule.getPathOfKeyToValidate())) continue;
      const result = await subRule.execute(folder!);
      if (!result.success) failedResults.push(result);

      let isSubRuleSuccess = result.success;

      // TODO: remove when @azure-tools/typespec-csharp is ready for validating tspconfig
      if (subRule instanceof TspconfigEmitterOptionsSubRuleBase) {
        const emitterOptionSubRule = subRule as TspconfigEmitterOptionsSubRuleBase;
        const emitterName = emitterOptionSubRule.getEmitterName();
        if (emitterName === "@azure-tools/typespec-csharp" && isSubRuleSuccess === false) {
          console.warn(
            `Validation on option "${emitterOptionSubRule.getPathOfKeyToValidate()}" in "${emitterName}" are failed. However, per ${emitterName}’s decision, we will treat it as passed, please refer to https://eng.ms/docs/products/azure-developer-experience/onboard/request-exception`,
          );
          isSubRuleSuccess = true;
        }
      }

      success &&= isSubRuleSuccess;
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
