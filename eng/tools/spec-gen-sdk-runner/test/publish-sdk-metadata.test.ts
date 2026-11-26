import { describe, expect, it, vi } from "vitest";
import { publishSdkMetadata } from "../src/publish-sdk-metadata.ts";

const manifest = {
  language: "azure-sdk-for-js",
  result: "failed",
  headSha: "a".repeat(40),
  prNumber: "7",
  labelAction: true,
  isSpecGenSdkCheckRequired: true,
  apiViewRequestData: [],
};

function publish(manifestText: string) {
  const fetchImpl = vi.fn<typeof fetch>(() => Promise.resolve(new Response(null, { status: 201 })));
  const promise = publishSdkMetadata({
    manifest: manifestText,
    repository: "Azure/azure-rest-api-specs-pr",
    collectionUri: "https://dev.azure.com/azure-sdk/",
    projectId: "p",
    definitionId: "7",
    buildId: "2",
    jobAttempt: "1",
    githubToken: "token",
    fetchImpl,
  });
  return { promise, fetchImpl };
}

describe("publishSdkMetadata", () => {
  it("creates a check that shares the Azure Pipelines check external_id and carries the manifest", async () => {
    const { promise, fetchImpl } = publish(JSON.stringify(manifest, undefined, 2));
    await promise;

    const [url, init] = fetchImpl.mock.calls[0];
    expect(url).toBe("https://api.github.com/repos/Azure/azure-rest-api-specs-pr/check-runs");
    expect(JSON.parse(init?.body as string)).toMatchObject({
      head_sha: manifest.headSha,
      external_id: "7|2|p",
      details_url: "https://dev.azure.com/azure-sdk/p/_build/results?buildId=2",
      status: "completed",
      conclusion: "neutral",
      output: { text: JSON.stringify(manifest) },
    });
  });

  it("rejects a manifest that doesn't fit in the check output", async () => {
    const { promise, fetchImpl } = publish(
      JSON.stringify({ ...manifest, padding: "x".repeat(65_535) }),
    );
    await expect(promise).rejects.toThrow("check output limit");
    expect(fetchImpl).not.toHaveBeenCalled();
  });
});
