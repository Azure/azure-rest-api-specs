import { expect, it, vi } from "vitest";
import { execNpmExec, type ExecFileOptions, type ExecResult } from "../src/exec.ts";

const { execFile } = vi.hoisted(() => ({
  execFile:
    vi.fn<(file: string, args: string[], options: ExecFileOptions) => Promise<ExecResult>>(),
}));

vi.mock("node:util", async (importOriginal) => ({
  ...(await importOriginal<typeof import("node:util")>()),
  promisify: () => execFile,
}));

it.each([undefined, { cwd: "working-directory" }])(
  "forwards npm exec arguments and options without launching npm (options: %o)",
  async (options) => {
    const result = { stdout: "output", stderr: "diagnostic" };
    execFile.mockResolvedValueOnce(result);

    await expect(execNpmExec(["tool", "--flag"], options)).resolves.toBe(result);
    expect(execFile.mock.lastCall?.[1].slice(-5)).toEqual(["exec", "--no", "--", "tool", "--flag"]);
    expect(execFile.mock.lastCall?.[2].cwd).toBe(options?.cwd);
  },
);
