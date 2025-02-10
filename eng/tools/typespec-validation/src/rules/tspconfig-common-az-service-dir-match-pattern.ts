import { TspconfigParameterRuleBase } from "../tspconfig-rule-helper.js";

export class TspConfigCommonAzServiceDirMatchPatternRule extends TspconfigParameterRuleBase {
  constructor() {
    super(
      "tspconfig-common-az-service-dir-match-pattern",
      'Validate "parameters.service-dir.default".',
      "service-dir",
      /^sdk\/[^\/]*$/,
    );
  }
}
