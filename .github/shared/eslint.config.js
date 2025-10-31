// Keep in sync with .github/eslint.config.js

import eslint from "@eslint/js";
import { defineConfig } from "eslint/config";
import globals from "globals";
import tseslint from "typescript-eslint";

/** @type {import('eslint').Linter.Config[]} */
export default defineConfig(
  {
    ignores: [
      // must enable TSC checking of tests, before we can enable eslint type-checked
      "test/**",
    ],
  },
  eslint.configs.recommended,
  tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: {
      // we only run in node, not browser
      globals: globals.node,
      // required to use tseslint.configs.recommendedTypeChecked
      parserOptions: { projectService: true },
    },
  },
);
