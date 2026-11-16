import {
  generateTypeSpecMetadata,
  type TypeSpecMetadata,
} from "@azure-tools/specs-shared/typespec-metadata";
import { beforeEach, describe, expect, test, vi } from "vitest";
import { checkEmitterEnabled } from "../src/emitter-check.ts";

vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: vi.fn(),
}));

const metadata: TypeSpecMetadata = {
  emitterVersion: "0.4.2",
  generatedAt: "2026-11-16T00:00:00Z",
  typespec: { namespace: "Contoso", type: "management" },
  languages: {
    "http-client-csharp-mgmt": [
      {
        emitterName: "@azure-typespec/http-client-csharp-mgmt",
        packageName: "Azure.ResourceManager.Contoso",
      },
    ],
  },
};

describe("checkEmitterEnabled", () => {
  beforeEach(() => {
    vi.mocked(generateTypeSpecMetadata).mockReset();
  });

  test("selects the configured management emitter for a private SDK repository", async () => {
    vi.mocked(generateTypeSpecMetadata).mockResolvedValue(metadata);

    await expect(checkEmitterEnabled("/spec/project", "azure-sdk-for-net-pr")).resolves.toEqual({
      enabled: true,
      metadata,
      languageKey: "http-client-csharp-mgmt",
      packageName: "Azure.ResourceManager.Contoso",
    });
  });

  test.each<TypeSpecMetadata["languages"]>([{}, { go: [] }])(
    "skips a language without configured emitters (%j)",
    async (languages) => {
      vi.mocked(generateTypeSpecMetadata).mockResolvedValue({ ...metadata, languages });

      expect(await checkEmitterEnabled("/spec/project", "azure-sdk-for-go")).toMatchObject({
        enabled: false,
      });
    },
  );

  test("propagates metadata failures instead of treating them as disabled emitters", async () => {
    const error = new Error("Failed to generate TypeSpec metadata: compilation failed");
    vi.mocked(generateTypeSpecMetadata).mockRejectedValue(error);

    await expect(checkEmitterEnabled("/spec/project", "azure-sdk-for-net")).rejects.toBe(error);
  });
});
