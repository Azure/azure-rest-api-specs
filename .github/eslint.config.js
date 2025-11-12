// Keep in sync with .github/shared/eslint.config.js

import eslint from "@eslint/js";
import { defineConfig } from "eslint/config";
import globals from "globals";
import tseslint from "typescript-eslint";

/** @type {import('eslint').Linter.Config[]} */
export default defineConfig(eslint.configs.recommended, tseslint.configs.recommended, {
  languageOptions: { globals: globals.node },
});
