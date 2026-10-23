import { defineConfig, mergeConfig } from "vitest/config";
import { defaultVitestConfig } from "../../../vitest.config.mts";

export default mergeConfig(
  defaultVitestConfig,
  defineConfig({
    test: {
      name: "storage-rp-to-typespec",
      include: ["test/**/*.test.ts"],
    },
  }),
);
