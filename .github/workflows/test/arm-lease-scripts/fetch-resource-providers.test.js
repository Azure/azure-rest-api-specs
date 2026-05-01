import { createRequire } from "module";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { describe, expect, it } from "vitest";

const require = createRequire(import.meta.url);
const { findRepoRoot, findResourceProviders, formatOutput } = require(
  "../../../arm-leases/scripts/fetch-resource-providers.cjs",
);

// Get the directory of the current test file to find repo root reliably
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

describe("fetch-resource-providers", () => {
  describe("findRepoRoot", () => {
    it("finds the repository root", () => {
      const repoRoot = findRepoRoot(__dirname);
      expect(repoRoot.endsWith("azure-rest-api-specs")).toBe(true);
      expect(fs.existsSync(path.join(repoRoot, "specification"))).toBe(true);
    });
  });

  describe("findResourceProviders (without service names)", () => {
    it("finds resource providers without service names", () => {
      const repoRoot = findRepoRoot(__dirname);
      const rps = findResourceProviders(repoRoot, false);

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

      expect(rps.length).toBeGreaterThan(0);
      expect(rps.every((rp) => rp.rpNamespace && rp.orgName && rp.path && rp.serviceNames)).toBe(
        true,
      );
      expect(rps.every((rp) => Array.isArray(rp.serviceNames))).toBe(true);

      const compute = rps.find((rp) => rp.rpNamespace === "Microsoft.Compute");
      expect(compute).toBeDefined();
      expect(compute.orgName).toBe("compute");
      expect(compute.serviceNames.includes("Compute")).toBe(true);
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
      const parsed = JSON.parse(output);
      expect(Array.isArray(parsed)).toBe(true);
      expect(parsed[0].rpNamespace).toBe("Microsoft.Test");
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
