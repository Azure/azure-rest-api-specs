// TODO: Convert to TS

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
  create(context) {
    return {
      YAMLPair(node) {
        if (node.key.value == "foo" && node.value.value != "bar") {
          context.report({
            node,
            message:
              'Value other than "bar" assigned to `foo`. Unexpected value: {{ notBar }}.',
            data: {
              notBar: node.value.value,
            },
            fix(fixer) {
              return fixer.replaceText(node.value, 'bar');
            },
          });
        }
      },
    };
  },
};
