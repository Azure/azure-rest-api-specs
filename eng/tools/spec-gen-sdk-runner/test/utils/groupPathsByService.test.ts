import { describe, test, expect } from "vitest";
import { groupPathsByService } from "../../src/utils.js";

describe("groupPathsByService", () => {
  test("groups paths by service name correctly", () => {
    const readmeMDResult = {
      "specification/storage/resource-manager": ["file1.json"],
      "specification/storage/data-plane/blob": ["file2.json"],
      "specification/compute/resource-manager": ["file3.json"],
    };

    const typespecProjectResult = {
      "specification/storage/Storage.Management": ["main.tsp", "client.tsp"],
      "specification/storage/StorageClient": ["client.tsp"],
      "specification/storage/Storage.Shared": ["main.tsp"],
      "specification/compute/Compute.Management": ["main.tsp"],
    };

    const result = groupPathsByService(readmeMDResult, typespecProjectResult);

    expect(result.size).toBe(2); // storage and compute

    const storage = result.get("storage");
    expect(storage).toBeDefined();
    expect(storage?.resourceManagerPaths).toHaveLength(1);
    expect(storage?.dataPlanePaths).toHaveLength(1);
    expect(storage?.managementPaths).toHaveLength(1);
    expect(storage?.otherTypeSpecPaths).toHaveLength(2);

    const compute = result.get("compute");
    expect(compute).toBeDefined();
    expect(compute?.resourceManagerPaths).toHaveLength(1);
    expect(compute?.managementPaths).toHaveLength(1);
  });

  test("groups paths by service name correctly", () => {
    const typespecProjectResult = {
      "specification/storage/Storage.Management": ["main.tsp", "client.tsp"],
      "specification/storage/StorageClient": ["client.tsp"],
      "specification/storage/Storage.Shared": ["main.tsp"],
    };

    const result = groupPathsByService({}, typespecProjectResult);

    expect(result.size).toBe(1); // storage and compute

    const storage = result.get("storage");
    expect(storage).toBeDefined();
    expect(storage?.resourceManagerPaths).toHaveLength(0);
    expect(storage?.dataPlanePaths).toHaveLength(0);
    expect(storage?.managementPaths).toHaveLength(1);
    expect(storage?.otherTypeSpecPaths).toHaveLength(2);
  });

  test("handles empty inputs", () => {
    const result = groupPathsByService({}, {});
    expect(result.size).toBe(0);
  });

  test("extracts subpath information correctly", () => {
    const readmeMDResult = {
      "specification/storage/resource-manager/Microsoft.Storage": ["file.json"],
      "specification/storage/data-plane/blob": ["file.json"],
    };

    const result = groupPathsByService(readmeMDResult, {});
    const storage = result.get("storage");

    expect(storage?.resourceManagerPaths[0].subPath).toBe("Microsoft.Storage");
    expect(storage?.dataPlanePaths[0].subFolder).toBe("blob");
  });

  test("handles path without service name", () => {
    const readmeMDResult = {
      nospecification: ["file.json"],
    };

    const result = groupPathsByService(readmeMDResult, {});

    expect(result).toBeDefined();
    expect(result.size).toBe(0);
  });

  test("handles typespec path without service name", () => {
    const typespecProjectResult = {
      nospecification: ["file.json"],
    };

    const result = groupPathsByService({}, typespecProjectResult);

    expect(result).toBeDefined();
    expect(result.size).toBe(0);
  });
});
