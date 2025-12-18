import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    dir: "./test",
    // Default timeout of 5 seconds is too low
    testTimeout: 20000,
  },
});
