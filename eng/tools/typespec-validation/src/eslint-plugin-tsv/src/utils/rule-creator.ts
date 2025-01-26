import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";
import {
  CreateCodeGenSDKRuleArgs,
  KeyType,
  RuleDocument,
  RuleInfo,
} from "../interfaces/rule-interfaces.js";
import { defaultMessageId, defaultRuleType, emitters } from "./constants.js";
import { NamedRule } from "../interfaces/named-eslint.js";
import { AST, getStaticYAMLValue } from "yaml-eslint-parser";
import { createRuleDocument } from "./rule-doc.js";

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
          // TODO: remove try-catch block when ESLint based TSV is ready, and have confidence for this 
          try {
            const yamlDocument = node as unknown as AST.YAMLDocument;
            const rawConfig = getStaticYAMLValue(yamlDocument) || {};
            const config = rawConfig as unknown as TypeSpecConfig;
            if (!ruleContext.functions.condition(config, context)) return;
            ruleContext.functions.validation(config, context, node);
          } catch (error) {
            console.error(`Failed to validate rule '${ruleContext.name}' due to error: ${error}`);
          }
        },
      };
    },
  };
  return rule;
}

export function createRuleMessages(messageId: string, docs: RuleDocument) {
  return {
    [messageId]: `Error: ${docs.error}.\nAction: ${docs.action}.\nExample:\n\`\`\`\n${docs.example}\n\`\`\``,
  };
}

export function isManagementSDK(context: Rule.RuleContext) {
  const filename = context.filename;
  return filename.includes(".Management");
}

function validateValue(
  context: Rule.RuleContext,
  node: Rule.Node,
  actual: string | boolean | undefined,
  expected: boolean | string | RegExp,
) {
  switch (typeof expected) {
    case "boolean":
    case "string":
      if (actual !== expected) context.report({ node, messageId: defaultMessageId });
      break;
    case "object":
      if (typeof actual !== "string" || !expected.test(actual))
        context.report({ node, messageId: defaultMessageId });
      break;
    case "undefined":
      context.report({ node, messageId: defaultMessageId });
      break;
    default:
      console.warn("Unsupported expected-value-type for tspconfig.yaml");      
      break;
  }
}

// TODO: add logs
export function createCodeGenSDKRule(args: CreateCodeGenSDKRuleArgs): NamedRule.RuleModule {
  const language = args.rule.split("-")[1]! as keyof typeof emitters;
  const emitterName = emitters[language];
  const documentation = createRuleDocument(
    emitterName,
    args.type,
    args.key,
    args.expectedValue,
    args.exampleValue,
    args.extraExplanation ?? "",
  );

  const ruleInfo: RuleInfo = {
    name: args.rule,
    documentation: documentation!,
    functions: {
      messages: () => createRuleMessages(defaultMessageId, documentation),
      condition: (tspconfig, context) => {
        if (args.condition) return args.condition(tspconfig, context);
        return true;
      },
      validation: (tspconfig, context, node) => {
        switch (args.type) {
          case KeyType.EmitterOption: {
            let option: Record<string, any> | undefined = tspconfig.options?.[emitterName];
            for (const segment of args.key.split(".")) {
              if (option && segment in option) option = option![segment];
            }
            validateValue(
              context,
              node,
              option as undefined | string | boolean,
              args.expectedValue,
            );
            break;
          }
          case KeyType.Parameter: {
            const parameter = tspconfig.parameters?.[args.key].default;
            validateValue(context, node, parameter, args.expectedValue);
            break;
          }
          default:
            console.warn("Unsupported key type in tspconfig.yaml");
            break;
        }
      },
    },
  };

  return createRule(ruleInfo);
}
