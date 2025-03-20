import { describe, expect, it, vi } from "vitest";
import * as exec from "../src/exec.js";
import { diff, lsTree, show } from "../src/git.js";

describe("git", () => {
  it("diff", async () => {
    const execRootSpy = vi
      .spyOn(exec, "execRoot")
      .mockResolvedValue("test diff");

    await expect(diff("HEAD^", "HEAD")).resolves.toBe("test diff");

    expect(execRootSpy).toBeCalledWith(
      "git -c core.quotepath=off diff HEAD^ HEAD",
      expect.anything(),
    );
  });

  it("lstree", async () => {
    const execRootSpy = vi
      .spyOn(exec, "execRoot")
      .mockResolvedValue("test lstree");

    await expect(
      lsTree("HEAD", "specification/contosowidgetmanager"),
    ).resolves.toBe("test lstree");

    expect(execRootSpy).toBeCalledWith(
      "git -c core.quotepath=off ls-tree HEAD specification/contosowidgetmanager",
      expect.anything(),
    );
  });

  it("show", async () => {
    const execRootSpy = vi
      .spyOn(exec, "execRoot")
      .mockResolvedValue("test show");

    await expect(
      show("HEAD", "specification/contosowidgetmanager/cspell.yaml"),
    ).resolves.toBe("test show");

    expect(execRootSpy).toBeCalledWith(
      "git -c core.quotepath=off show HEAD:specification/contosowidgetmanager/cspell.yaml",
      expect.anything(),
    );
  });
});
