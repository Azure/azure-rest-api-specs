import { dirname } from "path";
import semver from "semver";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";
import { execFile, execNpm, execNpmExec, isExecError } from "../src/exec.js";
import { debugLogger } from "../src/logger.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

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
    ).rejects.toMatchObject({
      stdout: "test",
      stderr: "",
      code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER",
    });
  });
});

describe("execNpm", () => {
  it("succeeds with --version", async () => {
    await expect(execNpm(["--version"], options)).resolves.toMatchObject({
      stdout: /** @type {unknown} */ (expect.toSatisfy((v) => semver.valid(String(v)) !== null)),
      stderr: "",
    });
  });

  it("succeeds with root", async () => {
    // "pnpm root" in this dir returns the node_modules path of the nearest workspace root
    const result = await execNpm(["root"], { ...options, cwd: __dirname });
    expect(result.stdout.trim()).toContain("node_modules");
  });

  it("succeeds with prefix option", async () => {
    const result = await execNpm(["--version"], { ...options, prefix: __dirname });
    expect(semver.valid(result.stdout.trim())).not.toBeNull();
  });

  it("fails with invalid command", async () => {
    await expect(execNpm(["invalid-command-xyz"], options)).rejects.toMatchObject({
      code: /** @type {unknown} */ (expect.toSatisfy((v) => v !== 0)),
    });
  });
});

describe("execNpmExec", () => {
  // A command run in the context of "pnpm exec ___" needs to call
  // something referenced in package.json. In this case, prettier is present
  // so it is used.
  it("runs prettier", async () => {
    await expect(execNpmExec(["prettier", "--version"], options)).resolves.toEqual({
      stdout: /** @type {unknown} */ (expect.toSatisfy((v) => semver.valid(String(v)) !== null)),
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

    const execError = /** @type {import("../src/exec.js").ExecError} */ (error);

    execError.stdout = "test";
    expect(isExecError(execError)).toBe(true);

    delete execError.stdout;
    expect(isExecError(execError)).toBe(false);

    execError.stderr = "test";
    expect(isExecError(execError)).toBe(true);
  });
});
