import { RuleDocuments, RuleInfo } from "../interfaces/rule-interfaces.js";
import { defaultMessageId, emitters } from "../utils/constants.js";
import { isManagementForTsEmitter, makeRuleMessages } from "../utils/rule.js";
import { createRule } from "../utils/tspconfig-validation-base.js";

const docs: RuleDocuments = {
  description:
    "Validate whether 'generateMetadata' is set to true in tspconfig.yaml when generating modular clients",
  error: "'generateMetadata' is NOT set to true in tspconfig.yaml when generating modular clients",
  action: `Set 'options.${emitters.ts}.generateMetadata' to true in tspconfig.yaml when generating modular clients`,
  example: `...
options:
  "@azure-tools/typespec-ts":
    generateMetadata: true # <--- 
    generateSample: true
    generateTest: true
    experimentalExtensibleEnums: true
    enableOperationGroup: true
    hierarchyClient: false
    package-dir: "pkg"
    packageDetails:
      name: "@azure/pkg"
    flavor: azure
`,
};
const ruleInfo: RuleInfo = {
  name: "tspconfig-ts-mgmt-modular-generate-metadata-true",
  docs,
  functions: {
    messages: () => makeRuleMessages(defaultMessageId, docs),
    condition: (tspconfig, context) => isManagementForTsEmitter(tspconfig, context),
    validation: (tspconfig, context, node) => {
      const generateMetadata = tspconfig.options?.[emitters.ts].generateMetadata;
      if (generateMetadata !== true) context.report({ node, messageId: defaultMessageId });
    },
  },
};

export default createRule(ruleInfo);
