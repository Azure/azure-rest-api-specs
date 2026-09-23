import { mkdir, mkdtemp, realpath, rm, writeFile } from "node:fs/promises";
import { findPackageJSON } from "node:module";
import { tmpdir } from "node:os";
import { dirname, join } from "path";
import semver from "semver";
import { fileURLToPath } from "url";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  execFile,
  execNodeBin,
  execNpm,
  execNpmExec,
  execPnpm,
  execPnpmExec,
  isExecError,
} from "../src/exec.ts";
import { debugLogger } from "../src/logger.ts";

vi.mock("node:module", async (importOriginal) => {
  const original = await importOriginal<typeof import("node:module")>();
  return { ...original, findPackageJSON: vi.fn(original.findPackageJSON) };
});

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

describe("execNodeBin", () => {
  let root: string;

  beforeEach(async () => {
    root = await mkdtemp(join(tmpdir(), "node-bin-test-"));
  });

  afterEach(async () => {
    await rm(root, { recursive: true, force: true });
  });

  async function installCli(
    folder: string,
    bin: string | Record<string, string> = { cli: "cli.cjs" },
    source = "console.log(JSON.stringify({ args: process.argv.slice(2), cwd: process.cwd(), node: process.execPath }))",
    exports: Record<string, string> = { "./package.json": "./package.json" },
  ) {
    const packageDir = join(folder, "node_modules", "@test", "cli");
    await mkdir(packageDir, { recursive: true });
    await writeFile(
      join(packageDir, "package.json"),
      JSON.stringify({ name: "@test/cli", exports, bin }),
    );
    await writeFile(join(packageDir, "cli.cjs"), source);
  }

  it("runs an installed binary using the default working directory", async () => {
    const result = await execNodeBin("prettier", ["prettier", "--version"], options);
    expect(semver.valid(result.stdout.trim())).not.toBeNull();
    expect(result.stderr).toBe("");
  });

  it.each([{ cli: "cli.cjs" }, "cli.cjs"])(
    "resolves ancestor packages and preserves cwd and arguments with bin %j",
    async (bin) => {
      await installCli(root, bin);
      const cwd = join(root, "project with spaces # and %");
      await mkdir(cwd);
      const args = ["a b", '{"value":"quoted"}', "../**/*.tsp", "", "--", "a&b|c"];
      const result = await execNodeBin("@test/cli", ["cli", ...args], { cwd });
      const output = JSON.parse(result.stdout) as {
        args: string[];
        cwd: string;
        node: string;
      };
      // Windows can report the same directory through its short (8.3) path.
      expect({ ...output, cwd: await realpath(output.cwd) }).toEqual({
        args,
        cwd: await realpath(cwd),
        node: process.execPath,
      });
    },
  );

  it("uses the dependency from the requested checkout, not the helper's checkout", async () => {
    const otherCheckout = join(root, "other-checkout");
    await installCli(root, "cli.cjs", "console.log('outer')");
    await installCli(otherCheckout, "cli.cjs", "console.log('other')");
    await expect(execNodeBin("@test/cli", ["cli"], { cwd: otherCheckout })).resolves.toEqual({
      stdout: "other\n",
      stderr: "",
    });
  });

  it("does not install a missing package or fall back to PATH", async () => {
    await expect(execNodeBin("@test/missing", ["node"], { cwd: root })).rejects.toMatchObject({
      code: "ERR_MODULE_NOT_FOUND",
    });
  });

  it.each<Record<string, string>>([{}, { ".": "./cli.cjs" }])(
    "runs a binary without a package.json export (exports: %j)",
    async (exports) => {
      await installCli(root, "cli.cjs", "console.log('not exported')", exports);
      await expect(execNodeBin("@test/cli", ["cli"], { cwd: root })).resolves.toEqual({
        stdout: "not exported\n",
        stderr: "",
      });
    },
  );

  it("reports when the resolver cannot find a package manifest", async () => {
    vi.mocked(findPackageJSON).mockReturnValueOnce(undefined);
    await expect(execNodeBin("@test/cli", ["cli"], { cwd: root })).rejects.toThrow(
      'Cannot find package.json for "@test/cli".',
    );
  });

  it.each([{ cli: "cli.cjs" }, "cli.cjs"])("rejects an unknown binary with bin %j", async (bin) => {
    await installCli(root, bin);
    await expect(execNodeBin("@test/cli", ["unknown"], { cwd: root })).rejects.toThrow(
      'Package "@test/cli" does not define the binary "unknown".',
    );
  });

  it("preserves nonzero exit codes and captured output", async () => {
    await installCli(
      root,
      "cli.cjs",
      "process.stdout.write('output'); process.stderr.write('diagnostic'); process.exit(7)",
    );
    await expect(execNodeBin("@test/cli", ["cli"], { cwd: root })).rejects.toMatchObject({
      code: 7,
      stdout: "output",
      stderr: "diagnostic",
    });
  });

  it("enforces the caller's output limit", async () => {
    await installCli(root, "cli.cjs", "console.log('too much output')");
    await expect(
      execNodeBin("@test/cli", ["cli"], { cwd: root, maxBuffer: 1 }),
    ).rejects.toMatchObject({ code: "ERR_CHILD_PROCESS_STDIO_MAXBUFFER" });
  });

  it("terminates the binary when the caller's timeout expires", async () => {
    await installCli(root, "cli.cjs", "setInterval(() => {}, 1000)");
    await expect(
      execNodeBin("@test/cli", ["cli"], { cwd: root, timeout: 100 }),
    ).rejects.toMatchObject({ killed: true });
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
