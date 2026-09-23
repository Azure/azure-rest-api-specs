import fs from "fs";
import { tmpdir } from "os";
import path from "path";
import { fileURLToPath } from "url";
import { afterEach, beforeEach, describe, expect, it } from "vitest";

import {
  findRepoRoot,
  findResourceProviders,
  formatOutput,
} from "../../cmd/arm-lease-fetch-resource-providers.ts";

// Get the directory of the current test file to find repo root reliably
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

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

  describe("findResourceProviders", () => {
    let repoRoot: string;

    beforeEach(() => {
      repoRoot = fs.mkdtempSync(path.join(tmpdir(), "arm-resource-providers-"));
    });

    afterEach(() => {
      fs.rmSync(repoRoot, { recursive: true, force: true });
    });

    it.each([false, true])(
      "returns no providers without specification (withServiceNames=%s)",
      (withServiceNames) => {
        expect(findResourceProviders(repoRoot, withServiceNames)).toEqual([]);
      },
    );

    it.each([false, true])(
      "returns no providers with only common-types (withServiceNames=%s)",
      (withServiceNames) => {
        fs.mkdirSync(path.join(repoRoot, "specification/common-types"), { recursive: true });
        expect(findResourceProviders(repoRoot, withServiceNames)).toEqual([]);
      },
    );

    describe("with resource provider fixtures", () => {
      beforeEach(() => {
        for (const directory of [
          "storage/resource-manager/Microsoft.Storage/stable",
          "storage/resource-manager/Microsoft.Storage/preview",
          "storage/resource-manager/Microsoft.Storage/examples",
          "storage/resource-manager/Microsoft.Storage/common-types",
          "compute/resource-manager/Microsoft.Compute/Disks",
          "compute/resource-manager/Microsoft.Compute/Compute",
          "compute/resource-manager/Microsoft.Compute/examples",
          "empty/resource-manager/Microsoft.Empty",
          "private/resource-manager/Private.Provider/stable",
          "common-types",
        ]) {
          fs.mkdirSync(path.join(repoRoot, "specification", directory), { recursive: true });
        }
      });

      it("finds only resource providers without service names", () => {
        expect(findResourceProviders(repoRoot, false)).toEqual([
          {
            rpNamespace: "Microsoft.Storage",
            orgName: "storage",
            path: path.join("specification", "storage", "resource-manager", "Microsoft.Storage"),
          },
        ]);
      });

      it("finds only resource providers with sorted service names", () => {
        expect(findResourceProviders(repoRoot, true)).toEqual([
          {
            rpNamespace: "Microsoft.Compute",
            orgName: "compute",
            path: path.join("specification", "compute", "resource-manager", "Microsoft.Compute"),
            serviceNames: ["Compute", "Disks"],
          },
        ]);
      });
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
