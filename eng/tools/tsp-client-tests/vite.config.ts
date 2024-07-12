import { defineConfig } from "vite";

export default defineConfig({
  test: {
    // Default timeout of 5 seconds is too low
    testTimeout: 60000,
  },
});
