import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    dir: "./test",
    coverage: {
      exclude: [...configDefaults.coverage.exclude!, "cmd/**", "src/index.ts"],
    },
  },
});
