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
      disabled: "Path does not match format '.*/specification/{orgName}/': ''{{filename}}'",
      autorestDiff: "Emitted autorest does not match content in repo",
    },
  },
  create(context) {
    return {
      Program(node) {
        // const filename = path.resolve(context.filename as string);
        // const pathSegments = filename.split(path.sep);
        // const specificationIndex = pathSegments.indexOf("specification");
        // const pathValid = specificationIndex >= 0 && specificationIndex < pathSegments.length - 1;
        // if (!pathValid) {
        //   context.report({
        //     node,
        //     messageId: "invalid",
        //     data: { filename: filename },
        //   });
        //   return;
        // }
        // const orgName = pathSegments[specificationIndex + 1];
        // const kebabCaseRegex = /^[a-z0-9]+(-[a-z0-9]+)*$/;
        // const orgNameKebabCase = orgName.match(kebabCaseRegex);
        // if (!orgNameKebabCase) {
        //   context.report({
        //     node,
        //     messageId: "kebab",
        //     data: { orgName: orgName },
        //   });
        // }
      },
    };
  },
};

export default rule;
