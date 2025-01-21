import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";
import { RuleDocument, RuleInfo } from "../interfaces/rule-interfaces.js";
import { defaultMessageId, defaultRuleType, emitters } from "./constants.js";
import { NamedRule } from "../interfaces/named-eslint.js";
import { AST, getStaticYAMLValue } from "yaml-eslint-parser";
import { stringify } from "yaml";
import { resolveValues } from "./config-interpolation.js";

function createManagementRuleDocument(
  emitterName: string,
  optionName: string,
  expectedOptionValue: string | boolean | RegExp,
  exampleValue: string | boolean,
  extraExplanation: string,
): RuleDocument {
  let description: string = "";
  switch (typeof expectedOptionValue) {
    case "string":
    case "boolean":
      `Validate whether 'options.${emitters.ts}.${optionName}' is set to '${expectedOptionValue}' in tspconfig.yaml when generating modular clients`;
      break;
    case "object":
      `Validate whether 'options.${emitters.ts}.${optionName}' matches regex pattern '${expectedOptionValue}' in tspconfig.yaml when generating modular clients. ${extraExplanation}`;
      break;
  }

  const document: RuleDocument = {
    description,
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
          const rawConfig = getStaticYAMLValue(yamlDocument) || {};
          const config = rawConfig as unknown as TypeSpecConfig;

          if (!ruleContext.functions.condition(config, context)) return;
          ruleContext.functions.validation(config, context, node);
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

export function isManagementSDK(
  tspconfig: TypeSpecConfig,
  context: Rule.RuleContext,
  emitterName: string,
) {
  const flavor = tspconfig.options?.[emitterName]?.flavor as string;
  const filename = context.filename;
  return flavor === "azure" && filename.includes(".Management");
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
  optionName: string,
  expectedOptionValue: string | boolean | RegExp,
  exampleValue: string | boolean,
  extraExplanation: string = "",
): NamedRule.RuleModule {
  const language = ruleName.split("-")[1]! as keyof typeof emitters;
  const emitterName = emitters[language];
  const documentation = createManagementRuleDocument(
    emitterName,
    optionName,
    expectedOptionValue,
    exampleValue,
    extraExplanation,
  );

  const ruleInfo: RuleInfo = {
    name: ruleName,
    documentation,
    functions: {
      messages: () => createRuleMessages(defaultMessageId, documentation),
      condition: (tspconfig, context) => {
        const isManagement = isManagementSDK(tspconfig, context, emitterName);
        if (!isManagement) return false;

        if (emitterName === emitters.ts) {
          const isModularLibrary = tspconfig.options?.[emitters.ts]?.isModularLibrary as
            | boolean
            | undefined;
          return isModularLibrary === undefined || isModularLibrary === true;
        }
        return true;
      },
      validation: (tspconfig, context, node) => {
        let option: any = tspconfig.options?.[emitterName];
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
