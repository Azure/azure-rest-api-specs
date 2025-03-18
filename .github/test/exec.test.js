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
      // Non-string values, both truthy and falsy
      true,
      false,
      -1,
      0,
      1,
      "",
      NaN,
      // Invalid, but we currently don't exclude it, so test it
      {},
      // Converts to "", so excluded as empty string
      [],
      // Converts to string
      ["arrayElement1", "arrayElement2"],
      ["newArray"],
    );
    expect(cmd).toBe(
      "foo spaceAfter   spaceBefore true false -1 0 1 NaN [object Object] arrayElement1,arrayElement2 newArray",
    );
  });
});
