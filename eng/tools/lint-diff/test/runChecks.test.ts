import { test, describe, expect } from "vitest";

import { executeCommand } from "../src/runChecks.js";

describe("executeCommand", () => {
  test("executes and returns result", async () => {
    const command = "echo 'hello world'";

    const { error, stdout } = await executeCommand(command);

    expect(error).toBeNull();
    expect(stdout).toMatch("hello world");
  });
});
