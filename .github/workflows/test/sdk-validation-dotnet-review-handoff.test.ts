import { createHash } from "node:crypto";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  SDK_REVIEW_BUNDLE_ARTIFACT_NAME,
  SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME,
  SDK_REVIEW_BUNDLE_SCHEMA_VERSION,
  SdkName,
  type SdkReviewBundleManifest,
} from "../../shared/src/sdk-types.ts";
import {
  MAX_SDK_REVIEW_MANIFEST_BYTES,
  MAX_SDK_REVIEW_TOTAL_PATCH_BYTES,
  parseAndValidateAdoBuildDetailsUrl,
  resolveSafeChildPath,
  runSdkValidationDotnetReviewHandoffImpl,
  validateCheckRunEventPayload,
  verifyManifestAgainstCheckRun,
  verifyPatchPaths,
} from "../src/sdk-validation-dotnet-review-handoff.ts";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.ts";

const mockFetch: import("vitest").Mock<
  (input: string, init?: RequestInit) => Promise<Partial<Response>>
> = vi.fn();

global.fetch = mockFetch as import("vitest").MockedFunction<typeof fetch>;

const temporaryDirectories: string[] = [];

const SAMPLE_HEAD_SHA = "38865cd3b650b3510e2a5b8bf9f990d0668a8810";
const SAMPLE_BASE_COMMIT_SHA = "7f2236ba6603779909dd53989ab7fefb3b78a7d6";
const SAMPLE_BUILD_ID = "6999663";
const SAMPLE_PROJECT_ID = "29ec6040-b234-4e31-b139-33dc4287b756";
const SAMPLE_DETAILS_URL = `https://dev.azure.com/azure-sdk/${SAMPLE_PROJECT_ID}/_build/results?buildId=${SAMPLE_BUILD_ID}`;
const SAMPLE_EXTERNAL_ID = `7516|${SAMPLE_BUILD_ID}|${SAMPLE_PROJECT_ID}`;

