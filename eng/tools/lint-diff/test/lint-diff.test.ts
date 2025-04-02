import { execa } from "execa";
import { test, describe } from "vitest";

// TODO: Actual tests
describe("e2e", () => {
  test.concurrent("Executes", async ({ expect }) => {
    const { exitCode } = await execa("npm", ["exec", "--no", "--", "lint-diff"], { reject: false });
    expect(exitCode).toBe(1);
  });
});
