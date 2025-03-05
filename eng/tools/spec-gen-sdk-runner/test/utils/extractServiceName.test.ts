import { describe, test, expect } from "vitest";
import { extractServiceName } from "../../src/utils";

describe("extractServiceName", () => {
  test("extracts service name from valid path", () => {
    expect(extractServiceName("specification/storage/resource-manager")).toBe("storage");
    expect(extractServiceName("specification/compute/Compute.Management")).toBe("compute");
    expect(extractServiceName("specification/network/data-plane/Network.Json")).toBe("network");
  });

  test("handles paths without specification prefix", () => {
    expect(extractServiceName("storage/resource-manager")).toBe("");
  });

  test("handles invalid paths", () => {
    expect(extractServiceName("")).toBe("");
    expect(extractServiceName("specification/")).toBe("");
    expect(extractServiceName("invalid/path")).toBe("");
  });
});
