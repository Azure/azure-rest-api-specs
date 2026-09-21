import { configDefaults, defineConfig, mergeConfig } from "vitest/config";
import { baseConfig } from "../vitest.base.config.ts";

export default mergeConfig(
  baseConfig,
  defineConfig({
    test: {
      coverage: {
        exclude: [...configDefaults.coverage.exclude!, "cmd/**", "src/index.ts"],
      },
    },
  }),
);
