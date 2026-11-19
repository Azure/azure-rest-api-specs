import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { encodeMetadata } from "../../../eng/tools/spec-gen-sdk-runner/src/publish-sdk-metadata.ts";
import { SdkMetadataSchema } from "../../shared/src/sdk-check-metadata.ts";
import { createMockSpecGenSdkArtifactInfo } from "../../shared/test/sdk-types.ts";
import * as artifacts from "../src/artifacts.ts";
import type { CheckRuns } from "../src/github.ts";
import { LabelAction } from "../src/label.ts";
import { getLabelAndAction } from "../src/sdk-breaking-change-labels.ts";
import { readPrivateSdkArtifact } from "../src/sdk-check-metadata.ts";
import setStatus, { setSpecGenSdkStatusImpl } from "../src/spec-gen-sdk-status.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const HEAD = "a".repeat(40);
const PROJECT = "29ec6040-b234-4e31-b139-33dc4287b756";
const WRITER_APP_ID = 123456;
const repo = { owner: "Azure", repo: "azure-rest-api-specs-pr" };

function fixture() {
  const native = {
    id: 100,
    name: "SDK Validation - JS",
    app: { id: 9426, slug: "azure-pipelines", name: "Azure Pipelines" },
    head_sha: HEAD,
    external_id: `7518|456|${PROJECT}`,
    details_url: `https://dev.azure.com/azure-sdk/${PROJECT}/_build/results?buildId=456`,
    status: "completed",
    conclusion: "success",
    started_at: "2026-11-19T10:00:00Z",
    completed_at: "2026-11-19T10:10:00Z",
    pull_requests: [{ number: 42 }],
  } as CheckRuns[number];
  const envelope = {
    schemaVersion: 1,
    kind: "spec-gen-sdk-metadata",
    build: {
      collectionUri: "https://dev.azure.com/azure-sdk/",
      projectId: PROJECT,
      definitionId: 7518,
      buildId: 456,
      stageAttempt: 1,
      jobAttempt: 1,
      jobId: "a6ca1e11-41e7-4e3a-8c11-f5458ffb5253",
    },
    sourceCheck: {
      id: native.id,
      name: native.name,
      startedAt: native.started_at,
      completedAt: native.completed_at,
    },
    artifact: createMockSpecGenSdkArtifactInfo({
      headSha: HEAD,
      prNumber: "42",
      language: "azure-sdk-for-js",
      result: "succeeded",
      labelAction: false,
    }),
  };
  const metadata = {
    ...native,
    id: 200,
    name: "SDK metadata / 7518",
    app: { id: WRITER_APP_ID, slug: "dedicated-sdk-writer" },
    conclusion: "neutral",
    external_id: `spec-gen-sdk-metadata:v1:${PROJECT}:7518:456:1:1`,
    output: {
      title: "SDK metadata",
      summary: "Metadata published",
      text: JSON.stringify(envelope),
    },
  } as CheckRuns[number];
  return { native, metadata, envelope };
}

