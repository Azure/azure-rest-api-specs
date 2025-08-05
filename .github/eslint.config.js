import eslint from "@eslint/js";
import globals from "globals";
import tseslint from "typescript-eslint";

/** @type {import('eslint').Linter.Config[]} */
export default tseslint.config(eslint.configs.recommended, tseslint.configs.recommended, {
  languageOptions: { globals: globals.node },
});
