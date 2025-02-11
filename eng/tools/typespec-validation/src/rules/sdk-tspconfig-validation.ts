import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { TsvHost } from "../tsv-host.js";
import {
  SkipResult,
  TspconfigEmitterOptionsSubRuleBase,
  TspconfigParameterSubRuleBase,
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
class TspConfigCommonAzServiceDirMatchPatternSubRule extends TspconfigParameterSubRuleBase {
  constructor() {
    super(
      "tspconfig-common-az-service-dir-match-pattern",
      'Validate "parameters.service-dir.default".',
      "service-dir",
      /^sdk\/[^\/]*$/,
    );
  }
}

// ----- Java sub rules -----
class TspConfigJavaAzPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-java-az-package-dir-match-pattern",
      'Validate "options.@azure-tools/typespec-java.package-dir".',
      "@azure-tools/typespec-java",
      "package-dir",
      new RegExp(/^azure(-\w+)+$/),
    );
  }
}

// ----- TS management modular sub rules -----
class TspConfigTsMgmtModularGenerateMetadataTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-ts-mgmt-modular-generate-metadata-true",
      'Validate "options.@azure-tools/typespec-ts.generateMetadata".',
      "@azure-tools/typespec-ts",
      "generateMetadata",
      true,
    );
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

class TspConfigTsMgmtModularHierarchyClientFalseSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-ts-mgmt-modular-hierarchy-client-false",
      'Validate "options.@azure-tools/typespec-ts.hierarchyClient".',
      "@azure-tools/typespec-ts",
      "hierarchyClient",
      false,
    );
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

class TspConfigTsMgmtModularExperimentalExtensibleEnumsTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-ts-mgmt-modular-experimental-extensible-enums-true",
      'Validate "options.@azure-tools/typespec-ts.experimentalExtensibleEnums".',
      "@azure-tools/typespec-ts",
      "experimentalExtensibleEnums",
      true,
    );
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

class TspConfigTsMgmtModularEnableOperationGroupTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-ts-mgmt-modular-enable-operation-group-true",
      'Validate "options.@azure-tools/typespec-ts.enableOperationGroup".',
      "@azure-tools/typespec-ts",
      "enableOperationGroup",
      true,
    );
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

class TspConfigTsMgmtModularPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-ts-mgmt-modular-package-dir-match-pattern",
      'Validate "options.@azure-tools/typespec-ts.package-dir".',
      "@azure-tools/typespec-ts",
      "package-dir",
      new RegExp(/^arm(?:-[a-z]+)+$/),
    );
  }
  protected skip(config: any, folder: string) {
    return skipForNonModularOrDataPlaneInTsEmitter(config, folder);
  }
}

class TspConfigTsMgmtModularPackageNameMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-ts-mgmt-modular-package-name-match-pattern",
      'Validate "options.@azure-tools/typespec-ts.packageDetails.name".',
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
class TspConfigGoMgmtServiceDirMatchPatternSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-service-dir-match-pattern",
      'Validate "options.@azure-tools/typespec-go.service-dir".',
      "@azure-tools/typespec-go",
      "service-dir",
      new RegExp(/^sdk\/resourcemanager\/[^\/]*$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigGoMgmtPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-package-dir-match-pattern",
      'Validate "options.@azure-tools/typespec-go.package-dir".',
      "@azure-tools/typespec-go",
      "package-dir",
      new RegExp(/^arm[^\/]*$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigGoMgmtModuleEqualStringSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-module-equal-string",
      'Validate "options.@azure-tools/typespec-go.module".',
      "@azure-tools/typespec-go",
      "module",
      "github.com/Azure/azure-sdk-for-go/{service-dir}/{package-dir}",
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigGoMgmtFixConstStutteringTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-fix-const-stuttering-true",
      'Validate "options.@azure-tools/typespec-go.fix-const-stuttering".',
      "@azure-tools/typespec-go",
      "fix-const-stuttering",
      true,
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigGoMgmtGenerateExamplesTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-generate-examples-true",
      'Validate "options.@azure-tools/typespec-go.generate-examples".',
      "@azure-tools/typespec-go",
      "generate-examples",
      true,
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigGoMgmtGenerateFakesTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-generate-fakes-true",
      'Validate "options.@azure-tools/typespec-go.generate-fakes".',
      "@azure-tools/typespec-go",
      "generate-fakes",
      true,
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigGoMgmtHeadAsBooleanTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-head-as-boolean-true",
      'Validate "options.@azure-tools/typespec-go.head-as-boolean".',
      "@azure-tools/typespec-go",
      "head-as-boolean",
      true,
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigGoMgmtInjectSpansTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-go-mgmt-inject-spans-true",
      'Validate "options.@azure-tools/typespec-go.inject-spans".',
      "@azure-tools/typespec-go",
      "inject-spans",
      true,
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

// ----- Python management sub rules -----
class TspConfigPythonMgmtPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-python-mgmt-package-dir-match-pattern",
      'Validate "options.@azure-tools/typespec-python.package-dir".',
      "@azure-tools/typespec-python",
      "package-dir",
      new RegExp(/^azure-mgmt(-[a-z]+){1,2}$/),
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigPythonMgmtPackageNameEqualStringSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-python-mgmt-package-name-equal-string",
      'Validate "options.@azure-tools/typespec-python.package-name".',
      "@azure-tools/typespec-python",
      "package-name",
      "{package-dir}",
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigPythonMgmtGenerateTestTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-python-mgmt-generate-test-true",
      'Validate "options.@azure-tools/typespec-python.generate-test".',
      "@azure-tools/typespec-python",
      "generate-test",
      true,
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

class TspConfigPythonMgmtGenerateSampleTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-python-mgmt-generate-sample-true",
      'Validate "options.@azure-tools/typespec-python.generate-sample".',
      "@azure-tools/typespec-python",
      "generate-sample",
      true,
    );
  }
  protected skip(_: any, folder: string) {
    return skipForDataPlane(folder);
  }
}

// ----- CSharp sub rules -----
class TspConfigCsharpAzPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-csharp-az-package-dir-match-pattern",
      'Validate "options.@azure-tools/typespec-csharp.package-dir".',
      "@azure-tools/typespec-csharp",
      "package-dir",
      new RegExp(/^Azure\./),
    );
  }
}

class TspConfigCsharpAzNamespaceEqualStringSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-csharp-az-namespace-equal-string",
      'Validate "options.@azure-tools/typespec-csharp.namespace".',
      "@azure-tools/typespec-csharp",
      "namespace",
      "{package-dir}",
    );
  }
}

class TspConfigCsharpAzClearOutputFolderTrueSubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-csharp-az-clear-output-folder-true",
      'Validate "options.@azure-tools/typespec-csharp.clear-output-folder".',
      "@azure-tools/typespec-csharp",
      "clear-output-folder",
      true,
    );
  }
}

class TspConfigCsharpMgmtPackageDirectorySubRule extends TspconfigEmitterOptionsSubRuleBase {
  constructor() {
    super(
      "tspconfig-csharp-mgmt-package-dir-match-pattern",
      'Validate "options.@azure-tools/typespec-csharp.package-dir" for management SDK.',
      "@azure-tools/typespec-csharp",
      "package-dir",
      new RegExp(/^Azure\.ResourceManager\./),
    );
  }
}

export class SdkTspConfigValidation implements Rule {
  name = "SdkTspConfigValidation";
  description = "Validate the SDK tspconfig.yaml file";
  async execute(host?: TsvHost, folder?: string): Promise<RuleResult> {
    const rules = [
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

    const failedResults = [];
    let success = true;
    for (const rule of rules) {
      const result = await rule.execute(host, folder);
      if (!result.success) failedResults.push(result);
      success &&= result.success;
    }

    // NOTE: to avoid huge impact on existing PRs, we always return true with info/warning messages.
    return {
      success: true,
      stdOutput: `[${this.name}]: validation ${success ? "passed" : "failed"}.\n${failedResults.map(r => r.errorOutput).join("\n")}`,
    };
  }
}
