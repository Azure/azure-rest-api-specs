import { Ajv } from "ajv";
import { Rule } from "eslint";
import { AST, getStaticYAMLValue } from "yaml-eslint-parser";
import { TypeSpecConfigJsonSchema } from "../config/config-schema.js";
import { TypeSpecConfig } from "../config/types.js";
import { NamedRule } from "../interfaces/named-eslint.js";

export const rule: NamedRule.RuleModule = {
  name: "emit-autorest",
  meta: {
    type: "problem",
    docs: {
      description:
        "Requires emitter 'typespec-autorest' to be enabled by default, and requires emitted autorest to match content in repo",
    },
    schema: [],
    messages: {
      invalid: "tspconfig.yaml is invalid per the schema: {{errors}}",
      missing:
        'tspconfig.yaml must include the following emitter by default:\n\nemit:\n  - "@azure-tools/typespec-autorest"',
      // disabled: "Path does not match format '.*/specification/{orgName}/': ''{{filename}}'",
      // autorestDiff: "Emitted autorest does not match content in repo",
    },
  },
  create(context) {
    return {
      YAMLDocument(node: Rule.Node) {
        const yamlDocument = node as unknown as AST.YAMLDocument;

        // If config yaml is empty, use empty object instead of "null"
        const config = getStaticYAMLValue(yamlDocument) || {};

        const ajv = new Ajv();
        const valid = ajv.validate(TypeSpecConfigJsonSchema, config);

        if (!valid) {
          context.report({
            node,
            messageId: "invalid",
            data: { errors: ajv.errorsText(ajv.errors) },
          });
          return;
        }

        const typedConfig = config as unknown as TypeSpecConfig;
        if (!typedConfig.emit?.includes("@azure-tools/typespec-autorest")) {
          // TODO: Move error message to "emit:" node
          context.report({
            node,
            messageId: "missing",
          });
          return;
        }
      },
    };
  },
};

export default rule;
