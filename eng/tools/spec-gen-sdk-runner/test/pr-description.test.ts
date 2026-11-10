import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { afterEach, describe, expect, test } from "vitest";
import { parse } from "yaml";

const repoRoot = path.resolve(import.meta.dirname, "../../../..");
const renderer = path.join(repoRoot, "eng/scripts/New-SdkPullRequestBody.ps1");
const releasePlanScript = path.join(repoRoot, "eng/scripts/Get-ReleasePlan-Info.ps1");
const pwsh = process.platform === "win32" ? "pwsh.exe" : "pwsh";
const temporaryDirectories: string[] = [];
const requiredParameters = {
  ConfigType: "TypeSpec",
  ConfigPath: "specification/example/tspconfig.yaml",
  SpecRepoUrl: "https://example.test/specs",
  SpecCommitSha: "abc1234",
  PipelineRun: "https://example.test/build?buildId=42",
};

function runPowerShell(script: string, env: Record<string, string>) {
  const result = spawnSync(pwsh, ["-NoLogo", "-NoProfile", "-NonInteractive", "-Command", script], {
    encoding: "utf8",
    env: { ...process.env, ...env },
    timeout: 20000,
  });
  if (result.error) {
    throw result.error;
  }
  return result;
}

function render(parameters: Record<string, string> = {}) {
  return runPowerShell(
    "$ErrorActionPreference = 'Stop'; $p = ConvertFrom-Json $env:PARAMETERS -AsHashtable; & $env:RENDERER @p | ConvertTo-Json -Compress",
    {
      RENDERER: renderer,
      PARAMETERS: JSON.stringify({ ...requiredParameters, ...parameters }),
    },
  );
}

function renderedBody(parameters: Record<string, string> = {}): string {
  const result = render(parameters);
  expect(result.stderr).toBe("");
  expect(result.status).toBe(0);
  const body: unknown = JSON.parse(result.stdout);
  expect(typeof body).toBe("string");
  return String(body);
}

function findPipelineScript(
  value: unknown,
  displayName: string,
  scriptProperty = "script",
): string | undefined {
  if (!value || typeof value !== "object") {
    return undefined;
  }
  if ("displayName" in value && value.displayName === displayName) {
    if ("inputs" in value && value.inputs && typeof value.inputs === "object") {
      if (scriptProperty in value.inputs) {
        const script: unknown = Reflect.get(value.inputs, scriptProperty);
        if (typeof script === "string") {
          return script;
        }
      }
    }
    throw new Error(`The ${displayName} task must contain an inline script.`);
  }
  for (const child of Object.values(value)) {
    const script = findPipelineScript(child, displayName, scriptProperty);
    if (script) {
      return script;
    }
  }
  return undefined;
}

afterEach(() => {
  for (const directory of temporaryDirectories.splice(0)) {
    fs.rmSync(directory, { recursive: true, force: true });
  }
});

