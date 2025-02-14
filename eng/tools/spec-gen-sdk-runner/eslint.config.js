// @ts-check

// The overall contents of this file is based on:
// https://typescript-eslint.io/getting-started#step-2-configuration
// https://typescript-eslint.io/getting-started/typed-linting/#shared-configurations
// Read inline comments for details on other sources.

import eslint from "@eslint/js";
import eslintPluginUnicorn from "eslint-plugin-unicorn";
import tseslint from "typescript-eslint";

const config = tseslint.config(
  // ========================================
  // ESLint + TS-ESLint configs
  // ========================================
  {
    // Needed for 'npm run lint' per:
    // https://eslint.org/docs/latest/use/configure/migration-guide#--ext
    // See also:
    // - https://typescript-eslint.io/troubleshooting/typed-linting/#i-get-errors-telling-me-eslint-was-configured-to-run--however-that-tsconfig-does-not--none-of-those-tsconfigs-include-this-file
    // - https://eslint.org/docs/latest/use/configure/ignore
    ignores: [".prettierrc.cjs", "**/*.d.ts", "**/*.js", "**/*.mjs"],
  },
  eslint.configs.recommended,
  ...tseslint.configs.strictTypeChecked,
  ...tseslint.configs.stylisticTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        project: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  {
    // Disable type-aware linting on .js files
    // Otherwise eslint would complain about types in .js files, including this config file.
    // Config snippet taken from https://typescript-eslint.io/packages/typescript-eslint/#advanced-usage
    // Note: this is likely redundant with the global ignores of .js files, but keeping here for reference.
    files: ["**/*.js"],
    ...tseslint.configs.disableTypeChecked,
  },

  // ========================================
  // Secondary configs
  // ========================================
  // @ts-expect-error The unicorn configs are not typed correctly, but they do work.
  // Snippet taken from https://github.com/sindresorhus/eslint-plugin-unicorn#preset-configs-eslintconfigjs
  eslintPluginUnicorn.configs["flat/recommended"],
  // Note: in spite of my best efforts, I did not manage to get lodash eslint plugin to work in a clean way.
  // https://github.com/wix-incubator/eslint-plugin-lodash
  // I did manage to get it to lint, but the ESLint server output was throwing error about
  // not being able to locate the config file.
  // I suspect this is because the plugin was not migrated to the new flat config format since ESLint v9.
  // Maybe this can be worked around with
  // https://eslint.org/blog/2024/05/eslint-compatibility-utilities/

  // ========================================
  // Rulesets overrides
  // ========================================
  {
    rules: {
      // Sometimes we have to help the type checker with "!":
      // e.g. when doing `if (arr.length > 0) { const ... = arr[0]! }`
      // Note: this originates from [strict]
      // https://typescript-eslint.io/rules/no-non-null-assertion
      "@typescript-eslint/no-non-null-assertion": "off",
      "@typescript-eslint/restrict-template-expressions": "off",
      "@typescript-eslint/no-unsafe-assignment": "off",
      "@typescript-eslint/no-unsafe-argument": "off",

      // We want more flexibility with file names.
      // https://github.com/sindresorhus/eslint-plugin-unicorn/blob/main/docs/rules/filename-case.md
      "unicorn/filename-case": "off",
      "unicorn/prefer-ternary": "off",

      // We prefer to have explicitly import at the top of the file, even if the same element is exported again,
      // which we do in index.ts files.
      // https://github.com/sindresorhus/eslint-plugin-unicorn/blob/main/docs/rules/prefer-export-from.md
      "unicorn/prefer-export-from": ["error", { ignoreUsedVariables: true }],

      // We allow some abbreviations that we like.
      // https://github.com/sindresorhus/eslint-plugin-unicorn/blob/main/docs/rules/prevent-abbreviations.md
      "unicorn/prevent-abbreviations": [
        "error",
        {
          allowList: {
            args: true,
          },
        },
      ],
    },
  }
);

export default config;

// Debug tool:
// Uncomment to print the config. View it in VS Code / Output / ESLint. Run "ESLint: Restart ESLint Server" command to force output.
// console.log(`ESLint config: ${JSON.stringify(config)}`)

// [strict]: https://github.com/typescript-eslint/typescript-eslint/blob/main/packages/eslint-plugin/src/configs/strict.ts
