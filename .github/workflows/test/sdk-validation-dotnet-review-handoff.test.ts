import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { strToU8, Zip, ZipDeflate, zipSync } from "fflate";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE,
  SdkName,
  type SpecGenSdkArtifactInfo,
} from "../../shared/src/sdk-types.ts";
import {
  EXPECTED_ADO_DEFINITION_ID,
  MAX_SNAPSHOT_FILE_BYTES,
  MAX_SPEC_GEN_SDK_ARTIFACT_BYTES,
  extractAndValidateSdkReviewInputArchive,
  PACKAGES_ARTIFACT_NAME,
  parseAndValidateAdoBuildDetailsUrl,
  runSdkValidationDotnetReviewHandoffImpl,
  SPEC_GEN_SDK_ARTIFACT_NAME,
  validateCheckRunEventPayload,
  verifyReviewInputAgainstCheckRun,
} from "../src/sdk-validation-dotnet-review-handoff.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const mockFetch = vi.fn<typeof fetch>();

const temporaryDirectories: string[] = [];
const SAMPLE_HEAD_SHA = "38865cd3b650b3510e2a5b8bf9f990d0668a8810";
const SAMPLE_BUILD_ID = "6999663";
const SAMPLE_PROJECT_ID = "29ec6040-b234-4e31-b139-33dc4287b756";
const SAMPLE_DETAILS_URL = `https://dev.azure.com/azure-sdk/${SAMPLE_PROJECT_ID}/_build/results?buildId=${SAMPLE_BUILD_ID}`;
const SAMPLE_EXTERNAL_ID = `7516|${SAMPLE_BUILD_ID}|${SAMPLE_PROJECT_ID}`;
const SAMPLE_SNAPSHOT_FILES = {
  "Azure.Widget/review-input/Azure.Widget.csproj": strToU8("<Project />"),
  "Azure.Widget/review-input/src/Generated/WidgetClient.cs": strToU8(
    "public class WidgetClient {}",
  ),
};
const SAMPLE_SNAPSHOT_BYTES = Object.values(SAMPLE_SNAPSHOT_FILES).reduce(
  (total, content) => total + content.byteLength,
  0,
);

function createTempOutputDir(): string {
  const directory = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-review-handoff-test-"));
  temporaryDirectories.push(directory);
  return directory;
}

function createSampleCheckRunPayload(overrides: Record<string, unknown> = {}) {
  return {
    check_run: {
      name: "SDK Validation - .NET",
      head_sha: SAMPLE_HEAD_SHA,
      status: "completed",
      conclusion: "success",
      details_url: SAMPLE_DETAILS_URL,
      external_id: SAMPLE_EXTERNAL_ID,
      app: {
        id: 9426,
        slug: "azure-pipelines",
        name: "Azure Pipelines",
      },
      pull_requests: [{ number: 47607, head: { sha: SAMPLE_HEAD_SHA } }],
      ...overrides,
    },
  };
}

function createSampleArtifact(
  overrides: Partial<SpecGenSdkArtifactInfo> = {},
): SpecGenSdkArtifactInfo {
  return {
    language: SdkName.Net,
    result: "succeeded",
    headSha: SAMPLE_HEAD_SHA,
    prNumber: "47607",
    isSpecGenSdkCheckRequired: true,
    apiViewRequestData: [
      {
        packageName: "Azure.Widget",
        filePath: "Azure.Widget.1.0.0.nupkg",
        packageRootPath: "sdk/widget/Azure.Widget",
        changedFiles: [
          "sdk/widget/Azure.Widget/api/Azure.Widget.netstandard2.0.cs",
          "sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs",
        ],
        sdkBaseCommitSha: "0123456789abcdef0123456789abcdef01234567",
        reviewInputPath: "Azure.Widget/review-input",
        reviewInputFileCount: Object.keys(SAMPLE_SNAPSHOT_FILES).length,
        reviewInputBytes: SAMPLE_SNAPSHOT_BYTES,
      },
    ],
    ...overrides,
  };
}

