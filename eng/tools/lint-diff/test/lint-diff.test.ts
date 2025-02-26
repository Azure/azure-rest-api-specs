import { execa } from "execa";
import { test } from "vitest";

// TODO: Actual tests
test.concurrent("Executes", async ({ expect }) => {
  const { exitCode } = await execa("npm", ["exec", "--no", "--", "lint-diff"], { reject: false });

  expect(exitCode).toBe(1);
});
