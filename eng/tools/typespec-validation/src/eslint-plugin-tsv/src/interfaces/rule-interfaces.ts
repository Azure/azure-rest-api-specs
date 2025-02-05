import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";

export enum KeyType {
  EmitterOption,
  Parameter,
}

export interface RuleDocument {
  description: string;
  error: string;
  action: string;
  example: string;
}

export interface RuleInfo {
  name: string;
  documentation: RuleDocument;
  functions: {
    messages: () => { [messageId: string]: string } | undefined;
    condition: (tspconfig: TypeSpecConfig, context: Rule.RuleContext) => boolean;
    validation: (tspconfig: TypeSpecConfig, context: Rule.RuleContext, node: Rule.Node) => void;
  };
}

export interface CreateCodeGenSDKRuleArgs {
  rule: string;
  type: KeyType;
  key: string;
  expectedValue: string | boolean | RegExp;
  exampleValue: string | boolean;
  extraExplanation?: string;
  condition?: (tspconfig: TypeSpecConfig, context: Rule.RuleContext) => boolean;
}