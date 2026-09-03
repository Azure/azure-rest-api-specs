import { describe, expect, it } from "vitest";
import { sdkLabels, SdkChangeSchema, SpecGenSdkArtifactInfoSchema } from "../src/sdk-types.js";
import { createMockSpecGenSdkArtifactInfo } from "./sdk-types.js";

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

  it("requires SDK change Markdown and breaking-change status", () => {
    const sdkChange = { changes: "Removed operation", hasBreakingChange: true };

    expect(SdkChangeSchema.parse(sdkChange)).toEqual(sdkChange);
    expect(SdkChangeSchema.safeParse({ changes: sdkChange.changes }).success).toBe(false);
    expect(SdkChangeSchema.safeParse({ hasBreakingChange: true }).success).toBe(false);
  });
});
