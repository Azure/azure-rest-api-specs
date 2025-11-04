import { basename, resolve, sep } from "path";
import { describe, expect, it } from "vitest";
import { includesSegment, untilLastSegment } from "../src/path.js";

const cwd = process.cwd();

describe("path", () => {
  it.each([
    ["/a/b/c/d.txt", "d.txt", true],
    ["/a/b/c/d.txt", "c", true],
    ["/a/b/c/d.txt", "b", true],
    ["/a/b/c/d.txt", "a", true],
    ["/a/b/c/d.txt", "", true],
    ["/a/b/c/d.txt", "z", false],
    ["/a/b/c/d.txt", sep, false],
    // Ensure path is resolved (against cwd) before searching
    ["a/b/c/d.txt", "d.txt", true],
    ["a/b/c/d.txt", "c", true],
    ["a/b/c/d.txt", "b", true],
    ["a/b/c/d.txt", "a", true],
    ["a/b/c/d.txt", basename(cwd), true],
    ["a/b/c/d.txt", "", true],
    ["a/b/c/d.txt", sep, false],
    // Multiple occurrences of segment
    ["/a/b/a/c/a/d.txt", "a", true],
  ])("includesSegment(%o, %o) => %o", (path, segment, expected) => {
    expect(includesSegment(path, segment)).toEqual(expected);
  });

  it.each([
    ["/a/b/c/d.txt", "d.txt", "/a/b/c"],
    ["/a/b/c/d.txt", "c", "/a/b"],
    ["/a/b/c/d.txt", "b", "/a"],
    ["/a/b/c/d.txt", "a", "/"],
    ["/a/b/c/d.txt", "", "/"],
    ["/a/b/c/d.txt", "z", ""],
    ["/a/b/c/d.txt", sep, ""],
    // Ensure path is resolved (against cwd) before searching
    ["a/b/c/d.txt", "d.txt", "a/b/c"],
    ["a/b/c/d.txt", "c", "a/b"],
    ["a/b/c/d.txt", "b", "a"],
    ["a/b/c/d.txt", "a", cwd],
    ["a/b/c/d.txt", "", "/"],
    ["a/b/c/d.txt", sep, ""],
    // Ensure last occurrence of segment is used
    ["/a/b/a/c/a/d.txt", "a", "/a/b/a/c"],
  ])("untilLastSegment(%o, %o) => %o", (path, segment, expected) => {
    const resolvedExpected = expected === "" ? "" : resolve(expected);
    expect(untilLastSegment(path, segment)).toEqual(resolvedExpected);
  });
});
