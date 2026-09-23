import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { checkEmitterEnabled } from "../src/emitter-check.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
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

  it("extracts configured package metadata from the shared helper", async () => {
    const result = metadata({
      python: [{ emitterName: "test-emitter", packageName: "test-package" }],
    });
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(result);
    await expect(checkEmitterEnabled("project", "azure-sdk-for-python")).resolves.toEqual({
      enabled: true,
      metadata: result,
      languageKey: "python",
      packageName: "test-package",
    });
    expect(generateTypeSpecMetadata).toHaveBeenCalledOnce();
    expect(vi.mocked(generateTypeSpecMetadata).mock.lastCall?.[0]).toBe("project");
    expect(vi.mocked(generateTypeSpecMetadata).mock.lastCall?.[1]?.logger).toBeDefined();
  });

  it.each<TypeSpecMetadata["languages"]>([{}, { python: [] }])(
    "returns disabled only after successfully reading metadata (%j)",
    async (languages) => {
      const result = metadata(languages);
      vi.mocked(generateTypeSpecMetadata).mockResolvedValue(result);
      await expect(checkEmitterEnabled("project", "azure-sdk-for-python")).resolves.toEqual({
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
  });
});
