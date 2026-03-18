import { defineConfig, mergeConfig } from "vitest/config";
import baseConfig from "./vitest.config.js";

export default mergeConfig(
  baseConfig,
  defineConfig({
    test: {
      coverage: {
        enabled: true,
      },
      reporters:
        process.env.GITHUB_ACTIONS === "true" ? ["verbose", "github-actions"] : ["verbose"],
    },
  }),
);
