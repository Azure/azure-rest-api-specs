import { ESLint } from "eslint";
import eslintPluginTsv from "../../src/eslint-plugin-tsv.js";

export function createESLint() {
  return new ESLint({
    cwd: "/",
    overrideConfig: eslintPluginTsv.configs.recommended,
    overrideConfigFile: true,
  });
}
