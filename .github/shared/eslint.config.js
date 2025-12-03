import { defineConfig } from "eslint/config";
import base from "./eslint.base.config.js";

/** @type {import('eslint').Linter.Config[]} */
export default defineConfig(base, {
  languageOptions: {
    parserOptions: {
      // ensures the tsconfig path resolves relative to this file (so cannot be defined in base file)
      // default is process.cwd() when running eslint, which may be incorrect
      tsconfigRootDir: import.meta.dirname,
    },
  },
});
