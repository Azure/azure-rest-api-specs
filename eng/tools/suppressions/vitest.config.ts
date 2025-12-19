import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    watch: false,
    include: ["test/**/*.test.ts"],
    coverage: {
      exclude: [...configDefaults.coverage.exclude!, "cmd/**", "src/index.ts"],
    },
  },
});
