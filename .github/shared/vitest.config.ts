import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    coverage: {
      exclude: [
        ...(configDefaults.coverage.exclude ?? []),

        // Not worth testing CLI code
        "cmd/**/*.ts",
      ],

      // Enforce 100% coverage for all metrics
      thresholds: {
        branches: 100,
        functions: 100,
        lines: 100,
        statements: 100,
      },
    },
  },
});
