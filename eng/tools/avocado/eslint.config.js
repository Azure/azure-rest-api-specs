import eslint from '@eslint/js'
import { defineConfig } from 'eslint/config'
import globals from 'globals'
import tseslint from 'typescript-eslint'

/** @type {import('eslint').Linter.Config[]} */
export default defineConfig({ ignores: ['dist/**'] }, eslint.configs.recommended, tseslint.configs.recommended, {
  languageOptions: { globals: globals.node },
  rules: {
    // 17 errors
    '@typescript-eslint/no-explicit-any': 'off',
    // 5 errors
    '@typescript-eslint/no-require-imports': 'off',
  },
})
