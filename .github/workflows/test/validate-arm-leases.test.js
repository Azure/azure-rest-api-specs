import { afterEach, describe, expect, it, vi } from "vitest";

// Mock fs/promises before imports
vi.mock("fs/promises", () => ({ access: vi.fn(), readFile: vi.fn() }));

import * as fs from "fs/promises";

const mockAccess = /** @type {import("vitest").Mock} */ (fs.access);
const mockReadFile = /** @type {import("vitest").Mock} */ (fs.readFile);

import {
  isFileAllowed,
  validateFolderStructure,
  validateLeaseContent,
  leaseSchema,
  LEASE_FILE_PATTERN,
  LEASE_FILE_WITH_GROUP_PATTERN,
} from "../src/validate-arm-leases.js";

describe("validate-arm-leases", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  describe("isFileAllowed", () => {
    it("allows valid lease files and README.md", () => {
      expect(isFileAllowed(".github/arm-leases/testservice/Microsoft.Test/lease.yaml")).toBe(true);
      expect(isFileAllowed(".github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml")).toBe(true);
      expect(isFileAllowed(".github/arm-leases/README.md")).toBe(true);
    });

    it("rejects files that do not match allowed patterns", () => {
      expect(isFileAllowed(".github/arm-leases/anything/here")).toBe(false);
      expect(isFileAllowed(".github/arm-leases/testservice/Microsoft.Test/other.yaml")).toBe(false);
      expect(isFileAllowed(".github/arm-leases/badtest/bad.test/noyaml.md")).toBe(false);
      expect(isFileAllowed(".github/arm-leases/testservice/readme.md")).toBe(false);
    });
  });

  describe("validateFolderStructure", () => {
    it("accepts valid lease file paths", () => {
      const validFiles = [
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        ".github/arm-leases/widgetservice/Azure.Widget/lease.yaml",
        ".github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml",
      ];
      expect(validateFolderStructure(validFiles)).toHaveLength(0);
    });

    it("rejects invalid folder structures", () => {
      const invalidFiles = [
        ".github/arm-leases/TestService/Microsoft.Test/lease.yaml",
        ".github/arm-leases/test-service/Microsoft.Test/lease.yaml",
        ".github/arm-leases/testservice/Microsoft.Test/other.yaml",
      ];
      expect(validateFolderStructure(invalidFiles)).toHaveLength(invalidFiles.length);
    });

    it("rejects stable or preview as service group", () => {
      const invalidFiles = [
        ".github/arm-leases/compute/Microsoft.Compute/stable/lease.yaml",
        ".github/arm-leases/compute/Microsoft.Compute/preview/lease.yaml",
        ".github/arm-leases/compute/Microsoft.Compute/stable-2024-01-01/lease.yaml",
        ".github/arm-leases/compute/Microsoft.Compute/preview-internal/lease.yaml",
      ];
      expect(validateFolderStructure(invalidFiles)).toHaveLength(invalidFiles.length);
    });
  });

  describe("LEASE_FILE_PATTERN", () => {
    it("matches valid patterns", () => {
      expect(LEASE_FILE_PATTERN.test(".github/arm-leases/testservice/Microsoft.Test/lease.yaml")).toBe(true);
      expect(LEASE_FILE_PATTERN.test(".github/arm-leases/service123/Contoso.Manager/lease.yaml")).toBe(true);
    });

    it("rejects invalid patterns", () => {
      expect(LEASE_FILE_PATTERN.test(".github/arm-leases/TestService/Microsoft.Test/lease.yaml")).toBe(false);
      expect(LEASE_FILE_PATTERN.test("arm-leases/testservice/Microsoft.Test/lease.yaml")).toBe(false);
    });
  });

  describe("LEASE_FILE_WITH_GROUP_PATTERN", () => {
    it("matches valid service group patterns", () => {
      expect(LEASE_FILE_WITH_GROUP_PATTERN.test(".github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml")).toBe(true);
      expect(LEASE_FILE_WITH_GROUP_PATTERN.test(".github/arm-leases/storage/Azure.Storage/BlobRP/lease.yaml")).toBe(true);
    });

    it("rejects stable/preview as service group", () => {
      expect(LEASE_FILE_WITH_GROUP_PATTERN.test(".github/arm-leases/compute/Microsoft.Compute/stable/lease.yaml")).toBe(false);
      expect(LEASE_FILE_WITH_GROUP_PATTERN.test(".github/arm-leases/compute/Microsoft.Compute/preview/lease.yaml")).toBe(false);
    });
  });

  describe("leaseSchema", () => {
    it("accepts valid lease data", () => {
      const valid = {
        lease: {
          "resource-provider": "Microsoft.Test",
          startdate: "2026-06-01",
          "duration-days": "P90D",
          reviewer: "John Doe",
        },
      };
      expect(leaseSchema.safeParse(valid).success).toBe(true);
    });

    it("rejects resource provider with lowercase parts", () => {
      const invalid = {
        lease: {
          "resource-provider": "microsoft.Test",
          startdate: "2026-06-01",
          "duration-days": "P90D",
          reviewer: "John Doe",
        },
      };
      expect(leaseSchema.safeParse(invalid).success).toBe(false);
    });

    it("rejects invalid startdate format", () => {
      const invalid = {
        lease: {
          "resource-provider": "Microsoft.Test",
          startdate: "01-15-2026",
          "duration-days": "P90D",
          reviewer: "John Doe",
        },
      };
      expect(leaseSchema.safeParse(invalid).success).toBe(false);
    });

    it("rejects invalid duration-days format", () => {
      const invalid = {
        lease: {
          "resource-provider": "Microsoft.Test",
          startdate: "2026-06-01",
          "duration-days": "90 days",
          reviewer: "John Doe",
        },
      };
      expect(leaseSchema.safeParse(invalid).success).toBe(false);
    });

    it("rejects duration exceeding 180 days", () => {
      const invalid = {
        lease: {
          "resource-provider": "Microsoft.Test",
          startdate: "2026-06-01",
          "duration-days": "P200D",
          reviewer: "John Doe",
        },
      };
      expect(leaseSchema.safeParse(invalid).success).toBe(false);
    });

    it("rejects zero duration", () => {
      const invalid = {
        lease: {
          "resource-provider": "Microsoft.Test",
          startdate: "2026-06-01",
          "duration-days": "P0D",
          reviewer: "John Doe",
        },
      };
      expect(leaseSchema.safeParse(invalid).success).toBe(false);
    });

    it("rejects empty reviewer", () => {
      const invalid = {
        lease: {
          "resource-provider": "Microsoft.Test",
          startdate: "2026-06-01",
          "duration-days": "P90D",
          reviewer: "",
        },
      };
      expect(leaseSchema.safeParse(invalid).success).toBe(false);
    });

    it("rejects missing lease key", () => {
      expect(leaseSchema.safeParse({ notlease: {} }).success).toBe(false);
    });
  });

  describe("validateLeaseContent", () => {
    const validYaml = `lease:
  resource-provider: Microsoft.Test
  startdate: "2027-06-01"
  duration-days: P90D
  reviewer: John Doe
`;

    it("validates a complete valid lease file", async () => {
      mockAccess.mockResolvedValue(undefined);
      mockReadFile.mockResolvedValue(validYaml);

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        "2026-01-07",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );

      expect(result.errors).toHaveLength(0);
      expect(mockAccess).toHaveBeenCalledOnce();
      expect(mockReadFile).toHaveBeenCalledOnce();
    });

    it("detects resource provider mismatch", async () => {
      const mismatchYaml = validYaml.replace("Microsoft.Test", "Microsoft.Other");
      mockAccess.mockResolvedValue(undefined);
      mockReadFile.mockResolvedValue(mismatchYaml);

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        "2026-01-07",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );

      expect(result.errors.some((e) => e.includes("mismatch"))).toBe(true);
    });

    it("detects past startdate", async () => {
      const pastYaml = validYaml.replace("2027-06-01", "2025-01-01");
      mockAccess.mockResolvedValue(undefined);
      mockReadFile.mockResolvedValue(pastYaml);

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        "2026-01-07",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );

      expect(result.errors.some((e) => e.includes("past"))).toBe(true);
    });

    it("returns error for non-existent file", async () => {
      mockAccess.mockRejectedValue(new Error("ENOENT"));

      const result = await validateLeaseContent(
        "/nonexistent/lease.yaml",
        "2026-01-07",
        ".github/arm-leases/svc/NS/lease.yaml",
      );

      expect(result.errors.some((e) => e.includes("does not exist"))).toBe(true);
    });

    it("detects invalid YAML content", async () => {
      mockAccess.mockResolvedValue(undefined);
      mockReadFile.mockResolvedValue("invalid yaml content without structure");

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        "2026-01-07",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );

      expect(result.errors.length).toBeGreaterThan(0);
    });

    it("accepts today as startdate", async () => {
      const todayYaml = validYaml.replace("2027-06-01", "2026-01-07");
      mockAccess.mockResolvedValue(undefined);
      mockReadFile.mockResolvedValue(todayYaml);

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        "2026-01-07",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );

      expect(result.errors).toHaveLength(0);
    });
  });
});
