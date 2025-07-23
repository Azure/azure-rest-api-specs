// Keep in sync with .github/shared/eslint.config.js

import js from "@eslint/js";
import importPlugin from "eslint-plugin-import";
import globals from "globals";

/** @type {import('eslint').Linter.Config[]} */
export default [
  js.configs.recommended,
  importPlugin.flatConfigs.recommended,
  { languageOptions: { ecmaVersion: "latest", globals: globals.node } },
];
