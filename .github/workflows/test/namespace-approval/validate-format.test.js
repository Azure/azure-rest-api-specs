import { describe, expect, it } from "vitest";
import {
  validateAllNamespaces,
  validateNamespaceFormat,
} from "../../src/namespace-approval/validate-format.js";

/** @type {import("../../src/namespace-approval/validate-format.js").FormatRulesConfig} */
const rules = {
  dotnet: {
    pattern: "^Azure\\.ResourceManager\\.(?:[A-Z][a-zA-Z0-9]*)(?:\\.[A-Z][a-zA-Z0-9]*)?$",
    description: "Azure.ResourceManager.{Name} (PascalCase)",
  },
  java: [
    {
      pattern: "^azure-resourcemanager-[a-z0-9]+(?:-[a-z0-9]+)?$",
      description: "Maven artifact (lowercase)",
    },
    {
      pattern: "^com\\.azure\\.resourcemanager\\.[a-z0-9]+(?:\\.[a-z0-9]+)?$",
      description: "Java package (lowercase)",
    },
  ],
  go: {
    pattern: "^sdk/resourcemanager/(?:[a-z0-9]+)/(?:arm[a-z0-9]+)$",
    description: "sdk/resourcemanager/{name}/arm{name}",
  },
  typescript: {
    pattern: "^@azure/arm-[a-z0-9]+$",
    description: "@azure/arm-{name}",
  },
  python: {
    pattern: "^azure\\.mgmt\\.[a-z0-9]+$",
    description: "azure.mgmt.{name}",
  },
};

describe("validate-format", () => {
  describe("dotnet", () => {
    it("should accept valid 3-level PascalCase namespace", () => {
      const result = validateNamespaceFormat("dotnet", "Azure.ResourceManager.Compute", rules);
      expect(result.valid).toBe(true);
    });

    it("should accept valid 4-level PascalCase namespace", () => {
      const result = validateNamespaceFormat(
        "dotnet",
        "Azure.ResourceManager.Monitor.Workspaces",
        rules,
      );
      expect(result.valid).toBe(true);
    });

    it("should reject lowercase namespace", () => {
      const result = validateNamespaceFormat("dotnet", "Azure.ResourceManager.compute", rules);
      expect(result.valid).toBe(false);
      expect(result.error).toContain("does not match");
    });

    it("should reject missing ResourceManager prefix", () => {
      const result = validateNamespaceFormat("dotnet", "Azure.Compute", rules);
      expect(result.valid).toBe(false);
    });
  });

  describe("java", () => {
    it("should accept valid Maven artifact name", () => {
      const result = validateNamespaceFormat("java", "azure-resourcemanager-compute", rules);
      expect(result.valid).toBe(true);
    });

    it("should accept valid Java package name", () => {
      const result = validateNamespaceFormat("java", "com.azure.resourcemanager.compute", rules);
      expect(result.valid).toBe(true);
    });

    it("should accept 4-level Maven artifact", () => {
      const result = validateNamespaceFormat(
        "java",
        "azure-resourcemanager-monitor-workspaces",
        rules,
      );
      expect(result.valid).toBe(true);
    });

    it("should reject PascalCase Java name", () => {
      const result = validateNamespaceFormat("java", "azure-resourcemanager-Compute", rules);
      expect(result.valid).toBe(false);
    });
  });

  describe("go", () => {
    it("should accept valid 3-level Go module path", () => {
      const result = validateNamespaceFormat("go", "sdk/resourcemanager/compute/armcompute", rules);
      expect(result.valid).toBe(true);
    });

    it("should reject missing arm prefix", () => {
      const result = validateNamespaceFormat("go", "sdk/resourcemanager/compute/compute", rules);
      expect(result.valid).toBe(false);
    });

    it("should reject PascalCase", () => {
      const result = validateNamespaceFormat("go", "sdk/resourcemanager/Compute/armCompute", rules);
      expect(result.valid).toBe(false);
    });
  });

  describe("typescript", () => {
    it("should accept valid JS/TS package name", () => {
      const result = validateNamespaceFormat("typescript", "@azure/arm-compute", rules);
      expect(result.valid).toBe(true);
    });

    it("should reject non-arm scoped package", () => {
      const result = validateNamespaceFormat("typescript", "@azure/compute", rules);
      expect(result.valid).toBe(false);
    });

    it("should reject PascalCase", () => {
      const result = validateNamespaceFormat("typescript", "@azure/arm-Compute", rules);
      expect(result.valid).toBe(false);
    });
  });

  describe("python", () => {
    it("should accept valid Python namespace", () => {
      const result = validateNamespaceFormat("python", "azure.mgmt.compute", rules);
      expect(result.valid).toBe(true);
    });

    it("should reject non-mgmt prefix", () => {
      const result = validateNamespaceFormat("python", "azure.compute", rules);
      expect(result.valid).toBe(false);
    });

    it("should reject dash-separated package name format", () => {
      const result = validateNamespaceFormat("python", "azure-mgmt-compute", rules);
      expect(result.valid).toBe(false);
    });
  });

  describe("unknown language", () => {
    it("should pass when no rules exist for language", () => {
      const result = validateNamespaceFormat("swift", "SomeNamespace", rules);
      expect(result.valid).toBe(true);
      expect(result.matchedRule).toBe("no rules defined");
    });
  });

  describe("validateAllNamespaces", () => {
    it("should validate all namespaces and return mixed results", () => {
      const namespaces = {
        dotnet: "Azure.ResourceManager.Compute",
        java: "INVALID-NAME",
        python: "azure.mgmt.network",
      };

      const results = validateAllNamespaces(namespaces, rules);

      expect(results).toHaveLength(3);
      expect(results.find((r) => r.language === "dotnet")?.valid).toBe(true);
      expect(results.find((r) => r.language === "java")?.valid).toBe(false);
      expect(results.find((r) => r.language === "python")?.valid).toBe(true);
    });
  });
});
