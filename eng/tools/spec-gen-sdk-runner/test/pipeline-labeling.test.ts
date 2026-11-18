import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { expect, test } from "vitest";
import { parse } from "yaml";

const testDirectory = path.dirname(fileURLToPath(import.meta.url));
const pipelineTemplatePath = path.resolve(
  testDirectory,
  "../../../pipelines/templates/stages/archetype-spec-gen-sdk.yml",
);
const pipelineTemplate = fs.readFileSync(pipelineTemplatePath, "utf8");
const installAzsdkTemplatePath = path.resolve(
  testDirectory,
  "../../../common/pipelines/templates/steps/install-azsdk-cli.yml",
);
const installAzsdkTemplate = fs.readFileSync(installAzsdkTemplatePath, "utf8");

function findPipelineStep(
  value: unknown,
  displayName: string,
): Record<string, unknown> | undefined {
  if (!value || typeof value !== "object") {
    return undefined;
  }
  if ("displayName" in value && value.displayName === displayName) {
    return value;
  }
  for (const child of Object.values(value)) {
    const match = findPipelineStep(child, displayName);
    if (match) {
      return match;
    }
  }
  return undefined;
}

test("passes the emitted build-failed label when creating the SDK pull request", () => {
  expect(pipelineTemplate).toContain('PRLabels = "$(BuildFailedLabel)"');
});

test("passes structured metadata to the renderer as data, not PowerShell source", () => {
  const step = findPipelineStep(parse(pipelineTemplate), "Create pull request");
  expect(step?.env).toEqual(
    expect.objectContaining({
      SDK_PR_CONFIG_TYPE: "${{ parameters.ConfigType }}",
      SDK_PR_CONFIG_PATH: "${{ parameters.ConfigPath }}",
      SDK_PR_SPEC_REPO_URL: "${{ parameters.SpecRepoUrl }}",
      SDK_PR_SPEC_COMMIT_SHA: "$(SpecRepoCommit)",
      SDK_PR_PIPELINE_RUN:
        "$(System.CollectionUri)$(System.TeamProject)/_build/results?buildId=$(Build.BuildId)",
      GENERATED_SDK_API_VERSIONS_JSON: "$(GeneratedSDKApiVersionsJson)",
      RELEASE_PLAN_METADATA: "$(ReleasePlanMetadata)",
    }),
  );
  expect(pipelineTemplate).toContain(
    'optional_params+=(--api-version "${{ parameters.ApiVersion }}")',
  );
});

test("initializes optional metadata before generation can fail and keeps the commit message separate", () => {
  expect(pipelineTemplate).toContain(
    'Write-Host "##vso[task.setvariable variable=GeneratedSDKApiVersionsJson][]"',
  );
  expect(pipelineTemplate).toContain("CommitMsg: $(GeneratedSDKInformation)");
});

test("keeps release-plan lookup best-effort even after a native CLI failure", () => {
  const step = findPipelineStep(parse(pipelineTemplate), "Get Release Plan details");
  expect(step?.continueOnError).toBe(true);
  expect(step?.inputs).toEqual(expect.objectContaining({ powerShellIgnoreLASTEXITCODE: true }));
});

test("passes the composed PR body directly to the existing submission script", () => {
  expect(pipelineTemplate).toContain("targetType: inline");
  expect(pipelineTemplate).toContain("PRBody = $prBody");
  expect(pipelineTemplate).toContain(
    '& "$(SdkRepoDirectory)/eng/common/scripts/Submit-PullRequest.ps1" @prParameters',
  );
  expect(pipelineTemplate).toContain("OpenAsDraft = $$(OpenSdkPullRequestAsDraft)");
  expect(pipelineTemplate).toContain("UpdateExistingPullRequest = $true");
  expect(pipelineTemplate).not.toContain("GeneratedSDKPRInformation");
});

test("keeps azsdk installation mandatory for Rust generation", () => {
  expect(pipelineTemplate).toContain(
    "Condition: and(succeeded(), contains(variables['SdkRepoName'], 'rust'))",
  );
});

test("makes azsdk installation best-effort for non-Rust SDK PR creation", () => {
  expect(pipelineTemplate).toContain(
    "Condition: and(succeeded(), not(contains(variables['SdkRepoName'], 'rust')), ne(variables['Build.Reason'], 'PullRequest'))",
  );
  expect(pipelineTemplate).toContain("ContinueOnError: true");
  expect(installAzsdkTemplate).toContain("ContinueOnError: false");
  expect(installAzsdkTemplate).toContain("continueOnError: ${{ parameters.ContinueOnError }}");
});
