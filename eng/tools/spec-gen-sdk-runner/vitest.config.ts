import { defineConfig, mergeConfig } from "vitest/config";
import { baseConfig } from "../vitest.base.config.ts";

export default mergeConfig(
  baseConfig,
  defineConfig({
    test: {
      testTimeout: 20000,
    },
  }),
);
