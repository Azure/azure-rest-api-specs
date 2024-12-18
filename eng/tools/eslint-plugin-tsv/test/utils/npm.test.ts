import { beforeEach, describe, expect, it, vi } from "vitest";
import { vol } from "memfs";
import { Npm } from "../../src/utils/npm.js";

vi.mock("fs/promises", async () => {
  const memfs = await import("memfs");
  return {
    ...memfs.fs.promises,
  };
});

describe("prefix", () => {
  beforeEach(() => {
    vol.reset();
  });

  describe("returns current directory if no match", () => {
    it.each([
      ["/tmp/foo/tspconfig.yaml", "/tmp/foo"],
      ["/tmp/foo", "/tmp/foo"],
    ])("%s", async (path, expected) => {
      vol.fromJSON({
        "/tmp/foo/tspconfig.yaml": "1",
      });

      expect(await Npm.prefix(path)).toBe(expected);
    });
  });
});
