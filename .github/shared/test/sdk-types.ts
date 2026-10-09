import { SdkName, type SpecGenSdkArtifactInfo } from "../src/sdk-types.ts";

/**
 * Create a mock SpecGenSdkArtifactInfo, filling unspecified properties with defaults.
 */
export function createMockSpecGenSdkArtifactInfo(
  overrides: Partial<import("../src/sdk-types.ts").SpecGenSdkArtifactInfo> = {},
): SpecGenSdkArtifactInfo {
  const defaults: SpecGenSdkArtifactInfo = {
    apiViewRequestData: [],
    headSha: "abc123",
    isSpecGenSdkCheckRequired: true,
    language: SdkName.Go,
    result: "test result",
  };

  return { ...defaults, ...overrides };
}
