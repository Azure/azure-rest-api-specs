import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    exclude: [
      ...configDefaults.exclude,

      // These files use node:test and are run by the assessment skill's `npm test`.
      // Vitest would collect them by name but find no Vitest test suite.
      "skills/azure-typespec-assessment/scripts/*.test.mjs",
    ],
    coverage: {
      exclude: [
        ...(configDefaults.coverage.exclude ?? []),

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
