import { defineConfig } from "vite";
import { configDefaults } from "vitest/config";

export default defineConfig({
  test: {
    ...configDefaults,
    // eslint-disable-next-line unicorn/numeric-separators-style
    testTimeout: 20000,
    coverage: {
      provider: "v8",
      reporter: ["text", "json", "html"],
    },
  },
});
