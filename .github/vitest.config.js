import { configDefaults, defineConfig } from "vitest/config";

export default defineConfig({
  esbuild: {
    // Ignore tsconfig.json, since it's only used for type checking, and causes
    // a warning if vitest tries to load it
    tsConfig: false,
  },

  test: {
    coverage: {
      exclude: [
        ...configDefaults.coverage.exclude,

        // Not worth testing CLI code
        "**/cmd/**",

        // Ignore all coverage folders
        "**/coverage/**",

        // Ignore all test folders
        "**/test/**",
      ],
    },
  },
});
