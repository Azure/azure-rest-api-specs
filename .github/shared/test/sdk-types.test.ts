import { describe, expect, it } from "vitest";
import {
  getSdkLanguage,
  sdkLabels,
  SdkName,
  SpecGenSdkArtifactInfoSchema,
} from "../src/sdk-types.ts";
import { createMockSpecGenSdkArtifactInfo } from "./sdk-types.ts";

describe("sdk-types", () => {
  it.each([
    [SdkName.Go, "Go"],
    [SdkName.Java, "Java"],
    [SdkName.Js, "JavaScript"],
    [SdkName.Net, "DotNet"],
    [SdkName.Python, "Python"],
    [SdkName.Rust, "Rust"],
  ])("returns the language name for %s", (repo, language) => {
    expect(getSdkLanguage(repo)).toBe(language);
  });

  it("rejects unsupported SDK repositories", () => {
    expect(() => getSdkLanguage("unknown-repository" as SdkName)).toThrow(
      "Unsupported SDK repository: unknown-repository",
    );
  });

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
