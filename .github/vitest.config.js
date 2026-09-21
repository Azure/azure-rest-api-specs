import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  esbuild: {
    // Ignore tsconfig.json, since it's only used for type checking, and causes
    // a warning if vitest tries to load it
    // @ts-expect-error: tsConfig' does not exist in type 'ESBuildOptions'
    tsConfig: false,
  },

  test: {
    exclude: [
      ...configDefaults.exclude,

      // These use node:test and are run by the assessment skill's own test suite.
      "skills/azure-typespec-assessment/scripts/*.test.mjs",
    ],
    coverage: {
      exclude: [
        ...(configDefaults.coverage.exclude ?? []),

        // Config files (not in defaults)
        "**/eslint*.config.js",

        // Not worth testing CLI code
        "**/cmd/**",

        // Ignore all coverage folders
        "**/coverage/**",

        // Ignore all test folders
        "**/test/**",
      ],
    },
  },
});
