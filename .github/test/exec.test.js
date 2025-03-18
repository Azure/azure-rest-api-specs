import { EOL } from "os";
import { describe, expect, it } from "vitest";
import { buildCmd, execRoot } from "../src/exec.js";
import { createMockLogger } from "./mocks.js";

describe("exec", () => {
  const str = "test";
  const cmd = `echo ${str}`;
  const expected = `${str}${EOL}`;

  it.each([{}, { logger: createMockLogger() }])(
    "execRoot succeeds with default buffer (options: %o)",
    async (options) => {
      await expect(execRoot(cmd, options)).resolves.toEqual(expected);
    },
  );

  it("execRoot succeeds with exact-sized buffer", async () => {
    await expect(
      execRoot(cmd, { maxBuffer: expected.length }),
    ).resolves.toEqual(expected);
  });

  it("execRoot fails with too-small buffer", async () => {
    await expect(
      execRoot(cmd, { maxBuffer: expected.length - 1 }),
    ).rejects.toThrowError(
      expect.objectContaining({ code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER" }),
    );
  });

  it("buildCmd", () => {
    const cmd = buildCmd(
      "foo",
      // Excluded
      null,
      // Arg is *not* trimmed, so trailing whitespace is preserved
      "spaceAfter ",
      // Excluded since all-whitespace
      " \t",
      // Excluded
      undefined,
      // Arg is *not* trimmed, so leading whitespace is preserved
      " spaceBefore",
    );
    expect(cmd).toBe("foo spaceAfter   spaceBefore");
  });
});
