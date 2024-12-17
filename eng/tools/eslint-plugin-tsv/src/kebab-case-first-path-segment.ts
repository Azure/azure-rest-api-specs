// TODO: Add types

export const rule = {
  meta: {
    name: "kebab-case-first-path-segment",
    type: "problem",
    docs: {
      description: "Requires first path segment after 'specification' to use kebab-case",
    },
    schema: [],
    messages: {
      kebab: "First path segment after 'specification' does not use kebab-case",
    },
  },
  // @ts-ignore
  create(context) {
    const filename = context.getFilename() as string;

    const regex = /\/specification\/[a-z0-9]+(-[a-z0-9]+)*\//;
    const kebabCaseFirstFolder = filename.match(regex);

    return {
      // @ts-ignore
      Program(node) {
        if (!kebabCaseFirstFolder) {
          context.report({
            node,
            messageId: "kebab",
          });
        }
      },
    };
  },
};

export default rule;
