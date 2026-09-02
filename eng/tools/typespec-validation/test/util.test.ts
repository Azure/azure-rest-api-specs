import { mockFolder, mockSimpleGit } from "./mocks.ts";
mockSimpleGit();

import { strict as assert } from "node:assert";
import path from "path";
import process from "process";
import { simpleGit } from "simple-git";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { gitDiffTopSpecFolder, normalizePath, readFileAtCommit } from "../src/utils.ts";

describe("util", function () {
  let revparseMock = vi.fn();
  let showMock = vi.fn();

  beforeEach(() => {
    revparseMock = vi.fn().mockResolvedValueOnce("abc123").mockResolvedValueOnce("C:/repo\n");
    showMock = vi.fn().mockResolvedValue("versions: []\n");
    vi.mocked(simpleGit).mockReturnValue({
      revparse: revparseMock,
      show: showMock,
      status: vi.fn().mockResolvedValue({
        modified: [],
        not_added: [],
        isClean: () => true,
      }),
    } as never);
  });

  describe("normalize", function () {
    it("should succeed if normalized . and normalized cwd matches", function () {
      const dotResult = normalizePath(".");
      const cwdResult = normalizePath(process.cwd());
      assert(dotResult === cwdResult);
    });

    it("should succeed if /foo/bar/ is normalized", function () {
      const result = normalizePath("/foo/bar/", path.posix);
      assert.equal(result, "/foo/bar");
    });

    it("should normalize windows drive letter", function () {
      const lowerResult = normalizePath("c:\\foo\\bar", path.win32);
      const upperResult = normalizePath("C:\\foo\\bar", path.win32);
      assert.equal(lowerResult, upperResult);
    });

    it("should distinguish different windows drive letters", function () {
      const lowerResult = normalizePath("c:\\foo\\bar", path.win32);
      const upperResult = normalizePath("d:\\foo\\bar", path.win32);
      assert.notEqual(lowerResult, upperResult);
    });
  });
  describe("gitDiff", function () {
    it("should succeed if git diff produces no output", async function () {
      const result = await gitDiffTopSpecFolder(mockFolder);
      assert(result.success);
    });
  });

  describe("readFileAtCommit", function () {
    it("reads a repository-relative path from the requested commit", async function () {
      const content = await readFileAtCommit(
        "C:/repo/specification/foo/Foo",
        "base",
        "C:/repo/specification/foo/Foo/service.yaml",
      );

      expect(content).toBe("versions: []\n");
      expect(revparseMock).toHaveBeenNthCalledWith(1, ["--verify", "base^{commit}"]);
      expect(showMock).toHaveBeenCalledWith(["base:specification/foo/Foo/service.yaml"]);
    });

    it("returns undefined when the file does not exist at the commit", async function () {
      vi.mocked(simpleGit).mockReturnValue({
        revparse: vi.fn().mockResolvedValueOnce("abc123").mockResolvedValueOnce("C:/repo\n"),
        show: vi.fn().mockRejectedValue(new Error("path does not exist")),
      } as never);

      await expect(
        readFileAtCommit(
          "C:/repo/specification/foo/Foo",
          "base",
          "C:/repo/specification/foo/Foo/service.yaml",
        ),
      ).resolves.toBeUndefined();
    });
  });
});
