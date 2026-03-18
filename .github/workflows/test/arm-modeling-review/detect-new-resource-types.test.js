import { afterEach, describe, expect, it, vi } from "vitest";
import { createMockCore } from "../mocks.js";

/** @type {import("vitest").MockedFunction<import("simple-git").SimpleGit["raw"]>} */
const mockRaw = vi.hoisted(() => vi.fn().mockResolvedValue(""));

/** @type {import("vitest").MockedFunction<import("simple-git").SimpleGit["show"]>} */
const mockShow = vi.hoisted(() => vi.fn().mockResolvedValue(""));

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({ raw: mockRaw, show: mockShow }),
}));

import { detectNewResourceTypes } from "../../src/arm-modeling-review/detect-new-resource-types.js";

const core = createMockCore();

const emptySwagger = JSON.stringify({ swagger: "2.0", paths: {} });

const vmSwagger = JSON.stringify({
  swagger: "2.0",
  paths: {
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}":
      {
        get: { operationId: "VirtualMachines_Get", responses: { 200: { description: "OK" } } },
      },
  },
});

const vmAndDiskSwagger = JSON.stringify({
  swagger: "2.0",
  paths: {
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}":
      {
        get: { operationId: "VirtualMachines_Get", responses: { 200: { description: "OK" } } },
      },
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/disks/{diskName}":
      {
        get: { operationId: "Disks_Get", responses: { 200: { description: "OK" } } },
        put: { operationId: "Disks_CreateOrUpdate", responses: { 200: { description: "OK" } } },
      },
  },
});

// ── helpers ─────────────────────────────────────────────────────────────

/**
 * Configure git mocks for ls-tree and show.
 *
 * @param {Object} opts
 * @param {Map<string, string[]>} [opts.baseFiles] - namespace path → file list at base ref
 * @param {Map<string, string[]>} [opts.headFiles] - namespace path → file list at HEAD
 * @param {Map<string, string>} [opts.fileContents] - "ref:file" → JSON string
 */
function setupGit({ baseFiles = new Map(), headFiles = new Map(), fileContents = new Map() } = {}) {
  mockRaw.mockImplementation(
    /** @type {any} */ (
      /** @param {string[]} args */ (args) => {
        if (args[0] === "ls-tree" && args.includes("-r")) {
          const commitish = args[3];
          const namespacePath = args[4];
          const filesMap = commitish === "HEAD" ? headFiles : baseFiles;
          const files = filesMap.get(namespacePath);
          if (files) {
            return files.join("\n");
          }
          throw new Error(`path '${namespacePath}' does not exist`);
        }
        return "";
      }
    ),
  );

  mockShow.mockImplementation(
    /** @type {any} */ (
      /** @param {string[]=} args */ (args) => {
        const key = String(args?.[0]); // "ref:filepath"
        const content = fileContents.get(key);
        if (content !== undefined) {
          return content;
        }
        const msg = `path does not exist: ${key}`;
        throw new Error(msg);
      }
    ),
  );
}

// ── tests ───────────────────────────────────────────────────────────────

