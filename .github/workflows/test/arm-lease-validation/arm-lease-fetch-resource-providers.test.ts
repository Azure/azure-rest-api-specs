import fs from "node:fs";
import { tmpdir } from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { afterAll, beforeAll, describe, expect, it } from "vitest";

import {
  findRepoRoot,
  findResourceProviders,
  formatOutput,
} from "../../cmd/arm-lease-fetch-resource-providers.ts";

// Get the directory of the current test file to find repo root reliably
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

let fixtureRoot: string;

beforeAll(() => {
  fixtureRoot = fs.mkdtempSync(path.join(tmpdir(), "arm-lease-resource-providers-"));
  for (const folder of [
    "storage/resource-manager/Microsoft.Storage/stable",
    "compute/resource-manager/Microsoft.Compute/Compute/stable",
  ]) {
    fs.mkdirSync(path.join(fixtureRoot, "specification", folder), { recursive: true });
  }
});

afterAll(() => {
  fs.rmSync(fixtureRoot, { recursive: true, force: true });
});

describe("fetch-resource-providers", () => {
  describe("findRepoRoot", () => {
    it("finds the repository root", () => {
      const repoRoot = findRepoRoot(__dirname);
      expect(fs.existsSync(repoRoot)).toBe(true);
      // In sparse checkouts, .github exists but specification may not
      expect(
        fs.existsSync(path.join(repoRoot, "specification")) ||
          fs.existsSync(path.join(repoRoot, ".github")),
      ).toBe(true);
    });
  });

  describe("findResourceProviders (without service names)", () => {
    it("finds resource providers without service names", () => {
      const rps = findResourceProviders(fixtureRoot, false);

      expect(rps.length).toBeGreaterThan(0);
      expect(rps.every((rp) => rp.rpNamespace && rp.orgName && rp.path)).toBe(true);
      expect(rps.every((rp) => !rp.serviceNames)).toBe(true);
      expect(rps.some((rp) => rp.rpNamespace === "Microsoft.Storage")).toBe(true);
      expect(rps.some((rp) => rp.rpNamespace === "Microsoft.Compute")).toBe(false);
    });
  });

  describe("findResourceProviders (with service names)", () => {
    it("finds resource providers with service names", () => {
      const rps = findResourceProviders(fixtureRoot, true);

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

  it("supports a partial checkout without Storage or Compute", () => {
    const partialRoot = path.join(fixtureRoot, "partial-checkout");
    fs.mkdirSync(
      path.join(
        partialRoot,
        "specification/cdn/resource-manager/Microsoft.Cdn/EdgeActions/preview",
      ),
      { recursive: true },
    );
    expect(findResourceProviders(partialRoot, false)).toEqual([]);
    expect(findResourceProviders(partialRoot, true)).toEqual([
      {
        rpNamespace: "Microsoft.Cdn",
        path: path.join("specification", "cdn", "resource-manager", "Microsoft.Cdn"),
        orgName: "cdn",
        serviceNames: ["EdgeActions"],
      },
    ]);
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
      /* oxlint-disable typescript/no-unsafe-assignment, typescript/no-unsafe-member-access */
      const parsed = JSON.parse(output);
      expect(Array.isArray(parsed)).toBe(true);
      expect(parsed[0].rpNamespace).toBe("Microsoft.Test");
      /* oxlint-enable typescript/no-unsafe-assignment, typescript/no-unsafe-member-access */
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
