import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";
import { RuleDocument, RuleInfo } from "../interfaces/rule-interfaces.js";
import { defaultMessageId, defaultRuleType, emitters } from "./constants.js";
import { NamedRule } from "../interfaces/named-eslint.js";
import { AST, getStaticYAMLValue } from "yaml-eslint-parser";

function createManagementRuleDocument(
  emitterName: string,
  optionName: string,
  expectedOptionValue: string | boolean,
): RuleDocument {
  const document: RuleDocument = {
    description: `Validate whether '${optionName}' is set to true in tspconfig.yaml when generating modular clients`,
    error: `'${optionName}' is NOT set to true in tspconfig.yaml when generating modular clients`,
    action: `Set 'options.${emitters.ts}.${optionName}' to true in tspconfig.yaml when generating modular clients`,
    example: `...
        options:
        "${emitterName}":
            ${optionName}: ${expectedOptionValue} # <--- SET HERE
            ...
        `,
  };
  return document;
}

export function createRule(ruleContext: RuleInfo): NamedRule.RuleModule {
  const rule: NamedRule.RuleModule = {
    name: ruleContext.name,
    meta: {
      type: defaultRuleType,
      docs: {
        description: ruleContext.documentation.description,
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

export function createRuleMessages(messageId: string, docs: RuleDocument) {
  return {
    [messageId]: `${docs.error}.\n${docs.action}.\n${docs.example}`,
  };
}

export function isManagementForTsEmitter(tspconfig: TypeSpecConfig, context: Rule.RuleContext) {
  const flavor = tspconfig.options?.[emitters.ts]?.flavor as string;
  const isModularLibrary = tspconfig.options?.[emitters.ts]?.isModularLibrary as
    | boolean
    | undefined;
  const filename = context.filename;
  return flavor === "azure" && filename.includes(".Management") && isModularLibrary == undefined;
}

export function generateEmitterOptions(
  emitter: string,
  ...pairs: { key: string; value: string | boolean | {} }[]
) {
  let content = `options:
    "${emitter}":`;
  for (const pair of pairs) {
    content += `
      ${pair.key}: ${pair.value}`;
  }
  return content;
}

export function createManagementClientRule(
  ruleName: string,
  emitterName: string,
  optionName: string,
  expectedOptionValue: string | boolean,
): NamedRule.RuleModule {
  const documentation = createManagementRuleDocument(emitterName, optionName, expectedOptionValue);

  const ruleInfo: RuleInfo = {
    name: ruleName,
    documentation,
    functions: {
      messages: () => createRuleMessages(defaultMessageId, documentation),
      condition: (tspconfig, context) => isManagementForTsEmitter(tspconfig, context),
      validation: (tspconfig, context, node) => {
        const option = tspconfig.options?.[emitters.ts][optionName];
        if (option !== expectedOptionValue) context.report({ node, messageId: defaultMessageId });
      },
    },
  };

  return createRule(ruleInfo);
}
