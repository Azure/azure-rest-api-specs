import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { checkEmitterEnabled } from "../src/emitter-check.ts";
import { logMessage, LogLevel } from "../src/log.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));
vi.mock("../src/log.ts", async (importOriginal) => ({
  ...(await importOriginal<typeof import("../src/log.ts")>()),
  logMessage: vi.fn(),
}));

function metadata(languages: TypeSpecMetadata["languages"]): TypeSpecMetadata {
  return {
    emitterVersion: "0.4.0",
    generatedAt: "2026-01-01T00:00:00Z",
    typespec: { namespace: "Contoso", type: "data" },
    languages,
  };
}

describe("checkEmitterEnabled", () => {
  beforeEach(() => vi.resetAllMocks());

  it.each([
    ["python", "python"],
    ["java", "java"],
    ["net", "csharp"],
    ["net", "http-client-csharp"],
    ["net", "http-client-csharp-mgmt"],
    ["js", "typescript"],
    ["go", "go"],
    ["rust", "rust"],
    ["python-pr", "python"],
  ])("finds the %s repository's %s emitter", async (repo, languageKey) => {
    const result = metadata({
      [languageKey]: [
        { emitterName: "test-emitter", packageName: "test-package" },
        { emitterName: "second-emitter", packageName: "second-package" },
      ],
    });
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(result);
    await expect(checkEmitterEnabled("project", `azure-sdk-for-${repo}`)).resolves.toEqual({
      enabled: true,
      metadata: result,
      languageKey,
      packageName: "test-package",
    });
    expect(generateTypeSpecMetadata).toHaveBeenCalledOnce();
    expect(vi.mocked(generateTypeSpecMetadata).mock.lastCall?.[0]).toBe("project");
    expect(vi.mocked(generateTypeSpecMetadata).mock.lastCall?.[1]?.logger).toBeDefined();
  });

  it.each([
    ["azure-sdk-for-python", {}],
    ["azure-sdk-for-python", { python: [] }],
    ["unknown-repository", { python: [{ emitterName: "test-emitter" }] }],
  ])(
    "returns disabled only after successfully reading metadata (%s, %j)",
    async (repo, languages) => {
      const result = metadata(languages);
      vi.mocked(generateTypeSpecMetadata).mockResolvedValue(result);
      await expect(checkEmitterEnabled("project", repo)).resolves.toEqual({
        enabled: false,
        metadata: result,
        languageKey: undefined,
      });
    },
  );

  it("skips empty aliases and supports missing optional package names", async () => {
    const result = metadata({
      csharp: [],
      "http-client-csharp": [{ emitterName: "test-emitter" }],
    });
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(result);
    await expect(checkEmitterEnabled("project", "azure-sdk-for-net")).resolves.toEqual({
      enabled: true,
      metadata: result,
      languageKey: "http-client-csharp",
      packageName: undefined,
    });
  });

  it("does not turn metadata failures into disabled emitters", async () => {
    const error = new Error("metadata compiler diagnostic");
    vi.mocked(generateTypeSpecMetadata).mockRejectedValue(error);
    await expect(checkEmitterEnabled("project", "azure-sdk-for-python")).rejects.toBe(error);
    expect(logMessage).not.toHaveBeenCalled();
  });

  it("routes shared compiler logs through runner logging", async () => {
    vi.mocked(generateTypeSpecMetadata).mockImplementation((_folder, options) => {
      options?.logger?.warning("compiler warning");
      options?.logger?.debug("compiler details");
      options?.logger?.info("compiler command");
      options?.logger?.error("compiler error");
      expect(options?.logger?.isDebug()).toBe(true);
      return Promise.resolve(metadata({}));
    });
    await checkEmitterEnabled("project", "azure-sdk-for-python");
    expect(logMessage).toHaveBeenCalledWith("compiler warning", LogLevel.Warn);
    expect(logMessage).toHaveBeenCalledWith("compiler details", LogLevel.Debug);
    expect(logMessage).toHaveBeenCalledWith("compiler command", LogLevel.Info);
    expect(logMessage).toHaveBeenCalledWith("compiler error", LogLevel.Error);
  });
});
