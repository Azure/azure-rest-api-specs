import { existsSync } from "fs";
import { writeFile } from "fs/promises";
import { dirname, join, resolve } from "path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { getChangedFilesStatuses } from "../../../shared/src/changed-files.ts";
import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "../../../shared/src/typespec-metadata.ts";
import detectNamespaces from "../../src/package-name-approval/detect-namespaces.ts";
import {
  loadFormatRules,
  validateAllNamespaces,
} from "../../src/package-name-approval/validate-format.ts";
import { createMockContext, createMockCore } from "../mocks.ts";

vi.mock("fs/promises", async (importOriginal) => ({
  ...(await importOriginal<typeof import("fs/promises")>()),
  writeFile: vi.fn(),
}));
vi.mock("fs", async (importOriginal) => ({
  ...(await importOriginal<typeof import("fs")>()),
  existsSync: vi.fn(),
}));
vi.mock("../../../shared/src/typespec-metadata.ts", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));
vi.mock("../../../shared/src/changed-files.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../../../shared/src/changed-files.ts")>()),
  getChangedFilesStatuses: vi.fn(),
}));
vi.mock("../../src/package-name-approval/validate-format.ts", () => ({
  loadFormatRules: vi.fn(),
  validateAllNamespaces: vi.fn(),
}));

const file = "specification/compute/Compute.Management/tspconfig.yaml";
const workspace = resolve("head-checkout");
const baseRefDir = resolve("base-checkout");
const runnerTemp = resolve("runner-temp");
let core: ReturnType<typeof createMockCore>;
let context: ReturnType<typeof createMockContext>;

function args(): import("@actions/github-script").AsyncFunctionArguments {
  const input: Partial<import("@actions/github-script").AsyncFunctionArguments> = { context, core };
  return input as import("@actions/github-script").AsyncFunctionArguments;
}

function mockFileStatuses(
  modifications: string[],
  extra: { additions?: string[]; renames?: { from: string; to: string }[] } = {},
) {
  vi.mocked(getChangedFilesStatuses).mockResolvedValue({
    additions: extra.additions ?? [],
    modifications,
    deletions: [],
    renames: extra.renames ?? [],
    total: modifications.length + (extra.additions?.length ?? 0) + (extra.renames?.length ?? 0),
  });
}

function metadata(
  languages: Record<string, Array<{ packageName?: string; namespace?: string }>> = {
    csharp: [
      { packageName: "Azure.ResourceManager.Compute", namespace: "Azure.ResourceManager.Compute" },
    ],
  },
  type: "management" | "data" = "management",
): TypeSpecMetadata {
  return {
    emitterVersion: "0.4.0",
    generatedAt: "2026-01-01T00:00:00Z",
    typespec: { namespace: "Test", type },
    languages: Object.fromEntries(
      Object.entries(languages).map(([language, entries]) => [
        language,
        entries.map((entry) => ({ emitterName: `test-${language}`, ...entry })),
      ]),
    ),
  };
}

function writtenResults(): unknown {
  const data = vi.mocked(writeFile).mock.lastCall?.[1];
  if (typeof data !== "string") throw new Error("Expected a JSON result artifact");
  return JSON.parse(data);
}

