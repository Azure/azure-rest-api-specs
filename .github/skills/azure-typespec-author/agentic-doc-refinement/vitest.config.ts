import { defineConfig, mergeConfig } from "vitest/config";
import { defaultVitestConfig } from "../../../../vitest.config.mts";

export default mergeConfig(
  defaultVitestConfig,
  defineConfig({
    test: {
      name: "azure-typespec-author-doc-refinement",
      include: ["*.test.ts"],
      restoreMocks: true,
      unstubGlobals: true,
      unstubEnvs: true,
    },
  }),
);
