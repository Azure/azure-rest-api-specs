import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { Suppression } from "suppressions";
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

  public getPathOfKeyToValidate() {
    return `options.${this.emitterName}.${this.keyToValidate}`;
  }
}

function isManagementSdk(folder: string): boolean {
  return folder.includes(".Management");
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

function skipForNonModularOrDataPlaneInTsEmitter(config: any, folder: string): SkipResult {
  // isModularLibrary is true by default
  const isModularClient = config?.options?.["@azure-tools/typespec-ts"]?.isModularLibrary !== false;
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
    super("service-dir", /^sdk\/[^\/]*$/);
  }
}

// ----- Java sub rules -----
export class TspConfigJavaAzPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-java", "package-dir", new RegExp(/^azure(-\w+)+$/));
  }
}

// ----- TS management modular sub rules -----
// NOTE: this is only used when TS emitter is migrating to the new option style
//       will be deleted when the migration is done
class TspConfigTsOptionMigrationSubRuleBase extends TspconfigEmitterOptionsSubRuleBase {
  private oldOptionStyleSubRule: TspconfigEmitterOptionsSubRuleBase & {
    validateOption(config: any): RuleResult;
  };
  private newOptionStyleSubRule: TspconfigEmitterOptionsSubRuleBase & {
    validateOption(config: any): RuleResult;
  };
  constructor(oldOptionName: string, newOptionName: string, expectedValue: ExpectedValueType) {
    class PrivateOptionStyleSubRule extends TspconfigEmitterOptionsSubRuleBase {
      constructor(optionName: string, expectedValue: ExpectedValueType) {
        super("@azure-tools/typespec-ts", optionName, expectedValue);
      }
      public validateOption(config: any): RuleResult {
        return this.validate(config);
      }
    }

    // the parameters are not used, but are required to be passed to the super constructor
    super("", "", "");
    this.oldOptionStyleSubRule = new PrivateOptionStyleSubRule(oldOptionName, expectedValue);
    this.newOptionStyleSubRule = new PrivateOptionStyleSubRule(newOptionName, expectedValue);
  }

  protected validate(config: any): RuleResult {
    var newResult = this.newOptionStyleSubRule.validateOption(config);
    // if success == true, then the option is found and passes validation
    // if success == false, and "Failed to find" is not in errorOutput, then the option is found but fails validation
    if (newResult.success || !newResult.errorOutput?.includes("Failed to find")) return newResult;

    var oldResult = this.oldOptionStyleSubRule.validateOption(config);
    return oldResult;
  }
}

export class TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule extends TspConfigTsOptionMigrationSubRuleBase {
  constructor() {
    super("experimentalExtensibleEnums", "experimental-extensible-enums", true);
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMgmtModularPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "package-dir", new RegExp(/^arm(?:-[a-z]+)+$/));
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMgmtModularPackageNameMatchPatternSubRule extends TspConfigTsOptionMigrationSubRuleBase {
  constructor() {
    super("packageDetails.name", "package-details.name", new RegExp(/^\@azure\/arm(?:-[a-z]+)+$/));
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

// ----- TS data plane sub rules -----
export class TspConfigTsDpPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "package-dir", new RegExp(/^(?:[a-z]+-)*-rest$/));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

export class TspConfigTsDpPackageNameMatchPatternSubRule extends TspConfigTsOptionMigrationSubRuleBase {
  constructor() {
    super(
      "packageDetails.name",
      "package-details.name",
      new RegExp(/^\@azure-rest\/[a-z]+(?:-[a-z]+)*$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
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

export class TspConfigGoMgmtServiceDirMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "service-dir", new RegExp(/^sdk\/resourcemanager\/[^\/]*$/));
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

export class TspConfigGoMgmtFixConstStutteringTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "fix-const-stuttering", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigGoMgmtGenerateExamplesTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "generate-examples", true);
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

// ----- Go az sub rules -----
export class TspConfigGoAzGenerateFakesTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "generate-fakes", true);
  }
}

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

// ----- Python data plane sub rules -----
export class TspConfigPythonDpPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "package-dir", new RegExp(/^azure(-[a-z]+){1,3}$/));
  }
  protected skip(_: any, folder: string) {
    return skipForManagementPlane(folder);
  }
}

// ----- Python azure sub rules -----
export class TspConfigPythonAzPackageNameEqualStringSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "package-name", "{package-dir}");
  }
}

export class TspConfigPythonAzGenerateTestTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "generate-test", true);
  }
}

export class TspConfigPythonAzGenerateSampleTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "generate-sample", true);
  }
}

