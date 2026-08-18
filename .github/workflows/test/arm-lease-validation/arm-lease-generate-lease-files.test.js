import path from "path";
import { describe, expect, it } from "vitest";

import {
  generateLeaseYaml,
  getLeasePath,
  getTodayDate,
  parseInputLine,
  validateDuration,
  validateOrgName,
  validateReviewer,
  validateRpNamespace,
  validateStartDate,
} from "../../cmd/arm-lease-generate-lease-files.js";

describe("generate-lease-files", () => {
  describe("parseInputLine", () => {
    it("parses line without service names", () => {
      const result = parseInputLine("storage, Microsoft.Storage");
      expect(result?.orgName).toBe("storage");
      expect(result?.rpNamespace).toBe("Microsoft.Storage");
      expect(result?.serviceNames).toHaveLength(0);
    });

    it("parses line with service names", () => {
      const result = parseInputLine("compute, Microsoft.Compute, [ComputeRP, DiskRP]");
      expect(result?.orgName).toBe("compute");
      expect(result?.rpNamespace).toBe("Microsoft.Compute");
      expect(result?.serviceNames).toHaveLength(2);
      expect(result?.serviceNames[0]).toBe("ComputeRP");
      expect(result?.serviceNames[1]).toBe("DiskRP");
    });

    it("returns null for empty line", () => {
      expect(parseInputLine("")).toBeNull();
    });

    it("returns null for comment", () => {
      expect(parseInputLine("# This is a comment")).toBeNull();
    });
  });

  describe("generateLeaseYaml", () => {
    it("generates valid YAML content", () => {
      const yaml = generateLeaseYaml("Microsoft.Test", "2026-06-01", "P180D", "@johnDoe");

      expect(yaml).toContain("resource-provider: Microsoft.Test");
      expect(yaml).toContain('startdate: "2026-06-01"');
      expect(yaml).toContain("duration: P180D");
      expect(yaml).toContain('reviewer: "@johnDoe"');
      expect(yaml.endsWith("\n")).toBe(true);
    });

    it("does not use duration-days field", () => {
      const yaml = generateLeaseYaml("Microsoft.Test", "2026-06-01", "P180D", "@johnDoe");
      expect(yaml).not.toContain("duration-days:");
    });
  });

  describe("getLeasePath", () => {
    it("returns correct path without service name", () => {
      const result = getLeasePath("/repo", "storage", "Microsoft.Storage");
      const expected = path.join(
        "/repo",
        ".github",
        "arm-leases",
        "storage",
        "Microsoft.Storage",
        "lease.yaml",
      );
      expect(result).toBe(expected);
    });

    it("returns correct path with service name", () => {
      const result = getLeasePath("/repo", "compute", "Microsoft.Compute", "DiskRP");
      const expected = path.join(
        "/repo",
        ".github",
        "arm-leases",
        "compute",
        "Microsoft.Compute",
        "DiskRP",
        "lease.yaml",
      );
      expect(result).toBe(expected);
    });
  });

  describe("validateStartDate", () => {
    it("accepts today's date", () => {
      const today = getTodayDate();
      expect(() => validateStartDate(today)).not.toThrow();
    });

    it("accepts future date", () => {
      expect(() => validateStartDate("2027-12-31")).not.toThrow();
    });

    it("accepts date within 10-day grace period", () => {
      const fiveDaysAgo = new Date();
      fiveDaysAgo.setDate(fiveDaysAgo.getDate() - 5);
      const fiveDaysAgoStr = fiveDaysAgo.toISOString().split("T")[0];
      expect(() => validateStartDate(fiveDaysAgoStr)).not.toThrow();
    });

    it("rejects invalid date format", () => {
      expect(() => validateStartDate("12/31/2026")).toThrow(/Invalid date format/);
    });

    it("rejects date too far in the past", () => {
      expect(() => validateStartDate("2020-01-01")).toThrow(/past/);
    });
  });

  describe("validateDuration", () => {
    it("accepts valid durations", () => {
      expect(validateDuration("P180D")).toBe("P180D");
      expect(validateDuration("P90D")).toBe("P90D");
      expect(validateDuration("P1D")).toBe("P1D");
    });

    it("converts lowercase to uppercase", () => {
      expect(validateDuration("p30d")).toBe("P30D");
    });

    it("rejects invalid format", () => {
      expect(() => validateDuration("180 days")).toThrow(/Invalid duration format/);
    });

    it("rejects duration over 180 days", () => {
      expect(() => validateDuration("P200D")).toThrow(/between 1 and 180/);
    });

    it("rejects zero duration", () => {
      expect(() => validateDuration("P0D")).toThrow(/between 1 and 180/);
    });
  });

  describe("validateRpNamespace", () => {
    it("accepts valid RP namespaces", () => {
      expect(() => validateRpNamespace("Microsoft.Test")).not.toThrow();
      expect(() => validateRpNamespace("Azure.Widget")).not.toThrow();
      expect(() => validateRpNamespace("Contoso.Manager")).not.toThrow();
    });

    it("rejects lowercase start", () => {
      expect(() => validateRpNamespace("microsoft.Test")).toThrow(/capital letter/);
    });
  });

  describe("validateOrgName", () => {
    it("accepts valid org names", () => {
      expect(() => validateOrgName("storage")).not.toThrow();
      expect(() => validateOrgName("compute")).not.toThrow();
      expect(() => validateOrgName("test123")).not.toThrow();
      expect(() => validateOrgName("datalake-analytics")).not.toThrow();
    });

    it("normalizes uppercase to lowercase", () => {
      expect(validateOrgName("EnterpriseKnowledgeGraph")).toBe("enterpriseknowledgegraph");
      expect(validateOrgName("Storage")).toBe("storage");
    });

    it("rejects empty org name", () => {
      expect(() => validateOrgName("")).toThrow();
    });
  });

  describe("validateReviewer", () => {
    it("accepts valid reviewer format", () => {
      expect(() => validateReviewer("@johnDoe")).not.toThrow();
      expect(() => validateReviewer("@jane-smith")).not.toThrow();
    });

    it("rejects reviewer without @", () => {
      expect(() => validateReviewer("johnDoe")).toThrow(/@/);
    });

    it("rejects empty reviewer", () => {
      expect(() => validateReviewer("")).toThrow();
    });
  });
});
