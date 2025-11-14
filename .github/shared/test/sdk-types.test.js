import { describe, expect, it } from "vitest";
import { sdkLabels, SpecGenSdkArtifactInfoSchema } from "../src/sdk-types.js";

/**
 * @typedef {import("../src/sdk-types.js").SpecGenSdkArtifactInfo} SpecGenSdkArtifactInfo
 */

/**
 * Create a mock SpecGenSdkArtifactInfo, filling unspecified properties with defaults.
 * @param {Partial<import("../src/sdk-types.js").SpecGenSdkArtifactInfo>} [overrides]
 * @returns {SpecGenSdkArtifactInfo}
 */
export function createMockSpecGenSdkArtifactInfo(overrides = {}) {
  /** @type {SpecGenSdkArtifactInfo} */
  const defaults = {
    apiViewRequestData: [],
    headSha: "abc123",
    isSpecGenSdkCheckRequired: true,
    language: "azure-sdk-for-go",
    result: "test result",
  };

  return { ...defaults, ...overrides };
}

describe("sdk-types", () => {
  it("defines sdkLabels", () => {
    // Ensures constant "sdkLabels" is considered "covered" by codecov
    expect(sdkLabels).toBeDefined();
  });

  it("parses SpecGetSdkArtifactInfo", () => {
    const artifactInfo = createMockSpecGenSdkArtifactInfo();

    const json = JSON.stringify(artifactInfo);
    expect(json).toMatchInlineSnapshot(
      `"{"apiViewRequestData":[],"headSha":"abc123","isSpecGenSdkCheckRequired":true,"language":"azure-sdk-for-go","result":"test result"}"`,
    );

    const parsed = SpecGenSdkArtifactInfoSchema.parse(JSON.parse(json));
    expect(parsed).toEqual(artifactInfo);
  });
});
