import { describe, expect, it } from "vitest";
import { execFile } from "../src/exec.js";
import { createMockLogger } from "./mocks.js";

describe("execFile", () => {
  const file = "node";
  const args = ["-e", `console.log("test")`];
  const expected = "test\n";

  it.each([{}, { logger: createMockLogger() }])(
    "exec succeeds with default buffer (options: %o)",
    async (options) => {
      await expect(execFile(file, args, options)).resolves.toEqual(expected);
    },
  );

  it("exec succeeds with exact-sized buffer", async () => {
    await expect(
      execFile(file, args, { maxBuffer: expected.length }),
    ).resolves.toEqual(expected);
  });

  it("exec fails with too-small buffer", async () => {
    await expect(
      execFile(file, args, { maxBuffer: expected.length - 1 }),
    ).rejects.toThrowError(
      expect.objectContaining({ code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER" }),
    );
  });
});
