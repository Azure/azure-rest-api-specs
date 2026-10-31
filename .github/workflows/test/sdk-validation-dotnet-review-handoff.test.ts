import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { strToU8, zipSync } from "fflate";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { SdkName, type SpecGenSdkArtifactInfo } from "../../shared/src/sdk-types.ts";
import {
    EXPECTED_ADO_DEFINITION_ID,
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

const mockFetch: import("vitest").Mock<
    (input: string, init?: RequestInit) => Promise<Partial<Response>>
> = vi.fn();

global.fetch = mockFetch as import("vitest").MockedFunction<typeof fetch>;

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

function createArtifactListResponse() {
    return {
        ok: true,
        json: vi.fn().mockResolvedValue({
            value: [
                {
                    name: SPEC_GEN_SDK_ARTIFACT_NAME,
          resource: { downloadUrl: "https://artifacts.example.com/spec-gen" },
        },
        {
          name: PACKAGES_ARTIFACT_NAME,
          resource: { downloadUrl: "https://artifacts.example.com/packages" },
                },
            ],
        }),
        status: 200,
        statusText: "OK",
    };
}

describe("sdk-validation-dotnet-review-handoff", () => {
    beforeEach(() => {
        vi.clearAllMocks();
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

    it("validates the existing artifact, writes a report-only input, and performs no PR mutations", async () => {
        const mockGithub = createMockGithub();
        const mockContext = createMockContext();
        const mockCore = createMockCore();
        const outputRootDir = createTempOutputDir();
        const artifact = createSampleArtifact();

        mockContext.payload = createSampleCheckRunPayload({ pull_requests: [] });
        mockGithub.rest.pulls.get.mockResolvedValue({
            data: {
                number: 47607,
                state: "open",
                head: { sha: SAMPLE_HEAD_SHA },
                base: { repo: { full_name: "owner/repo" } },
            },
        });
        mockFetch.mockImplementation((url) => {
            if (String(url).includes("artifacts?api-version=7.0")) {
        return Promise.resolve(createArtifactListResponse());
            }
      if (String(url).includes("/spec-gen") && String(url).includes("format=file")) {
                return Promise.resolve(
                    new Response(JSON.stringify(artifact), {
                        status: 200,
                        headers: { "content-length": String(JSON.stringify(artifact).length) },
                    }),
                );
            }
      if (String(url).includes("/packages") && String(url).includes("format=zip")) {
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
        });

        expect(result.status).toBe("validated");
        expect(result.entryCount).toBe(1);
        expect(JSON.parse(fs.readFileSync(result.artifactPath!, "utf8"))).toEqual(artifact);
    expect(
      fs.existsSync(
        path.join(result.inputDirectory!, "Azure.Widget", "review-input", "Azure.Widget.csproj"),
      ),
    ).toBe(true);
        expect(mockCore.summary.addRaw).toHaveBeenCalledWith(
            expect.stringContaining("SDK Validation - .NET Naming Review Input (Report-Only)"),
        );
    expect(mockFetch).toHaveBeenCalledTimes(4);
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
                base: { repo: { full_name: "owner/repo" } },
            },
        });

        const result = await runSdkValidationDotnetReviewHandoffImpl({
            github: mockGithub,
            context: mockContext,
            core: mockCore,
            outputRootDir: createTempOutputDir(),
        });

        expect(result.status).toBe("skipped");
        expect(result.reason).toContain("Skipping stale or closed PR #47607");
        expect(mockFetch).not.toHaveBeenCalled();
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
                base: { repo: { full_name: "owner/repo" } },
            },
        });
        mockFetch.mockImplementation((url) => {
            if (String(url).includes("artifacts?api-version=7.0")) {
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
            }),
        ).rejects.toThrow(`exceeds ${MAX_SPEC_GEN_SDK_ARTIFACT_BYTES} bytes`);
    });
});