// ----- CSharp sub rules -----
export class TspConfigCsharpAzPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-csharp", "package-dir", new RegExp(/^Azure\./));
  }
}

export class TspConfigCsharpAzNamespaceEqualStringSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-csharp", "namespace", "{package-dir}");
  }
  override validate(config: any): RuleResult {
    const option = this.tryFindOption(config);

    if (option === undefined)
      return this.createFailedResult(
        `Failed to find "options.${this.emitterName}.${this.keyToValidate}"`,
        `Please add "options.${this.emitterName}.${this.keyToValidate}"`,
      );

    const packageDir = config?.options?.[this.emitterName]?.["package-dir"];
    const actualValue = option as unknown as undefined | string | boolean;
    if (
      this.validateValue(actualValue, this.expectedValue) ||
      (packageDir !== undefined && this.validateValue(actualValue, packageDir))
    ) {
      return { success: true };
    }

    return this.createFailedResult(
      `The value of options.${this.emitterName}.${this.keyToValidate} "${actualValue}" does not match "${this.expectedValue}" or the value of "package-dir" option or parameter`,
      `Please update the value of "options.${this.emitterName}.${this.keyToValidate}" to match "${this.expectedValue}" or the value of "package-dir" option or parameter`,
    );
  }
}

export class TspConfigCsharpAzClearOutputFolderTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-csharp", "clear-output-folder", true);
  }
}

export class TspConfigCsharpMgmtPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-csharp", "package-dir", new RegExp(/^Azure\.ResourceManager\./));
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export const defaultRules = [
  new TspConfigCommonAzServiceDirMatchPatternSubRule(),
  new TspConfigJavaAzPackageDirectorySubRule(),
  new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule(),
  new TspConfigTsMgmtModularPackageDirectorySubRule(),
  new TspConfigTsMgmtModularPackageNameMatchPatternSubRule(),
  new TspConfigTsDpPackageDirectorySubRule(),
  new TspConfigTsDpPackageNameMatchPatternSubRule(),
  new TspConfigGoMgmtServiceDirMatchPatternSubRule(),
  new TspConfigGoMgmtPackageDirectorySubRule(),
  new TspConfigGoMgmtModuleEqualStringSubRule(),
  new TspConfigGoMgmtFixConstStutteringTrueSubRule(),
  new TspConfigGoMgmtGenerateExamplesTrueSubRule(),
  new TspConfigGoAzGenerateFakesTrueSubRule(),
  new TspConfigGoMgmtHeadAsBooleanTrueSubRule(),
  new TspConfigGoAzInjectSpansTrueSubRule(),
  new TspConfigGoDpServiceDirMatchPatternSubRule(),
  new TspConfigGoDpPackageDirectoryMatchPatternSubRule(),
  new TspConfigGoDpModuleMatchPatternSubRule(),
  new TspConfigPythonMgmtPackageDirectorySubRule(),
  new TspConfigPythonDpPackageDirectorySubRule(),
  new TspConfigPythonAzPackageNameEqualStringSubRule(),
  new TspConfigPythonAzGenerateTestTrueSubRule(),
  new TspConfigPythonAzGenerateSampleTrueSubRule(),
  new TspConfigCsharpAzPackageDirectorySubRule(),
  new TspConfigCsharpAzNamespaceEqualStringSubRule(),
  new TspConfigCsharpAzClearOutputFolderTrueSubRule(),
  new TspConfigCsharpMgmtPackageDirectorySubRule(),
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
    this.setSuppressedKeyPaths(suppressions);

    const failedResults = [];
    let success = true;
    for (const subRule of this.subRules) {
      // TODO: support wildcard
      if (this.suppressedKeyPaths.has(subRule.getPathOfKeyToValidate())) continue;
      const result = await subRule.execute(folder!);
      if (!result.success) failedResults.push(result);
      success &&= result.success;
    }

    const stdOutputFailedResults =
      failedResults.length > 0
        ? `${failedResults.map((r) => r.errorOutput).join("\n")}\n Please see https://aka.ms/azsdk/spec-gen-sdk-config for more info.`
        : "";

    // NOTE: to avoid huge impact on existing PRs, we always return true with info/warning messages.
    return {
      success: true,
      stdOutput: `[${this.name}]: validation ${success ? "passed" : "failed"}.\n${stdOutputFailedResults}`,
    };
  }

  private setSuppressedKeyPaths(suppressions: Suppression[]) {
    this.suppressedKeyPaths = new Set<string>();
    for (const suppression of suppressions) {
      if (!suppression.rules?.includes(this.name)) continue;
      for (const ignoredKey of suppression.subRules ?? []) this.suppressedKeyPaths.add(ignoredKey);
    }
  }
}
