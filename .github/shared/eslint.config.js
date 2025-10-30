// Keep in sync with .github/eslint.config.js

import eslint from "@eslint/js";
import { defineConfig } from "eslint/config";
import globals from "globals";
import tseslint from "typescript-eslint";

/** @type {import('eslint').Linter.Config[]} */
export default defineConfig(
  { ignores: ["*.config.js", "test/**"] },
  eslint.configs.recommended,
  tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: { globals: globals.node, parserOptions: { projectService: true } },
  },
);
