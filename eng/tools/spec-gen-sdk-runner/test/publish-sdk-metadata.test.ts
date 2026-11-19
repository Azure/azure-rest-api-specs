import { describe, expect, it, vi } from "vitest";
import * as z from "zod";
import {
  encodeMetadata,
  publishSdkMetadata,
  type PublisherOptions,
} from "../src/publish-sdk-metadata.ts";

const headSha = "a".repeat(40);
const projectId = "11111111-1111-4111-8111-111111111111";
const stageId = "22222222-2222-4222-8222-222222222222";
const jobId = "33333333-3333-4333-8333-333333333333";
const collectionUri = "https://dev.azure.com/azure-sdk/";
const detailsUrl = `${collectionUri}internal/_build/results?buildId=456`;
const startedAt = "2026-01-01T00:00:00Z";
const completedAt = "2026-01-01T01:00:00Z";
const identity = {
  collectionUri,
  projectId,
  definitionId: 123,
  buildId: 456,
  stageAttempt: 1,
  jobAttempt: 1,
  jobId,
};
const sourceCheck = { id: 789, name: ".NET", startedAt, completedAt };
const manifest = {
  language: "azure-sdk-for-net",
  result: "failed",
  headSha,
  prNumber: "7",
  isSpecGenSdkCheckRequired: true,
  labelAction: true,
  apiViewRequestData: [
    {
      packageName: "Azure.Widget",
      filePath: "Azure.Widget.nupkg",
      futureNestedField: { retain: true },
    },
  ],
  futureField: { retain: [1, false] },
};
const nativeCheck = {
  id: 789,
  name: ".NET",
  head_sha: headSha,
  external_id: `123|456|${projectId}`,
  details_url: detailsUrl,
  status: "completed",
  conclusion: "failure",
  started_at: startedAt,
  completed_at: completedAt,
  app: { id: 9426, slug: "azure-pipelines" },
  output: {},
};

function harness() {
  const build = {
    id: 456,
    definition: { id: 123 },
    project: { id: projectId, name: "internal" },
    repository: { type: "GitHub", name: "Azure/azure-rest-api-specs-pr" },
    reason: "pullRequest",
    status: "completed",
    triggerInfo: { "pr.sourceSha": headSha, "pr.number": "7" },
  };
  const timeline = {
    records: [
      { id: stageId, type: "Stage", identifier: "Build", attempt: 1, state: "completed" },
      {
        id: jobId,
        parentId: stageId,
        type: "Job",
        attempt: 1,
        state: "completed",
        finishTime: "2026-01-01T00:59:00Z",
      },
    ],
  };
  const artifact = {
    name: "spec-gen-sdk-metadata-1-1",
    source: jobId,
    resource: {
      downloadUrl: `${collectionUri}${projectId}/_apis/build/builds/456/artifacts?artifactName=spec-gen-sdk-metadata-1-1&%24format=zip`,
    },
  };
  const state = {
    build,
    timeline,
    artifacts: [artifact],
    manifest: JSON.stringify(manifest),
    checks: [structuredClone(nativeCheck)],
    posts: [] as Record<string, unknown>[],
    writerAppId: 777,
    changeDuringDownload: false,
    failWrite: false,
    downloadStatus: 200,
  };
  const fetchImpl = vi.fn<typeof fetch>(async (input, init) => {
    const request = new Request(input, init);
    const url = new URL(request.url);
    if (request.method === "POST") {
      state.posts.push(z.record(z.string(), z.unknown()).parse(JSON.parse(await request.text())));
      if (state.failWrite) return new Response(null, { status: 403 });
      const body = state.posts.at(-1)!;
      const check = {
        ...body,
        id: 900,
        app: { id: state.writerAppId, slug: "sdk-metadata-writer" },
        started_at: startedAt,
        completed_at: completedAt,
      };
      return Response.json(check, { status: 201 });
    }
    if (url.pathname === "/installation/repositories") {
      return Response.json({
        total_count: 1,
        repositories: [{ full_name: "Azure/azure-rest-api-specs-pr" }],
      });
    }
    if (url.pathname.endsWith("/check-runs"))
      return Response.json({
        check_runs: [
          {
            ...nativeCheck,
            id: 700,
            name: "Unrelated action",
            app: { id: 15368, slug: "github-actions" },
            output: { title: null },
          },
          ...state.checks,
        ],
      });
    if (url.pathname.endsWith("/timeline"))
      return Response.json({
        records: [
          {
            id: "44444444-4444-4444-8444-444444444444",
            parentId: null,
            type: "Task",
            identifier: null,
            state: "completed",
          },
          ...state.timeline.records,
        ],
      });
    if (url.pathname.endsWith("/artifacts")) {
      if (url.searchParams.get("format") === "file") {
        if (state.changeDuringDownload) state.timeline.records[1].attempt++;
        return new Response(state.manifest, { status: state.downloadStatus });
      }
      return Response.json({ value: state.artifacts });
    }
    if (url.pathname.endsWith("/builds/456")) return Response.json(state.build);
    throw new Error(`Unexpected mock request: ${url.pathname}`);
  });
  const options: PublisherOptions = {
    collectionUri,
    projectId,
    buildId: 456,
    allowedDefinitionIds: [123],
    publisherAppId: 777,
    adoToken: "mock-ado",
    githubToken: "mock-github",
    fetchImpl,
  };
  return { state, options, fetchImpl };
}

