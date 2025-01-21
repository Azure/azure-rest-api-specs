import { Rule } from "eslint";
import { AST, getStaticYAMLValue } from "yaml-eslint-parser";
import { TypeSpecConfig } from "../config/types.js";
import { NamedRule } from "../interfaces/named-eslint.js";
import { RuleInfo } from "../interfaces/rule-interfaces.js";
import { defaultRuleType } from "./constants.js";

export function createRule(ruleContext: RuleInfo) {
  const rule: NamedRule.RuleModule = {
    name: ruleContext.name,
    meta: {
      type: defaultRuleType,
      docs: {
        description: ruleContext.docs.description,
      },
      schema: [],
      messages: ruleContext.functions.messages(),
    },
    create(context) {
      return {
        YAMLDocument(node: Rule.Node) {
          const yamlDocument = node as unknown as AST.YAMLDocument;
          const config = getStaticYAMLValue(yamlDocument) || {};
          const typedConfig = config as unknown as TypeSpecConfig;
          if (!ruleContext.functions.condition(typedConfig, context)) return;
          ruleContext.functions.validation(typedConfig, context, node);
        },
      };
    },
  };
  return rule;
}