function createTempOutputDir(): string {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-review-handoff-test-"));
  temporaryDirectories.push(dir);
  return dir;
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

function createSampleManifest(
  patchContents: { entry1: string; entry2?: string },
  overrides: Partial<Extract<SdkReviewBundleManifest, { captureStatus: "complete" }>> = {},
): Extract<SdkReviewBundleManifest, { captureStatus: "complete" }> {
  const patch1Buf = Buffer.from(patchContents.entry1, "utf8");
  const entries: Extract<SdkReviewBundleManifest, { captureStatus: "complete" }>["entries"] = [
    {
      entryId: "01-Azure.Widget",
      tspConfigPath: "specification/widget/Widget/tspconfig.yaml",
      packageName: "Azure.Widget",
      packageRootPath: "sdk/widget/Azure.Widget",
      sdkBaseCommitSha: SAMPLE_BASE_COMMIT_SHA,
      executionResult: "succeeded",
      hasBreakingChange: false,
      patchFile: "01-Azure.Widget.patch",
      patchSha256: createHash("sha256").update(patch1Buf).digest("hex"),
      patchBytes: patch1Buf.byteLength,
      changedFileCount: 1,
      changedFiles: ["sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs"],
    },
  ];

  if (patchContents.entry2 !== undefined) {
    const patch2Buf = Buffer.from(patchContents.entry2, "utf8");
    entries.push({
      entryId: "02-Azure.ResourceManager.Gadget",
      tspConfigPath: "specification/gadget/Gadget.Management/tspconfig.yaml",
      packageName: "Azure.ResourceManager.Gadget",
      packageRootPath: "sdk/gadget/Azure.ResourceManager.Gadget",
      sdkBaseCommitSha: SAMPLE_BASE_COMMIT_SHA,
      executionResult: "succeeded",
      hasBreakingChange: true,
      patchFile: "02-Azure.ResourceManager.Gadget.patch",
      patchSha256: createHash("sha256").update(patch2Buf).digest("hex"),
      patchBytes: patch2Buf.byteLength,
      changedFileCount: 1,
      changedFiles: ["sdk/gadget/Azure.ResourceManager.Gadget/src/Generated/GadgetResource.cs"],
    });
  }

  return {
    schemaVersion: SDK_REVIEW_BUNDLE_SCHEMA_VERSION,
    buildId: SAMPLE_BUILD_ID,
    specPrNumber: "47607",
    specHeadSha: SAMPLE_HEAD_SHA,
    specRepoUrl: "https://github.com/Azure/azure-rest-api-specs",
    sdkLanguage: SdkName.Net,
    sdkRepoName: "azure-sdk-for-net",
    captureStatus: "complete",
    expectedEntryCount: entries.length,
    entries,
    ...overrides,
  };
}

describe("sdk-validation-dotnet-review-handoff", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  afterEach(() => {
    for (const dir of temporaryDirectories.splice(0)) {
      fs.rmSync(dir, { recursive: true, force: true });
    }
  });

  describe("parseAndValidateAdoBuildDetailsUrl", () => {
    it("accepts a valid Azure DevOps azure-sdk build details URL and matching external_id", () => {
      const target = parseAndValidateAdoBuildDetailsUrl(SAMPLE_DETAILS_URL, SAMPLE_EXTERNAL_ID);
      expect(target).toEqual({
        projectUrl: `https://dev.azure.com/azure-sdk/${SAMPLE_PROJECT_ID}`,
        organization: "azure-sdk",
        project: SAMPLE_PROJECT_ID,
        buildId: SAMPLE_BUILD_ID,
      });
    });

    it.each([
      ["missing URL", undefined, undefined, "Missing check_run.details_url"],
      [
        "non-HTTPS protocol",
        `http://dev.azure.com/azure-sdk/${SAMPLE_PROJECT_ID}/_build/results?buildId=123`,
        undefined,
        "Untrusted Azure DevOps host",
      ],
      [
        "untrusted host",
        `https://evil.example.com/azure-sdk/${SAMPLE_PROJECT_ID}/_build/results?buildId=123`,
        undefined,
        "Untrusted Azure DevOps host",
      ],
      [
        "wrong organization",
        `https://dev.azure.com/other-org/${SAMPLE_PROJECT_ID}/_build/results?buildId=123`,
        undefined,
        "Unexpected Azure DevOps path",
      ],
      [
        "non-numeric buildId",
        `https://dev.azure.com/azure-sdk/${SAMPLE_PROJECT_ID}/_build/results?buildId=123abc`,
        undefined,
        "Invalid or non-numeric buildId",
      ],
      [
        "mismatched external_id buildId",
        SAMPLE_DETAILS_URL,
        `7516|9999999|${SAMPLE_PROJECT_ID}`,
        "Mismatch between details_url buildId",
      ],
      [
        "mismatched external_id project",
        SAMPLE_DETAILS_URL,
        `7516|${SAMPLE_BUILD_ID}|other-project`,
        "Mismatch between details_url project",
      ],
    ])("rejects %s", (_label, detailsUrl, externalId, expectedMessage) => {
      expect(() => parseAndValidateAdoBuildDetailsUrl(detailsUrl, externalId)).toThrow(
        expectedMessage,
      );
    });
  });

  describe("validateCheckRunEventPayload", () => {
    it("matches SDK Validation - .NET from Azure Pipelines", () => {
      const result = validateCheckRunEventPayload(createSampleCheckRunPayload());
      expect(result.matched).toBe(true);
      expect(result.event?.adoBuild.buildId).toBe(SAMPLE_BUILD_ID);
      expect(result.event?.headSha).toBe(SAMPLE_HEAD_SHA);
    });

    it("ignores non-.NET check runs cleanly", () => {
      const result = validateCheckRunEventPayload(
        createSampleCheckRunPayload({ name: "SDK Validation - Python" }),
      );
      expect(result.matched).toBe(false);
      expect(result.reason).toContain("Ignoring check_run 'SDK Validation - Python'");
    });

    it("ignores check runs from untrusted apps", () => {
      const result = validateCheckRunEventPayload(
        createSampleCheckRunPayload({
          app: { id: 1, slug: "other-app", name: "Other App" },
        }),
      );
      expect(result.matched).toBe(false);
      expect(result.reason).toContain("Ignoring check_run from app");
    });
  });

  describe("resolveSafeChildPath & verifyManifestAgainstCheckRun", () => {
    it("rejects path traversal in resolveSafeChildPath", () => {
      const baseDir = createTempOutputDir();
      expect(() => resolveSafeChildPath(baseDir, "../evil.patch")).toThrow("Unsafe bundle file");
      expect(() => resolveSafeChildPath(baseDir, "nested/evil.patch")).toThrow(
        "Unsafe bundle file",
      );
      expect(resolveSafeChildPath(baseDir, "01-Azure.Widget.patch")).toBe(
        path.join(baseDir, "01-Azure.Widget.patch"),
      );
    });

    it("rejects manifest with mismatched headSha or buildId", () => {
      const event = validateCheckRunEventPayload(createSampleCheckRunPayload()).event!;
      const manifest = createSampleManifest({ entry1: "diff" });

      expect(() =>
        verifyManifestAgainstCheckRun({ ...manifest, specHeadSha: "f".repeat(40) }, event),
      ).toThrow("does not match check_run.head_sha");

      expect(() =>
        verifyManifestAgainstCheckRun({ ...manifest, buildId: "1111111" }, event),
      ).toThrow("does not match check_run buildId");
    });

    it("rejects failed capture manifests explicitly", () => {
      const event = validateCheckRunEventPayload(createSampleCheckRunPayload()).event!;
      const completeManifest = createSampleManifest({ entry1: "diff" });
      const failedManifest: SdkReviewBundleManifest = {
        ...completeManifest,
        captureStatus: "failed",
        expectedEntryCount: 1,
        captureErrors: ["Missing packageRootPath"],
        entries: [],
      };

      expect(() => verifyManifestAgainstCheckRun(failedManifest, event)).toThrow(
        "SDK review bundle capture failed",
      );
    });

    it.each([
      ["out-of-package changed file", ["sdk/other/Azure.Other/Foo.cs"], "not a strict descendant"],
      [
        "duplicate changed file",
        [
          "sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs",
          "sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs",
        ],
        "duplicate changed file",
      ],
    ])("rejects %s", (_label, changedFiles, message) => {
      const event = validateCheckRunEventPayload(createSampleCheckRunPayload()).event!;
      const manifest = createSampleManifest({ entry1: "diff" });
      manifest.entries[0].changedFiles = changedFiles;
      manifest.entries[0].changedFileCount = changedFiles.length;
      expect(() => verifyManifestAgainstCheckRun(manifest, event)).toThrow(message);
    });

    it("accepts the exact total patch-byte boundary", () => {
      const event = validateCheckRunEventPayload(createSampleCheckRunPayload()).event!;
      const manifest = createSampleManifest({ entry1: "" });
      manifest.entries[0].patchBytes = MAX_SDK_REVIEW_TOTAL_PATCH_BYTES;
      expect(() => verifyManifestAgainstCheckRun(manifest, event)).not.toThrow();
    });
  });

  describe("verifyPatchPaths", () => {
    const validPatch =
      "diff --git a/sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs b/sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs\n+// changed\n" +
      "diff --git a/sdk/widget/Azure.Widget/src/Generated/WidgetModel.cs b/sdk/widget/Azure.Widget/src/Generated/WidgetModel.cs\n+// changed\n";

    function createEntry() {
      const manifest = createSampleManifest({ entry1: validPatch });
      return {
        ...manifest.entries[0],
        changedFileCount: 2,
        changedFiles: [
          "sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs",
          "sdk/widget/Azure.Widget/src/Generated/WidgetModel.cs",
        ],
      };
    }

    it("accepts a valid multi-file patch", () => {
      expect(() => verifyPatchPaths(createEntry(), validPatch)).not.toThrow();
    });

    it("accepts a producer-generated patch for a path containing spaces", () => {
      const entry = createEntry();
      entry.changedFileCount = 1;
      entry.changedFiles = ["sdk/widget/Azure.Widget/src/Generated/Widget Client.cs"];
      const patch =
        "diff --git a/sdk/widget/Azure.Widget/src/Generated/Widget Client.cs b/sdk/widget/Azure.Widget/src/Generated/Widget Client.cs\n+// changed\n";

      expect(() => verifyPatchPaths(entry, patch)).not.toThrow();
    });

    it("rejects undeclared patch paths", () => {
      const patch =
        validPatch +
        "diff --git a/sdk/widget/Azure.Widget/src/Generated/Extra.cs b/sdk/widget/Azure.Widget/src/Generated/Extra.cs\n";
      expect(() => verifyPatchPaths(createEntry(), patch)).toThrow("undeclared");
    });

    it("rejects missing declared patch paths", () => {
      const patch =
        "diff --git a/sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs b/sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs\n";
      expect(() => verifyPatchPaths(createEntry(), patch)).toThrow("missing");
    });

    it("rejects quoted or ambiguous diff paths", () => {
      const patch =
        'diff --git "a/sdk/widget/Azure.Widget/src/Generated/Widget Client.cs" "b/sdk/widget/Azure.Widget/src/Generated/Widget Client.cs"\n';
      expect(() => verifyPatchPaths(createEntry(), patch)).toThrow("unsupported quoted");
    });
  });

  describe("runSdkValidationDotnetReviewHandoffImpl", () => {
    it("downloads, validates checksums for multiple packages, writes summary, and performs zero PR mutations", async () => {
      const mockGithub = createMockGithub();
      const mockContext = createMockContext();
      const mockCore = createMockCore();
      const outputRootDir = createTempOutputDir();

      mockContext.payload = createSampleCheckRunPayload({
        pull_requests: [], // Verify fork/empty pull_requests fallback via manifest.specPrNumber + pulls.get
      });
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: {
          number: 47607,
          state: "open",
          head: { sha: SAMPLE_HEAD_SHA },
          base: { repo: { full_name: "owner/repo" } },
        },
      });

      const patch1 =
        "diff --git a/sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs b/sdk/widget/Azure.Widget/src/Generated/WidgetClient.cs\n+// pkg1\n";
      const patch2 =
        "diff --git a/sdk/gadget/Azure.ResourceManager.Gadget/src/Generated/GadgetResource.cs b/sdk/gadget/Azure.ResourceManager.Gadget/src/Generated/GadgetResource.cs\n+// pkg2\n";
      const manifest = createSampleManifest({ entry1: patch1, entry2: patch2 });

      mockFetch.mockImplementation((url) => {
        if (url.includes(`artifacts?artifactName=${SDK_REVIEW_BUNDLE_ARTIFACT_NAME}`)) {
          return Promise.resolve({
            ok: true,
            json: vi.fn().mockResolvedValue({
              resource: {
                downloadUrl: "https://artprodcus3.artifacts.visualstudio.com/download?format=zip",
              },
            }),
          });
        }
        if (url.includes(`subPath=/${SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME}`)) {
          return Promise.resolve({
            ok: true,
            text: vi.fn().mockResolvedValue(JSON.stringify(manifest)),
          });
        }
        if (url.includes("subPath=/01-Azure.Widget.patch")) {
          return Promise.resolve({
            ok: true,
            text: vi.fn().mockResolvedValue(patch1),
          });
        }
        if (url.includes("subPath=/02-Azure.ResourceManager.Gadget.patch")) {
          return Promise.resolve({
            ok: true,
            text: vi.fn().mockResolvedValue(patch2),
          });
        }
        return Promise.resolve({
          ok: false,
          status: 404,
          statusText: "Not Found",
          text: vi.fn().mockResolvedValue("Not Found"),
        });
      });

      const result = await runSdkValidationDotnetReviewHandoffImpl({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
        outputRootDir,
        retryOptions: { initialDelayMs: 1 },
      });

      expect(result.status).toBe("validated");
      expect(result.entryCount).toBe(2);
      expect(result.prNumber).toBe(47607);
      expect(result.buildId).toBe(SAMPLE_BUILD_ID);
      expect(
        fs.readFileSync(path.join(result.bundleDirectory!, "01-Azure.Widget.patch"), "utf8"),
      ).toBe(patch1);
      expect(
        fs.readFileSync(
          path.join(result.bundleDirectory!, "02-Azure.ResourceManager.Gadget.patch"),
          "utf8",
        ),
      ).toBe(patch2);
      expect(fs.existsSync(result.summaryPath!)).toBe(true);
      expect(mockCore.summary.addRaw).toHaveBeenCalledWith(
        expect.stringContaining("SDK Validation - .NET Review Bundle Handoff (Report-Only)"),
      );
      expect(mockCore.summary.write).toHaveBeenCalledOnce();

      // Report-only guarantee: no comments, labels, or status mutations
      expect(mockGithub.rest.issues.createComment).not.toHaveBeenCalled();
      expect(mockGithub.rest.issues.updateComment).not.toHaveBeenCalled();
      expect(mockGithub.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(mockGithub.rest.repos.createCommitStatus).not.toHaveBeenCalled();
    });

    it("rejects stale PR head SHA before downloading artifacts when check_run.pull_requests is populated", async () => {
      const mockGithub = createMockGithub();
      const mockContext = createMockContext();
      const mockCore = createMockCore();

      mockContext.payload = createSampleCheckRunPayload();
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: {
          number: 47607,
          state: "open",
          head: { sha: "9999999999999999999999999999999999999999" },
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

    it("throws when downloaded patch content fails SHA-256 verification", async () => {
      const mockGithub = createMockGithub();
      const mockContext = createMockContext();
      const mockCore = createMockCore();

      mockContext.payload = createSampleCheckRunPayload();
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: {
          number: 47607,
          state: "open",
          head: { sha: SAMPLE_HEAD_SHA },
          base: { repo: { full_name: "owner/repo" } },
        },
      });

      const patch1 = "diff --git a/foo.cs b/foo.cs\n+// expected\n";
      const tamperedPatch1 = "diff --git a/foo.cs b/foo.cs\n+// tampered!\n";
      const manifest = createSampleManifest({ entry1: patch1 });

      mockFetch.mockImplementation((url) => {
        if (url.includes(`artifacts?artifactName=${SDK_REVIEW_BUNDLE_ARTIFACT_NAME}`)) {
          return Promise.resolve({
            ok: true,
            json: vi.fn().mockResolvedValue({
              resource: {
                downloadUrl: "https://artprodcus3.artifacts.visualstudio.com/download?format=zip",
              },
            }),
          });
        }
        if (url.includes(`subPath=/${SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME}`)) {
          return Promise.resolve({
            ok: true,
            text: vi.fn().mockResolvedValue(JSON.stringify(manifest)),
          });
        }
        return Promise.resolve({
          ok: true,
          text: vi.fn().mockResolvedValue(tamperedPatch1),
        });
      });

      await expect(
        runSdkValidationDotnetReviewHandoffImpl({
          github: mockGithub,
          context: mockContext,
          core: mockCore,
          outputRootDir: createTempOutputDir(),
          retryOptions: { initialDelayMs: 1 },
        }),
      ).rejects.toThrow(/Patch (size|SHA-256) mismatch/);
    });

    it("rejects an over-limit manifest before any patch download", async () => {
      const mockGithub = createMockGithub();
      const mockContext = createMockContext();
      const mockCore = createMockCore();
      mockContext.payload = createSampleCheckRunPayload();
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: {
          number: 47607,
          state: "open",
          head: { sha: SAMPLE_HEAD_SHA },
          base: { repo: { full_name: "owner/repo" } },
        },
      });

      const manifest = createSampleManifest({ entry1: "" });
      manifest.entries[0].patchBytes = MAX_SDK_REVIEW_TOTAL_PATCH_BYTES + 1;
      const manifestJson = JSON.stringify(manifest);
      mockFetch.mockImplementation((url) => {
        if (url.includes(`artifacts?artifactName=${SDK_REVIEW_BUNDLE_ARTIFACT_NAME}`)) {
          return Promise.resolve({
            ok: true,
            json: vi.fn().mockResolvedValue({
              resource: { downloadUrl: "https://example.com/download?format=zip" },
            }),
          });
        }
        if (url.includes(`subPath=/${SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME}`)) {
          return Promise.resolve({
            ok: true,
            text: vi.fn().mockResolvedValue(manifestJson),
          });
        }
        throw new Error(`Unexpected patch download: ${url}`);
      });

      await expect(
        runSdkValidationDotnetReviewHandoffImpl({
          github: mockGithub,
          context: mockContext,
          core: mockCore,
          outputRootDir: createTempOutputDir(),
          retryOptions: { initialDelayMs: 1 },
        }),
      ).rejects.toThrow(/patchBytes|patch bytes/);
      expect(mockFetch.mock.calls.filter(([url]) => String(url).includes(".patch")).length).toBe(0);
    });

    it("rejects manifest bytes above the limit before parsing", async () => {
      const mockGithub = createMockGithub();
      const mockContext = createMockContext();
      const mockCore = createMockCore();
      mockContext.payload = createSampleCheckRunPayload();
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: {
          number: 47607,
          state: "open",
          head: { sha: SAMPLE_HEAD_SHA },
          base: { repo: { full_name: "owner/repo" } },
        },
      });
      const oversizedManifest = "x".repeat(MAX_SDK_REVIEW_MANIFEST_BYTES + 1);
      mockFetch.mockImplementation((url) => {
        if (url.includes(`artifacts?artifactName=${SDK_REVIEW_BUNDLE_ARTIFACT_NAME}`)) {
          return Promise.resolve({
            ok: true,
            json: vi.fn().mockResolvedValue({
              resource: { downloadUrl: "https://example.com/download?format=zip" },
            }),
          });
        }
        return Promise.resolve({
          ok: true,
          text: vi.fn().mockResolvedValue(oversizedManifest),
        });
      });

      await expect(
        runSdkValidationDotnetReviewHandoffImpl({
          github: mockGithub,
          context: mockContext,
          core: mockCore,
          outputRootDir: createTempOutputDir(),
          retryOptions: { initialDelayMs: 1 },
        }),
      ).rejects.toThrow(`exceeds ${MAX_SDK_REVIEW_MANIFEST_BYTES} bytes`);
      expect(mockFetch).toHaveBeenCalledTimes(2);
    });

    it("fails a failed-status manifest without downloading patches", async () => {
      const mockGithub = createMockGithub();
      const mockContext = createMockContext();
      const mockCore = createMockCore();
      mockContext.payload = createSampleCheckRunPayload();
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: {
          number: 47607,
          state: "open",
          head: { sha: SAMPLE_HEAD_SHA },
          base: { repo: { full_name: "owner/repo" } },
        },
      });
      const completeManifest = createSampleManifest({ entry1: "" });
      const failedManifest: SdkReviewBundleManifest = {
        ...completeManifest,
        captureStatus: "failed",
        expectedEntryCount: 1,
        captureErrors: ["Missing packageRootPath"],
        entries: [],
      };
      mockFetch.mockImplementation((url) => {
        if (url.includes(`artifacts?artifactName=${SDK_REVIEW_BUNDLE_ARTIFACT_NAME}`)) {
          return Promise.resolve({
            ok: true,
            json: vi.fn().mockResolvedValue({
              resource: { downloadUrl: "https://example.com/download?format=zip" },
            }),
          });
        }
        return Promise.resolve({
          ok: true,
          text: vi.fn().mockResolvedValue(JSON.stringify(failedManifest)),
        });
      });

      await expect(
        runSdkValidationDotnetReviewHandoffImpl({
          github: mockGithub,
          context: mockContext,
          core: mockCore,
          outputRootDir: createTempOutputDir(),
        }),
      ).rejects.toThrow("SDK review bundle capture failed");
      expect(mockFetch).toHaveBeenCalledTimes(2);
    });

    it("requires a declared zero-byte patch file to be present", async () => {
      const mockGithub = createMockGithub();
      const mockContext = createMockContext();
      const mockCore = createMockCore();
      mockContext.payload = createSampleCheckRunPayload();
      mockGithub.rest.pulls.get.mockResolvedValue({
        data: {
          number: 47607,
          state: "open",
          head: { sha: SAMPLE_HEAD_SHA },
          base: { repo: { full_name: "owner/repo" } },
        },
      });
      const manifest = createSampleManifest({ entry1: "" });
      manifest.entries[0].changedFileCount = 0;
      manifest.entries[0].changedFiles = [];
      mockFetch.mockImplementation((url) => {
        if (url.includes(`artifacts?artifactName=${SDK_REVIEW_BUNDLE_ARTIFACT_NAME}`)) {
          return Promise.resolve({
            ok: true,
            json: vi.fn().mockResolvedValue({
              resource: { downloadUrl: "https://example.com/download?format=zip" },
            }),
          });
        }
        if (url.includes(`subPath=/${SDK_REVIEW_BUNDLE_MANIFEST_FILE_NAME}`)) {
          return Promise.resolve({
            ok: true,
            text: vi.fn().mockResolvedValue(JSON.stringify(manifest)),
          });
        }
        return Promise.resolve({
          ok: false,
          status: 404,
          statusText: "Not Found",
          text: vi.fn().mockResolvedValue("Not Found"),
        });
      });

      await expect(
        runSdkValidationDotnetReviewHandoffImpl({
          github: mockGithub,
          context: mockContext,
          core: mockCore,
          outputRootDir: createTempOutputDir(),
        }),
      ).rejects.toThrow("Failed to fetch artifact");
    });
  });
});
