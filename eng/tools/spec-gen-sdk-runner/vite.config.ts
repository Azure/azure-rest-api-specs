import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    ...configDefaults,
    // By default, vitest@4 only excludes tests from "node_modules" and ".git" folders (not "dist").
    // Recommended fix is to *include* only the folders you want (more performant than excluding).
    dir: "./test",
    // eslint-disable-next-line unicorn/numeric-separators-style
    testTimeout: 20000,
    coverage: {
      provider: "v8",
      reporter: ["text", "json", "html"],
    },
  },
});