function createArtifactListResponse(
  artifacts: Array<{ name: string; downloadUrl: string; source?: string }> = [
    {
      name: SPEC_GEN_SDK_ARTIFACT_NAME,
      downloadUrl: "https://artifacts.example.com/spec-gen",
    },
    {
      name: PACKAGES_ARTIFACT_NAME,
      downloadUrl: "https://artifacts.example.com/packages",
    },
  ],
): Response {
  return new Response(
    JSON.stringify({
      value: artifacts.map(({ name, downloadUrl, source = "job-1" }) => ({
        name,
        source,
        resource: { downloadUrl },
      })),
    }),
    {
      status: 200,
      headers: { "content-type": "application/json" },
    },
  );
}

function getRequestUrl(input: string | URL | Request): string {
  if (typeof input === "string") {
    return input;
  }
  return input instanceof URL ? input.href : input.url;
}

function setFirstCentralDirectoryOriginalSize(archive: Uint8Array, size: number): Uint8Array {
  const modifiedArchive = archive.slice();
  const view = new DataView(
    modifiedArchive.buffer,
    modifiedArchive.byteOffset,
    modifiedArchive.byteLength,
  );
  for (let offset = 0; offset <= modifiedArchive.byteLength - 4; offset += 1) {
    if (view.getUint32(offset, true) === 0x02014b50) {
      view.setUint32(offset + 24, size, true);
      return modifiedArchive;
    }
  }
  throw new Error("ZIP central directory not found");
}

function createStreamingZip(entries: Record<string, Uint8Array>): Promise<Uint8Array> {
  return new Promise((resolve, reject) => {
    const chunks: Uint8Array[] = [];
    const zip = new Zip((error, chunk, final) => {
      if (error) {
        reject(error);
        return;
      }
      chunks.push(chunk);
      if (!final) {
        return;
      }
      const totalBytes = chunks.reduce((total, value) => total + value.byteLength, 0);
      const archive = new Uint8Array(totalBytes);
      let offset = 0;
      for (const value of chunks) {
        archive.set(value, offset);
        offset += value.byteLength;
      }
      resolve(archive);
    });

    for (const [name, content] of Object.entries(entries)) {
      const file = new ZipDeflate(name, { level: 9 });
      zip.add(file);
      file.push(content, true);
    }
    zip.end();
  });
}

