import { describe, expect, test } from "vitest";
import { getLastPathSegment } from "../../src/utils.js";

describe("getLastPathSegment", () => {
  test("extracts last segment from path", () => {
    expect(getLastPathSegment("specification/storage/StorageClient")).toBe("StorageClient");
    expect(getLastPathSegment("specification/compute/Compute.Management")).toBe(
      "Compute.Management",
    );
    expect(getLastPathSegment("path/to/folder/")).toBe("");
  });

  test("handles paths with no segments", () => {
    expect(getLastPathSegment("")).toBe("");
  });

  test("handles single segment paths", () => {
    expect(getLastPathSegment("filename")).toBe("filename");
  });

  test("handles paths with different separators", () => {
    expect(getLastPathSegment("path/to/unix/style")).toBe("style");
  });
});
