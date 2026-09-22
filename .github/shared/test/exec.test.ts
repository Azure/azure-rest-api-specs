import { dirname } from "path";
import semver from "semver";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";
import {
  execFile,
  execNpm,
  execNpmExec,
  execPnpm,
  execPnpmExec,
  isExecError,
} from "../src/exec.ts";
import { debugLogger } from "../src/logger.ts";

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
      stdout: expect.toSatisfy((v) => semver.valid(String(v)) !== null) as unknown,
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
      code: expect.toSatisfy((v) => v !== 0) as unknown,
    });
  });
});

describe("execNpmExec", () => {
  // A command run in the context of "npm exec ___" needs to call
  // something installed in the workspace. In this case, oxfmt is present
  // so it is used.
  it("runs oxfmt", { timeout: 15_000 }, async () => {
    // npm may emit warnings to stderr (e.g. unknown env config) depending on the
    // environment, so only assert on stdout here.
    const result = await execNpmExec(["oxfmt", "--version"], options);
    expect(result.stdout.trim()).toMatch(/^Version: \d+\.\d+\.\d+$/);
  });
});

describe("execPnpm", () => {
  it("succeeds with --version", async () => {
    await expect(execPnpm(["--version"], options)).resolves.toMatchObject({
      stdout: expect.toSatisfy((v) => semver.valid(String(v)) !== null) as unknown,
      stderr: "",
    });
  });

  it("succeeds with root", async () => {
    // "pnpm root" in this dir returns the node_modules path of the nearest workspace root
    const result = await execPnpm(["root"], { ...options, cwd: __dirname });
    expect(result.stdout.trim()).toContain("node_modules");
  });

  it("succeeds with prefix option", async () => {
    const result = await execPnpm(["--version"], { ...options, prefix: __dirname });
    expect(semver.valid(result.stdout.trim())).not.toBeNull();
  });

  it("fails with invalid command", async () => {
    await expect(execPnpm(["invalid-command-xyz"], options)).rejects.toMatchObject({
      code: expect.toSatisfy((v) => v !== 0) as unknown,
    });
  });

  it("fails when stdout exceeds maxBuffer", async () => {
    await expect(execPnpm(["--version"], { ...options, maxBuffer: 1 })).rejects.toMatchObject({
      code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER",
    });
  });

  it("captures stderr", async () => {
    const result = await execPnpm(
      ["exec", "node", "-e", "process.stderr.write('hello-stderr')"],
      options,
    );
    expect(result.stderr).toContain("hello-stderr");
  });

  it("fails when stderr exceeds maxBuffer", async () => {
    await expect(
      execPnpm(["exec", "node", "-e", "process.stderr.write('x'.repeat(100))"], {
        ...options,
        maxBuffer: 1,
      }),
    ).rejects.toMatchObject({
      code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER",
    });
  });
});

describe("execPnpmExec", () => {
  // A command run in the context of "pnpm exec ___" needs to call
  // something installed in the workspace. In this case, oxfmt is present
  // so it is used.
  it("runs oxfmt", async () => {
    const result = await execPnpmExec(["oxfmt", "--version"], options);
    expect(result.stdout.trim()).toMatch(/^Version: \d+\.\d+\.\d+$/);
    expect(result.stderr).toBe("");
  });
});

describe("isExecError", () => {
  it("isExecError", () => {
    expect(isExecError("test")).toBe(false);

    const error = new Error();
    expect(isExecError(error)).toBe(false);

    const execError = error as import("../src/exec.ts").ExecError;

    execError.stdout = "test";
    expect(isExecError(execError)).toBe(true);

    delete execError.stdout;
    expect(isExecError(execError)).toBe(false);

    execError.stderr = "test";
    expect(isExecError(execError)).toBe(true);
  });
});
