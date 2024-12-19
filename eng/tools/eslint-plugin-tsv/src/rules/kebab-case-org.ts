import path from "path";
import { NamedRule } from "../named-eslint.js";

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
      kebab:
        "Organization name (first path segment after 'specification') does not use kebab-case: '{{orgName}}'",
    },
  },
  create(context) {
    const filename = path.resolve(context.filename as string);

    const pathSegments = filename.split(path.sep);

    // TODO: Handle errors
    // - No "specification" segment
    // - No segemnt after "specification"
    const orgName = pathSegments[pathSegments.indexOf("specification") + 1];
    const kebabCaseRegex = /^[a-z0-9]+(-[a-z0-9]+)*$/;
    const orgNameKebabCase = orgName.match(kebabCaseRegex);

    return {
      Program(node) {
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
