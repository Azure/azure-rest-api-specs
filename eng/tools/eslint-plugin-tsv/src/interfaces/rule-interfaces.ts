import { Rule } from "eslint";
import { TypeSpecConfig } from "../config/types.js";

export interface RuleDocuments {
  description: string;
  error: string;
  action: string;
  example: string;
}

export interface RuleInfo {
  name: string;
  docs: RuleDocuments;
  functions: {
    messages: () => { [messageId: string]: string } | undefined;
    condition: (tspconfig: TypeSpecConfig, context: Rule.RuleContext) => boolean;
    validation: (tspconfig: TypeSpecConfig, context: Rule.RuleContext, node: Rule.Node) => void;
  };
}
