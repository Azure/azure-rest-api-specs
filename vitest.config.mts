import { configDefaults, defineConfig, mergeConfig } from "vitest/config";

export const defaultVitestConfig = defineConfig({
  test: {
    testTimeout: 10000,
    coverage: {
      provider: "v8",
      reporter: ["text", "json", "html"],
      exclude: [
        ...(configDefaults.coverage.exclude ?? []),
        "**/cmd/**",
        "**/coverage/**",
        "**/test/**",
      ],
    },
  },
});

export default mergeConfig(
  defaultVitestConfig,
  defineConfig({
    test: {
      projects: [
        ".github/vitest.config.ts",
        ".github/shared/vitest.config.ts",
        "eng/tools/*/vitest.config.ts",
      ],
      coverage: {
        thresholds: {
          ".github/shared/src/**": {
            branches: 100,
            functions: 100,
            lines: 100,
            statements: 100,
          },
        },
      },
    },
  }),
);
