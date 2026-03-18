import { defineConfig, mergeConfig } from "vitest/config";
import baseConfig from "./vitest.base.config.js";

const config = mergeConfig(
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

export default config;
