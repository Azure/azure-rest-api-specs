import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    outputFile: {
      junit: "./test-results.xml",
    },
  },
});
