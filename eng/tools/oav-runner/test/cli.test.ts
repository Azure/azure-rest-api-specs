import { describe, it, expect, vi } from "vitest";
import { getRootFolder } from "../src/cli.js";
import path from "path";

const REPOROOT = path.resolve(__dirname, "..", "..", "..", "..");

describe("invocation directory checks", () => {
  it("Should return the same path when invoked from the root of a git repo.", async () => {
    const result = await getRootFolder(REPOROOT);
    expect(result).toBe(REPOROOT);
  });

  it("Should return a higher path when invoked from a path deep in a git repo.", async () => {
    const result = await getRootFolder(path.join(REPOROOT, "eng", "tools", "oav-runner"));
    expect(result).toBe(REPOROOT);
  });

  it("Should exit with error when invoked outside of a git directory.", async () => {
    const pathOutsideRepo = path.resolve(path.join(REPOROOT, ".."));

    const exitMock = vi
      .spyOn(process, "exit")
      .mockImplementation((code?: number) => {
        throw new Error(`Exit ${code}`);
      });

    await expect(getRootFolder(pathOutsideRepo)).rejects.toThrow("Exit 1");

    exitMock.mockRestore();
  });
});