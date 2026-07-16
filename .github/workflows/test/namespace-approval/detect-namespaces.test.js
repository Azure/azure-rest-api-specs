import { execFile } from "child_process";
import { readFile } from "fs/promises";
import yaml from "js-yaml";
import { describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore } from "../mocks.js";

// We can't easily test the default export (it depends on getChangedFiles and process.env),
// but we can test extractNamespaces and resolveLanguage by re-importing the module internals.
// Since they're not exported, we test them indirectly through tspconfig content.

// Mock readFile to return tspconfig content
vi.mock("fs/promises", async (importOriginal) => {
  /** @type {typeof import("fs/promises")} */
  const actual = /** @type {any} */ (await importOriginal());
  return {
    ...actual,
    readFile: vi.fn(),
    writeFile: vi.fn(),
  };
});

// Mock child_process.execFile for git show (base branch comparison)
// promisify(execFile) expects (err, stdout, stderr) callback pattern
vi.mock("child_process", () => ({
  execFile: vi.fn(
    (
      /** @type {string} */ _cmd,
      /** @type {string[]} */ _args,
      /** @type {(err: Error | null, stdout: string, stderr: string) => void} */ cb,
    ) => {
      // Default: file not found on base branch
      cb(new Error("fatal: path not found"), "", "");
    },
  ),
}));

// Mock getChangedFilesStatuses — path must match the import in detect-namespaces.js
vi.mock("../../../shared/src/changed-files.js", () => ({
  getChangedFilesStatuses: vi.fn().mockResolvedValue({
    additions: [],
    modifications: [],
    deletions: [],
    renames: [],
    total: 0,
  }),
  tspconfig: (/** @type {string} */ file) =>
    file.startsWith("specification/") && file.endsWith("/tspconfig.yaml"),
}));

// Mock format validation
vi.mock("../../src/namespace-approval/validate-format.js", () => ({
  loadFormatRules: vi.fn().mockReturnValue(null),
  validateNamespaceFormat: vi.fn(),
}));

// Import after mocks
const { default: detectNamespaces } =
  await import("../../src/namespace-approval/detect-namespaces.js");
const { getChangedFilesStatuses } = await import("../../../shared/src/changed-files.js");

/** @type {import("vitest").Mock} */
const readFileMock = /** @type {any} */ (readFile);
/** @type {import("vitest").Mock} */
const getChangedFilesStatusesMock = /** @type {any} */ (getChangedFilesStatuses);
/** @type {import("vitest").Mock} */
const execFileMock = /** @type {any} */ (execFile);

/** @type {ReturnType<typeof createMockCore>} */
let core;
/** @type {ReturnType<typeof createMockContext>} */
let context;

/** @returns {import("@actions/github-script").AsyncFunctionArguments} */
function args() {
  return /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (
    /** @type {unknown} */ ({ context, core })
  );
}

/**
 * Helper to mock getChangedFilesStatuses with modifications (most common case).
 * @param {string[]} modifications - Files that were modified
 * @param {{ additions?: string[], renames?: {from: string, to: string}[] }} [extra]
 */
function mockFileStatuses(modifications, extra = {}) {
  getChangedFilesStatusesMock.mockResolvedValue({
    additions: extra.additions ?? [],
    modifications,
    deletions: [],
    renames: extra.renames ?? [],
    total: modifications.length + (extra.additions?.length ?? 0) + (extra.renames?.length ?? 0),
  });
}

function mgmtTspconfig() {
  return yaml.dump({
    linter: {
      extends: ["@azure-tools/typespec-azure-resource-manager/all"],
    },
    options: {
      "@azure-tools/typespec-csharp": {
        namespace: "Azure.ResourceManager.Compute",
      },
      "@azure-tools/typespec-java": {
        "emitter-output-dir": "{output-dir}/{service-dir}/azure-resourcemanager-compute",
        namespace: "com.azure.resourcemanager.compute",
      },
      "@azure-tools/typespec-python": {
        "package-details": { name: "azure-mgmt-compute" },
      },
      "@azure-tools/typespec-ts": {
        namespace: "@azure/arm-compute",
      },
      "@azure-tools/typespec-go": {
        module: "sdk/resourcemanager/compute/armcompute",
      },
    },
  });
}

