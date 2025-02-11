import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { TsvHost } from "../tsv-host.js";
import {
  SkipResult,
  TspconfigEmitterOptionsSubRuleBase,
  TspconfigParameterSubRuleBase,
  TspconfigSubRuleBase,
} from "../tspconfig-rule-helper.js";

function isManagementSdk(folder: string): boolean {
  return folder.includes(".Management");
}

function skipForDataPlane(folder: string): SkipResult {
  return {
    shouldSkip: !isManagementSdk(folder),
    reason: "This rule is only applicable for management SDKs.",
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
export class TspConfigTsMgmtModularGenerateMetadataTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "generateMetadata", true);
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMgmtModularHierarchyClientFalseSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "hierarchyClient", false);
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "experimentalExtensibleEnums", true);
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

export class TspConfigTsMgmtModularEnableOperationGroupTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-ts", "enableOperationGroup", true);
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

export class TspConfigTsMgmtModularPackageNameMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "@azure-tools/typespec-ts",
      "packageDetails.name",
      new RegExp(/^\@azure\/arm(?:-[a-z]+)+$/),
    );
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

// ----- Go management sub rules -----
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

export class TspConfigGoMgmtGenerateFakesTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "generate-fakes", true);
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

export class TspConfigGoMgmtInjectSpansTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-go", "inject-spans", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

// ----- Python management sub rules -----
export class TspConfigPythonMgmtPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "package-dir", new RegExp(/^azure-mgmt(-[a-z]+){1,2}$/));
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigPythonMgmtPackageNameEqualStringSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "package-name", "{package-dir}");
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigPythonMgmtGenerateTestTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "generate-test", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

export class TspConfigPythonMgmtGenerateSampleTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super("@azure-tools/typespec-python", "generate-sample", true);
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
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
  new TspConfigTsMgmtModularGenerateMetadataTrueSubRule(),
  new TspConfigTsMgmtModularHierarchyClientFalseSubRule(),
  new TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule(),
  new TspConfigTsMgmtModularEnableOperationGroupTrueSubRule(),
  new TspConfigTsMgmtModularPackageDirectorySubRule(),
  new TspConfigTsMgmtModularPackageNameMatchPatternSubRule(),
  new TspConfigGoMgmtServiceDirMatchPatternSubRule(),
  new TspConfigGoMgmtPackageDirectorySubRule(),
  new TspConfigGoMgmtModuleEqualStringSubRule(),
  new TspConfigGoMgmtFixConstStutteringTrueSubRule(),
  new TspConfigGoMgmtGenerateExamplesTrueSubRule(),
  new TspConfigGoMgmtGenerateFakesTrueSubRule(),
  new TspConfigGoMgmtHeadAsBooleanTrueSubRule(),
  new TspConfigGoMgmtInjectSpansTrueSubRule(),
  new TspConfigPythonMgmtPackageDirectorySubRule(),
  new TspConfigPythonMgmtPackageNameEqualStringSubRule(),
  new TspConfigPythonMgmtGenerateTestTrueSubRule(),
  new TspConfigPythonMgmtGenerateSampleTrueSubRule(),
  new TspConfigCsharpAzPackageDirectorySubRule(),
  new TspConfigCsharpAzNamespaceEqualStringSubRule(),
  new TspConfigCsharpAzClearOutputFolderTrueSubRule(),
  new TspConfigCsharpMgmtPackageDirectorySubRule(),
];

export class SdkTspConfigValidationRule implements Rule {
  private rules: TspconfigSubRuleBase[] = [];
  name = "SdkTspConfigValidation";
  description = "Validate the SDK tspconfig.yaml file";

  constructor(rules?: TspconfigSubRuleBase[]) {
    this.rules = rules || defaultRules;
  }
  async execute(host?: TsvHost, folder?: string): Promise<RuleResult> {
    const failedResults = [];
    let success = true;
    for (const rule of this.rules) {
      const result = await rule.execute(host!, folder!);
      if (!result.success) failedResults.push(result);
      success &&= result.success;
    }

    // NOTE: to avoid huge impact on existing PRs, we always return true with info/warning messages.
    return {
      success: true,
      stdOutput: `[${this.name}]: validation ${success ? "passed" : "failed"}.\n${failedResults.map((r) => r.errorOutput).join("\n")}`,
    };
  }
}
