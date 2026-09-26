import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
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
