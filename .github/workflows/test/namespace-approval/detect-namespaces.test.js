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

// Mock getChangedFiles — path must match the import in detect-namespaces.js
vi.mock("../../../shared/src/changed-files.js", () => ({
  getChangedFiles: vi.fn().mockResolvedValue([]),
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
const { getChangedFiles } = await import("../../../shared/src/changed-files.js");

/** @type {import("vitest").Mock} */
const readFileMock = /** @type {any} */ (readFile);
/** @type {import("vitest").Mock} */
const getChangedFilesMock = /** @type {any} */ (getChangedFiles);

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

  it("should detect management plane namespaces from path", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 42 }, action: "opened" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    getChangedFilesMock.mockResolvedValue([file]);
    readFileMock.mockResolvedValue(mgmtTspconfig());

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it("should detect data plane from linter extends", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 43 }, action: "opened" };
    const file = "specification/eventgrid/EventGrid/tspconfig.yaml";
    getChangedFilesMock.mockResolvedValue([file]);
    readFileMock.mockResolvedValue(dataplaneTspconfig());

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it("should extract rust crate-name", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 44 }, action: "opened" };
    const file = "specification/storage/Storage/tspconfig.yaml";
    getChangedFilesMock.mockResolvedValue([file]);
    readFileMock.mockResolvedValue(rustTspconfig());

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it("should skip when no tspconfig.yaml changes detected", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 45 }, action: "opened" };
    getChangedFilesMock.mockResolvedValue(["specification/compute/readme.md"]);

    await detectNamespaces(args());

    expect(core.info).toHaveBeenCalledWith("No tspconfig.yaml changes detected, skipping");
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it("should handle tspconfig with no emitter options", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 46 }, action: "opened" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    getChangedFilesMock.mockResolvedValue([file]);
    readFileMock.mockResolvedValue(yaml.dump({ linter: {} }));

    await detectNamespaces(args());

    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("No emitter options found"));
  });
});
