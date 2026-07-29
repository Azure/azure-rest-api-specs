import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";

import {
  findRepoRoot,
  findResourceProviders,
  formatOutput,
} from "../../cmd/arm-lease-fetch-resource-providers.js";

// Get the directory of the current test file to find repo root reliably
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Check if specification directory exists (may not exist in sparse checkouts)
const hasSpecificationDir = () => {
  try {
    const repoRoot = findRepoRoot(__dirname);
    return fs.existsSync(path.join(repoRoot, "specification"));
  } catch {
    return false;
  }
};

describe("fetch-resource-providers", () => {
  describe("findRepoRoot", () => {
    it("finds the repository root", () => {
      const repoRoot = findRepoRoot(__dirname);
      expect(repoRoot.includes("azure-rest-api-specs")).toBe(true);
      // In sparse checkouts, .github exists but specification may not
      expect(
        fs.existsSync(path.join(repoRoot, "specification")) ||
          fs.existsSync(path.join(repoRoot, ".github")),
      ).toBe(true);
    });
  });

  describe("findResourceProviders (without service names)", () => {
    it("finds resource providers without service names", () => {
      const repoRoot = findRepoRoot(__dirname);
      const rps = findResourceProviders(repoRoot, false);

      // In sparse checkouts, specification/ may not exist, so rps could be empty
      if (!hasSpecificationDir()) {
        expect(rps).toEqual([]);
        return;
      }

      expect(rps.length).toBeGreaterThan(0);
      expect(rps.every((rp) => rp.rpNamespace && rp.orgName && rp.path)).toBe(true);
      expect(rps.every((rp) => !rp.serviceNames)).toBe(true);
      expect(rps.some((rp) => rp.rpNamespace === "Microsoft.Storage")).toBe(true);
      expect(rps.some((rp) => rp.rpNamespace === "Microsoft.Compute")).toBe(false);
    });
  });

  describe("findResourceProviders (with service names)", () => {
    it("finds resource providers with service names", () => {
      const repoRoot = findRepoRoot(__dirname);
      const rps = findResourceProviders(repoRoot, true);

      // In sparse checkouts, specification/ may not exist, so rps could be empty
      if (!hasSpecificationDir()) {
        expect(rps).toEqual([]);
        return;
      }

      expect(rps.length).toBeGreaterThan(0);
      expect(rps.every((rp) => rp.rpNamespace && rp.orgName && rp.path && rp.serviceNames)).toBe(
        true,
      );
      expect(rps.every((rp) => Array.isArray(rp.serviceNames))).toBe(true);

      const compute = rps.find((rp) => rp.rpNamespace === "Microsoft.Compute");
      expect(compute).toBeDefined();
      expect(compute?.orgName).toBe("compute");
      expect(compute?.serviceNames?.includes("Compute")).toBe(true);
      expect(rps.some((rp) => rp.rpNamespace === "Microsoft.Storage")).toBe(false);
    });
  });

  describe("formatOutput", () => {
    const rpsWithout = [{ rpNamespace: "Microsoft.Test", orgName: "test", path: "test/path" }];
    const rpsWith = [
      {
        rpNamespace: "Microsoft.Test2",
        orgName: "test2",
        path: "test2/path",
        serviceNames: ["Group1", "Group2"],
      },
    ];

    it("formats list output without service names", () => {
      const output = formatOutput(rpsWithout, "list", false);
      expect(output).toContain("test, Microsoft.Test");
    });

    it("formats list output with service names", () => {
      const output = formatOutput(rpsWith, "list", true);
      expect(output).toContain("test2, Microsoft.Test2, [Group1, Group2]");
    });

    it("formats JSON output", () => {
      const output = formatOutput(rpsWithout, "json", false);
      /* eslint-disable @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access */
      const parsed = JSON.parse(output);
      expect(Array.isArray(parsed)).toBe(true);
      expect(parsed[0].rpNamespace).toBe("Microsoft.Test");
      /* eslint-enable @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access */
    });

    it("formats table output", () => {
      const output = formatOutput(rpsWithout, "table", false);
      expect(output).toContain("orgName");
      expect(output).toContain("rpNamespace");
      expect(output).toContain("test");
      expect(output).toContain("Microsoft.Test");
    });
  });
});
