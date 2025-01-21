import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";
import { RuleDocument, RuleInfo } from "../interfaces/rule-interfaces.js";
import { defaultMessageId, defaultRuleType, emitters } from "./constants.js";
import { NamedRule } from "../interfaces/named-eslint.js";
import { AST, getStaticYAMLValue } from "yaml-eslint-parser";
import { stringify } from "yaml";

function createManagementRuleDocument(
  emitterName: string,
  optionName: string,
  expectedOptionValue: string | boolean | RegExp,
  exampleValue: string | boolean,
): RuleDocument {
  const document: RuleDocument = {
    // TODO: improve description with natual language
    description: `Validate whether 'options.${emitters.ts}.${optionName}' is set to '${expectedOptionValue}' in tspconfig.yaml when generating modular clients`,
    error: `'options.${emitters.ts}.${optionName}' is NOT set to '${expectedOptionValue}' in tspconfig.yaml when generating modular clients`,
    action: `Set 'options.${emitters.ts}.${optionName}' to '${expectedOptionValue}' in tspconfig.yaml when generating modular clients`,
    example: createEmitterOptions(emitterName, { key: optionName, value: exampleValue }),
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

export function createEmitterOptions(
  emitter: string,
  ...pairs: { key: string; value: string | boolean | {} }[]
) {
  const obj = { options: { [emitter]: {} } };
  for (const pair of pairs) {
    const segments = pair.key.split(".");
    let cur: { [id: string]: any } = obj.options[emitter];
    for (const [i, segment] of segments.entries()) {
      if (i === segments.length - 1) {
        cur[segment] = pair.value;
        break;
      }
      if (!(segment in cur)) {
        cur[segment] = {};
      }
      cur = cur[segment];
    }
  }
  const content = stringify(obj);
  return content;
}

export function createManagementClientRule(
  ruleName: string,
  emitterName: string,
  optionName: string,
  expectedOptionValue: string | boolean | RegExp,
  exampleValue: string | boolean,
): NamedRule.RuleModule {
  const documentation = createManagementRuleDocument(
    emitterName,
    optionName,
    expectedOptionValue,
    exampleValue,
  );

  const ruleInfo: RuleInfo = {
    name: ruleName,
    documentation,
    functions: {
      messages: () => createRuleMessages(defaultMessageId, documentation),
      condition: (tspconfig, context) => isManagementForTsEmitter(tspconfig, context),
      validation: (tspconfig, context, node) => {
        let option: any = tspconfig.options?.[emitters.ts];
        for (const segment of optionName.split(".")) {
          if (segment in option) option = option[segment];
        }
        switch (typeof expectedOptionValue) {
          case "boolean":
          case "string":
            if (option !== expectedOptionValue)
              context.report({ node, messageId: defaultMessageId });
            break;
          case "object":
            if (typeof option !== "string" || !expectedOptionValue.test(option))
              context.report({ node, messageId: defaultMessageId });
            break;
        }
      },
    },
  };

  return createRule(ruleInfo);
}
