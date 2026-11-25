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

function render(parameters: Record<string, string | boolean> = {}) {
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

function renderedBody(parameters: Record<string, string | boolean> = {}): string {
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
      if (
        "filePath" in value.inputs &&
        typeof value.inputs.filePath === "string" &&
        "arguments" in value.inputs &&
        typeof value.inputs.arguments === "string"
      ) {
        return `& "${value.inputs.filePath}" ${value.inputs.arguments}`;
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

  test.each<{
    apiVersions: string;
    releasePlan: string;
    lookup: string;
    scenario?: string;
    labelAction?: "add" | "remove" | "none";
    existingLabel?: boolean;
  }>([
    {
      apiVersions: JSON.stringify([{ version: "2025-01-01", namespace: "Example" }]),
      releasePlan: "{}",
      lookup: "new",
    },
    { apiVersions: "invalid JSON", releasePlan: "invalid JSON", lookup: "new" },
    {
      apiVersions: JSON.stringify([{ version: "2026-01-01", namespace: "Example" }]),
      releasePlan: "{}",
      lookup: "existing",
      labelAction: "add",
    },
    {
      apiVersions: JSON.stringify([{ version: "2026-01-01", namespace: "Example" }]),
      releasePlan: "{}",
      lookup: "failure",
    },
    {
      apiVersions: '[{"version":"2025-01-01","namespace":"Example"}]',
      releasePlan: "{}",
      lookup: "existing",
      scenario: "unchanged",
    },
    {
      apiVersions: '[{"version":"2025-01-01","namespace":"Example"}]',
      releasePlan: "{}",
      lookup: "existing",
      scenario: "unchanged",
      existingLabel: true,
      labelAction: "remove",
    },
    {
      apiVersions: '[{"version":"2026-01-01","namespace":"Example"}]',
      releasePlan: "{}",
      lookup: "existing",
      scenario: "already-labeled",
      existingLabel: true,
    },
    {
      apiVersions: '[{"version":"2026-01-01","namespace":"Example"}]',
      releasePlan: "{}",
      lookup: "existing",
      scenario: "repeat",
      labelAction: "add",
    },
    {
      apiVersions: '[{"version":"2026-01-01","namespace":"Example"}]',
      releasePlan: "{}",
      lookup: "existing",
      scenario: "incomplete",
      existingLabel: true,
    },
    {
      apiVersions: "invalid JSON",
      releasePlan: "{}",
      lookup: "existing",
      scenario: "unavailable-repeat",
      labelAction: "add",
    },
    {
      apiVersions: '[{"version":"2025-01-01","namespace":"Example"}]',
      releasePlan: "{}",
      lookup: "existing",
      scenario: "resolved",
      existingLabel: true,
      labelAction: "remove",
    },
  ])(
    "submits a complete body even with optional metadata %j",
    ({
      apiVersions,
      releasePlan,
      lookup,
      scenario,
      labelAction = "none",
      existingLabel = false,
    }) => {
      const sdkRoot = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-pr-description-"));
      temporaryDirectories.push(sdkRoot);
      const commonScripts = path.join(sdkRoot, "eng/common/scripts");
      fs.mkdirSync(commonScripts, { recursive: true });
      fs.writeFileSync(
        path.join(commonScripts, "Submit-PullRequest.ps1"),
        "param($RepoOwner,$RepoName,$BaseBranch,$PROwner,$PRBranch,$AuthToken,$PRTitle,$PRBody,$PRLabels,$OpenAsDraft,$UpdateExistingPullRequest)\nWrite-Host '##vso[task.setvariable variable=Submitted.PullRequest.Number]123'\n@{ body=$PRBody; draft=$OpenAsDraft; update=$UpdateExistingPullRequest; token=$AuthToken } | ConvertTo-Json -Compress",
      );
      fs.writeFileSync(
        path.join(commonScripts, "Invoke-GitHubAPI.ps1"),
        `
      function Get-GitHubPullRequests {
        param($RepoOwner,$RepoName,$Head,$Base,$AuthToken)
        if ($env:PR_LOOKUP -eq 'failure') { throw 'lookup failed' }
        if ($RepoOwner -ne 'azure' -or $RepoName -ne 'azure-sdk-for-example' -or $Head -ne 'azure:probe' -or $Base -ne 'main' -or $AuthToken -ne 'not-a-real-token') {
          throw 'Unexpected PR lookup parameters'
        }
        # Mirror Invoke-RestMethod, which emits a JSON array response as a single object.
        $pullRequests = @()
        if ($env:PR_LOOKUP -eq 'existing') {
          $pullRequests = @(@{ body = $env:PREVIOUS_PR_BODY; labels = @(@{ name = 'Mgmt' }) + @(if ($env:EXISTING_LABEL -eq 'true') { @{ name = 'spec-api-versions-changed' } }) })
        }
        Write-Output -NoEnumerate $pullRequests
      }
      `,
      );
      const baseline = renderedBody({
        ApiVersionsJson: '[{"version":"2025-01-01","namespace":"Example"}]',
        CompareApiVersions: true,
        ApiVersionsComplete: true,
        PreviousPullRequestState: "new",
      });
      const previousBody =
        scenario === "repeat" || scenario === "unavailable-repeat" || scenario === "resolved"
          ? renderedBody({
              ApiVersionsJson: '[{"version":"2026-01-01","namespace":"Example"}]',
              CompareApiVersions: true,
              ApiVersionsComplete: true,
              PreviousPullRequestState: "existing",
              PreviousBody: baseline,
            })
          : baseline;
      const complete = apiVersions !== "invalid JSON" && scenario !== "incomplete";
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
          GENERATED_SDK_API_VERSIONS_COMPLETE: String(complete),
          SDK_PR_GITHUB_TOKEN: "not-a-real-token",
          RELEASE_PLAN_METADATA: releasePlan,
          PREVIOUS_PR_BODY: previousBody,
          PR_LOOKUP: lookup,
          EXISTING_LABEL: String(existingLabel),
        },
      );
      const { value: submission, warnings } = scriptOutput(result);
      const expected = scriptOutput(
        render({
          ApiVersionsJson: apiVersions,
          ReleasePlanJson: releasePlan,
          CompareApiVersions: true,
          ApiVersionsComplete: complete,
          PreviousBody: lookup === "existing" ? previousBody : "",
          PreviousPullRequestState: lookup === "failure" ? "unknown" : lookup,
        }),
      );
      expect(JSON.parse(submission)).toEqual({
        body: expected.value,
        draft: true,
        update: true,
        token: "not-a-real-token",
      });
      if (lookup === "failure") {
        expect(warnings).toContain(
          "##vso[task.logissue type=warning]API Versions comparison unavailable: could not read the previous PR description.",
        );
      }
      expect(warnings).toEqual(expect.arrayContaining(expected.warnings));
      const signalPrefix = "##vso[task.setvariable variable=SpecApiVersionsChangedLabelAction]";
      const signal = warnings.find(
        (entry): entry is string => typeof entry === "string" && entry.startsWith(signalPrefix),
      );
      expect(signal).toBe(`${signalPrefix}${labelAction}`);
      const submittedNumber = "##vso[task.setvariable variable=Submitted.PullRequest.Number]123";
      expect(warnings.indexOf(submittedNumber)).toBeLessThan(warnings.indexOf(signal));

      if (labelAction !== "none") {
        const labelScript = findPipelineScript(pipeline, "Update API versions changed label");
        expect(labelScript).toBeDefined();
        const labelMacros: Record<string, string> = {
          ...macros,
          SdkRepoDirectory: repoRoot,
          "Submitted.PullRequest.Number": "123",
        };
        const expandedLabelScript = labelScript?.replace(
          /\$\(([^)]+)\)/g,
          (_match, name: string) => {
            if (!(name in labelMacros)) {
              throw new Error(`Unexpected labeling macro: ${name}`);
            }
            return labelMacros[name];
          },
        );
        const labelResult = runPowerShell(
          `
          $ErrorActionPreference = 'Stop'
          $global:labelCalls = @()
          function Invoke-RestMethod {
            param($Method,$Uri,$Headers,$Body,$MaximumRetryCount)
            $global:labelCalls += @{ method=$Method; uri=$Uri; payload=$(if ($Body) { $Body | ConvertFrom-Json } else { $null }); token=$Headers.Authorization }
          }
          ${expandedLabelScript}
          ConvertTo-Json -InputObject @($global:labelCalls) -Compress -Depth 5
          `,
          { LABEL_ACTION: labelAction, SDK_PR_GITHUB_TOKEN: "not-a-real-token" },
        );
        expect(labelResult.stderr).toBe("");
        expect(labelResult.status).toBe(0);
        const labelUri =
          "https://api.github.com/repos/azure/azure-sdk-for-example/issues/123/labels";
        expect(JSON.parse(labelResult.stdout)).toEqual([
          labelAction === "add"
            ? {
                method: "POST",
                uri: labelUri,
                payload: { labels: ["spec-api-versions-changed"] },
                token: "bearer not-a-real-token",
              }
            : {
                method: "DELETE",
                uri: `${labelUri}/spec-api-versions-changed`,
                payload: null,
                token: "bearer not-a-real-token",
              },
        ]);
      }
    },
  );

  test("adds the auto-release label using the env-mapped token", () => {
    const pipeline: unknown = parse(
      fs.readFileSync(
        path.join(repoRoot, "eng/pipelines/templates/stages/archetype-spec-gen-sdk.yml"),
        "utf8",
      ),
    );
    const script = findPipelineScript(pipeline, "Add auto-release label");
    const macros: Record<string, string> = {
      SdkRepoDirectory: repoRoot,
      SdkRepoName: "azure-sdk-for-example",
      "Submitted.PullRequest.Number": "123",
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
      function Invoke-RestMethod {
        param($Method,$Uri,$Headers,$Body,$MaximumRetryCount)
        $global:labelCall = @{ method=$Method; uri=$Uri; payload=($Body | ConvertFrom-Json); token=$Headers.Authorization }
      }
      ${expanded}
      $global:labelCall | ConvertTo-Json -Compress -Depth 5
      `,
      { SDK_PR_GITHUB_TOKEN: "not-a-real-token" },
    );
    expect(result.stderr).toBe("");
    expect(result.status).toBe(0);
    expect(JSON.parse(result.stdout)).toEqual({
      method: "POST",
      uri: "https://api.github.com/repos/azure/azure-sdk-for-example/issues/123/labels",
      payload: { labels: ["auto-release"] },
      token: "bearer not-a-real-token",
    });
  });
});

describe("API Versions regeneration warning", () => {
  const warningTitle = "**API Versions changed during regeneration.**";
  const previousVersions = [
    { version: "2026-06-01", namespace: "Microsoft.Network" },
    { version: "2026-09-01-preview", namespace: "Microsoft.Network" },
    { version: "2026-01-01", namespace: "Microsoft.Storage" },
    { version: "unchanged", namespace: "Microsoft.Unchanged" },
  ];
  const currentVersions = [
    { version: "2026-06-01", namespace: "Microsoft.Network" },
    { version: "2026-10-01-preview", namespace: "Microsoft.Network" },
    { version: "2026-07-01", namespace: "Microsoft.Compute" },
    { version: "unchanged", namespace: "Microsoft.Unchanged" },
  ];
  function compare(
    versions: unknown,
    previousBody = "",
    options: Record<string, string | boolean> = {},
  ) {
    return scriptOutput(
      render({
        CompareApiVersions: true,
        ApiVersionsComplete: true,
        ApiVersionsJson: JSON.stringify(versions),
        PreviousPullRequestState: previousBody ? "existing" : "new",
        PreviousBody: previousBody,
        ...options,
      }),
    );
  }
  function changeSection(body: string) {
    return body
      .split("<!-- azsdk-api-version-warning:v1:start -->")[1]
      ?.split("<!-- azsdk-api-version-warning:v1:end -->")[0];
  }

  test("a new PR establishes a snapshot without inventing a change", () => {
    const { value: body, warnings } = compare(currentVersions);
    expect(warnings).toEqual([]);
    expect(body).not.toContain(warningTitle);
    expect(body).not.toContain("comparison unavailable");
    expect(body).toContain("<!-- azsdk-api-version-comparison:v1:");
    expect(body).toContain("| **API versions** |");
    expect(body.startsWith("<!-- azsdk-autopr-description:v1:start -->")).toBe(true);
    expect(body.endsWith("<!-- azsdk-autopr-description:v1:end -->")).toBe(true);
  });

  test("a new PR with incomplete metadata reports nothing until a later comparison", () => {
    const { value: body, warnings } = compare([], "", { ApiVersionsComplete: false });
    expect(warnings).toEqual([]);
    expect(body).not.toContain("comparison unavailable");
    expect(body).not.toContain(warningTitle);
    expect(compare(currentVersions, body).warnings).toContainEqual(
      expect.stringContaining("API Versions comparison unavailable"),
    );
  });

  test("shows only changed groups above details, including added and removed namespaces", () => {
    const previous = compare(previousVersions).value;
    const { value: body, warnings } = compare(currentVersions, previous);
    expect(warnings).toEqual([]);
    expect(body.indexOf(warningTitle)).toBeLessThan(body.indexOf("## SDK Generation Details"));
    expect(body).toContain(
      "> Review the changes below. If unintended, create a spec PR that sets the intended API version in `tspconfig.yaml`. Merging that PR will trigger SDK regeneration.",
    );
    const section = changeSection(body);
    expect(section).toContain("| Namespace | Previous API Versions | Current API Versions |");
    expect(section).toContain(
      "| `Microsoft.Network` | `2026-06-01`<br>`2026-09-01-preview` | `2026-06-01`<br>`2026-10-01-preview` |",
    );
    expect(section).toContain("| `Microsoft.Compute` | Not present | `2026-07-01` |");
    expect(section).toContain("| `Microsoft.Storage` | `2026-01-01` | Not present |");
    expect(section).not.toContain("Microsoft.Unchanged");
    expect(body.split("## SDK Generation Details")[1]).toContain("Microsoft.Unchanged");
  });

  test("ignores order and duplicate entries but preserves namespace associations and case", () => {
    const previous = compare([
      { version: "x", namespace: "A" },
      { version: "y", namespace: "B" },
    ]).value;
    const unchanged = compare(
      [
        { version: "y", namespace: "B" },
        { version: "x", namespace: "A" },
        { version: "x", namespace: "A" },
      ],
      previous,
    ).value;
    expect(unchanged).not.toContain(warningTitle);
    const changed = compare(
      [
        { version: "y", namespace: "A" },
        { version: "x", namespace: "b" },
      ],
      unchanged,
    ).value;
    expect(changeSection(changed)).toContain("| `A` | `x` | `y` |");
    expect(changeSection(changed)).toContain("| `B` | `y` | Not present |");
    expect(changeSection(changed)).toContain("| `b` | Not present | `x` |");
  });

  test("does not infer namespaces or chronological ordering", () => {
    const previous = compare([
      { version: "z", namespace: null },
      { version: "named", namespace: "A" },
    ]).value;
    const body = compare([{ version: "a" }, { version: "named", namespace: "A" }], previous).value;
    expect(changeSection(body)).toContain("| Namespace not reported | `z` | `a` |");
    expect(changeSection(body)).not.toContain("| `A` |");
  });

  test("does not mistake a pre-feature table for a complete baseline", () => {
    const previous = renderedBody({ ApiVersionsJson: JSON.stringify(previousVersions) });
    const { value: body, warnings } = compare(currentVersions, previous);
    expect(warnings).toContainEqual(expect.stringContaining("API Versions comparison unavailable"));
    expect(body).not.toContain(warningTitle);
    expect(compare(currentVersions, body).warnings).toEqual([]);
    expect(compare(previousVersions, body).value).toContain(warningTitle);
  });

  test("keeps an unresolved warning across repeated runs and clears only on return to its baseline", () => {
    const baseline = compare(previousVersions).value;
    const changed = compare(currentVersions, baseline).value;
    const repeated = compare(currentVersions, changed).value;
    expect(repeated).toBe(changed);
    const resolved = compare([...previousVersions].reverse(), repeated).value;
    expect(resolved).not.toContain(warningTitle);
    expect(resolved).not.toContain("comparison unavailable");
  });

  test("updates a pending warning against the original baseline, not the latest repeat", () => {
    const baseline = compare([{ version: "a", namespace: "A" }]).value;
    const changed = compare([{ version: "b", namespace: "A" }], baseline).value;
    const updated = compare([{ version: "c", namespace: "A" }], changed).value;
    expect(changeSection(updated)).toContain("| `A` | `a` | `c` |");
    expect(changeSection(updated)).not.toContain("`b`");
  });

  test("unknown current data retains an existing warning without mistaking partial data for removals", () => {
    const baseline = compare(previousVersions).value;
    const changed = compare(currentVersions, baseline).value;
    const { value: unknown, warnings } = compare([], changed, { ApiVersionsComplete: false });
    expect(warnings).toContainEqual(expect.stringContaining("API Versions comparison unavailable"));
    expect(changeSection(unknown)).toBe(changeSection(changed));
    expect(unknown).toContain("The warning table retains the last verified comparison");
    const stillChanged = compare(currentVersions, unknown).value;
    expect(changeSection(stillChanged)).toBe(changeSection(changed));
    expect(stillChanged).not.toContain("comparison unavailable");
    const restored = compare(previousVersions, unknown).value;
    expect(restored).not.toContain(warningTitle);
  });

  test.each(["", "legacy unstructured body", "pre-feature v1 without API versions"])(
    "unknown previous metadata emits a diagnostic, not a version-change warning: %s",
    (previous) => {
      const { value: body, warnings } = compare(
        currentVersions,
        previous.startsWith("pre-feature") ? renderedBody() : previous,
        {
          PreviousPullRequestState: "existing",
        },
      );
      expect(warnings).toContainEqual(
        expect.stringContaining("API Versions comparison unavailable"),
      );
      expect(body).not.toContain(warningTitle);
      expect(body).not.toContain("| Namespace | Previous API Versions");
      const next = compare(currentVersions, body).value;
      expect(next).not.toContain("comparison unavailable");
    },
  );

  test.each(["not JSON", '[{"version":"x"},{"version":123}]'])(
    "malformed current data is unknown even when marked complete: %s",
    (versions) => {
      const baseline = compare(previousVersions).value;
      const { value: body, warnings } = compare([], baseline, { ApiVersionsJson: versions });
      expect(warnings).toContainEqual(
        expect.stringContaining("API Versions comparison unavailable"),
      );
      expect(body).not.toContain(warningTitle);
      expect(compare(previousVersions, body).warnings).toContainEqual(
        expect.stringContaining("API Versions comparison unavailable"),
      );
    },
  );

  test("explicitly complete empty snapshots represent genuine additions or removals", () => {
    const empty = compare([]).value;
    const added = compare([{ version: "x" }], empty).value;
    expect(changeSection(added)).toContain("| Namespace not reported | Not present | `x` |");
    const removed = compare([], compare([{ version: "x" }]).value).value;
    expect(changeSection(removed)).toContain("| Namespace not reported | `x` | Not present |");
  });

  test("a failed prior-PR read cannot silently declare a previous warning resolved", () => {
    const { value: first, warnings } = compare(currentVersions, "", {
      PreviousPullRequestState: "unknown",
    });
    expect(warnings).toContainEqual(
      expect.stringContaining("Any earlier API Versions warning remains unresolved"),
    );
    const next = compare(currentVersions, first);
    expect(next.warnings).toContainEqual(expect.stringContaining("comparison unavailable"));
    expect(next.value).not.toContain(warningTitle);
  });

  test("malformed persisted state preserves the last warning and an unresolved diagnostic", () => {
    const baseline = compare(previousVersions).value;
    const changed = compare(currentVersions, baseline).value;
    const damaged = changed.replace(
      /<!-- azsdk-api-version-comparison:v1:[A-Za-z0-9+/=]+ -->/,
      "<!-- azsdk-api-version-comparison:v1:bm90LWpzb24= -->",
    );
    const unknown = compare(currentVersions, damaged);
    expect(unknown.warnings).toContainEqual(expect.stringContaining("state is malformed"));
    expect(changeSection(unknown.value)).toBe(changeSection(changed));
    const next = compare(currentVersions, unknown.value);
    expect(changeSection(next.value)).toBe(changeSection(changed));
    expect(next.value).toContain("comparison unavailable");
  });

  test("escapes comparison cells and keeps HTML comment delimiters out of stored metadata", () => {
    const namespace = "A|`B\n--> <!--unexpected-->";
    const baseline = compare([{ version: "a|b", namespace }]).value;
    const body = compare([{ version: "c``d", namespace }], baseline).value;
    expect(changeSection(body)).toContain("``A\\|`B --> <!--unexpected-->``");
    expect(changeSection(body)).toContain("`a\\|b`");
    expect(changeSection(body)).toContain("```c``d```");
    expect(body.match(/<!-- azsdk-api-version-comparison:v1:/g)).toHaveLength(1);
    expect(compare([{ version: "c``d", namespace }], body).value).toBe(body);
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
