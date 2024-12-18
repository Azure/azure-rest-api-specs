// import { beforeEach, test, vi } from "vitest";
import { describe, expect, it } from "vitest";

import { Npm } from "../../src/utils/npm.js";

// vi.mock('fs')
describe("prefix", () => {
  describe("returns current directory if no match", () => {
    it.each([
      ["/tmp/foo/tspconfig.yaml", "/tmp/foo"],
      ["/tmp/foo", "/tmp/foo"],
    ])("%s", async (path, expected) => {
      expect(Npm.prefix(path)).toBe(expected);
    });
  });
});
