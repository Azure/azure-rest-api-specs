import fs from "node:fs";
import { tmpdir } from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";
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
      repoRoot = fs.mkdtempSync(path.join(tmpdir(), "lease-provider-discovery-"));
      for (const directory of [
        "flat/resource-manager/Microsoft.Flat/stable",
        "flat/resource-manager/Microsoft.Flat/preview",
        "flat/resource-manager/Microsoft.Flat/common-types",
        "flat/resource-manager/Microsoft.Flat/examples",
        "grouped/resource-manager/Microsoft.Grouped/Zulu/stable",
        "grouped/resource-manager/Microsoft.Grouped/Alpha/preview",
        "grouped/resource-manager/Microsoft.Grouped/common-types",
        "grouped/resource-manager/Microsoft.Grouped/examples",
        "grouped/resource-manager/Microsoft.Grouped/stable",
        "grouped/resource-manager/Microsoft.Grouped/preview",
        "ignored/resource-manager/Other.Ignored/stable",
        "ignored/data-plane/Microsoft.Ignored/stable",
        "ignored/resource-manager/Microsoft.Empty",
      ]) {
        fs.mkdirSync(path.join(repoRoot, "specification", directory), { recursive: true });
      }
    });

    afterEach(() => {
      fs.rmSync(repoRoot, { recursive: true, force: true, maxRetries: 5, retryDelay: 100 });
    });

    it("finds resource providers with versions directly under the namespace", () => {
      expect(findResourceProviders(repoRoot, false)).toEqual([
        {
          rpNamespace: "Microsoft.Flat",
          orgName: "flat",
          path: path.join("specification", "flat", "resource-manager", "Microsoft.Flat"),
        },
      ]);
    });

    it("finds sorted service groups without treating version and support folders as groups", () => {
      expect(findResourceProviders(repoRoot, true)).toEqual([
        {
          rpNamespace: "Microsoft.Grouped",
          orgName: "grouped",
          path: path.join("specification", "grouped", "resource-manager", "Microsoft.Grouped"),
          serviceNames: ["Alpha", "Zulu"],
        },
      ]);
    });

    it.each([false, true])(
      "returns no providers without specification/ (service names: %s)",
      (withServiceNames) => {
        fs.rmSync(path.join(repoRoot, "specification"), { recursive: true });

        expect(findResourceProviders(repoRoot, withServiceNames)).toEqual([]);
      },
    );
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
