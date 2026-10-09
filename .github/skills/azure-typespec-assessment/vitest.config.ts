import { defineConfig, mergeConfig } from "vitest/config";
import { defaultVitestConfig } from "../../../vitest.config.mts";

export default mergeConfig(
  defaultVitestConfig,
  defineConfig({
    test: {
      name: "azure-typespec-assessment",
      fileParallelism: false,
      include: ["scripts/**/*.test.ts"],
      restoreMocks: true,
      testTimeout: 60_000,
    },
  }),
);
