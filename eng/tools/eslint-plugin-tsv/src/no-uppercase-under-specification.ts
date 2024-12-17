export const rule = {
  meta: {
    type: "problem",
    docs: {
      description: "Disallow uppercase letters in first folder under '/specification/'",
    },
    schema: [],
    messages: {
      upper: "'{{path}}' contains uppercase letters in the first folder under '/specification/'",
    },
  },
  // @ts-ignore
  create(context) {
    const filename = context.getFilename() as string;

    const regex = /\/specification\/[^/A-Z]+\//;
    const uppercaseLettersInFirstFolder = !filename.match(regex);

    return {
      // @ts-ignore
      Program(node) {
        if (uppercaseLettersInFirstFolder) {
          context.report({
            node,
            messageId: "upper",
            data: { path: filename },
          });
        }
      },
    };
  },
};

export default rule;
