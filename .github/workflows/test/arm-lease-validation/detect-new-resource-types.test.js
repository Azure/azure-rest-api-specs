import { afterEach, describe, expect, it, vi } from "vitest";
import { createMockCore } from "../mocks.js";

/** @type {import("vitest").MockedFunction<import("simple-git").SimpleGit["raw"]>} */
const mockRaw = vi.hoisted(() => vi.fn().mockResolvedValue(""));

/** @type {import("vitest").MockedFunction<import("simple-git").SimpleGit["show"]>} */
const mockShow = vi.hoisted(() => vi.fn().mockResolvedValue(""));

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({ raw: mockRaw, show: mockShow }),
}));

const mockGetAllResources = vi.hoisted(() => vi.fn().mockReturnValue([]));

vi.mock(
  "@microsoft.azure/openapi-validator-rulesets/dist/native/utilities/arm-helper.js",
  () => ({
    ArmHelper: vi.fn().mockImplementation(function () {
      return { getAllResources: mockGetAllResources };
    }),
  }),
);

vi.mock("@microsoft.azure/openapi-validator-core", () => ({
  SwaggerInventory: vi.fn().mockImplementation(function () {}),
}));

import { detectNewResourceTypes } from "../../src/arm-lease-validation/detect-new-resource-types.js";

const core = createMockCore();

const swaggerContent = JSON.stringify({ swagger: "2.0", paths: {} });

// ── test data ───────────────────────────────────────────────────────────

const vmResource = {
  modelName: "VirtualMachine",
  operations: [
    {
      httpMethod: "GET",
      apiPath: "/subscriptions/{id}/providers/Microsoft.Compute/virtualMachines/{name}",
    },
  ],
};

const diskResource = {
  modelName: "Disk",
  operations: [
    {
      httpMethod: "GET",
      apiPath: "/subscriptions/{id}/providers/Microsoft.Compute/disks/{name}",
    },
    {
      httpMethod: "PUT",
      apiPath: "/subscriptions/{id}/providers/Microsoft.Compute/disks/{name}",
    },
  ],
};

// ── helpers ─────────────────────────────────────────────────────────────

/**
 * Configure git mocks for ls-tree and show.
 *
 * @param {Object} opts
 * @param {Map<string, string[]>} [opts.baseFiles] - namespace path → file list at base ref
 * @param {Map<string, string[]>} [opts.headFiles] - namespace path → file list at HEAD
 * @param {Map<string, string>} [opts.fileContents] - "ref:file" → JSON string
 */
