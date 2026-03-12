import { Temporal } from "@js-temporal/polyfill";
import { afterAll, afterEach, beforeAll, describe, expect, it, vi } from "vitest";

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
  });
});
