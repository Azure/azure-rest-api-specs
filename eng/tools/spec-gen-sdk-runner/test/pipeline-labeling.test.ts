import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { expect, test } from "vitest";

const testDirectory = path.dirname(fileURLToPath(import.meta.url));
const pipelineTemplatePath = path.resolve(
  testDirectory,
  "../../../pipelines/templates/stages/archetype-spec-gen-sdk.yml",
);
const pipelineTemplate = fs.readFileSync(pipelineTemplatePath, "utf8");

test("passes the emitted build-failed label when creating the SDK pull request", () => {
  expect(pipelineTemplate).toContain('PRLabels = "$(BuildFailedLabel)"');
});

test("includes generated API versions in the PR body without evaluating metadata as PowerShell", () => {
  expect(pipelineTemplate).toContain("$prBody = $env:GENERATED_SDK_INFORMATION");
  expect(pipelineTemplate).toContain("GENERATED_SDK_INFORMATION: $(GeneratedSDKInformation)");
  expect(pipelineTemplate).toContain("GENERATED_SDK_API_VERSIONS: $(GeneratedSDKApiVersions)");
  expect(pipelineTemplate).toContain("RELEASE_PLAN_INFO: $(ReleasePlanInfo)");
  expect(pipelineTemplate).toContain(
    '$prBody.Replace(" and CommitSHA:", " $env:GENERATED_SDK_API_VERSIONS, and CommitSHA:")',
  );
  expect(pipelineTemplate).toContain(
    "if (-not [string]::IsNullOrWhiteSpace($env:GENERATED_SDK_API_VERSIONS))",
  );
  expect(pipelineTemplate).toContain('$prBody = "$prBody  $env:RELEASE_PLAN_INFO"');
  expect(pipelineTemplate).not.toContain(
    'sdk_gen_info="$sdk_gen_info API Version: ${{ parameters.ApiVersion }},"',
  );
  expect(pipelineTemplate).toContain(
    'optional_params="$optional_params --api-version ${{ parameters.ApiVersion }}"',
  );
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
  expect(pipelineTemplate).not.toContain("%AZP25");
});

test("installs azsdk for all SDK PR creation languages and retains Rust validation support", () => {
  expect(pipelineTemplate).toContain(
    "Condition: and(succeeded(), or(contains(variables['SdkRepoName'], 'rust'), ne(variables['Build.Reason'], 'PullRequest')))",
  );
});
