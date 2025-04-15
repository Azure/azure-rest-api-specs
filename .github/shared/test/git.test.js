// @ts-check

import { describe, expect, it, vi } from "vitest";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    diff: vi.fn().mockResolvedValue(""),
    raw: vi.fn().mockResolvedValue(""),
  }),
}));

import * as simpleGit from "simple-git";
import * as exec from "../src/exec.js";
import { diff, lsTree, show, status } from "../src/git.js";
import { ConsoleLogger } from "../src/logger.js";

const gitOpts = { logger: new ConsoleLogger(/*isDebug*/ true) };

describe("git", () => {
  it("diff", async () => {
    vi.mocked(simpleGit.simpleGit().diff).mockResolvedValue("test diff");

    await expect(diff("HEAD^", "HEAD", gitOpts)).resolves.toBe("test diff");
  });

  it("lsTree", async () => {
    vi.mocked(simpleGit.simpleGit().raw).mockResolvedValue("test ls-tree");

    await expect(
      lsTree("HEAD", "specification/contosowidgetmanager"),
    ).resolves.toBe("test ls-tree");
  });

  it("show", async () => {
    const execSpy = vi
      .spyOn(exec, "execFile")
      .mockResolvedValue({ stdout: "test show", stderr: "" });

    await expect(
      show("HEAD", "specification/contosowidgetmanager/cspell.yaml"),
    ).resolves.toBe("test show");

    expect(execSpy).toBeCalledWith(
      "git",
      [
        "-c",
        "core.quotepath=off",
        "show",
        "HEAD:specification/contosowidgetmanager/cspell.yaml",
      ],
      expect.anything(),
    );
  });

  it("status", async () => {
    const execSpy = vi
      .spyOn(exec, "execFile")
      .mockResolvedValue({ stdout: "test status", stderr: "" });

    await expect(
      status({ args: ["-b", "--porcelain", "does-not-exist"] }),
    ).resolves.toBe("test status");

    expect(execSpy).toBeCalledWith(
      "git",
      [
        "-c",
        "core.quotepath=off",
        "status",
        "-b",
        "--porcelain",
        "does-not-exist",
      ],
      expect.anything(),
    );
  });
});
