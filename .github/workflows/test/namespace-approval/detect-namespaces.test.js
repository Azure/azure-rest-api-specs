/* eslint-disable @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access */
import { execFile } from "child_process";
import { existsSync } from "fs";
import { readFile, writeFile } from "fs/promises";
import { describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore } from "../mocks.js";

// Mock fs/promises for readFile (metadata JSON) and writeFile (results)
vi.mock("fs/promises", async (importOriginal) => {
  /** @type {typeof import("fs/promises")} */
  const actual = /** @type {any} */ (await importOriginal());
  return {
    ...actual,
    readFile: vi.fn(),
    writeFile: vi.fn(),
  };
});

// Mock fs.existsSync for metadata output and base-ref path checks
vi.mock("fs", async (importOriginal) => {
  /** @type {typeof import("fs")} */
  const actual = /** @type {any} */ (await importOriginal());
  return {
    ...actual,
    existsSync: vi.fn().mockReturnValue(true),
  };
});

// Mock child_process.execFile for npx tsp compile
vi.mock("child_process", () => ({
  execFile: vi.fn(
    (
      /** @type {string} */ _cmd,
      /** @type {string[]} */ _args,
      /** @type {object | ((err: Error | null, stdout: string, stderr: string) => void)} */ cbOrOpts,
      /** @type {((err: Error | null, stdout: string, stderr: string) => void) | undefined} */ maybeCb,
    ) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    },
  ),
}));

// Mock getChangedFilesStatuses
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
  validateAllNamespaces: vi.fn().mockReturnValue([]),
}));

// Import after mocks
const { default: detectNamespaces } =
  await import("../../src/namespace-approval/detect-namespaces.js");
const { getChangedFilesStatuses } = await import("../../../shared/src/changed-files.js");

/** @type {import("vitest").Mock} */
const readFileMock = /** @type {any} */ (readFile);
/** @type {import("vitest").Mock} */
const writeFileMock = /** @type {any} */ (writeFile);
/** @type {import("vitest").Mock} */
const getChangedFilesStatusesMock = /** @type {any} */ (getChangedFilesStatuses);
/** @type {import("vitest").Mock} */
const execFileMock = /** @type {any} */ (execFile);
/** @type {import("vitest").Mock} */
const existsSyncMock = /** @type {any} */ (existsSync);

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
 * Helper to mock getChangedFilesStatuses.
 * @param {string[]} modifications
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

/**
 * Create a metadata JSON response as the emitter would produce.
 * @param {Record<string, Array<{packageName: string, namespace?: string}>>} languages
 * @param {"management" | "data"} type
 * @returns {string}
 */
function makeMetadataJson(languages, type) {
  return JSON.stringify({
    emitterVersion: "0.2.1",
    generatedAt: "2025-01-01T00:00:00Z",
    typespec: { namespace: "Test", type },
    languages,
    sourceConfigPath: "/test/tspconfig.yaml",
  });
}

