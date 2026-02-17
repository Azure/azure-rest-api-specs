import { describe, it, expect, vi, beforeEach } from "vitest";

// simple-git: mock git.raw() and git.show()
const mockGitRaw = vi.fn();
const mockGitShow = vi.fn();
vi.mock("simple-git", () => ({
  simpleGit: () => ({ raw: mockGitRaw, show: mockGitShow }),
}));

// ArmHelper mock
const mockGetAllResources = vi.fn();
vi.mock(
  "@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js",
  () => ({
    ArmHelper: vi.fn().mockImplementation(() => ({
      getAllResources: mockGetAllResources,
    })),
  }),
);

vi.mock("@microsoft.azure/openapi-validator-core", () => ({
  SwaggerInventory: vi.fn(),
}));

import { detectNewResourceTypes } from "../src/detect-new-resource-types.js";

function makeMockCore() {
  return {
    info: vi.fn(),
    error: vi.fn(),
    setFailed: vi.fn(),
  };
}

/**
 * Helper to set up git mocks for ls-tree and show.
 * @param {Object} opts
 * @param {Map<string, string[]>} opts.baseFiles - Map of namespacePath to file list at base ref
 * @param {Map<string, string[]>} opts.headFiles - Map of namespacePath to file list at HEAD
 * @param {Map<string, string>} opts.fileContents - Map of "ref:file" to JSON content
 */
function setupGitMock({
  baseFiles = new Map(),
  headFiles = new Map(),
  fileContents = new Map(),
} = {}) {
  mockGitRaw.mockImplementation(async (args) => {
    if (args[0] === "ls-tree" && args.includes("-r")) {
      const commitish = args[3];
      const namespacePath = args[4];
      const filesMap = commitish === "HEAD" ? headFiles : baseFiles;
      if (filesMap.has(namespacePath)) {
        return filesMap.get(namespacePath).join("\n");
      }
      throw new Error(`path '${namespacePath}' does not exist`);
    }
    return "";
  });

  mockGitShow.mockImplementation(async (args) => {
    const key = args[0]; // "ref:filepath"
    if (fileContents.has(key)) {
      return fileContents.get(key);
    }
    throw new Error(`path does not exist: ${key}`);
  });
}

