import { execa } from "execa";
import { describe, expect, test } from "vitest";

// TODO: Actual tests
describe("e2e", () => {
  test("Executes", async () => {
    const output = await execa("npm", ["exec", "--no", "--", "lint-diff"], { reject: false });

    try {
      expect(output.exitCode).toBe(1);
    } catch (error) {
      console.log(`stdout: ${output.stdout}`);
      console.log(`stderr: ${output.stderr}`);
      console.error("Error:", error);
      throw error;
    }
  });
});
