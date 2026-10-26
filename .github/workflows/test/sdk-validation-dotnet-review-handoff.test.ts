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
  parseAndValidateAdoBuildDetailsUrl,
  resolveSafeChildPath,
  runSdkValidationDotnetReviewHandoffImpl,
  validateCheckRunEventPayload,
  verifyManifestAgainstCheckRun,
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
  overrides: Partial<SdkReviewBundleManifest> = {},
): SdkReviewBundleManifest {
  const patch1Buf = Buffer.from(patchContents.entry1, "utf8");
  const entries: SdkReviewBundleManifest["entries"] = [
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
  });
});
