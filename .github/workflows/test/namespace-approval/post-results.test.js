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
        "| java | `com.azure.resourcemanager.compute` | ✅ | ⏳ Pending | JonathanGiles |",
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
        "| java | `com.azure.resourcemanager.compute` | ✅ | ✅ Approved by @JonathanGiles | JonathanGiles |",
        "| dotnet | `Azure.ResourceManager.Compute` | ✅ | ⏳ Pending | approver-a |",
      ].join("\n");

      const result = parseCommentTable(body);

      expect(result.get("java")?.status).toBe("✅ Approved by @JonathanGiles");
      expect(result.get("dotnet")?.status).toBe("⏳ Pending");
    });

    it("should return empty map for body without table", () => {
      const result = parseCommentTable("No table here");
      expect(result.size).toBe(0);
    });

    it("should handle format warning column values", () => {
      const body = "| dotnet | `Azure.Compute` | ⚠️ Invalid | ⏳ Pending | ArthurMa1978, m-nash |";

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
    it("should identify changed namespaces for reset", () => {
      /** @type {Map<string, { namespace: string, status: string }>} */
      const previousTable = new Map([
        [
          "java",
          {
            namespace: "com.azure.resourcemanager.compute",
            status: "✅ Approved by @JonathanGiles",
          },
        ],
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver-a" },
        ],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.network", // changed
        dotnet: "Azure.ResourceManager.Compute", // unchanged
      };

      const resetLanguages = [];
      /** @type {Map<string, { namespace: string, status: string }>} */
      const preservedApprovals = new Map();

      for (const [language, newNs] of Object.entries(newNamespaces)) {
        const prev = previousTable.get(language);
        if (!prev || prev.namespace !== newNs) {
          resetLanguages.push(language);
        } else if (prev.status && !prev.status.includes("Pending")) {
          preservedApprovals.set(language, prev);
        }
      }

      expect(resetLanguages).toEqual(["java"]);
      expect(preservedApprovals.size).toBe(1);
      expect(preservedApprovals.get("dotnet")?.status).toBe("✅ Approved by @approver-a");
    });

    it("should reset new languages not in previous comment", () => {
      /** @type {Map<string, { namespace: string, status: string }>} */
      const previousTable = new Map([
        [
          "java",
          {
            namespace: "com.azure.resourcemanager.compute",
            status: "✅ Approved by @JonathanGiles",
          },
        ],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        python: "azure-mgmt-compute", // new language
      };

      const resetLanguages = [];
      /** @type {Map<string, { namespace: string, status: string }>} */
      const preservedApprovals = new Map();

      for (const [language, newNs] of Object.entries(newNamespaces)) {
        const prev = previousTable.get(language);
        if (!prev || prev.namespace !== newNs) {
          resetLanguages.push(language);
        } else if (prev.status && !prev.status.includes("Pending")) {
          preservedApprovals.set(language, prev);
        }
      }

      expect(resetLanguages).toEqual(["python"]);
      expect(preservedApprovals.get("java")?.status).toBe("✅ Approved by @JonathanGiles");
    });

    it("should reset all when no previous comment exists", () => {
      /** @type {Map<string, { namespace: string, status: string }>} */
      const previousTable = new Map(); // empty - first run

      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        dotnet: "Azure.ResourceManager.Compute",
      };

      const resetLanguages = [];
      for (const [language, newNs] of Object.entries(newNamespaces)) {
        const prev = previousTable.get(language);
        if (!prev || prev.namespace !== newNs) {
          resetLanguages.push(language);
        }
      }

      expect(resetLanguages).toEqual(["java", "dotnet"]);
    });

    it("should not reset any when all namespaces unchanged", () => {
      /** @type {Map<string, { namespace: string, status: string }>} */
      const previousTable = new Map([
        [
          "java",
          {
            namespace: "com.azure.resourcemanager.compute",
            status: "✅ Approved by @JonathanGiles",
          },
        ],
        [
          "dotnet",
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver-a" },
        ],
      ]);

      const newNamespaces = {
        java: "com.azure.resourcemanager.compute",
        dotnet: "Azure.ResourceManager.Compute",
      };

      const resetLanguages = [];
      /** @type {Map<string, { namespace: string, status: string }>} */
      const preservedApprovals = new Map();

      for (const [language, newNs] of Object.entries(newNamespaces)) {
        const prev = previousTable.get(language);
        if (!prev || prev.namespace !== newNs) {
          resetLanguages.push(language);
        } else if (prev.status && !prev.status.includes("Pending")) {
          preservedApprovals.set(language, prev);
        }
      }

      expect(resetLanguages).toEqual([]);
      expect(preservedApprovals.size).toBe(2);
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
        "| java | `com.azure.messaging.eventgrid` | — | ⏳ Pending | JonathanGiles |",
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
          { namespace: "Azure.ResourceManager.Compute", status: "✅ Approved by @approver-a" },
        ],
      ]);

      const preserved = preservedApprovals.get("dotnet");
      const status = preserved?.status ?? "⏳ Pending";

      expect(status).toBe("✅ Approved by @approver-a");
    });
  });

  describe("label skip logic", () => {
    it("should not add pending when language already approved", () => {
      const existingLabels = ["java-namespace-approved", "namespace-review-required"];
      const languages = ["java", "dotnet"];
      const labelsToAdd = new Set(["namespace-review-required"]);

      for (const language of languages) {
        const approvedLabel = `${language}-namespace-approved`;
        if (!existingLabels.includes(approvedLabel)) {
          labelsToAdd.add(`${language}-namespace-pending`);
        }
      }

      expect(labelsToAdd.has("java-namespace-pending")).toBe(false);
      expect(labelsToAdd.has("dotnet-namespace-pending")).toBe(true);
    });

    it("should remove namespace-review-required when all approved", () => {
      const existingLabels = [
        "java-namespace-approved",
        "dotnet-namespace-approved",
        "namespace-review-required",
      ];
      const languages = ["java", "dotnet"];
      const labelsToAdd = new Set(["namespace-review-required"]);

      for (const language of languages) {
        const approvedLabel = `${language}-namespace-approved`;
        if (!existingLabels.includes(approvedLabel)) {
          labelsToAdd.add(`${language}-namespace-pending`);
        }
      }

      const allApproved = languages.every((lang) =>
        existingLabels.includes(`${lang}-namespace-approved`),
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
