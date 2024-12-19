import { beforeEach, describe, expect, it, vi } from "vitest";
import { vol } from "memfs";
import { resolve } from "path";
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
      ["/foo/bar/tspconfig.yaml", "/foo/bar"],
      ["/foo/bar", "/foo/bar"],
    ])("%s", async (path, expected) => {
      vol.fromJSON({
        "/foo/bar/tspconfig.yaml": "",
      });

      expect(await Npm.prefix(path)).toBe(resolve(expected));
    });
  });

  describe("returns first match", () => {
    it.each([
      ["/pj", "/pj"],
      ["/pj/none", "/pj"],
      ["/pj/none/none/none", "/pj"],
      ["/pj/nm", "/pj/nm"],
      ["/pj/nm/none", "/pj/nm"],
      ["/pj/pj", "/pj/pj"],
      ["/pj/nm/pj", "/pj/nm/pj"],
      ["/pj/pj/nm", "/pj/pj/nm"],
    ])("%s", async (path, expected) => {
      vol.fromJSON({
        "/pj/package.json": "",
        "/pj/none": null,
        "/pj/none/none/none": null,
        "/pj/nm/node_modules": null,
        "/pj/nm/none": null,
        "/pj/pj/package.json": "",
        "/pj/nm/pj/package.json": "",
        "/pj/pj/nm/node_modules": null,
      });

      expect(await Npm.prefix(path)).toBe(resolve(expected));
    });
  });
});
