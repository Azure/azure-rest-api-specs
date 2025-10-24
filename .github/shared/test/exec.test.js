import semver from "semver";
import { describe, expect, it } from "vitest";
import { execFile, execNpm, execNpmExec, isExecError } from "../src/exec.js";
import { debugLogger } from "../src/logger.js";

const options = { logger: debugLogger };

describe("execFile", () => {
  const file = "node";
  const args = ["-e", `console.log("test")`];
  const expected = "test\n";

  it.each([{}, options])("exec succeeds with default buffer (options: %o)", async (options) => {
    await expect(execFile(file, args, options)).resolves.toEqual({
      stdout: expected,
      stderr: "",
    });
  });

  it("exec succeeds with exact-sized buffer", async () => {
    await expect(execFile(file, args, { ...options, maxBuffer: expected.length })).resolves.toEqual(
      { stdout: expected, stderr: "" },
    );
  });

  it("exec fails with too-small buffer", async () => {
    await expect(
      execFile(file, args, { ...options, maxBuffer: expected.length - 1 }),
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
    await expect(execNpm(["--version"], options)).resolves.toEqual({
      stdout: expect.toSatisfy((v) => semver.valid(v)),
      stderr: "",
    });
  });

  it("fails with --help", async () => {
    await expect(execNpm(["--help"], options)).rejects.toThrowError(
      expect.objectContaining({
        stdout: expect.stringMatching(/usage/i),
        stderr: "",
        code: 1,
      }),
    );
  });
});

describe("execNpmExec", () => {
  // A command run in the context of "npm exec --no -- ___" needs to call
  // something referenced in package.json. In this case, js-yaml is present
  // so it is used.
  it("runs js-yaml", async () => {
    await expect(execNpmExec(["js-yaml", "--version"], options)).resolves.toEqual({
      stdout: expect.toSatisfy((v) => semver.valid(v)),
      stderr: "",
      error: undefined,
    });
  });
});

describe("isExecError", () => {
  it("isExecError", () => {
    expect(isExecError("test")).toBe(false);

    const error = new Error();
    expect(isExecError(error)).toBe(false);

    error.stdout = "test";
    expect(isExecError(error)).toBe(true);

    delete error.stdout;
    expect(isExecError(error)).toBe(false);

    error.stderr = "test";
    expect(isExecError(error)).toBe(true);
  });
});
