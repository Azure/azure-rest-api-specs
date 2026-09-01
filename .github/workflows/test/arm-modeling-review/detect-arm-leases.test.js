import { Temporal } from "@js-temporal/polyfill";
import { resolve } from "path";
import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";

/** @type {import("vitest").MockedFunction<(path: string, encoding: string) => Promise<string>>} */
const mockReadFile = vi.hoisted(() => vi.fn());

vi.mock("fs/promises", () => ({
  readFile: mockReadFile,
}));

import { checkLease, parseLease } from "../../src/arm-modeling-review/detect-arm-leases.js";

const WORKSPACE = "/fake/workspace";
const LEASES_DIR = resolve(WORKSPACE, "arm-leases");

/** Build the expected path of a lease file in the public-main checkout
 * @param {...string} parts
 */
function leasePath(...parts) {
  return resolve(LEASES_DIR, ".github", "arm-leases", ...parts, "lease.yaml");
}

// Use a fixed date for deterministic tests (avoids flakiness around midnight)
const FIXED_TEST_DATE = new Date("2025-06-15T12:00:00Z");
const FIXED_PLAIN_DATE = Temporal.PlainDate.from("2025-06-15");

/** Get fixed today's date using Temporal */
function today() {
  return FIXED_PLAIN_DATE;
}

/** Subtract days from today and return YYYY-MM-DD string
 *  @param {number} n - Number of days to subtract
 */
function daysAgo(n) {
  return today().subtract({ days: n }).toString();
}

/** Build a valid lease YAML string
 * @param {string} startdate
 * @param {string} duration
 */
function leaseYaml(startdate, duration) {
  return `lease:\n  startdate: "${startdate}"\n  duration: "${duration}"\n`;
}

describe("detect-arm-leases", () => {
  beforeAll(() => {
    vi.useFakeTimers();
    vi.setSystemTime(FIXED_TEST_DATE);
    // Stub Temporal.Now.plainDateISO since the polyfill may not respect vi.useFakeTimers()
    vi.spyOn(Temporal.Now, "plainDateISO").mockReturnValue(FIXED_PLAIN_DATE);
  });

  afterAll(() => {
    vi.useRealTimers();
  });

  beforeEach(() => {
    vi.stubEnv("GITHUB_WORKSPACE", WORKSPACE);
    vi.stubEnv("ARM_LEASES_DIR", LEASES_DIR);
  });

  afterEach(() => {
    vi.clearAllMocks();
    vi.unstubAllEnvs();
  });

  describe("parseLease", () => {
    it("returns valid for a non-expired lease", () => {
      const result = parseLease(leaseYaml(daysAgo(30), "P90D"));
      expect(result.valid).toBe(true);
    });

    it("returns invalid when lease has expired", () => {
      const result = parseLease(leaseYaml(daysAgo(100), "P90D"));
      expect(result.valid).toBe(false);
      expect(result.reason).toContain("expired");
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

    it("handles single day duration", () => {
      const result = parseLease(leaseYaml(today().toString(), "P1D"));
      expect(result.valid).toBe(true);
    });

    it("returns invalid for malformed YAML", () => {
      const result = parseLease("invalid: yaml: content");
      expect(result.valid).toBe(false);
    });

    it("returns invalid for empty content", () => {
      const result = parseLease("");
      expect(result.valid).toBe(false);
      expect(result.reason).toContain("Empty");
    });

    it("returns valid for future start dates", () => {
      const start = today().add({ days: 10 }).toString();
      const result = parseLease(leaseYaml(start, "P90D"));
      expect(result.valid).toBe(true);
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

    it("reads lease from the public main checkout (with serviceName)", async () => {
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(30), "P90D"));

      const result = await checkLease("xyz", "Microsoft.XYZ", "XYZ");

      expect(result).toBe(true);
      expect(mockReadFile).toHaveBeenCalledWith(leasePath("xyz", "Microsoft.XYZ", "XYZ"), "utf-8");
    });

    it("reads lease from the public main checkout (without serviceName)", async () => {
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(30), "P90D"));

      const result = await checkLease("xyz", "Microsoft.XYZ");

      expect(result).toBe(true);
      expect(mockReadFile).toHaveBeenCalledWith(leasePath("xyz", "Microsoft.XYZ"), "utf-8");
    });

    it("falls back to <workspace>/arm-leases when ARM_LEASES_DIR is not set", async () => {
      vi.stubEnv("ARM_LEASES_DIR", undefined);
      vi.stubEnv("GITHUB_WORKSPACE", "/other/workspace");
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(30), "P90D"));

      const result = await checkLease("xyz", "Microsoft.XYZ");

      expect(result).toBe(true);
      expect(mockReadFile).toHaveBeenCalledWith(
        resolve(
          "/other/workspace",
          "arm-leases",
          ".github",
          "arm-leases",
          "xyz",
          "Microsoft.XYZ",
          "lease.yaml",
        ),
        "utf-8",
      );
    });

    it("falls back to cwd when neither ARM_LEASES_DIR nor GITHUB_WORKSPACE is set", async () => {
      vi.stubEnv("ARM_LEASES_DIR", undefined);
      vi.stubEnv("GITHUB_WORKSPACE", undefined);
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(30), "P90D"));

      const result = await checkLease("xyz", "Microsoft.XYZ");

      expect(result).toBe(true);
      expect(mockReadFile).toHaveBeenCalledWith(
        resolve(
          process.cwd(),
          "arm-leases",
          ".github",
          "arm-leases",
          "xyz",
          "Microsoft.XYZ",
          "lease.yaml",
        ),
        "utf-8",
      );
    });

    it("reads from ARM_LEASES_DIR when it differs from the workspace default", async () => {
      vi.stubEnv("ARM_LEASES_DIR", resolve("/custom", "leases-checkout"));
      mockReadFile.mockResolvedValue(leaseYaml(daysAgo(30), "P90D"));

      const result = await checkLease("xyz", "Microsoft.XYZ");

      expect(result).toBe(true);
      expect(mockReadFile).toHaveBeenCalledWith(
        resolve(
          "/custom",
          "leases-checkout",
          ".github",
          "arm-leases",
          "xyz",
          "Microsoft.XYZ",
          "lease.yaml",
        ),
        "utf-8",
      );
    });
  });
});