function dataplaneTspconfig() {
  return yaml.dump({
    linter: {
      extends: ["@azure-tools/typespec-azure-core/all"],
    },
    options: {
      "@azure-tools/typespec-java": {
        namespace: "com.azure.messaging.eventgrid",
      },
      "@azure-tools/typespec-python": {
        "package-details": { name: "azure-eventgrid" },
      },
      "@azure-tools/typespec-ts": {
        namespace: "@azure/eventgrid",
      },
    },
  });
}

function rustTspconfig() {
  return yaml.dump({
    options: {
      "@azure-tools/typespec-rust": {
        "crate-name": "azure_storage_blobs",
      },
    },
  });
}

describe("detect-namespaces", () => {
  // Set RUNNER_TEMP for tests since we removed the fallback
  process.env.RUNNER_TEMP = process.env.RUNNER_TEMP ?? "/tmp";

  // Default: git show fails (file not on base branch = new file)
  function mockGitShowNotFound() {
    execFileMock.mockImplementation(
      (
        /** @type {string} */ _cmd,
        /** @type {string[]} */ _args,
        /** @type {(err: Error | null, stdout: string, stderr: string) => void} */ cb,
      ) => {
        cb(new Error("fatal: path not found"), "", "");
      },
    );
  }

  /**
   * Mock git show to return base branch content for a given file.
   * @param {string} content - YAML content to return
   */
  function mockGitShowReturns(content) {
    execFileMock.mockImplementation(
      (
        /** @type {string} */ _cmd,
        /** @type {string[]} */ _args,
        /** @type {(err: Error | null, stdout: string, stderr: string) => void} */ cb,
      ) => {
        cb(null, content, "");
      },
    );
  }

  it("should detect management plane namespaces from path", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 42 }, action: "opened" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);
    readFileMock.mockResolvedValue(mgmtTspconfig());

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it("should detect data plane from linter extends", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 43 }, action: "opened" };
    const file = "specification/eventgrid/EventGrid/tspconfig.yaml";
    mockFileStatuses([file]);
    readFileMock.mockResolvedValue(dataplaneTspconfig());

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it("should extract rust crate-name", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 44 }, action: "opened" };
    const file = "specification/storage/Storage/tspconfig.yaml";
    mockFileStatuses([file]);
    readFileMock.mockResolvedValue(rustTspconfig());

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it("should skip when no tspconfig.yaml changes detected", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 45 }, action: "opened" };
    mockFileStatuses(["specification/compute/readme.md"]);

    await detectNamespaces(args());

    expect(core.info).toHaveBeenCalledWith("No tspconfig.yaml changes detected, skipping");
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it("should handle tspconfig with no emitter options", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 46 }, action: "opened" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);
    readFileMock.mockResolvedValue(yaml.dump({ linter: {} }));
    mockGitShowNotFound();

    await detectNamespaces(args());

    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("No emitter options found"));
  });

  it("should skip namespaces unchanged from base branch", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 47 }, action: "synchronize" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);
    // PR version: same namespaces as base, but with added generate-samples option
    const prContent = yaml.dump({
      options: {
        "@azure-tools/typespec-csharp": {
          namespace: "Azure.ResourceManager.Compute",
        },
        "@azure-tools/typespec-java": {
          namespace: "com.azure.resourcemanager.compute",
          "generate-samples": false,
          "generate-tests": false,
        },
      },
    });
    readFileMock.mockResolvedValue(prContent);
    // Base version: same namespaces, without generate-samples
    const baseContent = yaml.dump({
      options: {
        "@azure-tools/typespec-csharp": {
          namespace: "Azure.ResourceManager.Compute",
        },
        "@azure-tools/typespec-java": {
          namespace: "com.azure.resourcemanager.compute",
        },
      },
    });
    mockGitShowReturns(baseContent);

    await detectNamespaces(args());

    // No namespace changes → should not output results
    expect(core.setOutput).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "No namespace changes detected after comparing with base branch",
    );
  });

  it("should detect only the language whose namespace changed", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 48 }, action: "synchronize" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);
    // PR version: typescript namespace changed
    const prContent = yaml.dump({
      options: {
        "@azure-tools/typespec-csharp": {
          namespace: "Azure.ResourceManager.Compute",
        },
        "@azure-tools/typespec-java": {
          namespace: "com.azure.resourcemanager.compute",
        },
        "@azure-tools/typespec-ts": {
          "package-details": { name: "@azure/arm-compute-v2" },
        },
      },
    });
    readFileMock.mockResolvedValue(prContent);
    // Base version: original typescript namespace
    const baseContent = yaml.dump({
      options: {
        "@azure-tools/typespec-csharp": {
          namespace: "Azure.ResourceManager.Compute",
        },
        "@azure-tools/typespec-java": {
          namespace: "com.azure.resourcemanager.compute",
        },
        "@azure-tools/typespec-ts": {
          "package-details": { name: "@azure/arm-compute" },
        },
      },
    });
    mockGitShowReturns(baseContent);

    await detectNamespaces(args());

    // Only typescript changed → should output results
    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    // Verify dotnet and java were skipped
    expect(core.info).toHaveBeenCalledWith(
      expect.stringContaining("Namespace unchanged for dotnet"),
    );
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("Namespace unchanged for java"));
  });

  it("should skip unchanged namespaces when file is renamed (folder migration)", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 49 }, action: "opened" };
    const oldPath = "specification/edgezones/resource-manager/tspconfig.yaml";
    const newPath =
      "specification/edgezones/resource-manager/Microsoft.EdgeZones/EdgeZones/tspconfig.yaml";
    // Report as a rename
    mockFileStatuses([], { renames: [{ from: oldPath, to: newPath }] });
    // PR version: namespaces unchanged, only output paths differ
    const content = yaml.dump({
      options: {
        "@azure-tools/typespec-python": {
          "emitter-output-dir": "{output-dir}/{service-dir}/azure-mgmt-edgezones",
          namespace: "azure.mgmt.edgezones",
        },
        "@azure-tools/typespec-java": {
          namespace: "com.azure.resourcemanager.edgezones",
        },
        "@azure-tools/typespec-csharp": {
          namespace: "Azure.ResourceManager.EdgeZones",
        },
      },
    });
    readFileMock.mockResolvedValue(content);
    // Base version at old path: same namespaces
    mockGitShowReturns(content);

    await detectNamespaces(args());

    // All namespaces unchanged → should not output results
    expect(core.setOutput).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "No namespace changes detected after comparing with base branch",
    );
  });

  it("should use old path for git show when file is renamed", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 50 }, action: "opened" };
    const oldPath = "specification/edgezones/resource-manager/tspconfig.yaml";
    const newPath =
      "specification/edgezones/resource-manager/Microsoft.EdgeZones/EdgeZones/tspconfig.yaml";
    mockFileStatuses([], { renames: [{ from: oldPath, to: newPath }] });
    // PR version: typescript namespace changed during rename
    const prContent = yaml.dump({
      options: {
        "@azure-tools/typespec-csharp": {
          namespace: "Azure.ResourceManager.EdgeZones",
        },
        "@azure-tools/typespec-ts": {
          namespace: "@azure/arm-edgezones-v2",
        },
      },
    });
    readFileMock.mockResolvedValue(prContent);
    // Base version: original typescript namespace
    const baseContent = yaml.dump({
      options: {
        "@azure-tools/typespec-csharp": {
          namespace: "Azure.ResourceManager.EdgeZones",
        },
        "@azure-tools/typespec-ts": {
          namespace: "@azure/arm-edgezones",
        },
      },
    });
    execFileMock.mockImplementation(
      (
        /** @type {string} */ _cmd,
        /** @type {string[]} */ args,
        /** @type {(err: Error | null, stdout: string, stderr: string) => void} */ cb,
      ) => {
        // Verify git show is called with the OLD path, not the new path
        expect(args[1]).toContain(oldPath);
        expect(args[1]).not.toContain("Microsoft.EdgeZones");
        cb(null, baseContent, "");
      },
    );

    await detectNamespaces(args());

    // Only typescript changed → should output results
    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    // dotnet unchanged
    expect(core.info).toHaveBeenCalledWith(
      expect.stringContaining("Namespace unchanged for dotnet"),
    );
  });

  it("should treat additions as new files (no base comparison)", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 51 }, action: "opened" };
    const file = "specification/newservice/NewService/tspconfig.yaml";
    mockFileStatuses([], { additions: [file] });
    readFileMock.mockResolvedValue(
      yaml.dump({
        options: {
          "@azure-tools/typespec-java": {
            namespace: "com.azure.newservice",
          },
        },
      }),
    );
    // git show should NOT be called for additions
    mockGitShowNotFound();

    await detectNamespaces(args());

    // New file → all namespaces reported
    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });
});
