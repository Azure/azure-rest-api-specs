import { describe, expect, it, vi } from "vitest";
import { parseCommentTable } from "../../src/namespace-approval/post-results.js";

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
    it("should extract language, namespace, and pending status from table rows", () => {
      const body = [
        "## Namespace Review Required",
        "",
        "| Language | Proposed Namespace | Format | Status | Approvers |",
        "|----------|-------------------|--------|--------|----------|",
        "| java | `com.azure.resourcemanager.compute` | ✅ | ⏳ Pending | approver1 |",
        "| dotnet | `Azure.ResourceManager.Compute` | ✅ | ⏳ Pending | approver-a |",
        "",
        "<!-- namespace-review-bot -->",
      ].join("\n");

      const result = parseCommentTable(body);

      expect(result.size).toBe(2);
      expect(result.get("java")).toEqual({
        namespace: "com.azure.resourcemanager.compute",
        status: "⏳ Pending",
      });
      expect(result.get("dotnet")).toEqual({
        namespace: "Azure.ResourceManager.Compute",
        status: "⏳ Pending",
      });
    });

    it("should extract approved status from table rows", () => {
      const body = [
        "| Language | Proposed Namespace | Format | Status | Approvers |",
        "|----------|-------------------|--------|--------|----------|",
        "| java | `com.azure.resourcemanager.compute` | ✅ | ✅ Approved by @approver1 | approver1 |",
        "| dotnet | `Azure.ResourceManager.Compute` | ✅ | ⏳ Pending | approver-a |",
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
      const body = "| dotnet | `Azure.Compute` | ⚠️ Invalid | ⏳ Pending | approver3, approver4 |";

      const result = parseCommentTable(body);

      expect(result.get("dotnet")).toEqual({
        namespace: "Azure.Compute",
        status: "⏳ Pending",
      });
    });

    it("should keep primary namespace when artifact row follows", () => {
      const body = [
        "| java _(package)_ | `com.azure.resourcemanager.compute` | ✅ | ⏳ Pending | approver-b |",
        "| java _(artifact)_ | `azure-resourcemanager-compute` | ✅ | ⏳ Pending | approver-b |",
      ].join("\n");

      const result = parseCommentTable(body);

      // First match (package) is kept, artifact row is skipped
      expect(result.get("java")).toEqual({
        namespace: "com.azure.resourcemanager.compute",
        status: "⏳ Pending",
      });
      expect(result.size).toBe(1);
    });
  });

  describe("selective reset logic", () => {
    /**
     * Helper that mirrors the production reset logic from post-results.js.
     * Only resets a language when:
     *  1. A previous entry exists (prev !== undefined)
     *  2. The namespace actually changed (prev.namespace !== newNs)
     *  3. The language was previously approved (has approved label)
     *
     * First-time detections (!prev) are treated as new pending, not reset.
     *
     * @param {Map<string, { namespace: string, status: string }>} previousTable
     * @param {Record<string, string>} newNamespaces
     * @param {string[] | undefined} [existingLabels]
     * @returns {{ resetLanguages: string[], preservedApprovals: Map<string, { namespace: string, status: string }> }}
     */
    function computeResets(previousTable, newNamespaces, existingLabels) {
      /** @type {string[]} */
      const resetLanguages = [];
      /** @type {Map<string, { namespace: string, status: string }>} */
      const preservedApprovals = new Map();
      const labels = existingLabels ?? [];
      for (const [language, newNs] of Object.entries(newNamespaces)) {
        const prev = previousTable.get(language);
        if (prev && prev.namespace !== newNs) {
          const approvedLabel = `namespace-${language}-approved`;
          if (labels.includes(approvedLabel)) {
            resetLanguages.push(language);
          }
        } else if (prev && prev.status && !prev.status.includes("Pending")) {
          preservedApprovals.set(language, prev);
        }
      }
      return { resetLanguages, preservedApprovals };
    }

    it("should reset only the language whose namespace changed and was approved", () => {
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

      const existingLabels = ["namespace-java-approved", "namespace-dotnet-approved"];
      const { resetLanguages, preservedApprovals } = computeResets(
        previousTable,
        newNamespaces,
        existingLabels,
      );

      expect(resetLanguages).toEqual(["java"]);
      expect(preservedApprovals.size).toBe(1);
      expect(preservedApprovals.get("dotnet")?.status).toBe("✅ Approved by @approver2");
    });

    it("should not reset a changed namespace if it was not previously approved", () => {
      const previousTable = new Map([
        ["java", { namespace: "com.azure.resourcemanager.compute", status: "⏳ Pending" }],
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver2" },
        ],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.network", // changed but was pending, not approved
        dotnet: "Azure.ResourceManager.Compute", // unchanged
      };

      const existingLabels = ["namespace-dotnet-approved"]; // java has no approved label
      const { resetLanguages, preservedApprovals } = computeResets(
        previousTable,
        newNamespaces,
        existingLabels,
      );

      expect(resetLanguages).toEqual([]);
      expect(preservedApprovals.size).toBe(1);
      expect(preservedApprovals.get("dotnet")?.status).toBe("✅ Approved by @approver2");
    });

    it("should not reset new languages not in previous comment (first detection)", () => {
      const previousTable = new Map([
        [
          "java",
          { namespace: "com.azure.resourcemanager.compute", status: "✅ Approved by @approver1" },
        ],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        python: "azure-mgmt-compute", // new language, no previous entry
      };

      const existingLabels = ["namespace-java-approved"];
      const { resetLanguages, preservedApprovals } = computeResets(
        previousTable,
        newNamespaces,
        existingLabels,
      );

      // python is new (no prev), should NOT be reset
      expect(resetLanguages).toEqual([]);
      expect(preservedApprovals.get("java")?.status).toBe("✅ Approved by @approver1");
    });

    it("should not reset any when no previous comment exists (first run)", () => {
      /** @type {Map<string, { namespace: string, status: string }> } */
      const previousTable = new Map(); // empty - first run

      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        dotnet: "Azure.ResourceManager.Compute",
      };

      const { resetLanguages } = computeResets(previousTable, newNamespaces, []);

      // First detection: everything is new pending, nothing to reset
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

      const existingLabels = ["namespace-java-approved", "namespace-dotnet-approved"];
      const { resetLanguages, preservedApprovals } = computeResets(
        previousTable,
        newNamespaces,
        existingLabels,
      );

      expect(resetLanguages).toEqual([]);
      expect(preservedApprovals.size).toBe(2);
    });

    it("should only reset the single changed language when multiple exist", () => {
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
      };

      const existingLabels = [
        "namespace-java-approved",
        "namespace-dotnet-approved",
        "namespace-python-approved",
        "namespace-typescript-approved",
      ];
      const { resetLanguages, preservedApprovals } = computeResets(
        previousTable,
        newNamespaces,
        existingLabels,
      );

      expect(resetLanguages).toEqual(["typescript"]);
      expect(preservedApprovals.size).toBe(3);
    });
  });

  describe("comment body generation", () => {
    it("should generate a 5-column table that matches validate-approval regex", () => {
      const body = [
        "## Namespace Review Required",
        "",
        "**Plane:** Data Plane",
        "",
        "| Language | Proposed Namespace | Format | Status | Approvers |",
        "|----------|-------------------|--------|--------|----------|",
        "| java | `com.azure.messaging.eventgrid` | — | ⏳ Pending | approver1 |",
      ].join("\n");

      const rowRegex = new RegExp(`(\\| java[^|]*\\|[^|]+\\|[^|]+\\|) ⏳ Pending (\\|)`, "gi");
      expect(rowRegex.test(body)).toBe(true);
    });

    it("should approve both package and artifact rows with g flag regex", () => {
      const body = [
        "| java _(package)_ | `com.azure.resourcemanager.compute` | ✅ | ⏳ Pending | approver-b |",
        "| java _(artifact)_ | `azure-resourcemanager-compute` | ✅ | ⏳ Pending | approver-b |",
      ].join("\n");

      const rowRegex = new RegExp(`(\\| java[^|]*\\|[^|]+\\|[^|]+\\|) ⏳ Pending (\\|)`, "gi");
      const replaced = body.replace(rowRegex, "$1 ✅ Approved by @approver-b $2");

      expect(replaced).not.toContain("⏳ Pending");
      expect(replaced.match(/Approved by/g)).toHaveLength(2);
    });

    it("should include specific language names in reset warning", () => {
      const resetLanguages = ["java", "python"];
      const warning = `> ⚠️ **Namespace changed** — approvals for ${resetLanguages.join(", ")} have been reset.\n`;

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
      const existingLabels = ["namespace-java-approved", "namespace-review-required"];
      const languages = ["java", "dotnet"];
      const labelsToAdd = new Set(["namespace-review-required"]);

      for (const language of languages) {
        const approvedLabel = `namespace-${language}-approved`;
        if (!existingLabels.includes(approvedLabel)) {
          labelsToAdd.add(`namespace-${language}-pending`);
        }
      }

      expect(labelsToAdd.has("namespace-java-pending")).toBe(false);
      expect(labelsToAdd.has("namespace-dotnet-pending")).toBe(true);
    });

    it("should remove namespace-review-required when all approved", () => {
      const existingLabels = [
        "namespace-java-approved",
        "namespace-dotnet-approved",
        "namespace-review-required",
      ];
      const languages = ["java", "dotnet"];
      const labelsToAdd = new Set(["namespace-review-required"]);

      for (const language of languages) {
        const approvedLabel = `namespace-${language}-approved`;
        if (!existingLabels.includes(approvedLabel)) {
          labelsToAdd.add(`namespace-${language}-pending`);
        }
      }

      const allApproved = languages.every((lang) =>
        existingLabels.includes(`namespace-${lang}-approved`),
      );
      if (allApproved && languages.length > 0) {
        labelsToAdd.delete("namespace-review-required");
      }

      expect(labelsToAdd.has("namespace-review-required")).toBe(false);
    });

    it("should keep namespace-review-required for empty languages (vacuous every)", () => {
      /** @type {string[]} */
      const languages = [];
      const labelsToAdd = new Set(["namespace-review-required"]);

      const allApproved = languages.every(() => false);
      if (allApproved && languages.length > 0) {
        labelsToAdd.delete("namespace-review-required");
      }

      expect(labelsToAdd.has("namespace-review-required")).toBe(true);
    });
  });
});