describe("SDK pull request description", () => {
  test("renders the existing v1 format with source, generated versions, release and submitter links", () => {
    const body = renderedBody({
      ApiVersionsJson: JSON.stringify([
        { version: "2025-01-01", namespace: "Microsoft.Example" },
        { version: "2026-01-01-preview" },
      ]),
      SdkReleaseType: "beta",
      ReleasePlanJson: JSON.stringify({
        url: "https://example.test/plans?releaseplan=99",
        submittedBy: "submitter@example.test",
      }),
    });
    expect(body).toBe(
      [
        "<!-- azsdk-autopr-description:v1:start -->",
        "## SDK Generation Details",
        "",
        "> [!NOTE]",
        "> This pull request was generated automatically.",
        "",
        "| Detail | Value |",
        "| :--- | :--- |",
        "| **TypeSpec source** | [`specification/example/tspconfig.yaml`](https://example.test/specs/blob/abc1234/specification/example/tspconfig.yaml) at [`abc1234`](https://example.test/specs/commit/abc1234) |",
        "| **API versions** | `2025-01-01` (Namespace: `Microsoft.Example`)<br>`2026-01-01-preview` |",
        "| **SDK release type** | `beta` |",
        "| **Pipeline run** | [SDK Generation #42](https://example.test/build?buildId=42) |",
        "| **Release plan** | [Release plan #99](https://example.test/plans?releaseplan=99) |",
        "| **Submitted by** | `submitter@example.test` |",
        "",
        "> [!IMPORTANT]",
        "> Complete the [SDK release prerequisites](https://eng.ms/docs/products/azure-developer-experience/develop/sdk-release/sdk-release-prerequisites) before release.",
        "<!-- azsdk-autopr-description:v1:end -->",
      ].join("\n"),
    );
    expect(body).not.toContain("Configurations:");
  });

  test("omits unavailable metadata rather than substituting the requested version", () => {
    const body = renderedBody({ SdkReleaseType: "none" });
    expect(body).not.toContain("**API version");
    expect(body).not.toContain("**SDK release type**");
    expect(body).not.toContain("**Release plan**");
    expect(body).not.toContain("**Submitted by**");
    expect(body).toContain("**Pipeline run**");
  });

  test("supports OpenAPI and keeps the full source SHA in URLs", () => {
    const sha = "a".repeat(40);
    const body = renderedBody({
      ConfigType: "OpenAPI",
      ConfigPath: "specification/example/resource-manager/readme.md",
      SpecCommitSha: sha,
      SpecRepoUrl: "https://example.test/specs/",
    });
    expect(body).toContain("| **OpenAPI source** |");
    expect(body).toContain(`/blob/${sha}/specification/example/resource-manager/readme.md`);
    expect(body).toContain(`[\`aaaaaaa\`](https://example.test/specs/commit/${sha})`);
  });

  test("preserves literal PowerShell syntax, Unicode, percent signs and Markdown metacharacters", () => {
    const version = "2026`test|O'Brien $HOME $(throw 'must not execute') %0A 中文";
    const body = renderedBody({
      ConfigPath: "specification/example (test)/tspconfig.yaml",
      ApiVersionsJson: JSON.stringify([{ version, namespace: "Microsoft.``Example" }]),
    });
    expect(body).toContain("example%20%28test%29/tspconfig.yaml");
    expect(body).toContain("``2026`test\\|O'Brien $HOME $(throw 'must not execute') %0A 中文``");
    expect(body).toContain("```Microsoft.``Example```");
    expect(body).not.toContain("\r");
  });

  test("renders link labels when optional query IDs are missing", () => {
    const body = renderedBody({
      PipelineRun: "https://example.test/build",
      ReleasePlanJson: JSON.stringify({ url: "https://example.test/plans", submittedBy: "" }),
    });
    expect(body).toContain("[Open pipeline run](https://example.test/build)");
    expect(body).toContain("[Open release plan](https://example.test/plans)");
    expect(body).not.toContain("**Submitted by**");
  });

  test("escapes query IDs in link labels without changing their destinations", () => {
    const body = renderedBody({
      PipelineRun: "https://example.test/build?buildId=42%5D%7C%0Aextra",
      ReleasePlanJson: JSON.stringify({ url: "https://example.test/plans?releaseplan=99%5B" }),
    });
    expect(body).toContain("[SDK Generation #42\\]\\| extra]");
    expect(body).toContain("[Release plan #99\\[]");
    expect(body).toContain("buildId=42%5D%7C%0Aextra");
  });

  test.each<Record<string, string>>([
    { ApiVersionsJson: "not JSON" },
    { ApiVersionsJson: "{}" },
    { ApiVersionsJson: '[{"version":123}]' },
    { ApiVersionsJson: '[{"version":""}]' },
    { ApiVersionsJson: '[{"version":"2025-01-01","namespace":123}]' },
    { ReleasePlanJson: "[]" },
    { ReleasePlanJson: '{"url":123}' },
    { ReleasePlanJson: '{"url":"file:///local"}' },
    { ReleasePlanJson: '{"submittedBy":123}' },
    { PipelineRun: "relative/path" },
    { SpecCommitSha: "not-a-sha" },
  ])("rejects malformed metadata explicitly: %j", (parameters) => {
    const result = render(parameters);
    expect(result.status).not.toBe(0);
    expect(result.stderr).not.toBe("");
    expect(result.stdout).not.toContain("## SDK Generation Details");
  });

  test("passes the exact rendered body through the actual pipeline submission script", () => {
    const sdkRoot = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-pr-description-"));
    temporaryDirectories.push(sdkRoot);
    const commonScripts = path.join(sdkRoot, "eng/common/scripts");
    fs.mkdirSync(commonScripts, { recursive: true });
    fs.writeFileSync(
      path.join(commonScripts, "Submit-PullRequest.ps1"),
      "param($RepoOwner,$RepoName,$BaseBranch,$PROwner,$PRBranch,$AuthToken,$PRTitle,$PRBody,$PRLabels,$OpenAsDraft,$UpdateExistingPullRequest)\n@{ body=$PRBody; draft=$OpenAsDraft; update=$UpdateExistingPullRequest } | ConvertTo-Json -Compress",
    );
    const pipeline: unknown = parse(
      fs.readFileSync(
        path.join(repoRoot, "eng/pipelines/templates/stages/archetype-spec-gen-sdk.yml"),
        "utf8",
      ),
    );
    const script = findPipelineScript(pipeline, "Create pull request");
    expect(script).toBeDefined();
    const macros: Record<string, string> = {
      SpecRepoDirectory: repoRoot,
      SdkRepoDirectory: sdkRoot,
      SdkRepoName: "azure-sdk-for-example",
      SdkRepoOwner: "azure",
      SdkPullRequestSourceBranch: "probe",
      GH_TOKEN: "not-a-real-token",
      PrTitle: "Probe",
      "Build.DefinitionName": "SDK Generation",
      "Build.BuildId": "42",
      BuildFailedLabel: "",
      OpenSdkPullRequestAsDraft: "true",
    };
    const expanded = script?.replace(/\$\(([^)]+)\)/g, (_match, name: string) => {
      if (!(name in macros)) {
        throw new Error(`Unexpected pipeline macro: ${name}`);
      }
      return macros[name];
    });
    const apiVersions = JSON.stringify([{ version: "2025-01-01", namespace: "Example" }]);
    const result = runPowerShell(`$ErrorActionPreference = 'Stop'; ${expanded}`, {
      SDK_PR_CONFIG_TYPE: requiredParameters.ConfigType,
      SDK_PR_CONFIG_PATH: requiredParameters.ConfigPath,
      SDK_PR_SPEC_REPO_URL: requiredParameters.SpecRepoUrl,
      SDK_PR_SPEC_COMMIT_SHA: requiredParameters.SpecCommitSha,
      SDK_PR_PIPELINE_RUN: requiredParameters.PipelineRun,
      SDK_PR_RELEASE_TYPE: "",
      GENERATED_SDK_API_VERSIONS_JSON: apiVersions,
      RELEASE_PLAN_METADATA: "{}",
    });
    expect(result.stderr).toBe("");
    expect(result.status).toBe(0);
    expect(JSON.parse(result.stdout)).toEqual({
      body: renderedBody({ ApiVersionsJson: apiVersions }),
      draft: true,
      update: true,
    });
  });
});

