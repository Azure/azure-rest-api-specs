import { defineConfig, mergeConfig } from "vitest/config";
import { defaultVitestConfig } from "../../vitest.config.mts";

export const baseConfig = mergeConfig(
  defaultVitestConfig,
  defineConfig({
    test: {
      include: ["test/**/*.test.ts"],
    },
  }),
);
