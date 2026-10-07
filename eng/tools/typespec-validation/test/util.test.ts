import { mockFolder } from "./mocks.ts";
import { defaultLogger } from "@azure-tools/specs-shared/logger";

import { strict as assert } from "node:assert";
import path from "node:path";
import process from "node:process";
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
        files: [],
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

    it.each([
      ["c:\\foo\\bar", "C:/foo/bar"],
      ["C:\\foo\\bar\\..\\baz\\", "C:/foo/baz"],
      ["d:\\", "D:/"],
      ["\\\\server\\share\\folder\\..\\file.txt", "//server/share/file.txt"],
      ["\\\\server\\share\\..\\file.txt", "//server/share/file.txt"],
      ["\\\\server\\share", "//server/share/"],
      ["\\\\?\\C:\\foo\\bar", "//?/C:/foo/bar"],
      ["\\\\.\\pipe\\example", "//./pipe/example"],
    ])("normalizes Windows path %s without changing its root", (input, expected) => {
      expect(normalizePath(input, path.win32)).toBe(expected);
    });

    it.each(["c:foo", "c:", "C:folder\\..\\file.txt"])(
      "uses native resolution for drive-relative path %s",
      (input) => {
        const expected = path.win32.resolve(input).replaceAll("\\", "/").replace(/^c:/, "C:");
        expect(normalizePath(input, path.win32)).toBe(expected);
      },
    );

    it("preserves literal backslashes in POSIX filenames", () => {
      expect(normalizePath("/foo\\bar/file.txt", path.posix)).toBe("/foo\\bar/file.txt");
    });
  });
  describe("gitDiff", function () {
    it("should succeed if git diff produces no output", async function () {
      const result = await gitDiffTopSpecFolder(mockFolder, defaultLogger);
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
