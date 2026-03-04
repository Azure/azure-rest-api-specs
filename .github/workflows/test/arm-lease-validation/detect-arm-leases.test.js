import { afterEach, describe, expect, it, vi } from "vitest";
import { Temporal } from "@js-temporal/polyfill";

/** @type {import("vitest").MockedFunction<typeof import("fs/promises").readFile>} */
const mockReadFile = vi.hoisted(() => vi.fn());

vi.mock("fs/promises", () => ({
  readFile: mockReadFile,
}));

/** @type {import("vitest").MockedFunction<typeof import("../../../shared/src/simple-git.js").getRootFolder>} */
const mockGetRootFolder = vi.hoisted(() => vi.fn().mockResolvedValue("/fake/repo"));

vi.mock("../../../shared/src/simple-git.js", () => ({
  getRootFolder: mockGetRootFolder,
}));

import { checkLease, parseLease } from "../../src/arm-lease-validation/detect-arm-leases.js";

/** Get today's date string using Temporal (same as source code) */
function today() {
  return Temporal.Now.plainDateISO();
}

/** Subtract days from today and return YYYY-MM-DD string */
function daysAgo(n) {
  return today().subtract({ days: n }).toString();
}

/** Build a valid lease YAML string */
function leaseYaml(startdate, duration) {
  return [
    "lease:",
    `  startdate: ${startdate}`,
    `  duration: ${duration}`,
  ].join("\n");
}

describe("detect-arm-leases", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  describe("parseLease", () => {
    it("returns valid for a non-expired lease", () => {
      const result = parseLease(leaseYaml(daysAgo(30), "P90D"));
      expect(result.valid).toBe(true);
    });

    it("returns invalid when lease has expired", () => {
      const result = parseLease(leaseYaml(daysAgo(100), "P90D"));
      expect(result.valid).toBe(false);
      expect(result.reason).toMatch(/expired/i);
    });

    it("returns valid on the last day of lease", () => {
      const result = parseLease(leaseYaml(daysAgo(90), "P90D"));
      expect(result.valid).toBe(true);
    });

    it("returns invalid one day after lease expires", () => {
      const result = parseLease(leaseYaml(daysAgo(91), "P90D"));
      expect(result.valid).toBe(false);
    });

    it("supports month-based durations", () => {
      const start = today().subtract({ months: 3 }).toString();
      const result = parseLease(leaseYaml(start, "P6M"));
      expect(result.valid).toBe(true);
    });

    it("supports year-based durations", () => {
      const start = today().subtract({ years: 1 }).add({ months: 1 }).toString();
      const result = parseLease(leaseYaml(start, "P2Y"));
      expect(result.valid).toBe(true);
    });

    it("supports combined durations like P1Y6M", () => {
      const result = parseLease(leaseYaml("2025-01-01", "P1Y6M"));
      expect(result.valid).toBe(true);
    });

    it("returns valid for single day duration starting today", () => {
      const result = parseLease(leaseYaml(today().toString(), "P1D"));
      expect(result.valid).toBe(true);
    });

    it("returns valid for future start dates", () => {
      const start = today().add({ days: 10 }).toString();
      const result = parseLease(leaseYaml(start, "P90D"));
      expect(result.valid).toBe(true);
    });

    it("returns invalid for empty YAML content", () => {
      const result = parseLease("");
      expect(result.valid).toBe(false);
    });

    it("returns invalid for malformed YAML", () => {
      const result = parseLease("invalid: yaml: content");
      expect(result.valid).toBe(false);
    });

    it("returns invalid when startdate is missing", () => {
      const yaml = ["lease:", "  duration: P90D"].join("\n");
      const result = parseLease(yaml);
      expect(result.valid).toBe(false);
    });

    it("returns invalid when duration is missing", () => {
      const yaml = ["lease:", "  startdate: " + daysAgo(10)].join("\n");
      const result = parseLease(yaml);
      expect(result.valid).toBe(false);
    });

    it("returns invalid for bad startdate format", () => {
      const result = parseLease(leaseYaml("01-01-2025", "P90D"));
      expect(result.valid).toBe(false);
    });

    it("returns invalid for bad duration format", () => {
      const result = parseLease(leaseYaml(daysAgo(10), "90 days"));
      expect(result.valid).toBe(false);
    });
  });

  describe("checkLease", () => {
    it("returns false when lease file does not exist", async () => {
      mockReadFile.mockRejectedValue(new Error("ENOENT"));

      const result = await checkLease("testservice", "Microsoft.Test");
      expect(result).toBe(false);
    });

    it("returns true when lease is valid and not expired", async () => {
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(30), "P90D"));

      const result = await checkLease("testservice", "Microsoft.Test");
      expect(result).toBe(true);
    });

    it("returns false when lease has expired", async () => {
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(100), "P90D"));

      const result = await checkLease("testservice", "Microsoft.Test");
      expect(result).toBe(false);
    });

    it("returns false for invalid lease file format", async () => {
      mockReadFile.mockResolvedValue("invalid: yaml: content");

      const result = await checkLease("testservice", "Microsoft.Test");
      expect(result).toBe(false);
    });

    it("handles multiple services and namespaces", async () => {
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(30), "P90D"));

      expect(await checkLease("app", "Microsoft.App")).toBe(true);
      expect(await checkLease("compute", "Microsoft.Compute")).toBe(true);
    });

    it("returns false for missing namespace", async () => {
      mockReadFile.mockRejectedValue(new Error("ENOENT"));

      expect(await checkLease("storage", "Microsoft.Storage")).toBe(false);
    });
  });
});