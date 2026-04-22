import { afterEach, describe, expect, it, vi } from "vitest";

/** @type {import("vitest").Mock} */
const mockReadFile = vi.hoisted(() => vi.fn());
/** @type {import("vitest").Mock} */
const mockStat = vi.hoisted(() => vi.fn());

vi.mock("fs/promises", () => ({
  readFile: mockReadFile,
  stat: mockStat,
}));

import {
  isFileAllowed,
  leaseSchema,
  validateFolderStructure,
  validateLeaseContent,
} from "../../src/arm-lease-validation/arm-lease-validation.js";

describe("validate-arm-leases", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  describe("isFileAllowed", () => {
    it("allows valid lease files and README.md", () => {
      expect(isFileAllowed(".github/arm-leases/testservice/Microsoft.Test/lease.yaml")).toBe(true);
      expect(isFileAllowed(".github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml")).toBe(
        true,
      );
      expect(isFileAllowed(".github/arm-leases/README.md")).toBe(true);
    });

    it("rejects invalid files", () => {
      expect(isFileAllowed(".github/arm-leases/anything/here")).toBe(false);
      expect(isFileAllowed(".github/arm-leases/testservice/Microsoft.Test/other.yaml")).toBe(false);
      expect(isFileAllowed(".github/arm-leases/badtest/No.Yaml/no.md")).toBe(false);
    });
  });

  describe("validateFolderStructure", () => {
    it("accepts valid paths and rejects invalid ones", () => {
      expect(
        validateFolderStructure([
          ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
          ".github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml",
        ]),
      ).toHaveLength(0);

      expect(
        validateFolderStructure([
          ".github/arm-leases/TestService/Microsoft.Test/lease.yaml", // uppercase org
          ".github/arm-leases/compute/Microsoft.Compute/stable/lease.yaml", // stable not allowed
        ]),
      ).toHaveLength(2);
    });
  });

  describe("leaseSchema", () => {
    const validLease = {
      lease: {
        "resource-provider": "Microsoft.Test",
        startdate: "2026-06-01",
        duration: "P90D",
        reviewer: "@johndoe",
      },
    };

    it("accepts valid lease data", () => {
      expect(leaseSchema.safeParse(validLease).success).toBe(true);
      expect(
        leaseSchema.safeParse({ ...validLease, lease: { ...validLease.lease, duration: "P5M" } })
          .success,
      ).toBe(true);
      expect(
        leaseSchema.safeParse({ ...validLease, lease: { ...validLease.lease, duration: "P180D" } })
          .success,
      ).toBe(true);
    });

    it("rejects invalid resource-provider", () => {
      expect(
        leaseSchema.safeParse({
          lease: { ...validLease.lease, "resource-provider": "microsoft.Test" },
        }).success,
      ).toBe(false);
      expect(
        leaseSchema.safeParse({
          lease: { ...validLease.lease, "resource-provider": "microsoft.Test" },
        }).success,
      ).toBe(false);
    });

    it("rejects invalid startdate", () => {
      expect(
        leaseSchema.safeParse({ lease: { ...validLease.lease, startdate: "01-15-2026" } }).success,
      ).toBe(false);
      expect(
        leaseSchema.safeParse({ lease: { ...validLease.lease, startdate: "2026-99-99" } }).success,
      ).toBe(false);
    });

    it("rejects invalid duration", () => {
      expect(
        leaseSchema.safeParse({ lease: { ...validLease.lease, duration: "90 days" } }).success,
      ).toBe(false);
      expect(
        leaseSchema.safeParse({ lease: { ...validLease.lease, duration: "P1Y" } }).success,
      ).toBe(false); // exceeds 180 days
    });

    it("rejects invalid reviewer", () => {
      expect(leaseSchema.safeParse({ lease: { ...validLease.lease, reviewer: "" } }).success).toBe(
        false,
      );
      expect(
        leaseSchema.safeParse({ lease: { ...validLease.lease, reviewer: "johndoe" } }).success,
      ).toBe(false); // no @
    });

    it("rejects missing lease key", () => {
      expect(leaseSchema.safeParse({ notlease: {} }).success).toBe(false);
    });
  });

  describe("validateLeaseContent", () => {
    const validYaml = `lease:
  resource-provider: Microsoft.Test
  startdate: "2027-06-01"
  duration: P90D
  reviewer: "@johndoe"
`;

    it("validates a complete valid lease file", async () => {
      mockReadFile.mockResolvedValue(validYaml);
      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );
      expect(result.errors).toHaveLength(0);
    });

    it("detects resource provider mismatch", async () => {
      mockReadFile.mockResolvedValue(validYaml.replace("Microsoft.Test", "Microsoft.Other"));
      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );
      expect(result.errors.some((e) => e.includes("mismatch"))).toBe(true);
    });

    it("returns error for non-existent file", async () => {
      mockReadFile.mockRejectedValue(new Error("ENOENT"));
      const result = await validateLeaseContent(
        "/nonexistent/lease.yaml",
        ".github/arm-leases/svc/NS/lease.yaml",
      );
      expect(result.errors.some((e) => e.includes("Error reading file"))).toBe(true);
    });

    it("validates startdate within 10 days grace period", async () => {
      // 5 days ago - should pass
      const recentDate = new Date();
      recentDate.setDate(recentDate.getDate() - 5);
      mockReadFile.mockResolvedValue(
        validYaml.replace("2027-06-01", recentDate.toISOString().split("T")[0]),
      );
      let result = await validateLeaseContent(
        "/repo/lease.yaml",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );
      expect(result.errors).toHaveLength(0);

      // Old date - should fail
      mockReadFile.mockResolvedValue(validYaml.replace("2027-06-01", "2025-01-01"));
      result = await validateLeaseContent(
        "/repo/lease.yaml",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
      );
      expect(result.errors.some((e) => e.includes("Startdate is in the past"))).toBe(true);
    });

    it("validates specification folder structure", async () => {
      mockReadFile.mockResolvedValue(validYaml);
      mockStat.mockResolvedValue(/** @type {any} */ ({ isDirectory: () => true }));

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        "/repo",
      );
      expect(result.errors).toHaveLength(0);
      expect(mockStat).toHaveBeenCalledTimes(2);
    });

    it("allows new RP when service folder does not exist", async () => {
      mockReadFile.mockResolvedValue(validYaml);
      mockStat.mockRejectedValue(new Error("ENOENT"));

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/newservice/Microsoft.Test/lease.yaml",
        ".github/arm-leases/newservice/Microsoft.Test/lease.yaml",
        "/repo",
      );
      expect(result.errors).toHaveLength(0);
    });

    it("allows new RP when service exists but RP folder does not", async () => {
      mockReadFile.mockResolvedValue(validYaml);
      mockStat
        .mockResolvedValueOnce(/** @type {any} */ ({ isDirectory: () => true }))
        .mockRejectedValueOnce(new Error("ENOENT"));

      const result = await validateLeaseContent(
        "/repo/.github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        ".github/arm-leases/testservice/Microsoft.Test/lease.yaml",
        "/repo",
      );
      expect(result.errors).toHaveLength(0);
    });
  });
});
