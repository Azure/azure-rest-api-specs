import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";
import { RuleDocuments } from "../interfaces/rule-interfaces.js";
import { emitters } from "./constants.js";

export function makeRuleMessages(messageId: string, docs: RuleDocuments) {
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
