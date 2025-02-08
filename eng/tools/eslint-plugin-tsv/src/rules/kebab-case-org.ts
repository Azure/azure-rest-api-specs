import path from "path";
import { NamedRule } from "../interfaces/named-eslint.js";

// Valid:   /specification/kebab-case/Kebab.Case/tspconfig.yaml
// Invalid: /specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml

export const rule: NamedRule.RuleModule = {
  name: "kebab-case-org",
  meta: {
    type: "problem",
    docs: {
      description:
        "Requires kebab-case for'organization' name (first path segment after 'specification')",
    },
    schema: [],
    messages: {
      invalid: "Path does not match format '.*/specification/{orgName}/': ''{{filename}}'",
      kebab:
        "Organization name (first path segment after 'specification') does not use kebab-case: '{{orgName}}'",
    },
  },
  create(context) {
    return {
      Program(node) {
        const filename = path.resolve(context.filename as string);
        const pathSegments = filename.split(path.sep);
        const specificationIndex = pathSegments.indexOf("specification");
        const pathValid = specificationIndex >= 0 && specificationIndex < pathSegments.length - 1;

        if (!pathValid) {
          context.report({
            node,
            messageId: "invalid",
            data: { filename: filename },
          });
          return;
        }

        const orgName = pathSegments[specificationIndex + 1];
        const kebabCaseRegex = /^[a-z0-9]+(-[a-z0-9]+)*$/;
        const orgNameKebabCase = orgName.match(kebabCaseRegex);

        if (!orgNameKebabCase) {
          context.report({
            node,
            messageId: "kebab",
            data: { orgName: orgName },
          });
        }
      },
    };
  },
};

export default rule;