describe("detectNewResourceTypes", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it("returns empty when rmFiles has no version-pattern matches", async () => {
    const result = await detectNewResourceTypes({
      rmFiles: ["specification/compute/resource-manager/readme.md"],
      core,
    });

    expect(result).toEqual([]);
    expect(mockRaw).not.toHaveBeenCalled();
  });

  it("returns empty when rmFiles is empty", async () => {
    const result = await detectNewResourceTypes({
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
      rmFiles: [rmFile],
      core,
    });

    expect(result).toEqual([]);
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("no resources in base"));
  });

  it("returns empty when HEAD has same resource types as base", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const file = `${ns}/stable/2024-01-01/compute.json`;
    // When path contains stable/preview, compare at namespace root
    const namespacePath = ns;

    setupGit({
      baseFiles: new Map([[namespacePath, [file]]]),
      headFiles: new Map([[namespacePath, [file]]]),
      fileContents: new Map([
        [`HEAD^:${file}`, vmSwagger],
        [`HEAD:${file}`, vmSwagger],
      ]),
    });

    const result = await detectNewResourceTypes({
      rmFiles: [file],
      core,
    });

    expect(result).toEqual([]);
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("no new resource types"));
  });

  it("detects new resource types present in HEAD but absent from base", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const file = `${ns}/stable/2024-01-01/compute.json`;
    // When path contains stable/preview, compare at namespace root
    const namespacePath = ns;

    setupGit({
      baseFiles: new Map([[namespacePath, [file]]]),
      headFiles: new Map([[namespacePath, [file]]]),
      fileContents: new Map([
        [`HEAD^:${file}`, vmSwagger], // base: VM only
        [`HEAD:${file}`, vmAndDiskSwagger], // HEAD: VM + Disk
      ]),
    });

    const result = await detectNewResourceTypes({
      rmFiles: [file],
      core,
    });

    expect(result).toHaveLength(1);
    expect(result[0]).toMatchObject({
      rpNamespace: "Microsoft.Compute",
      orgName: "compute",
      serviceName: "",
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
    // When path contains stable/preview, compare at namespace root
    const computeNamespacePath = computeNs;
    const networkNamespacePath = networkNs;

    setupGit({
      baseFiles: new Map([
        [computeNamespacePath, [computeFile]],
        [networkNamespacePath, [networkFile]],
      ]),
      headFiles: new Map([
        [computeNamespacePath, [computeFile]],
        [networkNamespacePath, [networkFile]],
      ]),
      fileContents: new Map([
        [`HEAD^:${computeFile}`, emptySwagger],
        [`HEAD:${computeFile}`, emptySwagger],
        [`HEAD^:${networkFile}`, emptySwagger],
        [`HEAD:${networkFile}`, emptySwagger],
      ]),
    });

    const result = await detectNewResourceTypes({
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
    // When path contains stable/preview, compare at namespace root
    const namespacePath = ns;

    setupGit({
      baseFiles: new Map([[namespacePath, [file, exampleFile]]]),
      headFiles: new Map([[namespacePath, [file, exampleFile]]]),
      fileContents: new Map([
        [`HEAD^:${file}`, emptySwagger],
        [`HEAD:${file}`, emptySwagger],
      ]),
    });

    await detectNewResourceTypes({
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
    const readme = `${ns}/stable/readme.md`;
    // When path contains stable/preview, compare at namespace root
    const namespacePath = ns;

    setupGit({
      baseFiles: new Map([[namespacePath, [file, readme]]]),
      headFiles: new Map([[namespacePath, [file, readme]]]),
      fileContents: new Map([
        [`HEAD^:${file}`, emptySwagger],
        [`HEAD:${file}`, emptySwagger],
      ]),
    });

    await detectNewResourceTypes({
      rmFiles: [file],
      core,
    });

    expect(mockShow).not.toHaveBeenCalledWith(
      expect.arrayContaining([expect.stringContaining("readme.md")]),
    );
  });

  it("detects new RT when introducing first preview folder under existing stable-only namespace", async () => {
    // This tests the fix for false-negative when introducing the first preview folder
    // under an existing namespace that only had stable. Without the fix, the code
    // would try to compare .../Microsoft.Compute/preview which doesn't exist in base
    // and skip detection entirely.
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const stableFile = `${ns}/stable/2024-01-01/compute.json`;
    const previewFile = `${ns}/preview/2026-01-01-preview/compute.json`;
    // Compare at namespace root to include both stable and preview
    const namespacePath = ns;

    const stableSwagger = JSON.stringify({
      swagger: "2.0",
      paths: {
        "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}":
          {
            get: { operationId: "VirtualMachines_Get", responses: { 200: { description: "OK" } } },
          },
      },
    });

    const previewSwagger = JSON.stringify({
      swagger: "2.0",
      paths: {
        "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/quantumVMs/{vmName}":
          {
            get: { operationId: "QuantumVMs_Get", responses: { 200: { description: "OK" } } },
            put: {
              operationId: "QuantumVMs_CreateOrUpdate",
              responses: { 200: { description: "OK" } },
            },
          },
      },
    });

    setupGit({
      // Base only has stable folder
      baseFiles: new Map([[namespacePath, [stableFile]]]),
      // HEAD has both stable and new preview folder
      headFiles: new Map([[namespacePath, [stableFile, previewFile]]]),
      fileContents: new Map([
        [`HEAD^:${stableFile}`, stableSwagger],
        [`HEAD:${stableFile}`, stableSwagger],
        [`HEAD:${previewFile}`, previewSwagger],
      ]),
    });

    const result = await detectNewResourceTypes({
      rmFiles: [previewFile],
      core,
    });

    // Should detect the new quantumVMs resource type from preview
    expect(result).toHaveLength(1);
    expect(result[0].rpNamespace).toBe("Microsoft.Compute");
    const quantumType = result[0].newResourceTypes.find(
      (t) => t.resourceType === "Microsoft.Compute/quantumVMs",
    );
    expect(quantumType).toBeDefined();
    expect(quantumType?.operations).toContain("GET");
    expect(quantumType?.operations).toContain("PUT");
  });

  it("detects new resource types from path-based detection", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const existingFile = `${ns}/DiskRP/stable/2024-01-01/disk.json`;
    const newFile = `${ns}/DiskRP/preview/2026-05-01-preview/disk.json`;

    const existingSwagger = JSON.stringify({ swagger: "2.0", paths: {} });
    const newSwagger = JSON.stringify({
      swagger: "2.0",
      paths: {
        "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/superDisks/{diskName}":
          {
            get: { operationId: "SuperDisks_Get", responses: { 200: { description: "OK" } } },
          },
        "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/superDisks/{diskName}/metrics/{metricName}":
          {
            get: { operationId: "SuperDiskMetrics_Get", responses: { 200: { description: "OK" } } },
          },
      },
    });

    setupGit({
      baseFiles: new Map([[`${ns}/DiskRP`, [existingFile]]]),
      headFiles: new Map([[`${ns}/DiskRP`, [existingFile, newFile]]]),
      fileContents: new Map([
        [`HEAD^:${existingFile}`, existingSwagger],
        [`HEAD:${existingFile}`, existingSwagger],
        [`HEAD:${newFile}`, newSwagger],
      ]),
    });

    const result = await detectNewResourceTypes({
      rmFiles: [newFile],
      core,
    });

    expect(result).toHaveLength(1);
    expect(result[0].rpNamespace).toBe("Microsoft.Compute");
    // superDisks should be detected
    const superDisksType = result[0].newResourceTypes.find(
      (t) => t.resourceType === "Microsoft.Compute/superDisks",
    );
    expect(superDisksType).toBeDefined();
    expect(superDisksType?.operations).toContain("GET");
    // superDisks/metrics is also new
    const metricsType = result[0].newResourceTypes.find(
      (t) => t.resourceType === "Microsoft.Compute/superDisks/metrics",
    );
    expect(metricsType).toBeDefined();
  });

  it("excludes operations-only paths", async () => {
    const ns = "specification/compute/resource-manager/Microsoft.Compute";
    const existingPreviewFile = `${ns}/DiskRP/stable/2024-01-01/compute.json`;
    const newFile = `${ns}/DiskRP/preview/2026-01-01-preview/compute.json`;

    const existingSwagger = JSON.stringify({ swagger: "2.0", paths: {} });
    const operationsOnlySwagger = JSON.stringify({
      swagger: "2.0",
      paths: {
        "/providers/Microsoft.Compute/operations": {
          get: { operationId: "Operations_List", responses: { 200: { description: "OK" } } },
        },
      },
    });

    setupGit({
      baseFiles: new Map([[`${ns}/DiskRP`, [existingPreviewFile]]]),
      headFiles: new Map([[`${ns}/DiskRP`, [existingPreviewFile, newFile]]]),
      fileContents: new Map([
        [`HEAD^:${existingPreviewFile}`, existingSwagger],
        [`HEAD:${existingPreviewFile}`, existingSwagger],
        [`HEAD:${newFile}`, operationsOnlySwagger],
      ]),
    });

    const result = await detectNewResourceTypes({
      rmFiles: [newFile],
      core,
    });

    expect(result).toEqual([]);
  });
});
