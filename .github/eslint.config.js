import { defineConfig } from "eslint/config";
import baseConfig from "./shared/eslint.base.config.js";

/** @type {import('eslint').Linter.Config[]} */
export default defineConfig(baseConfig, {
  languageOptions: {
    parserOptions: {
      // ensures the tsconfig path resolves relative to this file (so cannot be defined in base file)
      // default is process.cwd() when running eslint, which may be incorrect
      tsconfigRootDir: import.meta.dirname,
    },
  },
});