describe("detect-namespaces (dual tsp compile)", () => {
  process.env.RUNNER_TEMP = process.env.RUNNER_TEMP ?? "/tmp";
  process.env.BASE_REF_DIR = "/base-ref";

  it("should detect management plane package names via tsp compile", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 42 }, action: "opened" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);

    // existsSync: true for metadata output, false for base-ref tspconfig (new file)
    existsSyncMock.mockImplementation((/** @type {string} */ path) => {
      if (path.includes("base-ref")) return false;
      return true; // metadata JSON exists
    });

    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });

    readFileMock.mockResolvedValue(
      makeMetadataJson(
        {
          csharp: [
            {
              packageName: "Azure.ResourceManager.Compute",
              namespace: "Azure.ResourceManager.Compute",
            },
          ],
          java: [
            {
              packageName: "azure-resourcemanager-compute",
              namespace: "com.azure.resourcemanager.compute",
            },
          ],
          python: [{ packageName: "azure-mgmt-compute", namespace: "azure.mgmt.compute" }],
          typescript: [{ packageName: "@azure/arm-compute", namespace: "Azure.Compute" }],
        },
        "management",
      ),
    );

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    const writtenJson = String(writeFileMock.mock.lastCall?.[1]);
    const results = JSON.parse(writtenJson);
    expect(results.isMgmt).toBe(true);
    expect(results.namespacesFound.dotnet).toBe("Azure.ResourceManager.Compute");
    expect(results.namespacesFound.java).toBe("azure-resourcemanager-compute");
    expect(results.namespacesFound.python).toBe("azure-mgmt-compute");
    expect(results.namespacesFound.typescript).toBe("@azure/arm-compute");
  });

  it("should detect data plane package names", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 43 }, action: "opened" };
    const file = "specification/eventgrid/EventGrid/tspconfig.yaml";
    mockFileStatuses([file]);

    existsSyncMock.mockImplementation((/** @type {string} */ path) => {
      if (path.includes("base-ref")) return false;
      return true;
    });
    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });
    readFileMock.mockResolvedValue(
      makeMetadataJson(
        {
          java: [
            {
              packageName: "azure-messaging-eventgrid",
              namespace: "com.azure.messaging.eventgrid",
            },
          ],
          python: [{ packageName: "azure-eventgrid", namespace: "azure.eventgrid" }],
          typescript: [{ packageName: "@azure/eventgrid", namespace: "Azure.EventGrid" }],
        },
        "data",
      ),
    );

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    const writtenJson = String(writeFileMock.mock.lastCall?.[1]);
    const results = JSON.parse(writtenJson);
    expect(results.isDataPlane).toBe(true);
    expect(results.isMgmt).toBe(false);
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

  it("should filter unchanged package names using dual tsp compile", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 47 }, action: "synchronize" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);

    // Both base-ref tspconfig and metadata output exist
    existsSyncMock.mockReturnValue(true);

    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });

    // readFile is called twice: once for PR metadata, once for base metadata
    // Both return the same package names = unchanged
    readFileMock.mockResolvedValue(
      makeMetadataJson(
        {
          csharp: [
            {
              packageName: "Azure.ResourceManager.Compute",
              namespace: "Azure.ResourceManager.Compute",
            },
          ],
          java: [
            {
              packageName: "azure-resourcemanager-compute",
              namespace: "com.azure.resourcemanager.compute",
            },
          ],
        },
        "management",
      ),
    );

    await detectNamespaces(args());

    expect(core.setOutput).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "No package name changes detected after comparing with base branch",
    );
  });

  it("should detect only the language whose package name changed", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 48 }, action: "synchronize" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);

    existsSyncMock.mockReturnValue(true);
    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });

    // PR has updated typescript package name; base has original
    let readCount = 0;
    readFileMock.mockImplementation(() => {
      readCount++;
      if (readCount === 1) {
        // PR head result
        return Promise.resolve(
          makeMetadataJson(
            {
              csharp: [
                {
                  packageName: "Azure.ResourceManager.Compute",
                  namespace: "Azure.ResourceManager.Compute",
                },
              ],
              typescript: [{ packageName: "@azure/arm-compute-v2", namespace: "Azure.Compute" }],
            },
            "management",
          ),
        );
      }
      // Base result
      return Promise.resolve(
        makeMetadataJson(
          {
            csharp: [
              {
                packageName: "Azure.ResourceManager.Compute",
                namespace: "Azure.ResourceManager.Compute",
              },
            ],
            typescript: [{ packageName: "@azure/arm-compute", namespace: "Azure.Compute" }],
          },
          "management",
        ),
      );
    });

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    expect(core.info).toHaveBeenCalledWith(
      expect.stringContaining("Package name unchanged for dotnet"),
    );
    const writtenJson = String(writeFileMock.mock.lastCall?.[1]);
    const results = JSON.parse(writtenJson);
    expect(results.namespacesFound.typescript).toBe("@azure/arm-compute-v2");
    expect(results.namespacesFound.dotnet).toBeUndefined();
  });

  it("should treat additions as new files (no base comparison)", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 51 }, action: "opened" };
    const file = "specification/newservice/NewService/tspconfig.yaml";
    mockFileStatuses([], { additions: [file] });

    existsSyncMock.mockImplementation((/** @type {string} */ path) => {
      if (path.includes("base-ref")) return false;
      return true;
    });
    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });
    readFileMock.mockResolvedValue(
      makeMetadataJson(
        {
          java: [{ packageName: "azure-newservice", namespace: "com.azure.newservice" }],
        },
        "data",
      ),
    );

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it("should handle base compile failure gracefully (treat as new)", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 53 }, action: "synchronize" };
    const file = "specification/compute/Compute.Management/tspconfig.yaml";
    mockFileStatuses([file]);

    existsSyncMock.mockImplementation((/** @type {string} */ path) => {
      if (path.includes("base-ref") && path.includes("typespec-metadata.json")) {
        return false; // base compile output missing
      }
      return true; // base tspconfig exists, PR metadata exists
    });

    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });
    readFileMock.mockResolvedValue(
      makeMetadataJson(
        {
          csharp: [
            {
              packageName: "Azure.ResourceManager.Compute",
              namespace: "Azure.ResourceManager.Compute",
            },
          ],
        },
        "management",
      ),
    );

    await detectNamespaces(args());

    // Base failed, so treat all as new
    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining("Failed to compile base"));
  });

  it("should map csharp to dotnet in language keys", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 52 }, action: "opened" };
    const file = "specification/test/Test/tspconfig.yaml";
    mockFileStatuses([], { additions: [file] });

    existsSyncMock.mockImplementation((/** @type {string} */ path) => {
      if (path.includes("base-ref")) return false;
      return true;
    });
    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });
    readFileMock.mockResolvedValue(
      makeMetadataJson(
        {
          csharp: [{ packageName: "Azure.Test", namespace: "Azure.Test" }],
          "http-client-csharp": [{ packageName: "Azure.Test", namespace: "Azure.Test" }],
        },
        "data",
      ),
    );

    await detectNamespaces(args());

    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    const writtenJson = String(writeFileMock.mock.lastCall?.[1]);
    const results = JSON.parse(writtenJson);
    expect(results.namespacesFound.dotnet).toBe("Azure.Test");
  });

  it("should use basePath from rename for base compilation", async () => {
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 54 }, action: "opened" };
    const oldPath = "specification/edgezones/resource-manager/tspconfig.yaml";
    const newPath =
      "specification/edgezones/resource-manager/Microsoft.EdgeZones/EdgeZones/tspconfig.yaml";
    mockFileStatuses([], { renames: [{ from: oldPath, to: newPath }] });

    // base-ref has the OLD path, not the new path
    existsSyncMock.mockImplementation((/** @type {string} */ path) => {
      if (path.includes("base-ref") && path.includes(oldPath)) return true;
      if (path.includes("base-ref") && path.includes("Microsoft.EdgeZones")) return false;
      return true; // metadata outputs
    });
    execFileMock.mockImplementation((_cmd, _args, cbOrOpts, maybeCb) => {
      const cb = typeof cbOrOpts === "function" ? cbOrOpts : maybeCb;
      if (cb) cb(null, "", "");
    });
    // Both return same package names = unchanged
    readFileMock.mockResolvedValue(
      makeMetadataJson(
        {
          python: [{ packageName: "azure-mgmt-edgezones", namespace: "azure.mgmt.edgezones" }],
        },
        "management",
      ),
    );

    await detectNamespaces(args());

    // All unchanged
    expect(core.setOutput).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "No package name changes detected after comparing with base branch",
    );
  });
});
