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
    `
    $ErrorActionPreference = 'Stop'
    $p = ConvertFrom-Json $env:PARAMETERS -AsHashtable
    $output = @(& $env:RENDERER @p 6>&1)
    @{
      value = ($output | Where-Object { $_ -is [string] })
      warnings = @($output | Where-Object { $_ -is [System.Management.Automation.InformationRecord] } | ForEach-Object { $_.ToString() })
    } | ConvertTo-Json -Compress
    `,
    {
      RENDERER: renderer,
      PARAMETERS: JSON.stringify({ ...requiredParameters, ...parameters }),
    },
  );
}

function scriptOutput(result: ReturnType<typeof runPowerShell>) {
  expect(result.stderr).toBe("");
  expect(result.status).toBe(0);
  const output: unknown = JSON.parse(result.stdout);
  if (
    !output ||
    typeof output !== "object" ||
    !("value" in output) ||
    typeof output.value !== "string" ||
    !("warnings" in output) ||
    !Array.isArray(output.warnings)
  ) {
    throw new Error("Expected one string output and a warning array.");
  }
  const warnings: unknown[] = output.warnings;
  return { value: output.value, warnings };
}

function renderedBody(parameters: Record<string, string> = {}): string {
  const output = scriptOutput(render(parameters));
  expect(output.warnings).toEqual([]);
  return output.value;
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
    if ("pwsh" in value && typeof value.pwsh === "string") {
      return value.pwsh;
    }
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

  test("explains an unavailable release plan instead of silently omitting it", () => {
    const body = renderedBody({ ReleasePlanJson: '{"unavailable":true}' });
    expect(body).toContain(
      "| **Release plan** | Release plan information is not available. Create a release plan and link SDK pull request to the release plan. Refer [aka.ms/azsdk/releaseplan-dashboard](https://aka.ms/azsdk/releaseplan-dashboard) for more info. |",
    );
    expect(body).not.toContain("**Submitted by**");
  });

  test.each([
    "",
    "not JSON",
    "{}",
    "null",
    '[{"version":123}]',
    '[{"version":""}]',
    '[{"version":"2025-01-01","namespace":123}]',
    "[null]",
  ])("warns and omits invalid API versions without failing rendering: %s", (apiVersionsJson) => {
    const { value: body, warnings } = scriptOutput(render({ ApiVersionsJson: apiVersionsJson }));
    expect(warnings).toEqual(
      expect.arrayContaining([expect.stringContaining("##vso[task.logissue type=warning]")]),
    );
    expect(body).not.toContain("**API versions**");
    expect(body).toContain("| **Pipeline run** |");
    expect(body).toContain("<!-- azsdk-autopr-description:v1:end -->");
  });

  test("retains valid API versions when other entries are malformed", () => {
    const { value: body, warnings } = scriptOutput(
      render({
        ApiVersionsJson: JSON.stringify([
          { version: 123 },
          { version: "2025-01-01", namespace: "Example" },
          { version: "2026-01-01", namespace: false },
          { version: "2024-01-01", namespace: null },
        ]),
      }),
    );
    expect(warnings).toHaveLength(2);
    expect(body).toContain(
      "| **API versions** | `2025-01-01` (Namespace: `Example`)<br>`2024-01-01` |",
    );
    expect(body).not.toContain("2026-01-01");
  });

  test.each([
    "",
    "not JSON",
    "null",
    "[]",
    '[{"url":"https://example.test/plans"}]',
    '{"unavailable":"false"}',
    '{"unavailable":null}',
    '{"url":123}',
    '{"url":false}',
    '{"url":""}',
    '{"url":"file:///local"}',
  ])("warns and renders guidance for malformed release-plan metadata: %s", (releasePlanJson) => {
    const { value: body, warnings } = scriptOutput(render({ ReleasePlanJson: releasePlanJson }));
    expect(warnings).toEqual(
      expect.arrayContaining([expect.stringContaining("##vso[task.logissue type=warning]")]),
    );
    expect(body).toContain("| **Release plan** | Release plan information is not available.");
    expect(body).toContain("](https://aka.ms/azsdk/releaseplan-dashboard)");
    expect(body).not.toContain("**Submitted by**");
  });

  test.each([123, false, null])(
    "omits a malformed submitter but preserves the plan: %j",
    (submitter) => {
      const { value: body, warnings } = scriptOutput(
        render({
          ReleasePlanJson: JSON.stringify({
            url: "https://example.test/plans?releaseplan=99",
            submittedBy: submitter,
          }),
        }),
      );
      expect(warnings).toEqual([
        expect.stringContaining("The release plan submitter must be a string"),
      ]);
      expect(body).toContain("[Release plan #99](https://example.test/plans?releaseplan=99)");
      expect(body).not.toContain("**Submitted by**");
    },
  );

  test.each<Record<string, string>>([
    { ConfigType: "Other" },
    { ConfigPath: "" },
    { SpecRepoUrl: "relative/path" },
    { PipelineRun: "relative/path" },
    { SpecCommitSha: "not-a-sha" },
  ])("still rejects malformed required inputs: %j", (parameters) => {
    const result = render(parameters);
    expect(result.status).not.toBe(0);
    expect(result.stderr).not.toBe("");
    expect(result.stdout).not.toContain("## SDK Generation Details");
  });

  test.each([
    {
      apiVersions: JSON.stringify([{ version: "2025-01-01", namespace: "Example" }]),
      releasePlan: "{}",
    },
    { apiVersions: "invalid JSON", releasePlan: "invalid JSON" },
  ])("submits a complete body even with optional metadata %j", ({ apiVersions, releasePlan }) => {
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
    const result = runPowerShell(
      `
      $ErrorActionPreference = 'Stop'
      $output = @(& { ${expanded} } 6>&1)
      @{
        value = ($output | Where-Object { $_ -is [string] })
        warnings = @($output | Where-Object { $_ -is [System.Management.Automation.InformationRecord] } | ForEach-Object { $_.ToString() })
      } | ConvertTo-Json -Compress
      `,
      {
        SDK_PR_CONFIG_TYPE: requiredParameters.ConfigType,
        SDK_PR_CONFIG_PATH: requiredParameters.ConfigPath,
        SDK_PR_SPEC_REPO_URL: requiredParameters.SpecRepoUrl,
        SDK_PR_SPEC_COMMIT_SHA: requiredParameters.SpecCommitSha,
        SDK_PR_PIPELINE_RUN: requiredParameters.PipelineRun,
        SDK_PR_RELEASE_TYPE: "",
        GENERATED_SDK_API_VERSIONS_JSON: apiVersions,
        RELEASE_PLAN_METADATA: releasePlan,
      },
    );
    const { value: submission, warnings } = scriptOutput(result);
    const expected = scriptOutput(
      render({ ApiVersionsJson: apiVersions, ReleasePlanJson: releasePlan }),
    );
    expect(JSON.parse(submission)).toEqual({
      body: expected.value,
      draft: true,
      update: true,
    });
    expect(warnings).toEqual(expected.warnings);
  });
});