function setupGit({
  baseFiles = new Map(),
  headFiles = new Map(),
  fileContents = new Map(),
} = {}) {
  mockRaw.mockImplementation(async (args) => {
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

  mockShow.mockImplementation(async (args) => {
    const key = args[0]; // "ref:filepath"
    if (fileContents.has(key)) {
      return fileContents.get(key);
    }
    throw new Error(`path does not exist: ${key}`);
  });
}

// ── tests ───────────────────────────────────────────────────────────────

describe("detectNewResourceTypes", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it("returns empty when rmFiles has no version-pattern matches", async () => {
    const result = await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: ["specification/compute/resource-manager/readme.md"],
      core,
    });

    expect(result).toEqual([]);
    expect(mockRaw).not.toHaveBeenCalled();
  });

  it("returns empty when rmFiles is empty", async () => {
    const result = await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: [],
      core,
    });

    expect(result).toEqual([]);
  });

  it("skips namespace when no resources exist in base (new RP)", async () => {
    const rmFile =
      "specification/newservice/resource-manager/Microsoft.NewService/stable/2025-01-01/api.json";

    setupGit({ baseFiles: new Map() }); // ls-tree throws → no base

    const result = await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: [rmFile],
      core,
    });

    expect(result).toEqual([]);
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("no resources in base"));
  });

  it("returns empty when HEAD has same resource types as base", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const file = `${ns}/stable/2024-01-01/compute.json`;

    setupGit({
      baseFiles: new Map([[ns, [file]]]),
      headFiles: new Map([[ns, [file]]]),
      fileContents: new Map([
        [`base123:${file}`, swaggerContent],
        [`HEAD:${file}`, swaggerContent],
      ]),
    });

    mockGetAllResources.mockReturnValue([vmResource]);

    const result = await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: [file],
      core,
    });

    expect(result).toEqual([]);
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("no new resource types"));
  });

  it("detects new resource types present in HEAD but absent from base", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const file = `${ns}/stable/2024-01-01/compute.json`;

    setupGit({
      baseFiles: new Map([[ns, [file]]]),
      headFiles: new Map([[ns, [file]]]),
      fileContents: new Map([
        [`base123:${file}`, swaggerContent],
        [`HEAD:${file}`, swaggerContent],
      ]),
    });

    mockGetAllResources
      .mockReturnValueOnce([vmResource]) // base: VM only
      .mockReturnValueOnce([vmResource, diskResource]); // HEAD: VM + Disk

    const result = await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: [file],
      core,
    });

    expect(result).toHaveLength(1);
    expect(result[0]).toMatchObject({
      namespace: "Microsoft.Compute",
      orgName: "compute",
    });
    expect(result[0].newResourceTypes).toHaveLength(1);
    expect(result[0].newResourceTypes[0]).toMatchObject({
      resourceType: "Microsoft.Compute/disks",
    });
    expect(result[0].newResourceTypes[0].operations).toContain("GET");
    expect(result[0].newResourceTypes[0].operations).toContain("PUT");
  });

  it("processes multiple namespaces independently", async () => {
    const computeNs = "specification/compute/resource-manager/Microsoft.Compute";
    const networkNs = "specification/network/resource-manager/Microsoft.Network";
    const computeFile = `${computeNs}/stable/2024-01-01/compute.json`;
    const networkFile = `${networkNs}/stable/2024-01-01/network.json`;

    setupGit({
      baseFiles: new Map([
        [computeNs, [computeFile]],
        [networkNs, [networkFile]],
      ]),
      headFiles: new Map([
        [computeNs, [computeFile]],
        [networkNs, [networkFile]],
      ]),
      fileContents: new Map([
        [`base123:${computeFile}`, swaggerContent],
        [`HEAD:${computeFile}`, swaggerContent],
        [`base123:${networkFile}`, swaggerContent],
        [`HEAD:${networkFile}`, swaggerContent],
      ]),
    });

    mockGetAllResources.mockReturnValue([]);

    const result = await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: [computeFile, networkFile],
      core,
    });

    expect(result).toEqual([]);
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("Microsoft.Compute"));
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("Microsoft.Network"));
  });

  it("skips example files from ls-tree output", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const file = `${ns}/stable/2024-01-01/compute.json`;
    const exampleFile = `${ns}/stable/2024-01-01/examples/create.json`;

    setupGit({
      baseFiles: new Map([[ns, [file, exampleFile]]]),
      headFiles: new Map([[ns, [file, exampleFile]]]),
      fileContents: new Map([
        [`base123:${file}`, swaggerContent],
        [`HEAD:${file}`, swaggerContent],
      ]),
    });

    mockGetAllResources.mockReturnValue([]);

    await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: [file],
      core,
    });

    expect(mockShow).not.toHaveBeenCalledWith(
      expect.arrayContaining([expect.stringContaining("examples")]),
    );
  });

  it("skips non-JSON files from ls-tree output", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const file = `${ns}/stable/2024-01-01/compute.json`;
    const readme = `${ns}/readme.md`;

    setupGit({
      baseFiles: new Map([[ns, [file, readme]]]),
      headFiles: new Map([[ns, [file, readme]]]),
      fileContents: new Map([
        [`base123:${file}`, swaggerContent],
        [`HEAD:${file}`, swaggerContent],
      ]),
    });

    mockGetAllResources.mockReturnValue([]);

    await detectNewResourceTypes({
      repoRoot: "/fake/repo",
      mergeBase: "base123",
      rmFiles: [file],
      core,
    });

    expect(mockShow).not.toHaveBeenCalledWith(
      expect.arrayContaining([expect.stringContaining("readme.md")]),
    );
  });

});
