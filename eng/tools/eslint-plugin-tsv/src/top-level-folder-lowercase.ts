export const rule = {
  meta: {
    type: "problem",
    docs: {
      description: "Enforce that top level folder under 'specification' is lower case.",
    },
    schema: [],
  },
  // @ts-ignore
  create(context) {
    const filename = context.getFilename() as string;
    const regex = /specification\/[^/]*[A-Z]+[^/]*\//;

    return {
      // @ts-ignore
      Program(node) {
        // Check if the filename ends with '.test.js'
        if (filename.match(regex)) {
          context.report({
            node,
            message: "invalidPath",
          });
        }
      },
    };
  },
};

export default rule;
