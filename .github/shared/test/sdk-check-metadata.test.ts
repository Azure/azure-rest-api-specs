import { describe, expect, it } from "vitest";
import {
  nativeSdkBuildIdentity,
  parseSdkMetadata,
  SDK_METADATA_COLLECTION_URI,
  SDK_METADATA_MAX_TEXT_BYTES,
  sdkMetadataCheckName,
  sdkMetadataExternalId,
  serializeSdkMetadata,
} from "../src/sdk-check-metadata.ts";

const projectId = "11111111-2222-4333-8444-555555555555";
const build = {
  collectionUri: SDK_METADATA_COLLECTION_URI,
  projectId,
  definitionId: 123,
  buildId: 456,
  stageAttempt: 1,
  jobAttempt: 2,
  jobId: "22222222-3333-4444-8555-666666666666",
};
const envelope = {
  schemaVersion: 1,
  kind: "spec-gen-sdk-metadata",
  build,
  sourceCheck: {
    id: 789,
    name: "SDK Validation - JS - PR",
    startedAt: "2026-11-19T10:00:00Z",
    completedAt: "2026-11-19T10:10:00Z",
  },
  artifact: {
    headSha: "a".repeat(40),
    prNumber: "42",
    language: "azure-sdk-for-js",
    result: "failed",
    isSpecGenSdkCheckRequired: false,
    labelAction: true,
    apiViewRequestData: [
      { packageName: "widget", filePath: "api.json", future: { retained: true } },
    ],
    future: { nested: [1, false] },
  },
};
const native = {
  external_id: `123|456|${projectId}`,
  details_url: `${SDK_METADATA_COLLECTION_URI}internal/_build/results?buildId=456`,
};

describe("shared SDK metadata protocol", () => {
  it("round-trips the complete manifest without changing runtime signals or unknown extensions", () => {
    expect(parseSdkMetadata(serializeSdkMetadata(envelope))).toEqual(envelope);
    expect(sdkMetadataCheckName(build.definitionId)).toBe("SDK metadata / 123");
    expect(sdkMetadataExternalId(build)).toBe(`spec-gen-sdk-metadata:v1:${projectId}:123:456:1:2`);
  });

  it("enforces the same schema and UTF-8 byte budget when writing and reading", () => {
    const empty = { ...envelope, artifact: { ...envelope.artifact, padding: "" } };
    const bytes = Buffer.byteLength(serializeSdkMetadata(empty), "utf8");
    const exact = {
      ...empty,
      artifact: { ...empty.artifact, padding: "x".repeat(SDK_METADATA_MAX_TEXT_BYTES - bytes) },
    };
    const text = serializeSdkMetadata(exact);
    expect(Buffer.byteLength(text, "utf8")).toBe(SDK_METADATA_MAX_TEXT_BYTES);
    expect(parseSdkMetadata(text)).toEqual(exact);
    const tooLarge = {
      ...exact,
      artifact: { ...exact.artifact, padding: `${exact.artifact.padding}é` },
    };
    expect(() => serializeSdkMetadata(tooLarge)).toThrow("oversized");
    expect(() => parseSdkMetadata(JSON.stringify(tooLarge))).toThrow("oversized");
    const invalid = { ...envelope, artifact: { ...envelope.artifact, result: "future" } };
    expect(() => serializeSdkMetadata(invalid)).toThrow();
    expect(() => parseSdkMetadata(JSON.stringify(invalid))).toThrow();
  });

  it("binds named or GUID project URLs to the immutable native identity", () => {
    expect(nativeSdkBuildIdentity(native)).toEqual({
      projectId,
      definitionId: 123,
      buildId: 456,
      projectRef: "internal",
    });
    expect(
      nativeSdkBuildIdentity({
        ...native,
        details_url: `${SDK_METADATA_COLLECTION_URI}${projectId}/_build/results?buildId=456`,
      }).projectId,
    ).toBe(projectId);
  });

  it.each([
    { details_url: null },
    { external_id: null },
    { details_url: "https://example.com/azure-sdk/internal/_build/results?buildId=456" },
    { details_url: "https://user@dev.azure.com/azure-sdk/internal/_build/results?buildId=456" },
    { details_url: "https://:secret@dev.azure.com/azure-sdk/internal/_build/results?buildId=456" },
    { details_url: `${native.details_url}#fragment` },
    { details_url: `${SDK_METADATA_COLLECTION_URI}internal/_build/other?buildId=456` },
    { external_id: "123|456|bad" },
    { details_url: `${SDK_METADATA_COLLECTION_URI}${build.jobId}/_build/results?buildId=456` },
    { details_url: `${SDK_METADATA_COLLECTION_URI}internal/_build/results?buildId=999` },
    { details_url: `${native.details_url}&buildId=456` },
    { external_id: `9007199254740992|456|${projectId}` },
    {
      external_id: `123|9007199254740992|${projectId}`,
      details_url: `${SDK_METADATA_COLLECTION_URI}internal/_build/results?buildId=9007199254740992`,
    },
  ])("rejects unsafe or conflicting native build identity %#", (override) => {
    expect(() => nativeSdkBuildIdentity({ ...native, ...override })).toThrow();
  });
});
