// no-unresolved is not aware of exports definition in package.json
// https://github.com/import-js/eslint-plugin-import/issues/1810
//
// eslint-disable-next-line import/no-unresolved
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
        "cmd/**/*.js",
      ],
    },
  },
});