describe("detect-namespaces", () => {
  beforeEach(() => {
    vi.resetAllMocks();
    vi.stubEnv("GITHUB_WORKSPACE", workspace);
    vi.stubEnv("BASE_REF_DIR", baseRefDir);
    vi.stubEnv("RUNNER_TEMP", runnerTemp);
    core = createMockCore();
    context = createMockContext();
    context.payload = { pull_request: { number: 42 }, action: "opened" };
    vi.mocked(existsSync).mockReturnValue(true);
    vi.mocked(loadFormatRules).mockResolvedValue(null);
    vi.mocked(validateAllNamespaces).mockReturnValue([]);
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(metadata());
    mockFileStatuses([], { additions: [file] });
  });

  afterEach(() => vi.unstubAllEnvs());

  it("preserves the management-plane result artifact and language normalization", async () => {
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata({
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
        python: [{ packageName: "azure-mgmt-compute" }],
        typescript: [{ packageName: "@azure/arm-compute" }],
      }),
    );
    await detectNamespaces(args());
    const packageNames = {
      dotnet: "Azure.ResourceManager.Compute",
      java: "azure-resourcemanager-compute",
      python: "azure-mgmt-compute",
      typescript: "@azure/arm-compute",
    };
    const namespaces = {
      dotnet: "Azure.ResourceManager.Compute",
      java: "com.azure.resourcemanager.compute",
    };
    expect(writtenResults()).toEqual({
      namespacesFound: packageNames,
      namespaces,
      allConfiguredPackageNames: packageNames,
      allConfiguredNamespaces: namespaces,
      formatResults: [],
      isMgmt: true,
      isDataPlane: false,
      prNumber: 42,
      action: "opened",
    });
    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
    expect(core.setOutput).toHaveBeenCalledWith(
      "results_path",
      join(runnerTemp, "package-name-results.json"),
    );
  });

  it("detects data-plane names without running management-plane format validation", async () => {
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
      metadata(
        {
          python: [{ packageName: "azure-compute" }],
        },
        "data",
      ),
    );
    await detectNamespaces(args());
    expect(writtenResults()).toMatchObject({ isMgmt: false, isDataPlane: true });
    expect(validateAllNamespaces).not.toHaveBeenCalled();
  });

  it("skips unrelated changes", async () => {
    mockFileStatuses(["specification/compute/readme.md"]);
    await detectNamespaces(args());
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it.each(["main.tsp", "client.tsp"])(
    "passes the %s entrypoint, timeout, logger, and each checkout",
    async (entrypoint) => {
      mockFileStatuses([file]);
      if (entrypoint === "client.tsp") {
        vi.mocked(existsSync).mockImplementation((path) => !String(path).endsWith("main.tsp"));
      }
      await detectNamespaces(args());
      expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(2);
      for (const [index, checkout] of [workspace, baseRefDir].entries()) {
        const folder = dirname(join(checkout, file));
        expect(generateTypeSpecMetadata).toHaveBeenNthCalledWith(index + 1, folder, {
          entrypoint: join(folder, entrypoint),
          timeout: 120_000,
          logger: core,
        });
      }
      expect(core.setOutput).not.toHaveBeenCalled();
    },
  );

  it("skips a head project with neither entrypoint", async () => {
    vi.mocked(existsSync).mockReturnValue(false);
    await detectNamespaces(args());
    expect(generateTypeSpecMetadata).not.toHaveBeenCalled();
    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining("no main.tsp or client.tsp"));
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it("filters unchanged names while retaining all configured names in the artifact", async () => {
    mockFileStatuses([file]);
    vi.mocked(generateTypeSpecMetadata)
      .mockResolvedValueOnce(
        metadata({
          csharp: [{ packageName: "Azure.Compute" }],
          typescript: [{ packageName: "@azure/arm-compute-v2", namespace: "Azure.Compute" }],
        }),
      )
      .mockResolvedValueOnce(
        metadata({
          csharp: [{ packageName: "Azure.Compute" }],
          typescript: [{ packageName: "@azure/arm-compute" }],
        }),
      );
    await detectNamespaces(args());
    expect(writtenResults()).toMatchObject({
      namespacesFound: { typescript: "@azure/arm-compute-v2" },
      namespaces: { typescript: "Azure.Compute" },
      allConfiguredPackageNames: { dotnet: "Azure.Compute", typescript: "@azure/arm-compute-v2" },
    });
    expect(core.info).toHaveBeenCalledWith(
      expect.stringContaining("Package name unchanged for dotnet"),
    );
  });

  it("does not compile a base version for additions", async () => {
    await detectNamespaces(args());
    expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(1);
    expect(core.setOutput).toHaveBeenCalledWith("results", "true");
  });

  it.each(["missing config", "missing entrypoint", "compile failure"])(
    "treats base %s as new",
    async (reason) => {
      mockFileStatuses([file]);
      vi.mocked(existsSync).mockImplementation((path) => {
        if (!String(path).startsWith(baseRefDir)) return true;
        return (
          reason === "compile failure" ||
          (reason === "missing entrypoint" && String(path).endsWith("tspconfig.yaml"))
        );
      });
      if (reason === "compile failure") {
        vi.mocked(generateTypeSpecMetadata)
          .mockResolvedValueOnce(metadata())
          .mockRejectedValueOnce(new Error("base compiler diagnostic"));
      }
      await detectNamespaces(args());
      expect(core.setOutput).toHaveBeenCalledWith("results", "true");
      if (reason === "compile failure") {
        expect(core.warning).toHaveBeenCalledWith(
          expect.stringContaining("base compiler diagnostic"),
        );
      } else {
        expect(generateTypeSpecMetadata).toHaveBeenCalledTimes(1);
      }
    },
  );

  it("propagates head failures without publishing successful results", async () => {
    const error = new Error("head compiler diagnostic");
    vi.mocked(generateTypeSpecMetadata).mockRejectedValue(error);
    await expect(detectNamespaces(args())).rejects.toBe(error);
    expect(writeFile).not.toHaveBeenCalled();
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it.each(["csharp", "http-client-csharp", "http-client-csharp-mgmt"])(
    "normalizes %s and ignores empty or unnamed entries",
    async (language) => {
      vi.mocked(generateTypeSpecMetadata).mockResolvedValue(
        metadata({
          [language]: [{ packageName: "Azure.Compute" }],
          python: [],
          java: [{}],
        }),
      );
      await detectNamespaces(args());
      expect(writtenResults()).toMatchObject({ namespacesFound: { dotnet: "Azure.Compute" } });
    },
  );

  it("uses the old path for a renamed base project", async () => {
    const oldPath = "specification/compute/old/tspconfig.yaml";
    mockFileStatuses([], { renames: [{ from: oldPath, to: file }] });
    await detectNamespaces(args());
    const baseFolder = dirname(join(baseRefDir, oldPath));
    expect(generateTypeSpecMetadata).toHaveBeenNthCalledWith(2, baseFolder, {
      entrypoint: join(baseFolder, "main.tsp"),
      timeout: 120_000,
      logger: core,
    });
    expect(core.setOutput).not.toHaveBeenCalled();
  });
});