describe("detect-new-resource-types", () => {
  let mockCore;

  beforeEach(() => {
    vi.clearAllMocks();
    mockCore = makeMockCore();
    mockGetAllResources.mockReturnValue([]);
  });

  describe("no matching files", () => {
    it("should return empty when rmFiles has no version-pattern matches", async () => {
      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: ["specification/compute/resource-manager/readme.md"],
        core: mockCore,
      });

      expect(result).toEqual([]);
      expect(mockGitRaw).not.toHaveBeenCalled();
    });

    it("should return empty when rmFiles is empty", async () => {
      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [],
        core: mockCore,
      });

      expect(result).toEqual([]);
    });
  });

  describe("new RP (no base resources)", () => {
    it("should skip namespace when no resources exist in base", async () => {
      const rmFile =
        "specification/newservice/resource-manager/Microsoft.NewService/stable/2025-01-01/api.json";
      setupGitMock({
        baseFiles: new Map(), // ls-tree throws — namespace doesn't exist in base
      });

      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [rmFile],
        core: mockCore,
      });

      expect(result).toEqual([]);
      expect(mockCore.info).toHaveBeenCalledWith(
        expect.stringContaining("no resources in base"),
      );
    });
  });

  describe("existing RP with no new resource types", () => {
    it("should return empty when HEAD has same types as base", async () => {
      const namespacePath =
        "specification/compute/resource-manager/Microsoft.Compute";
      const swaggerFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";
      const swaggerContent = JSON.stringify({ swagger: "2.0", paths: {} });

      setupGitMock({
        baseFiles: new Map([[namespacePath, [swaggerFile]]]),
        headFiles: new Map([[namespacePath, [swaggerFile]]]),
        fileContents: new Map([
          [`base123:${swaggerFile}`, swaggerContent],
          [`HEAD:${swaggerFile}`, swaggerContent],
        ]),
      });

      // Both base and HEAD return same resource type
      mockGetAllResources.mockReturnValue([
        {
          modelName: "VirtualMachine",
          operations: [
            {
              httpMethod: "GET",
              apiPath:
                "/subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}",
            },
          ],
        },
      ]);

      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [swaggerFile],
        core: mockCore,
      });

      expect(result).toEqual([]);
      expect(mockCore.info).toHaveBeenCalledWith(
        expect.stringContaining("no new resource types"),
      );
    });
  });

  describe("existing RP with new resource types", () => {
    it("should detect new resource types in HEAD that are absent from base", async () => {
      const namespacePath =
        "specification/compute/resource-manager/Microsoft.Compute";
      const swaggerFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";
      const swaggerContent = JSON.stringify({ swagger: "2.0", paths: {} });

      setupGitMock({
        baseFiles: new Map([[namespacePath, [swaggerFile]]]),
        headFiles: new Map([[namespacePath, [swaggerFile]]]),
        fileContents: new Map([
          [`base123:${swaggerFile}`, swaggerContent],
          [`HEAD:${swaggerFile}`, swaggerContent],
        ]),
      });

      let callCount = 0;
      mockGetAllResources.mockImplementation(() => {
        callCount++;
        if (callCount <= 1) {
          // Base: only virtualMachines
          return [
            {
              modelName: "VirtualMachine",
              operations: [
                {
                  httpMethod: "GET",
                  apiPath:
                    "/subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}",
                },
              ],
            },
          ];
        }
        // HEAD: virtualMachines + disks
        return [
          {
            modelName: "VirtualMachine",
            operations: [
              {
                httpMethod: "GET",
                apiPath:
                  "/subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}",
              },
            ],
          },
          {
            modelName: "Disk",
            operations: [
              {
                httpMethod: "GET",
                apiPath:
                  "/subscriptions/{id}/providers/Microsoft.Compute/disks/{name}",
              },
              {
                httpMethod: "PUT",
                apiPath:
                  "/subscriptions/{id}/providers/Microsoft.Compute/disks/{name}",
              },
            ],
          },
        ];
      });

      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [swaggerFile],
        core: mockCore,
      });

      expect(result).toHaveLength(1);
      expect(result[0].namespace).toBe("Microsoft.Compute");
      expect(result[0].serviceName).toBe("compute");
      expect(result[0].newResourceTypes).toHaveLength(1);
      expect(result[0].newResourceTypes[0].resourceType).toBe(
        "Microsoft.Compute/disks",
      );
      expect(result[0].newResourceTypes[0].operations).toContain("GET");
      expect(result[0].newResourceTypes[0].operations).toContain("PUT");
    });
  });

  describe("multiple namespaces", () => {
    it("should process each namespace independently", async () => {
      const computePath =
        "specification/compute/resource-manager/Microsoft.Compute";
      const networkPath =
        "specification/network/resource-manager/Microsoft.Network";
      const computeFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";
      const networkFile =
        "specification/network/resource-manager/Microsoft.Network/stable/2024-01-01/network.json";
      const swaggerContent = JSON.stringify({ swagger: "2.0", paths: {} });

      setupGitMock({
        baseFiles: new Map([
          [computePath, [computeFile]],
          [networkPath, [networkFile]],
        ]),
        headFiles: new Map([
          [computePath, [computeFile]],
          [networkPath, [networkFile]],
        ]),
        fileContents: new Map([
          [`base123:${computeFile}`, swaggerContent],
          [`HEAD:${computeFile}`, swaggerContent],
          [`base123:${networkFile}`, swaggerContent],
          [`HEAD:${networkFile}`, swaggerContent],
        ]),
      });

      // No new resources in either namespace
      mockGetAllResources.mockReturnValue([]);

      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [computeFile, networkFile],
        core: mockCore,
      });

      expect(result).toEqual([]);
      // Should have checked both namespaces
      expect(mockCore.info).toHaveBeenCalledWith(
        expect.stringContaining("Microsoft.Compute"),
      );
      expect(mockCore.info).toHaveBeenCalledWith(
        expect.stringContaining("Microsoft.Network"),
      );
    });
  });

  describe("file filtering", () => {
    it("should skip example files from ls-tree output", async () => {
      const namespacePath =
        "specification/compute/resource-manager/Microsoft.Compute";
      const swaggerFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";
      const exampleFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/examples/create.json";
      const swaggerContent = JSON.stringify({ swagger: "2.0", paths: {} });

      setupGitMock({
        baseFiles: new Map([
          [namespacePath, [swaggerFile, exampleFile].join("\n")],
        ]),
        headFiles: new Map([
          [namespacePath, [swaggerFile, exampleFile].join("\n")],
        ]),
        fileContents: new Map([
          [`base123:${swaggerFile}`, swaggerContent],
          [`HEAD:${swaggerFile}`, swaggerContent],
        ]),
      });

      mockGetAllResources.mockReturnValue([]);

      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [swaggerFile],
        core: mockCore,
      });

      expect(result).toEqual([]);
      // git.show should NOT have been called for the example file
      expect(mockGitShow).not.toHaveBeenCalledWith(
        expect.arrayContaining([expect.stringContaining("examples")]),
      );
    });

    it("should skip non-JSON files from ls-tree output", async () => {
      const namespacePath =
        "specification/compute/resource-manager/Microsoft.Compute";
      const swaggerFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";
      const readmeFile =
        "specification/compute/resource-manager/Microsoft.Compute/readme.md";

      setupGitMock({
        baseFiles: new Map([
          [namespacePath, [swaggerFile, readmeFile].join("\n")],
        ]),
        headFiles: new Map([
          [namespacePath, [swaggerFile, readmeFile].join("\n")],
        ]),
        fileContents: new Map([
          [
            `base123:${swaggerFile}`,
            JSON.stringify({ swagger: "2.0", paths: {} }),
          ],
          [
            `HEAD:${swaggerFile}`,
            JSON.stringify({ swagger: "2.0", paths: {} }),
          ],
        ]),
      });

      mockGetAllResources.mockReturnValue([]);

      await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [swaggerFile],
        core: mockCore,
      });

      // git.show should NOT have been called for the readme file
      expect(mockGitShow).not.toHaveBeenCalledWith(
        expect.arrayContaining([expect.stringContaining("readme.md")]),
      );
    });
  });

  describe("error handling", () => {
    it("should skip un-parseable swagger files gracefully", async () => {
      const namespacePath =
        "specification/compute/resource-manager/Microsoft.Compute";
      const swaggerFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";

      setupGitMock({
        baseFiles: new Map([[namespacePath, [swaggerFile]]]),
        headFiles: new Map([[namespacePath, [swaggerFile]]]),
        fileContents: new Map([
          [`base123:${swaggerFile}`, "not valid json"],
          [`HEAD:${swaggerFile}`, "also not valid json"],
        ]),
      });

      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [swaggerFile],
        core: mockCore,
      });

      // Should not throw, just return empty since no resources could be parsed
      expect(result).toEqual([]);
    });

    it("should continue when git.show fails for a file", async () => {
      const namespacePath =
        "specification/compute/resource-manager/Microsoft.Compute";
      const swaggerFile =
        "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";

      setupGitMock({
        baseFiles: new Map([[namespacePath, [swaggerFile]]]),
        headFiles: new Map([[namespacePath, [swaggerFile]]]),
        fileContents: new Map(), // No content → git.show will throw
      });

      const result = await detectNewResourceTypes({
        repoRoot: "/fake/repo",
        mergeBase: "base123",
        rmFiles: [swaggerFile],
        core: mockCore,
      });

      expect(result).toEqual([]);
    });
  });
});
