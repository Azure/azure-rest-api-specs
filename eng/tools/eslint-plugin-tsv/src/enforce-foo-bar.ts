module.exports = {
  meta: {
    type: "problem",
    docs: {
      description:
        "Enforce that a variable named `foo` can only be assigned a value of 'bar'.",
    },
    fixable: "code",
    schema: [],
  },
  // @ts-ignore
  create(context) {
    return {
      // @ts-ignore
      YAMLPair(node) {
        if (node.key.value == "foo" && node.value.value != "bar") {
          context.report({
            node,
            message:
              'Value other than "bar" assigned to `foo`. Unexpected value: {{ notBar }}.',
            data: {
              notBar: node.value.value,
            },
            // @ts-ignore
            fix(fixer) {
              return fixer.replaceText(node.value, 'bar');
            },
          });
        }
      },
    };
  },
};
