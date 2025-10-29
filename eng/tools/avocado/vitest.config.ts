import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    // git-test.ts can be slow on Windows
    testTimeout: 100000,
  },
});
