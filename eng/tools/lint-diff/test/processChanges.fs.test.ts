import { vol } from "memfs";
import { afterEach, describe, expect, test, vi } from "vitest";

import { readFileList } from "../src/processChanges.js";

// These tests are in a separate module because fs mocking is difficult to undo

vi.mock("node:fs/promises", async () => {
  const memfs = (await vi.importActual("memfs")) as typeof import("memfs");
  return {
    ...memfs.fs.promises,
  };
});

describe("readFileList", () => {
  afterEach(() => {
    vol.reset();
  });

  test("returns a list of items", async () => {
    // Using test1.txt because somehow another test affects the
    // value of test.txt in this context.
    const files = {
      "./test1.txt": "line1\nline2",
    };
    vol.fromJSON(files, ".");

    const fileList = await readFileList("./test1.txt");
    expect(fileList).toEqual(["line1", "line2"]);
  });

  test("returns an empty list if the file is empty", async () => {
    const files = {
      "./test.txt": "",
    };
    vol.fromJSON(files, ".");

    const fileList = await readFileList("./test.txt");
    expect(fileList).toEqual([]);
  });
});
