import { describe, expect, it } from "vitest";
import { sdkLabels, SpecGenSdkArtifactInfoSchema } from "../src/sdk-types.ts";
import { createMockSpecGenSdkArtifactInfo } from "./sdk-types.ts";

describe("sdk-types", () => {
  it("defines management labels only for JavaScript", () => {
    expect(sdkLabels["azure-sdk-for-js"].management).toBe("mgmt-review-needed");
    expect(
      Object.entries(sdkLabels)
        .filter(([sdkName]) => sdkName !== "azure-sdk-for-js")
        .map(([, labels]) => labels.management),
    ).toEqual([undefined, undefined, undefined, undefined, undefined]);
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
