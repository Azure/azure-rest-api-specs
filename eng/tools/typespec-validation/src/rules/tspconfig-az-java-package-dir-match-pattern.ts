import { TspconfigEmitterOptionsRuleBase } from "../tspconfig-rule-helper.js";

export class TspConfigJavaAzPackageDirectoryRule extends TspconfigEmitterOptionsRuleBase {
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
