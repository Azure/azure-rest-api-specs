import { describe, expect, it } from "vitest";
import { compareApiVersionsAsc, parseApiVersion } from "../src/api-version.ts";

describe("API versions", () => {
  it("parses dated preview and stable versions", () => {
    expect(parseApiVersion("2026-02-03-preview")).toEqual({
      year: 2026,
      month: 2,
      day: 3,
      isPreview: true,
    });
    expect(parseApiVersion("2026-02-03")).toEqual({
      year: 2026,
      month: 2,
      day: 3,
      isPreview: false,
    });
    expect(parseApiVersion("1.0")).toBeUndefined();
  });

  it("orders dates with preview preceding stable on the same date", () => {
    const versions = ["2026-01-02", "2026-01-01", "2025-12-01", "2026-02-01", "2026-01-01-preview"];
    expect(versions.sort(compareApiVersionsAsc)).toEqual([
      "2025-12-01",
      "2026-01-01-preview",
      "2026-01-01",
      "2026-01-02",
      "2026-02-01",
    ]);
    expect(compareApiVersionsAsc("2026-01-01", "2026-01-01")).toBe(0);
    expect(compareApiVersionsAsc("2026-01-01", "2026-01-01-preview")).toBeGreaterThan(0);
  });

  it("preserves lexical ordering for other version formats", () => {
    expect(compareApiVersionsAsc("1.0", "2.0")).toBeLessThan(0);
    expect(compareApiVersionsAsc("2026-01-01", "all")).toBeLessThan(0);
  });
});
