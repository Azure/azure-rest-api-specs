import nodePlugin from "eslint-plugin-n";

export default [
  {
    ignores: ["**/coverage/**"],
  },
  {
    files: [".github/**/*.js", "eng/tools/**/*.js"],
    plugins: {
      n: nodePlugin,
    },
    rules: {
      ...nodePlugin.configs["flat/recommended"].rules,
      "n/prefer-node-protocol": "error",
    },
  },
];
