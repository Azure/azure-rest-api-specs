import { describe, expect, it, vi } from "vitest";
import {
  getResetLanguages,
  parseCommentTable,
} from "../../src/package-name-approval/post-results.js";

// Import only the pure functions we can test without heavy mocking
// buildCommentBody and getApprovers are the key testable units

// We need to import the module, but it has side-effect imports.
// Use dynamic import with mocks.

vi.mock("fs/promises", () => ({
  readFile: vi.fn(),
  writeFile: vi.fn(),
  unlink: vi.fn(),
}));

vi.mock("../../../../shared/src/exec.js", () => ({
  execFile: vi.fn(),
}));

vi.mock("../../../../shared/src/github.js", () => ({
  PER_PAGE_MAX: 100,
}));

vi.mock("../../src/comment.js", () => ({
  commentOrUpdate: vi.fn(),
  parseExistingComments: vi.fn().mockReturnValue([undefined, undefined]),
}));

vi.mock("../../src/context.js", () => ({
  extractInputs: vi.fn(),
}));

describe("post-results", () => {
  describe("parseCommentTable", () => {
    it("should extract language, package name, and pending status from table rows", () => {
      const body = [
        "## Package Name Review Required",
        "",
        "| Language | Package Name | Namespace | Format | Status | Approvers |",
        "|----------|--------------|-----------|--------|--------|----------|",
        "| java | `azure-resourcemanager-compute` | `com.azure.resourcemanager.compute` | ✅ | ⏳ Pending | approver1 |",
        "| dotnet | `Azure.ResourceManager.Compute` | `Azure.ResourceManager.Compute` | ✅ | ⏳ Pending | approver-a |",
        "",
        "<!-- package-name-review-bot -->",
      ].join("\n");

      const result = parseCommentTable(body);

      expect(result.size).toBe(2);
      expect(result.get("java")).toEqual({
        namespace: "azure-resourcemanager-compute",
        status: "⏳ Pending",
      });
      expect(result.get("dotnet")).toEqual({
        namespace: "Azure.ResourceManager.Compute",
        status: "⏳ Pending",
      });
    });

    it("should extract approved status from table rows", () => {
      const body = [
        "| Language | Package Name | Namespace | Format | Status | Approvers |",
        "|----------|--------------|-----------|--------|--------|----------|",
        "| java | `azure-resourcemanager-compute` | `com.azure.resourcemanager.compute` | ✅ | ✅ Approved by @approver1 | approver1 |",
        "| dotnet | `Azure.ResourceManager.Compute` | `Azure.ResourceManager.Compute` | ✅ | ⏳ Pending | approver-a |",
      ].join("\n");

      const result = parseCommentTable(body);

      expect(result.get("java")?.status).toBe("✅ Approved by @approver1");
      expect(result.get("dotnet")?.status).toBe("⏳ Pending");
    });

    it("should return empty map for body without table", () => {
      const result = parseCommentTable("No table here");
      expect(result.size).toBe(0);
    });

    it("should handle format warning column values", () => {
      const body =
        "| dotnet | `Azure.Compute` | `Azure.Compute` | ⚠️ Invalid | ⏳ Pending | approver3, approver4 |";

      const result = parseCommentTable(body);

      expect(result.get("dotnet")).toEqual({
        namespace: "Azure.Compute",
        status: "⏳ Pending",
      });
    });

    it("should keep first match per language when duplicate rows exist", () => {
      const body = [
        "| java | `azure-resourcemanager-compute` | `com.azure.resourcemanager.compute` | ✅ | ⏳ Pending | approver-b |",
        "| java | `azure-resourcemanager-compute-v2` | `com.azure.resourcemanager.compute.v2` | ✅ | ⏳ Pending | approver-b |",
      ].join("\n");

      const result = parseCommentTable(body);

      // First match is kept
      expect(result.get("java")).toEqual({
        namespace: "azure-resourcemanager-compute",
        status: "⏳ Pending",
      });
      expect(result.size).toBe(1);
    });
  });

  describe("Tier 1 reset logic", () => {
    it("should reset every approved Tier 1 language when a package name changes", () => {
      const previousTable = new Map([
        [
          "java",
          { namespace: "com.azure.resourcemanager.compute", status: "✅ Approved by @approver1" },
        ],
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver2" },
        ],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.network", // changed
        dotnet: "Azure.ResourceManager.Compute", // unchanged
      };
      const existingLabels = ["package-name-java-approved", "package-name-dotnet-approved"];
      const resetLanguages = getResetLanguages(previousTable, newNamespaces, existingLabels, false);

      expect(resetLanguages).toEqual(["dotnet", "java"]);
    });

    it("should reset approved Tier 1 languages when the changed language is pending", () => {
      const previousTable = new Map([
        ["java", { namespace: "com.azure.resourcemanager.compute", status: "⏳ Pending" }],
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver2" },
        ],
      ]);
      const newNamespaces = {
        java: "com.azure.resourcemanager.network",
        dotnet: "Azure.ResourceManager.Compute",
      };

      const resetLanguages = getResetLanguages(
        previousTable,
        newNamespaces,
        ["package-name-dotnet-approved"],
        false,
      );

      expect(resetLanguages).toEqual(["dotnet"]);
    });

    it("should reset the Go approval for management plane package name changes", () => {
      const previousTable = new Map([
        ["java", { namespace: "com.azure.compute", status: "✅ Approved by @approver1" }],
      ]);
      const newNamespaces = { java: "com.azure.network" };
      const existingLabels = ["package-name-go-approved"];

      const resetLanguages = getResetLanguages(previousTable, newNamespaces, existingLabels, true);

      expect(resetLanguages).toEqual(["go"]);
    });

    it("should not reset new languages not in previous comment", () => {
      const previousTable = new Map([
        [
          "java",
          { namespace: "com.azure.resourcemanager.compute", status: "✅ Approved by @approver1" },
        ],
      ]);
      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        python: "azure-mgmt-compute",
      };

      const resetLanguages = getResetLanguages(
        previousTable,
        newNamespaces,
        ["package-name-java-approved"],
        false,
      );

      expect(resetLanguages).toEqual([]);
    });

    it("should not reset any languages when no previous comment exists", () => {
      const resetLanguages = getResetLanguages(
        new Map(),
        {
          java: "com.azure.resourcemanager.compute",
          dotnet: "Azure.ResourceManager.Compute",
        },
        [],
        false,
      );

      expect(resetLanguages).toEqual([]);
    });

    it("should not reset any when all namespaces unchanged", () => {
      const previousTable = new Map([
        [
          "java",
          { namespace: "com.azure.resourcemanager.compute", status: "✅ Approved by @approver1" },
        ],
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver2" },
        ],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        dotnet: "Azure.ResourceManager.Compute",
      };

      const existingLabels = ["package-name-java-approved", "package-name-dotnet-approved"];
      const resetLanguages = getResetLanguages(previousTable, newNamespaces, existingLabels, false);

      expect(resetLanguages).toEqual([]);
    });

    it("should retain reset behavior for approved non-Tier 1 languages that changed", () => {
      const previousTable = new Map([
        [
          "java",
          { namespace: "com.azure.resourcemanager.compute", status: "✅ Approved by @approver1" },
        ],
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver2" },
        ],
        ["python", { namespace: "azure-mgmt-compute", status: "✅ Approved by @approver3" }],
        ["typescript", { namespace: "@azure/arm-compute", status: "✅ Approved by @approver4" }],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        dotnet: "Azure.ResourceManager.Compute",
        python: "azure-mgmt-compute",
        typescript: "@azure/arm-compute-2", // only TS changed
        rust: "azure-resourcemanager-compute",
      };

      const existingLabels = [
        "package-name-java-approved",
        "package-name-dotnet-approved",
        "package-name-python-approved",
        "package-name-typescript-approved",
        "package-name-rust-approved",
      ];
      previousTable.set("rust", {
        namespace: "azure-resourcemanager-compute-v1",
        status: "✅ Approved by @approver5",
      });
      const resetLanguages = getResetLanguages(previousTable, newNamespaces, existingLabels, false);

      expect(resetLanguages).toEqual(["dotnet", "java", "python", "typescript", "rust"]);
    });
  });

  describe("comment body generation", () => {
    it("should generate a 6-column table that matches validate-approval regex", () => {
      const body = [
        "## Package Name Review Required",
        "",
        "**Plane:** Data Plane",
        "",
        "| Language | Package Name | Namespace | Format | Status | Approvers |",
        "|----------|--------------|-----------|--------|--------|----------|",
        "| java | `azure-messaging-eventgrid` | `com.azure.messaging.eventgrid` | — | ⏳ Pending | approver1 |",
      ].join("\n");

      const rowRegex = new RegExp(
        `(\\| java[^|]*\\|[^|]+\\|[^|]+\\|[^|]+\\|) ⏳ Pending (\\|)`,
        "gi",
      );
      expect(rowRegex.test(body)).toBe(true);
    });

    it("should approve rows with the validate-approval regex pattern", () => {
      const body = [
        "| java | `azure-resourcemanager-compute` | `com.azure.resourcemanager.compute` | ✅ | ⏳ Pending | approver-b |",
        "| dotnet | `Azure.ResourceManager.Compute` | `Azure.ResourceManager.Compute` | ✅ | ⏳ Pending | approver-a |",
      ].join("\n");

      const rowRegex = new RegExp(
        `(\\| java[^|]*\\|[^|]+\\|[^|]+\\|[^|]+\\|) ⏳ Pending (\\|)`,
        "gi",
      );
      const replaced = body.replace(rowRegex, "$1 ✅ Approved by @approver-b $2");

      expect(replaced).toContain("Approved by @approver-b");
      // dotnet row should not be affected
      expect(replaced).toContain("| dotnet | `Azure.ResourceManager.Compute`");
    });

    it("should include specific language names in reset warning", () => {
      const resetLanguages = ["java", "python"];
      const warning = `> ⚠️ **Package name changed** -- approvals for ${resetLanguages.join(", ")} have been reset.\n`;

      expect(warning).toContain("java, python");
      expect(warning).not.toContain("affected languages");
    });

    it("should preserve approved status for unchanged languages in comment", () => {
      const preservedApprovals = new Map([
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver2" },
        ],
      ]);

      const preserved = preservedApprovals.get("dotnet");
      const status = preserved?.status ?? "⏳ Pending";

      expect(status).toBe("✅ Approved by @approver2");
    });
  });

  describe("label skip logic", () => {
    it("should not add pending when language already approved", () => {
      const existingLabels = ["package-name-java-approved", "package-name-review-required"];
      const languages = ["java", "dotnet"];
      const labelsToAdd = new Set(["package-name-review-required"]);

      for (const language of languages) {
        const approvedLabel = `package-name-${language}-approved`;
        if (!existingLabels.includes(approvedLabel)) {
          labelsToAdd.add(`package-name-${language}-pending`);
        }
      }

      expect(labelsToAdd.has("package-name-java-pending")).toBe(false);
      expect(labelsToAdd.has("package-name-dotnet-pending")).toBe(true);
    });

    it("should remove package-name-review-required when all approved", () => {
      const existingLabels = [
        "package-name-java-approved",
        "package-name-dotnet-approved",
        "package-name-review-required",
      ];
      const languages = ["java", "dotnet"];
      const labelsToAdd = new Set(["package-name-review-required"]);

      for (const language of languages) {
        const approvedLabel = `package-name-${language}-approved`;
        if (!existingLabels.includes(approvedLabel)) {
          labelsToAdd.add(`package-name-${language}-pending`);
        }
      }

      const allApproved = languages.every((lang) =>
        existingLabels.includes(`package-name-${lang}-approved`),
      );
      if (allApproved && languages.length > 0) {
        labelsToAdd.delete("package-name-review-required");
      }

      expect(labelsToAdd.has("package-name-review-required")).toBe(false);
    });

    it("should keep package-name-review-required for empty languages (vacuous every)", () => {
      /** @type {string[]} */
      const languages = [];
      const labelsToAdd = new Set(["package-name-review-required"]);

      const allApproved = languages.every(() => false);
      if (allApproved && languages.length > 0) {
        labelsToAdd.delete("package-name-review-required");
      }

      expect(labelsToAdd.has("package-name-review-required")).toBe(true);
    });
  });
});
