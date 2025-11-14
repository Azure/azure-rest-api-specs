// Keep in sync with .github/shared/eslint.config.js

import eslint from "@eslint/js";
import { defineConfig } from "eslint/config";
import globals from "globals";
import tseslint from "typescript-eslint";

/** @type {import('eslint').Linter.Config[]} */
export default defineConfig(eslint.configs.recommended, tseslint.configs.recommendedTypeChecked, {
  languageOptions: {
    // we only run in node, not browser
    globals: globals.node,
    // required to use tseslint.configs.recommendedTypeChecked
    parserOptions: {
      projectService: true,
      // ensures the tsconfig path resolves relative to this file
      // default is process.cwd() when running eslint, which may be incorrect
      tsconfigRootDir: import.meta.dirname,
    },
  },
});
