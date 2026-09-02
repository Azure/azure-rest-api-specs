// @ts-check

import { defineConfig } from "vitest/config";

export const baseConfig = defineConfig({
  test: {
    // By default, vitest@4 only excludes tests from "node_modules" and ".git" folders (not "dist").
    // Recommended fix is to *include* only the folders you want (more performant than excluding).
    dir: "./test",
  },
});
