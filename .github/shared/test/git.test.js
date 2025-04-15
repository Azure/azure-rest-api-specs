// @ts-check

import { afterEach, describe, expect, it, vi } from "vitest";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    diff: vi.fn().mockResolvedValue(""),
    raw: vi.fn().mockResolvedValue(""),
    show: vi.fn().mockResolvedValue(""),
    status: vi.fn().mockResolvedValue(""),
  }),
}));

import * as simpleGit from "simple-git";
import { diff, lsTree, show, status } from "../src/git.js";
import { ConsoleLogger } from "../src/logger.js";

const gitOpts = { logger: new ConsoleLogger(/*isDebug*/ true) };

describe("git", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

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
    vi.mocked(simpleGit.simpleGit().show).mockResolvedValue("test show");

    await expect(
      show("HEAD", "specification/contosowidgetmanager/cspell.yaml"),
    ).resolves.toBe("test show");
  });

  it("status", async () => {
    vi.mocked(simpleGit.simpleGit().raw).mockResolvedValue("test status");

    await expect(
      status({ args: ["-b", "--porcelain", "does-not-exist"] }),
    ).resolves.toBe("test status");
  });
});
