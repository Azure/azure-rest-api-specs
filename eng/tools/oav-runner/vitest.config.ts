import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    ...configDefaults,
    testTimeout: 20000,
    coverage: {
      provider: "v8",
      reporter: ["text", "json", "html"],
    },
  },
});
