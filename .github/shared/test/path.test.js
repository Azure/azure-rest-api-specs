// @ts-check

import { sep } from "path";
import { describe, expect, it } from "vitest";
import { includesFolder } from "../src/path.js";

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
  ])("includesFolder(%s, %s) => %s", (path, folder, result) => {
    console.log();
    expect(includesFolder(path, folder)).toEqual(result);
  });

  // TODO: Add tests for untilFolder using cwdSegments
});
