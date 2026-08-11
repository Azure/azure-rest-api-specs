import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    // By default, vitest@4 only excludes tests from "node_modules" and ".git" folders (not "dist").
    // Recommended fix is to *include* only the folders you want (more performant than excluding).
    dir: "./test",
    coverage: {
      exclude: [...configDefaults.coverage.exclude!, "cmd/**", "src/index.ts"],
    },
  },
});