describe("sdk-validation-dotnet-review-handoff", () => {
  beforeEach(() => {
    mockFetch.mockReset();
  });

  afterEach(() => {
    for (const directory of temporaryDirectories.splice(0)) {
      fs.rmSync(directory, { recursive: true, force: true });
    }
  });

  describe("parseAndValidateAdoBuildDetailsUrl", () => {
    it("accepts a trusted build URL and matching external ID", () => {
      expect(parseAndValidateAdoBuildDetailsUrl(SAMPLE_DETAILS_URL, SAMPLE_EXTERNAL_ID)).toEqual({
        projectUrl: `https://dev.azure.com/azure-sdk/${SAMPLE_PROJECT_ID}`,
        organization: "azure-sdk",
        project: SAMPLE_PROJECT_ID,
        buildId: SAMPLE_BUILD_ID,
      });
    });

    it.each([
      ["missing URL", undefined, SAMPLE_EXTERNAL_ID, "Missing check_run.details_url"],
      ["missing external ID", SAMPLE_DETAILS_URL, undefined, "Missing check_run.external_id"],
      [
        "wrong definition",
        SAMPLE_DETAILS_URL,
        `9999|${SAMPLE_BUILD_ID}|${SAMPLE_PROJECT_ID}`,
        "Unexpected Azure Pipelines definition ID",
      ],
      [
        "mismatched build",
        SAMPLE_DETAILS_URL,
        `${EXPECTED_ADO_DEFINITION_ID}|1|${SAMPLE_PROJECT_ID}`,
        "Mismatch between details_url buildId",
      ],
      [
        "untrusted host",
        `https://example.com/azure-sdk/${SAMPLE_PROJECT_ID}/_build/results?buildId=1`,
        SAMPLE_EXTERNAL_ID,
        "Untrusted Azure DevOps host",
      ],
    ])("rejects %s", (_label, detailsUrl, externalId, expectedMessage) => {
      expect(() => parseAndValidateAdoBuildDetailsUrl(detailsUrl, externalId)).toThrow(
        expectedMessage,
      );
    });
  });

  it("matches only the completed .NET check from Azure Pipelines", () => {
    expect(validateCheckRunEventPayload(createSampleCheckRunPayload()).matched).toBe(true);
    expect(
      validateCheckRunEventPayload(createSampleCheckRunPayload({ name: "SDK Validation - Python" }))
        .matched,
    ).toBe(false);
    expect(
      validateCheckRunEventPayload(
        createSampleCheckRunPayload({
          app: { id: 1, slug: "other-app", name: "Other App" },
        }),
      ).matched,
    ).toBe(false);
  });

  it("requires enriched APIView entries and matching immutable identity", () => {
    const event = validateCheckRunEventPayload(createSampleCheckRunPayload()).event!;
    expect(verifyReviewInputAgainstCheckRun(createSampleArtifact(), event)).toBe(47607);

    expect(() =>
      verifyReviewInputAgainstCheckRun(createSampleArtifact({ headSha: "f".repeat(40) }), event),
    ).toThrow("does not match check_run.head_sha");
    expect(() =>
      verifyReviewInputAgainstCheckRun(
        createSampleArtifact({
          apiViewRequestData: [
            {
              packageName: "Azure.Widget",
              filePath: "Azure.Widget.1.0.0.nupkg",
            },
          ],
        }),
        event,
      ),
    ).toThrow("missing complete SDK review input metadata");
    expect(() =>
      verifyReviewInputAgainstCheckRun(
        createSampleArtifact({
          apiViewRequestData: [
            {
              ...createSampleArtifact().apiViewRequestData[0],
              filePath: "../escape.nupkg",
            },
          ],
        }),
        event,
      ),
    ).toThrow("unsafe artifact path");
  });

  it("enforces aggregate review budgets only at the handoff boundary", () => {
    const event = validateCheckRunEventPayload(createSampleCheckRunPayload()).event!;
    const request = createSampleArtifact().apiViewRequestData[0];
    const apiViewRequestData = Array.from({ length: 3 }, (_, index) => {
      const packageName = `Azure.Widget${index}`;
      return {
        ...request,
        packageName,
        filePath: `${packageName}.1.0.0.nupkg`,
        packageRootPath: `sdk/widget/${packageName}`,
        changedFiles: [`sdk/widget/${packageName}/src/Generated/WidgetClient.cs`],
        reviewInputPath: `${packageName}/review-input`,
        reviewInputBytes: 48 * 1024 * 1024,
      };
    });

    expect(() =>
      verifyReviewInputAgainstCheckRun(createSampleArtifact({ apiViewRequestData }), event),
    ).toThrow("snapshot bytes; maximum");
  });

  it("enforces per-package changed-file budgets only at the handoff boundary", () => {
    const event = validateCheckRunEventPayload(createSampleCheckRunPayload()).event!;
    const request = createSampleArtifact().apiViewRequestData[0];
    const changedFiles = Array.from(
      { length: SDK_REVIEW_MAX_CHANGED_FILES_PER_PACKAGE + 1 },
      (_, index) => `sdk/widget/Azure.Widget/src/Generated/Widget${index}.cs`,
    );

    expect(() =>
      verifyReviewInputAgainstCheckRun(
        createSampleArtifact({
          apiViewRequestData: [{ ...request, changedFiles }],
        }),
        event,
      ),
    ).toThrow("changed files; maximum");
  });

  it("extracts only declared source snapshots and verifies declared counts", () => {
    const outputDirectory = createTempOutputDir();
    const artifact = createSampleArtifact();
    const archive = zipSync({
      ...SAMPLE_SNAPSHOT_FILES,
      "Azure.Widget/Azure.Widget.1.0.0.nupkg": strToU8("ignored package"),
    });

    extractAndValidateSdkReviewInputArchive(archive, artifact, outputDirectory);

    expect(
      fs.readFileSync(
        path.join(outputDirectory, "Azure.Widget", "review-input", "Azure.Widget.csproj"),
        "utf8",
      ),
    ).toBe("<Project />");
    expect(
      fs.existsSync(path.join(outputDirectory, "Azure.Widget", "Azure.Widget.1.0.0.nupkg")),
    ).toBe(false);

    expect(() =>
      extractAndValidateSdkReviewInputArchive(
        zipSync({
          "Azure.Widget/review-input/Azure.Widget.csproj": strToU8("<Project />"),
        }),
        artifact,
        createTempOutputDir(),
      ),
    ).toThrow("expected 2 files");
  });

  it("extracts snapshots using the selected failed-attempt artifact prefix", () => {
    const outputDirectory = createTempOutputDir();
    const failedArtifactName = `${PACKAGES_ARTIFACT_NAME}-FailedAttempt2`;
    const prefixedFiles = Object.fromEntries(
      Object.entries(SAMPLE_SNAPSHOT_FILES).map(([name, content]) => [
        `${failedArtifactName}/${name}`,
        content,
      ]),
    );

    extractAndValidateSdkReviewInputArchive(
      zipSync(prefixedFiles),
      createSampleArtifact(),
      outputDirectory,
      failedArtifactName,
    );

    expect(
      fs.readFileSync(
        path.join(outputDirectory, "Azure.Widget", "review-input", "Azure.Widget.csproj"),
        "utf8",
      ),
    ).toBe("<Project />");
  });

  it("rejects archive entries that resolve to the same snapshot destination", () => {
    const duplicatePath = "Azure.Widget/review-input/Azure.Widget.csproj";
    expect(() =>
      extractAndValidateSdkReviewInputArchive(
        zipSync({
          ...SAMPLE_SNAPSHOT_FILES,
          [`${PACKAGES_ARTIFACT_NAME}/${duplicatePath}`]: strToU8("<DifferentProject />"),
        }),
        createSampleArtifact(),
        createTempOutputDir(),
      ),
    ).toThrow("Multiple ZIP entries resolve to");
  });

  it("extracts streamed ZIP entries that use data descriptors", async () => {
    const outputDirectory = createTempOutputDir();
    const archive = await createStreamingZip(SAMPLE_SNAPSHOT_FILES);

    expect(new DataView(archive.buffer, archive.byteOffset).getUint16(6, true) & 0x08).toBe(0x08);
    extractAndValidateSdkReviewInputArchive(archive, createSampleArtifact(), outputDirectory);
    expect(
      fs.readFileSync(
        path.join(
          outputDirectory,
          "Azure.Widget",
          "review-input",
          "src",
          "Generated",
          "WidgetClient.cs",
        ),
        "utf8",
      ),
    ).toBe("public class WidgetClient {}");
  });

  it("validates a large streamed ZIP without exhausting the call stack", async () => {
    const fileCount = 4_500;
    const snapshotFiles = Object.fromEntries(
      Array.from({ length: fileCount }, (_, index) => [
        `Azure.Widget/review-input/src/Generated/Model${index}.cs`,
        new Uint8Array(),
      ]),
    );
    const request = createSampleArtifact().apiViewRequestData[0];
    const artifact = createSampleArtifact({
      apiViewRequestData: [
        {
          ...request,
          changedFiles: ["sdk/widget/Azure.Widget/src/Generated/Model0.cs"],
          reviewInputFileCount: fileCount,
          reviewInputBytes: 0,
        },
      ],
    });
    const archive = await createStreamingZip(snapshotFiles);
    const outputDirectory = createTempOutputDir();

    expect(() =>
      extractAndValidateSdkReviewInputArchive(archive, artifact, outputDirectory),
    ).not.toThrow();
    expect(
      fs.existsSync(
        path.join(
          outputDirectory,
          "Azure.Widget",
          "review-input",
          "src",
          "Generated",
          "Model4499.cs",
        ),
      ),
    ).toBe(true);
  });

  it("rejects highly compressible oversized entries before extraction", () => {
    const outputDirectory = createTempOutputDir();
    const oversizedContent = new Uint8Array(MAX_SNAPSHOT_FILE_BYTES + 1);
    const oversizedFiles = {
      "Azure.Widget/review-input/src/Generated/Oversized.cs": oversizedContent,
    };
    const request = createSampleArtifact().apiViewRequestData[0];
    const artifact = createSampleArtifact({
      apiViewRequestData: [
        {
          ...request,
          changedFiles: ["sdk/widget/Azure.Widget/src/Generated/Oversized.cs"],
          reviewInputFileCount: 1,
          reviewInputBytes: oversizedContent.byteLength,
        },
      ],
    });
    const archive = zipSync(oversizedFiles, { level: 9 });

    expect(archive.byteLength).toBeLessThan(64 * 1024);
    expect(() =>
      extractAndValidateSdkReviewInputArchive(archive, artifact, outputDirectory),
    ).toThrow(`declares more than ${MAX_SNAPSHOT_FILE_BYTES} bytes`);
    expect(fs.readdirSync(outputDirectory)).toEqual([]);
  });

  it("rejects mismatched central-directory and local-header sizes before extraction", () => {
    const outputDirectory = createTempOutputDir();
    const oversizedContent = new Uint8Array(MAX_SNAPSHOT_FILE_BYTES + 1);
    const entryName = "Azure.Widget/review-input/src/Generated/Oversized.cs";
    const archive = setFirstCentralDirectoryOriginalSize(
      zipSync({ [entryName]: oversizedContent }, { level: 9 }),
      1,
    );
    const request = createSampleArtifact().apiViewRequestData[0];
    const artifact = createSampleArtifact({
      apiViewRequestData: [
        {
          ...request,
          changedFiles: ["sdk/widget/Azure.Widget/src/Generated/Oversized.cs"],
          reviewInputFileCount: 1,
          reviewInputBytes: 1,
        },
      ],
    });

    expect(() =>
      extractAndValidateSdkReviewInputArchive(archive, artifact, outputDirectory),
    ).toThrow("local header does not match its central-directory metadata");
    expect(fs.readdirSync(outputDirectory)).toEqual([]);
  });

  it("validates the existing artifact, writes a report-only input, and performs no PR mutations", async () => {
    const mockGithub = createMockGithub();
    const mockContext = createMockContext();
    const mockCore = createMockCore();
    const outputRootDir = createTempOutputDir();
    const artifact = createSampleArtifact();

    mockContext.payload = createSampleCheckRunPayload({
      pull_requests: [
        { number: 47500, head: { sha: "9".repeat(40) } },
        { number: 47607, head: { sha: SAMPLE_HEAD_SHA } },
      ],
    });
    mockGithub.rest.pulls.get.mockResolvedValue({
      data: {
        number: 47607,
        state: "open",
        head: { sha: SAMPLE_HEAD_SHA },
        base: { sha: "1".repeat(40), repo: { full_name: "owner/repo" } },
      },
    });
    mockFetch.mockImplementation((url) => {
      const requestUrl = getRequestUrl(url);
      if (requestUrl.includes("artifacts?api-version=7.0")) {
        return Promise.resolve(createArtifactListResponse());
      }
      if (requestUrl.includes("/spec-gen") && requestUrl.includes("format=file")) {
        return Promise.resolve(
          new Response(JSON.stringify(artifact), {
            status: 200,
            headers: { "content-length": String(JSON.stringify(artifact).length) },
          }),
        );
      }
      if (requestUrl.includes("/packages") && requestUrl.includes("format=zip")) {
        const archive = zipSync(SAMPLE_SNAPSHOT_FILES);
        return Promise.resolve(
          new Response(archive, {
            status: 200,
            headers: { "content-length": String(archive.byteLength) },
          }),
        );
      }
      return Promise.resolve(new Response("Not Found", { status: 404 }));
    });

    const result = await runSdkValidationDotnetReviewHandoffImpl({
      github: mockGithub,
      context: mockContext,
      core: mockCore,
      outputRootDir,
      retryOptions: { initialDelayMs: 1 },
      fetchImpl: mockFetch,
    });

    expect(result.status).toBe("validated");
    expect(result.entryCount).toBe(1);
    expect(JSON.parse(fs.readFileSync(result.artifactPath!, "utf8"))).toEqual(artifact);
    expect(JSON.parse(fs.readFileSync(result.typeSpecContextPath!, "utf8"))).toEqual({
      schemaVersion: 1,
      source: {
        specPrNumber: 47607,
        specHeadSha: SAMPLE_HEAD_SHA,
        specBaseSha: "1".repeat(40),
      },
      projects: [],
      files: [],
    });
    expect(
      fs.existsSync(
        path.join(result.inputDirectory!, "Azure.Widget", "review-input", "Azure.Widget.csproj"),
      ),
    ).toBe(true);
    expect(mockCore.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("SDK Validation - .NET Naming Review Input (Report-Only)"),
    );
    expect(mockFetch).toHaveBeenCalledTimes(3);
    expect(mockGithub.rest.pulls.get).toHaveBeenCalledWith(
      expect.objectContaining({ pull_number: 47607 }),
    );
    expect(mockGithub.rest.issues.createComment).not.toHaveBeenCalled();
    expect(mockGithub.rest.issues.updateComment).not.toHaveBeenCalled();
    expect(mockGithub.rest.issues.addLabels).not.toHaveBeenCalled();
    expect(mockGithub.rest.repos.createCommitStatus).not.toHaveBeenCalled();
  });

  it("rejects stale PRs before downloading artifacts", async () => {
    const mockGithub = createMockGithub();
    const mockContext = createMockContext();
    const mockCore = createMockCore();
    mockContext.payload = createSampleCheckRunPayload();
    mockGithub.rest.pulls.get.mockResolvedValue({
      data: {
        number: 47607,
        state: "open",
        head: { sha: "9".repeat(40) },
        base: { sha: "1".repeat(40), repo: { full_name: "owner/repo" } },
      },
    });

    const result = await runSdkValidationDotnetReviewHandoffImpl({
      github: mockGithub,
      context: mockContext,
      core: mockCore,
      outputRootDir: createTempOutputDir(),
      fetchImpl: mockFetch,
    });

    expect(result.status).toBe("skipped");
    expect(result.reason).toContain("Skipping stale or closed PR #47607");
    expect(mockFetch).not.toHaveBeenCalled();
  });

  it("skips review when SDK generation produced no reviewable packages", async () => {
    const mockGithub = createMockGithub();
    const mockContext = createMockContext();
    const mockCore = createMockCore();
    const artifact = createSampleArtifact({
      isSpecGenSdkCheckRequired: false,
      apiViewRequestData: [],
    });

    mockContext.payload = createSampleCheckRunPayload({ pull_requests: [] });
    mockFetch.mockImplementation((url) => {
      const requestUrl = getRequestUrl(url);
      if (requestUrl.includes("artifacts?api-version=7.0")) {
        return Promise.resolve(
          createArtifactListResponse([
            {
              name: SPEC_GEN_SDK_ARTIFACT_NAME,
              downloadUrl: "https://artifacts.example.com/spec-gen",
            },
          ]),
        );
      }
      if (requestUrl.includes("/spec-gen") && requestUrl.includes("format=file")) {
        return Promise.resolve(
          new Response(JSON.stringify(artifact), {
            status: 200,
            headers: { "content-length": String(JSON.stringify(artifact).length) },
          }),
        );
      }
      return Promise.resolve(new Response("Not Found", { status: 404 }));
    });

    const result = await runSdkValidationDotnetReviewHandoffImpl({
      github: mockGithub,
      context: mockContext,
      core: mockCore,
      outputRootDir: createTempOutputDir(),
      retryOptions: { initialDelayMs: 1 },
      fetchImpl: mockFetch,
    });

    expect(result.status).toBe("skipped");
    expect(result.reason).toContain("produced no reviewable packages");
    expect(mockFetch).toHaveBeenCalledTimes(2);
    expect(mockFetch.mock.calls.some(([url]) => getRequestUrl(url).includes("format=zip"))).toBe(
      false,
    );
    expect(mockGithub.rest.pulls.get).not.toHaveBeenCalled();
  });

  it("enforces the existing artifact byte limit", async () => {
    const mockGithub = createMockGithub();
    const mockContext = createMockContext();
    const mockCore = createMockCore();
    mockContext.payload = createSampleCheckRunPayload({ pull_requests: [] });
    mockGithub.rest.pulls.get.mockResolvedValue({
      data: {
        number: 47607,
        state: "open",
        head: { sha: SAMPLE_HEAD_SHA },
        base: { sha: "1".repeat(40), repo: { full_name: "owner/repo" } },
      },
    });
    mockFetch.mockImplementation((url) => {
      if (getRequestUrl(url).includes("artifacts?api-version=7.0")) {
        return Promise.resolve(createArtifactListResponse());
      }
      return Promise.resolve(
        new Response("x", {
          status: 200,
          headers: { "content-length": String(MAX_SPEC_GEN_SDK_ARTIFACT_BYTES + 1) },
        }),
      );
    });

    await expect(
      runSdkValidationDotnetReviewHandoffImpl({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
        outputRootDir: createTempOutputDir(),
        fetchImpl: mockFetch,
      }),
    ).rejects.toThrow(`exceeds ${MAX_SPEC_GEN_SDK_ARTIFACT_BYTES} bytes`);
  });
});