describe("SDK metadata transport", () => {
  it("preserves the full manifest, nested extensions, runtime required flag and failure result", () => {
    const text = encodeMetadata(JSON.stringify(manifest), identity, sourceCheck, headSha, "7");
    expect(JSON.parse(text)).toEqual({
      schemaVersion: 1,
      kind: "spec-gen-sdk-metadata",
      build: identity,
      sourceCheck,
      artifact: manifest,
    });
  });

  it("measures the complete envelope in UTF-8 bytes and never truncates it", () => {
    const base = Buffer.byteLength(
      encodeMetadata(
        JSON.stringify({ ...manifest, padding: "" }),
        identity,
        sourceCheck,
        headSha,
        "7",
      ),
    );
    const exact = { ...manifest, padding: "x".repeat(65_535 - base) };
    expect(
      Buffer.byteLength(encodeMetadata(JSON.stringify(exact), identity, sourceCheck, headSha, "7")),
    ).toBe(65_535);
    expect(() =>
      encodeMetadata(
        JSON.stringify({ ...exact, padding: `${exact.padding}x` }),
        identity,
        sourceCheck,
        headSha,
        "7",
      ),
    ).toThrow("65,535");
    expect(() =>
      encodeMetadata(
        JSON.stringify({ ...manifest, padding: "é".repeat(33_000) }),
        identity,
        sourceCheck,
        headSha,
        "7",
      ),
    ).toThrow("65,535");
  });

  it("creates a neutral metadata check even when SDK generation failed", async () => {
    const { state, options, fetchImpl } = harness();
    await expect(publishSdkMetadata(options)).resolves.toBe("created");
    expect(state.posts).toHaveLength(1);
    expect(state.posts[0]).toMatchObject({
      name: "SDK metadata / 123",
      head_sha: headSha,
      details_url: detailsUrl,
      external_id: `spec-gen-sdk-metadata:v1:${projectId}:123:456:1:1`,
      status: "completed",
      conclusion: "neutral",
      output: { text: encodeMetadata(state.manifest, identity, sourceCheck, headSha, "7") },
    });
    expect(fetchImpl.mock.calls.some(([, init]) => init?.method === "PATCH")).toBe(false);
    const fileRead = fetchImpl.mock.calls.find(([url]) =>
      new Request(url).url.includes("format=file"),
    );
    expect(new Request(fileRead![0]).url).not.toContain("%24format");
  });

  it("does not emit another completed event for identical redelivery and rejects conflicts", async () => {
    const { state, options } = harness();
    const text = encodeMetadata(state.manifest, identity, sourceCheck, headSha, "7");
    state.checks.push({
      ...nativeCheck,
      id: 900,
      name: "SDK metadata / 123",
      external_id: `spec-gen-sdk-metadata:v1:${projectId}:123:456:1:1`,
      app: { id: 777, slug: "sdk-metadata-writer" },
      conclusion: "neutral",
      output: {
        text,
        summary:
          "Full SDK generation manifest for native check 789, build 456, stage attempt 1, job attempt 1. This neutral check reports metadata transport, not generation success.",
      },
    });
    await expect(publishSdkMetadata(options)).resolves.toBe("unchanged");
    expect(state.posts).toHaveLength(0);
    state.manifest = JSON.stringify({ ...manifest, isSpecGenSdkCheckRequired: false });
    await expect(publishSdkMetadata(options)).rejects.toThrow("Conflicting publication");
    expect(state.posts).toHaveLength(0);
  });

  it.each(["missing", "invalid", "oversized", "wrong-head", "wrong-pr", "wrong-job"] as const)(
    "publishes visible failure without partial JSON for %s metadata",
    async (failure) => {
      const { state, options } = harness();
      if (failure === "missing") state.artifacts = [];
      if (failure === "invalid") state.manifest = '{"language":"invalid"}';
      if (failure === "oversized")
        state.manifest = JSON.stringify({ ...manifest, extra: "x".repeat(65_535) });
      if (failure === "wrong-head")
        state.manifest = JSON.stringify({ ...manifest, headSha: "b".repeat(40) });
      if (failure === "wrong-pr") state.manifest = JSON.stringify({ ...manifest, prNumber: "8" });
      if (failure === "wrong-job") state.artifacts[0].source = stageId;
      await expect(publishSdkMetadata(options)).rejects.toThrow("SDK metadata unavailable");
      expect(state.posts).toHaveLength(1);
      expect(state.posts[0]).toMatchObject({ conclusion: "failure" });
      expect(state.posts[0].output).not.toHaveProperty("text");
    },
  );

  it("uses the current source attempt and does not fall back to a stale artifact", async () => {
    const { state, options } = harness();
    state.timeline.records[1].attempt = 2;
    await expect(publishSdkMetadata(options)).rejects.toThrow("SDK metadata unavailable");
    expect(state.posts[0].external_id).toBe(`spec-gen-sdk-metadata:v1:${projectId}:123:456:1:2`);
    expect(state.posts[0]).toMatchObject({ conclusion: "failure" });
    state.artifacts[0].name = "spec-gen-sdk-metadata-1-2";
    state.artifacts[0].resource.downloadUrl = state.artifacts[0].resource.downloadUrl.replaceAll(
      "metadata-1-1",
      "metadata-1-2",
    );
    state.posts = [];
    await expect(publishSdkMetadata(options)).resolves.toBe("created");
    expect(JSON.parse((state.posts[0].output as { text: string }).text)).toMatchObject({
      build: { jobAttempt: 2 },
    });
  });

  it("refuses publication if the source retries while the manifest is downloaded", async () => {
    const { state, options } = harness();
    state.changeDuringDownload = true;
    await expect(publishSdkMetadata(options)).rejects.toThrow("changed during");
    expect(state.posts).toHaveLength(0);
  });

  it.each([
    "allowlist",
    "repository",
    "reader-app",
    "native-owner",
    "native-build",
    "native-time",
    "native-running",
  ] as const)("fails closed before writing for an untrusted or ambiguous %s", async (failure) => {
    const { state, options } = harness();
    if (failure === "allowlist") options.allowedDefinitionIds = [];
    if (failure === "repository") state.build.repository.name = "Azure/azure-rest-api-specs";
    if (failure === "reader-app") options.publisherAppId = 1086291;
    if (failure === "native-owner") state.checks[0].app.id = 777;
    if (failure === "native-build") state.checks[0].external_id = `124|456|${projectId}`;
    if (failure === "native-time") state.checks[0].completed_at = startedAt;
    if (failure === "native-running") state.checks[0].status = "in_progress";
    await expect(publishSdkMetadata(options)).rejects.toThrow();
    expect(state.posts).toHaveLength(0);
  });

  it("surfaces API write failures without retrying an uncertain POST", async () => {
    const { state, options } = harness();
    state.failWrite = true;
    await expect(publishSdkMetadata(options)).rejects.toThrow("creation failed (403)");
    expect(state.posts).toHaveLength(1);
  });

  it("can retry a transient manifest download failure without consuming the check identity", async () => {
    const { state, options } = harness();
    state.downloadStatus = 503;
    await expect(publishSdkMetadata(options)).rejects.toThrow("Failed to fetch artifact file");
    expect(state.posts).toHaveLength(0);
    state.downloadStatus = 200;
    await expect(publishSdkMetadata(options)).resolves.toBe("created");
    expect(state.posts).toHaveLength(1);
  });

  it("verifies the created companion belongs to the configured writer App", async () => {
    const { state, options } = harness();
    state.writerAppId = 778;
    await expect(publishSdkMetadata(options)).rejects.toThrow("unexpected GitHub App");
  });
});