describe("release plan description metadata", () => {
  test.each([
    { workItemId: 0, expectedMetadata: {} },
    { workItemId: 123, expectedMetadata: { unavailable: true } },
  ])(
    "initializes metadata before lookup for work item $workItemId",
    ({ workItemId, expectedMetadata }) => {
      const pipeline: unknown = parse(
        fs.readFileSync(
          path.join(repoRoot, "eng/pipelines/templates/stages/archetype-spec-gen-sdk.yml"),
          "utf8",
        ),
      );
      const script = findPipelineScript(pipeline, "Create Run Time Variables");
      const parameters: Record<string, string> = {
        ConfigType: "TypeSpec",
        ConfigPath: requiredParameters.ConfigPath,
        SpecBatchTypes: "",
        SdkReleaseType: "none",
        ApiVersion: "none",
        SpecRepoUrl: "https://github.com/Azure/azure-rest-api-specs",
        SdkRepoUrl: "https://github.com/Azure/azure-sdk-for-go",
        SdkRepoBranch: "main",
        ReleasePlanWorkItemId: String(workItemId),
      };
      const expanded = script
        ?.replace(/\$\{\{\s*parameters\.(\w+)\s*\}\}/g, (_match, name: string) => {
          if (!(name in parameters)) {
            throw new Error(`Unexpected template parameter: ${name}`);
          }
          return parameters[name];
        })
        .replaceAll("$(Build.Reason)", "Manual")
        .replaceAll("$(System.DefaultWorkingDirectory)", repoRoot);
      const result = runPowerShell(`$ErrorActionPreference = 'Stop'; ${expanded}`, {});
      expect(result.stderr).toBe("");
      expect(result.status).toBe(0);
      const prefix = "##vso[task.setvariable variable=ReleasePlanMetadata]";
      const command = result.stdout.split(/\r?\n/).find((line) => line.startsWith(prefix));
      expect(command).toBeDefined();
      expect(JSON.parse(command?.slice(prefix.length) ?? "")).toEqual(expectedMetadata);
    },
  );

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

  function getReleasePlan(
    fields: Record<string, unknown>,
    asJson: boolean,
    lookupMode: "success" | "missing" | "throw" | "error" | "native-error" = "success",
  ) {
    return runPowerShell(
      `
      $ErrorActionPreference = 'Stop'
      function az {
        if ($env:LOOKUP_MODE -eq 'native-error') { $global:LASTEXITCODE = 1; return }
        'not-a-real-token'
      }
      function Invoke-RestMethod {
        param($Method,$Uri,$Headers,$Body,$ContentType,$MaximumRetryCount)
        if ($env:LOOKUP_MODE -eq 'throw') { throw 'DevOps REST lookup failed' }
        if ($env:LOOKUP_MODE -eq 'error') { Write-Error 'DevOps REST lookup failed'; return }
        if ($Method -eq 'POST' -and $Uri.StartsWith('https://dev.azure.com/azure-sdk/Release/_apis/wit/wiql/')) {
          if ($env:LOOKUP_MODE -eq 'missing') { return @{ workItems = @() } }
          return @{ workItems = @(@{ id = 123 }) }
        }
        if ($Method -eq 'GET' -and $Uri.StartsWith('https://dev.azure.com/azure-sdk/Release/_apis/wit/workitems?')) {
          return @{ value = @(@{ fields = (ConvertFrom-Json $env:PLAN_FIELDS -AsHashtable) }) }
        }
        throw "Unexpected network call: $Uri"
      }
      $p = @{ ReleasePlanWorkItemId = 123 }
      if ($env:AS_JSON -eq 'true') { $p.AsJson = $true }
      $output = @(& $env:PLAN_SCRIPT @p 6>&1)
      @{
        value = ($output | Where-Object { $_ -is [string] })
        warnings = @($output | Where-Object {
          $_ -is [System.Management.Automation.InformationRecord] -and $_.ToString().StartsWith('##vso[task.logissue type=warning]')
        } | ForEach-Object { $_.ToString() })
      } | ConvertTo-Json -Compress
      `,
      {
        PLAN_SCRIPT: releasePlanScript,
        PLAN_FIELDS: JSON.stringify(fields),
        AS_JSON: String(asJson),
        LOOKUP_MODE: lookupMode,
      },
    );
  }

  test("returns structured dashboard metadata without confusing work-item and plan IDs", () => {
    const result = getReleasePlan(
      { "Custom.ReleasePlanID": 99, "Custom.ReleasePlanSubmittedby": "submitter@example.test" },
      true,
    );
    const { value: metadata, warnings } = scriptOutput(result);
    expect(warnings).toEqual([]);
    expect(JSON.parse(metadata)).toEqual({
      url: "https://azsdk-releaseplan-dashboard-hveph5aqhhcfhtgu.westus-01.azurewebsites.net/?releaseplan=99",
      submittedBy: "submitter@example.test",
    });
  });

  test("preserves the legacy output for existing callers", () => {
    const result = getReleasePlan(
      { "Custom.ReleasePlanID": 99, "Custom.ReleasePlanSubmittedby": "submitter@example.test" },
      false,
    );
    const { value, warnings } = scriptOutput(result);
    expect(warnings).toEqual([]);
    expect(value).toContain("**Release plan link:** [https://");
    expect(value).toContain("**Submitted by**: submitter@example.test");
  });

  test.each([0, "", null])("marks dashboard ID %j as unavailable", (id) => {
    const { value, warnings } = scriptOutput(getReleasePlan({ "Custom.ReleasePlanID": id }, true));
    expect(JSON.parse(value)).toEqual({ unavailable: true });
    expect(warnings).toEqual([expect.stringContaining("Release plan ID is empty or 0")]);
    expect(renderedBody({ ReleasePlanJson: value })).toContain(
      "| **Release plan** | Release plan information is not available.",
    );
  });

  test.each(["missing", "throw", "error", "native-error"] as const)(
    "lookup failure %s produces guidance without failing",
    (mode) => {
      const { value, warnings } = scriptOutput(getReleasePlan({}, true, mode));
      expect(JSON.parse(value)).toEqual({ unavailable: true });
      expect(warnings).toEqual([expect.stringContaining("##vso[task.logissue type=warning]")]);
      expect(renderedBody({ ReleasePlanJson: value })).toContain(
        "| **Release plan** | Release plan information is not available.",
      );
    },
  );

  test("preserves the legacy guidance when lookup throws", () => {
    const { value, warnings } = scriptOutput(getReleasePlan({}, false, "throw"));
    expect(value).toBe(
      "Release plan information is not available. Create a release plan and link SDK pull request to the release plan. Refer aka.ms/azsdk/releaseplan-dashboard for more info.",
    );
    expect(warnings).toEqual([expect.stringContaining("DevOps REST lookup failed")]);
  });
});
