import { defineConfig, mergeConfig } from "vitest/config";
import { defaultVitestConfig } from "../../vitest.config.mts";

export default mergeConfig(
  defaultVitestConfig,
  defineConfig({
    test: {
      include: ["test/**/*.test.ts"],
    },
  }),
);