describe("private SDK check metadata consumers", () => {
  let github: ReturnType<typeof createMockGithub>;
  let core: ReturnType<typeof createMockCore>;
  let context: ReturnType<typeof createMockContext>;
  let sample: ReturnType<typeof fixture>;
  let ado: import("vitest").MockInstance<typeof artifacts.getAzurePipelineArtifact>;
  const fetchMock = vi.fn();

  function publish() {
    sample.metadata.output.text = JSON.stringify(sample.envelope);
  }

  function checks(values = [sample.native, sample.metadata]) {
    github.rest.checks.listForRef.mockResolvedValue({ data: { check_runs: values } });
  }

  async function status() {
    return setSpecGenSdkStatusImpl({
      ...repo,
      head_sha: HEAD,
      issue_number: 42,
      target_url: "https://github.com/actions/runs/1",
      github,
      core,
      eventCheckId: Number(sample.native.id),
    });
  }

  async function labels() {
    return getLabelAndAction({ github, core, context });
  }

  beforeEach(() => {
    github = createMockGithub();
    core = createMockCore();
    context = createMockContext();
    context.repo = repo;
    sample = fixture();
    context.payload.check_run = { id: sample.metadata.id, head_sha: HEAD };
    vi.stubEnv("SDK_METADATA_PUBLISHER_APP_ID", String(WRITER_APP_ID));
    ado = vi.spyOn(artifacts, "getAzurePipelineArtifact");
    fetchMock.mockReset();
    vi.stubGlobal("fetch", fetchMock);
    github.rest.pulls.get.mockResolvedValue({
      data: {
        number: 42,
        state: "open",
        head: { sha: HEAD },
        base: { ref: "main", repo: { full_name: "Azure/azure-rest-api-specs-pr" } },
      },
    });
    checks();
  });

  afterEach(() => {
    expect(ado).not.toHaveBeenCalled();
    expect(fetchMock).not.toHaveBeenCalled();
    vi.restoreAllMocks();
    vi.unstubAllEnvs();
    vi.unstubAllGlobals();
  });

  it("uses the complete manifest, not native conclusion, with runtime requiredness", async () => {
    sample.envelope.artifact.result = "failed";
    publish();
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({
        state: "failure",
        description: "SDK Validation failed for js languages",
      }),
    );
    sample.envelope.artifact.isSpecGenSdkCheckRequired = false;
    publish();
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "success" }),
    );
    expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining("❌ failed | false"));
    expect(core.setOutput).toHaveBeenCalledWith("issue_number", 42);
  });

  it("consumes the publisher's actual wire output without a second protocol definition", async () => {
    const artifact = {
      ...sample.envelope.artifact,
      result: "failed",
      isSpecGenSdkCheckRequired: false,
      labelAction: true,
      future: { preserve: [1, false] },
      apiViewRequestData: [{ packageName: "widget", filePath: "api.json", future: { keep: true } }],
    };
    sample.metadata.output.text = encodeMetadata(
      JSON.stringify(artifact),
      sample.envelope.build,
      SdkMetadataSchema.shape.sourceCheck.parse(sample.envelope.sourceCheck),
      HEAD,
      "42",
    );
    expect(readPrivateSdkArtifact(sample.native, [sample.metadata], 42)).toEqual(artifact);
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
      expect.objectContaining({ state: "success" }),
    );
    expect((await labels()).labelAction).toBe(LabelAction.Add);
  });

  it("accepts private native names ending in ' - PR' while retaining exact source binding", async () => {
    sample.native.name = "SDK Validation - JS - PR";
    sample.envelope.sourceCheck.name = sample.native.name;
    publish();
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success" }),
    );
    expect((await labels()).labelAction).toBe(LabelAction.Remove);

    sample.envelope.sourceCheck.name = "SDK Validation - JS";
    publish();
    await expect(labels()).rejects.toThrow("Stale or duplicate");
  });

  it("rejects unknown private native names instead of stripping arbitrary suffixes", async () => {
    sample.native.name = "SDK Validation - JS - PR unexpected";
    sample.envelope.sourceCheck.name = sample.native.name;
    publish();
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
    await expect(labels()).rejects.toThrow("identity or transport mismatch");
  });

  it("accepts named native project URLs and preserves complete manifest extensions", () => {
    sample.native.details_url = sample.native.details_url!.replace(PROJECT, "internal");
    sample.metadata.details_url = sample.native.details_url;
    Object.assign(sample.envelope.artifact, { futureField: { retain: true } });
    sample.envelope.artifact.apiViewRequestData = [
      Object.assign(
        { packageName: "Synthetic", filePath: "api.json" },
        { futureRequestField: true },
      ),
    ];
    publish();
    expect(readPrivateSdkArtifact(sample.native, [sample.metadata], 42)).toEqual(
      sample.envelope.artifact,
    );
  });

  it("rejects a conflicting project GUID in the native build URL", () => {
    sample.native.details_url = sample.native.details_url!.replace(
      PROJECT,
      "11111111-1111-4111-8111-111111111111",
    );
    expect(() => readPrivateSdkArtifact(sample.native, [sample.metadata], 42)).toThrow(
      "Invalid native SDK build identity",
    );
  });

  it.each([
    [true, "main", LabelAction.Add],
    [true, "RPSaaSMaster", LabelAction.Add],
    [true, "release", LabelAction.None],
    [false, "release", LabelAction.Remove],
    [undefined, "main", LabelAction.None],
  ])("retains labelAction=%s on target %s", async (action, branch, expected) => {
    sample.envelope.artifact.labelAction = action;
    publish();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        state: "open",
        head: { sha: HEAD },
        base: { ref: branch, repo: { full_name: "Azure/azure-rest-api-specs-pr" } },
      },
    });
    expect(await labels()).toEqual({
      labelName: "BreakingChange-JavaScript-Sdk",
      labelAction: expected,
      headSha: HEAD,
      issueNumber: 42,
    });
  });

  it("waits for native completion even when metadata arrives first", async () => {
    sample.native.status = "in_progress";
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "pending" }),
    );
    expect((await labels()).labelAction).toBe(LabelAction.None);
  });

  it.each(["pending", "inProgress"])(
    "does not leave a finished native build pending or remove labels for result %s",
    async (result) => {
      sample.envelope.artifact.result = result;
      publish();
      await status();
      expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: "failure" }),
      );
      await expect(labels()).rejects.toThrow("incomplete manifest");
    },
  );

  it.each(["warning", "notEnabled"])("preserves final result %s in the summary", async (result) => {
    sample.envelope.artifact.result = result;
    publish();
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success" }),
    );
    expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining(result));
  });

  it.each(["failure", "cancelled", "timed_out"] as const)(
    "fails closed for a finished %s native build without metadata, then recovers on publication",
    async (conclusion) => {
      sample.native.conclusion = conclusion;
      checks([sample.native]);
      context.payload.check_run = { id: sample.native.id, head_sha: HEAD };
      await status();
      expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
        expect.objectContaining({ state: "failure" }),
      );
      await expect(labels()).rejects.toThrow("Missing SDK metadata");
      expect(core.setOutput).toHaveBeenCalledWith("head_sha", HEAD);
      checks();
      context.payload.check_run = { id: sample.metadata.id, head_sha: HEAD };
      await status();
      expect(github.rest.repos.createCommitStatus).toHaveBeenLastCalledWith(
        expect.objectContaining({ state: "success" }),
      );
      expect((await labels()).labelAction).toBe(LabelAction.Remove);
    },
  );

  it("does not reuse metadata after a native retry updates the same check", async () => {
    sample.native.completed_at = "2026-11-19T11:00:00Z";
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
    await expect(labels()).rejects.toThrow("Stale or duplicate");
  });

  it("selects the newest native build and never falls back to an older successful build", async () => {
    const newer = {
      ...sample.native,
      id: 101,
      external_id: `7518|457|${PROJECT}`,
      details_url: sample.native.details_url?.replace("456", "457") ?? null,
    };
    checks([sample.native, sample.metadata, newer]);
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
  });

  it("ignores stale PR heads without exporting label decisions or commit statuses", async () => {
    github.rest.pulls.get.mockResolvedValue({
      data: {
        state: "open",
        head: { sha: "b".repeat(40) },
        base: { repo: { full_name: "Azure/azure-rest-api-specs-pr" } },
      },
    });
    await status();
    expect((await labels()).labelAction).toBe(LabelAction.None);
    expect(core.setOutput).not.toHaveBeenCalled();
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it.each(["", "1086291x", "0", "9007199254740992"])(
    "fails closed with invalid protected writer ID '%s'",
    async (value) => {
      vi.stubEnv("SDK_METADATA_PUBLISHER_APP_ID", value);
      await status();
      expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
        expect.objectContaining({ state: "failure" }),
      );
    },
  );

  it("ignores spoofed publisher names and rejects unauthenticated trigger IDs", async () => {
    sample.metadata.app = { ...sample.metadata.app!, id: 1086291 };
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
    await expect(labels()).rejects.toThrow("not an authenticated");
  });

  it("does not authenticate a native check by display name", async () => {
    sample.native.app = { ...sample.native.app!, id: 123 };
    await expect(status()).rejects.toThrow("not an authenticated");
    expect(github.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("handles identical duplicate events idempotently and rejects duplicate check identities", async () => {
    expect((await labels()).labelAction).toBe(LabelAction.Remove);
    expect((await labels()).labelAction).toBe(LabelAction.Remove);
    checks([sample.native, sample.metadata, { ...sample.metadata, id: 201 }]);
    await expect(labels()).rejects.toThrow("Stale or duplicate");
  });

  it.each([
    [
      "version",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.schemaVersion = 2;
      },
    ],
    [
      "PR",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.artifact.prNumber = "43";
      },
    ],
    [
      "head",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.artifact.headSha = "b".repeat(40);
      },
    ],
    [
      "language",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.artifact.language = "azure-sdk-for-go";
      },
    ],
    [
      "definition",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.build.definitionId = 123;
      },
    ],
    [
      "build",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.build.buildId = 123;
      },
    ],
    [
      "attempt",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.build.jobAttempt = 2;
      },
    ],
    [
      "native name",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.sourceCheck.name = "SDK Validation - Go";
      },
    ],
    [
      "native id",
      (s: ReturnType<typeof fixture>) => {
        s.envelope.sourceCheck.id = 99;
      },
    ],
  ])("rejects mismatched %s without producing a label removal", async (_name, mutate) => {
    mutate(sample);
    publish();
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
    await expect(labels()).rejects.toThrow();
  });

  it.each(["{invalid", "x".repeat(65_536), null])(
    "rejects malformed or oversized text",
    async (text) => {
      sample.metadata.output.text = text;
      await expect(labels()).rejects.toThrow();
    },
  );

  it("enforces the UTF-8 byte limit while accepting a complete manifest at the limit", () => {
    sample.envelope.artifact.apiViewRequestData = [{ packageName: "", filePath: "api.json" }];
    const bytes = Buffer.byteLength(JSON.stringify(sample.envelope), "utf8");
    sample.envelope.artifact.apiViewRequestData[0].packageName = "a".repeat(65_535 - bytes);
    publish();
    expect(Buffer.byteLength(sample.metadata.output.text!, "utf8")).toBe(65_535);
    expect(readPrivateSdkArtifact(sample.native, [sample.metadata], 42).apiViewRequestData).toEqual(
      sample.envelope.artifact.apiViewRequestData,
    );
    // Two UTF-8 bytes replacing one ASCII byte exceeds the limit without increasing string length.
    sample.envelope.artifact.apiViewRequestData[0].packageName =
      "\u00e9" + sample.envelope.artifact.apiViewRequestData[0].packageName.slice(1);
    publish();
    expect(Buffer.byteLength(sample.metadata.output.text!, "utf8")).toBe(65_536);
    expect(() => readPrivateSdkArtifact(sample.native, [sample.metadata], 42)).toThrow("oversized");
  });

  it("requires complete runtime requiredness rather than reconstructing it", async () => {
    Reflect.deleteProperty(sample.envelope.artifact, "isSpecGenSdkCheckRequired");
    publish();
    await expect(labels()).rejects.toThrow();
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
  });

  it("rejects a failed transport even when it contains an earlier successful envelope", async () => {
    sample.metadata.conclusion = "failure";
    await expect(labels()).rejects.toThrow("transport mismatch");
    await status();
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "failure" }),
    );
  });

  it("binds the native immutable external ID to the details URL without an ADO request", () => {
    sample.native.external_id = `7518|999|${PROJECT}`;
    expect(() => readPrivateSdkArtifact(sample.native, [sample.metadata], 42)).toThrow(
      "Invalid native",
    );
  });

  it("uses the latest published attempt only when it binds to the current native generation", () => {
    const older = { ...sample.metadata, output: { ...sample.metadata.output } };
    sample.envelope.build.jobAttempt = 2;
    sample.metadata.external_id = sample.metadata.external_id?.replace(/:1$/, ":2") ?? null;
    publish();
    expect(readPrivateSdkArtifact(sample.native, [older, sample.metadata], 42).result).toBe(
      "succeeded",
    );
  });

  it("correlates PRs through GitHub when native checks omit their PR list", async () => {
    sample.native.pull_requests = [];
    github.rest.repos.listPullRequestsAssociatedWithCommit.mockResolvedValue({
      data: [
        {
          number: 42,
          state: "open",
          head: { sha: HEAD },
          base: { repo: { full_name: "Azure/azure-rest-api-specs-pr" } },
        },
      ],
    });
    expect((await labels()).labelAction).toBe(LabelAction.Remove);
    expect(github.rest.repos.listPullRequestsAssociatedWithCommit).toHaveBeenCalledWith(
      expect.objectContaining({ ...repo, commit_sha: HEAD, per_page: 100 }),
    );
  });

  it("refreshes on reopen without requiring an ADO details URL in the PR event", async () => {
    context.eventName = "pull_request_target";
    context.payload = {
      action: "reopened",
      repository: { owner: { login: "Azure" }, name: repo.repo },
      pull_request: { number: 42, head: { sha: HEAD } },
    };
    await setStatus({ github, context, core });
    expect(github.rest.repos.createCommitStatus).toHaveBeenCalledWith(
      expect.objectContaining({ state: "success" }),
    );
  });
});
