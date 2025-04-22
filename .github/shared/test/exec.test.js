import semver from "semver";
import { describe, expect, it } from "vitest";
import { execFile, execNpm } from "../src/exec.js";
import { consoleLogger } from "../src/logger.js";

describe("execFile", () => {
  const file = "node";
  const args = ["-e", `console.log("test")`];
  const expected = "test\n";

  it.each([{}, { logger: consoleLogger }])(
    "exec succeeds with default buffer (options: %o)",
    async (options) => {
      await expect(execFile(file, args, options)).resolves.toEqual({
        stdout: expected,
        stderr: "",
      });
    },
  );

  it("exec succeeds with exact-sized buffer", async () => {
    await expect(
      execFile(file, args, { maxBuffer: expected.length }),
    ).resolves.toEqual({ stdout: expected, stderr: "" });
  });

  it("exec fails with too-small buffer", async () => {
    await expect(
      execFile(file, args, { maxBuffer: expected.length - 1 }),
    ).rejects.toThrowError(
      expect.objectContaining({
        stdout: "test",
        stderr: "",
        code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER",
      }),
    );
  });
});

describe("execNpm", () => {
  it("succeeds with --version", async () => {
    await expect(execNpm(["--version"])).resolves.toEqual({
      stdout: expect.toSatisfy((v) => semver.valid(v)),
      stderr: "",
    });
  });

  it("fails with --help", async () => {
    await expect(execNpm(["--help"])).rejects.toThrowError(
      expect.objectContaining({
        stdout: expect.stringMatching(/usage/i),
        stderr: "",
        code: 1,
      }),
    );
  });
});