describe("release plan description metadata", () => {
  test.each([false, true])("handles a missing work-item ID with AsJson=%s", (asJson) => {
    const result = runPowerShell(
      "$ErrorActionPreference = 'Stop'; $p = @{ ReleasePlanWorkItemId = 0 }; if ($env:AS_JSON -eq 'true') { $p.AsJson = $true }; $result = & $env:PLAN_SCRIPT @p 6>$null; $result | ConvertTo-Json -Compress",
      { PLAN_SCRIPT: releasePlanScript, AS_JSON: String(asJson) },
    );
    expect(result.stderr).toBe("");
    expect(result.status).toBe(0);
    if (asJson) {
      expect(JSON.parse(result.stdout)).toBe("{}");
    } else {
      expect(JSON.parse(result.stdout)).toContain("Release plan information is not available.");
    }
  });

  test("preserves percent escapes and literal script syntax through the pipeline logging command", () => {
    const specRoot = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-pr-metadata-"));
    temporaryDirectories.push(specRoot);
    const scriptDirectory = path.join(specRoot, "eng/scripts");
    fs.mkdirSync(scriptDirectory, { recursive: true });
    fs.writeFileSync(
      path.join(scriptDirectory, "Get-ReleasePlan-Info.ps1"),
      "param($ReleasePlanWorkItemId,[switch]$AsJson)\n$env:PLAN_JSON",
    );
    const pipeline: unknown = parse(
      fs.readFileSync(
        path.join(repoRoot, "eng/pipelines/templates/stages/archetype-spec-gen-sdk.yml"),
        "utf8",
      ),
    );
    const script = findPipelineScript(pipeline, "Get Release Plan details", "inlineScript");
    expect(script).toBeDefined();
    const expanded = script
      ?.replaceAll("$(SpecRepoDirectory)", specRoot)
      .replaceAll("${{ parameters.ReleasePlanWorkItemId }}", "123");
    const metadata = JSON.stringify({
      url: "https://example.test/plans?releaseplan=99&literal=%0A%AZP25",
      submittedBy: "O'Brien `literal` $HOME $(throw 'must not execute')\n中文",
    });
    const result = runPowerShell(`$ErrorActionPreference = 'Stop'; ${expanded}`, {
      PLAN_JSON: metadata,
    });
    expect(result.stderr).toBe("");
    expect(result.status).toBe(0);
    const prefix = "##vso[task.setvariable variable=ReleasePlanMetadata]";
    const command = result.stdout.split(/\r?\n/).find((line) => line.startsWith(prefix));
    expect(command).toBeDefined();
    const decoded = command
      ?.slice(prefix.length)
      .replaceAll("%0D", "\r")
      .replaceAll("%0A", "\n")
      .replaceAll("%AZP25", "%");
    expect(decoded).toBe(metadata);
  });

  function getReleasePlan(fields: Record<string, unknown>, asJson: boolean) {
    return runPowerShell(
      `
      $ErrorActionPreference = 'Stop'
      function az { 'not-a-real-token' }
      function Invoke-RestMethod {
        param($Method,$Uri,$Headers,$Body,$ContentType,$MaximumRetryCount)
        if ($Method -eq 'POST' -and $Uri.StartsWith('https://dev.azure.com/azure-sdk/Release/_apis/wit/wiql/')) {
          return @{ workItems = @(@{ id = 123 }) }
        }
        if ($Method -eq 'GET' -and $Uri.StartsWith('https://dev.azure.com/azure-sdk/Release/_apis/wit/workitems?')) {
          return @{ value = @(@{ fields = (ConvertFrom-Json $env:PLAN_FIELDS -AsHashtable) }) }
        }
        throw "Unexpected network call: $Uri"
      }
      $p = @{ ReleasePlanWorkItemId = 123 }
      if ($env:AS_JSON -eq 'true') { $p.AsJson = $true }
      $result = & $env:PLAN_SCRIPT @p 6>$null
      $result | ConvertTo-Json -Compress
      `,
      {
        PLAN_SCRIPT: releasePlanScript,
        PLAN_FIELDS: JSON.stringify(fields),
        AS_JSON: String(asJson),
      },
    );
  }

  test("returns structured dashboard metadata without confusing work-item and plan IDs", () => {
    const result = getReleasePlan(
      { "Custom.ReleasePlanID": 99, "Custom.ReleasePlanSubmittedby": "submitter@example.test" },
      true,
    );
    expect(result.stderr).toBe("");
    expect(result.status).toBe(0);
    const metadata: unknown = JSON.parse(result.stdout);
    expect(typeof metadata).toBe("string");
    expect(JSON.parse(String(metadata))).toEqual({
      url: "https://azsdk-releaseplan-dashboard-hveph5aqhhcfhtgu.westus-01.azurewebsites.net/?releaseplan=99",
      submittedBy: "submitter@example.test",
    });
  });

  test("preserves the legacy output for existing callers", () => {
    const result = getReleasePlan(
      { "Custom.ReleasePlanID": 99, "Custom.ReleasePlanSubmittedby": "submitter@example.test" },
      false,
    );
    expect(result.status).toBe(0);
    expect(JSON.parse(result.stdout)).toContain("**Release plan link:** [https://");
    expect(JSON.parse(result.stdout)).toContain("**Submitted by**: submitter@example.test");
  });

  test("returns an empty metadata object when the dashboard ID is unavailable", () => {
    const result = getReleasePlan({ "Custom.ReleasePlanID": 0 }, true);
    expect(result.stderr).toBe("");
    expect(result.status).toBe(0);
    expect(JSON.parse(result.stdout)).toBe("{}");
  });
});
