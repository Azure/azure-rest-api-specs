import eslintPluginTsv from "../../../src/eslint-plugin-tsv.js";

export const config = [
  ...(eslintPluginTsv.configs as any).recommended,
];

export default config;
