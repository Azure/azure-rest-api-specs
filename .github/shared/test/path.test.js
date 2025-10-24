// @ts-check

import { sep } from "path";
import { describe, expect, it } from "vitest";
import { includesFolder, untilFolder } from "../src/path.js";

const cwd = process.cwd();
const cwdSegments = cwd.split(sep);

describe("path", () => {
  it.each([
    ["/path/to/examples/file.json", "examples", true],
    ["/path/to/examples", "examples", true],
    ["/path/to/swagger/file.json", "examples", false],
    // Ensure path is resolved (against cwd) before searching
    ["foo/bar", "foo", true],
    ["foo/bar", cwdSegments[cwdSegments.length - 1], true],
    ["foo/bar", "qux", false],
  ])("includesFolder(%o, %o) => %o", (path, folder, expected) => {
    expect(includesFolder(path, folder)).toEqual(expected);
  });

  it.each([
    ["/a/b/c/d.txt", "c", "/a/b"],
    ["/a/b/c/d.txt", "b", "/a"],
    ["/a/b/c/d.txt", "a", "/"],
    ["/a/b/c/d.txt", "z", ""],
  ])("untilFolder(%o, %o) => %o", (path, folder, expected) => {
    expect(untilFolder(path, folder)).toEqual(expected);
  });
});
