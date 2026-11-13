---
name: "Generated .NET SDK Review and TypeSpec Remediation (Report-Only)"
description: Review generated .NET SDK changes and translate findings into TypeSpec remediation guidance.
on:
  workflow_run:
    workflows: ["SDK Validation - .NET Naming Review Input"]
    types: [completed]
    branches: [main]
  roles: all
  permissions:
    actions: read
  steps:
    - id: find-input
      name: Find validated SDK review input
      uses: actions/github-script@3a2844b7e9c422d3c10d287c895573f7108da1b3 # v9.0.0
      with:
        script: |
          const runAttempt = context.payload.workflow_run.run_attempt;
          if (!Number.isSafeInteger(runAttempt) || runAttempt < 1) {
            throw new Error(`Invalid workflow run attempt: ${JSON.stringify(runAttempt)}`);
          }
          const attemptSuffix = `-attempt-${runAttempt}`;
          const response = await github.rest.actions.listWorkflowRunArtifacts({
            owner: context.repo.owner,
            repo: context.repo.repo,
            run_id: context.payload.workflow_run.id,
            per_page: 100,
          });
          const artifacts = response.data.artifacts.filter(
            (artifact) =>
              !artifact.expired &&
              artifact.name.startsWith("sdk-naming-review-input-build-") &&
              artifact.name.endsWith(attemptSuffix),
          );
          if (artifacts.length > 1) {
            throw new Error(`Expected at most one validated SDK review input, found ${artifacts.length}`);
          }
          core.setOutput("has_input", artifacts.length === 1 ? "true" : "false");
          core.setOutput("artifact_name", artifacts[0]?.name ?? "");
jobs:
  pre-activation:
    outputs:
      artifact_name: ${{ steps.find-input.outputs.artifact_name }}
      has_input: ${{ steps.find-input.outputs.has_input }}
  agent:
    needs: pre-activation
if: >-
  github.repository == 'Azure/azure-rest-api-specs' &&
  github.event.workflow_run.conclusion == 'success' &&
  needs.pre_activation.outputs.has_input == 'true'
concurrency:
  group: generated-dotnet-sdk-review-${{ github.event.workflow_run.id }}
  cancel-in-progress: false
permissions:
  actions: read
  contents: read
  copilot-requests: write
checkout:
  sparse-checkout: |
    .github/workflows/scripts/prepare-sdk-review-workspaces.ts
    .github/workflows/src/sdk-validation-dotnet-review-result.ts
    .github/workflows/src/sdk-validation-typespec-remediation-result.ts
engine:
  id: copilot
  args: ["--excluded-tools=task"]
model: gpt-5.6-sol
timeout-minutes: 30
max-ai-credits: 1000
steps:
  - name: Download validated SDK review input
    uses: actions/download-artifact@v8
    with:
      name: ${{ needs.pre_activation.outputs.artifact_name }}
      path: /tmp/gh-aw/sdk-review-input
      github-token: ${{ secrets.GITHUB_TOKEN }}
      run-id: ${{ github.event.workflow_run.id }}
  - name: Reconstruct generated SDK workspaces
    env:
      SDK_REVIEW_INPUT_ROOT: /tmp/gh-aw/sdk-review-input
      SDK_REVIEW_WORKSPACE_ROOT: /tmp/gh-aw/sdk-review-workspaces
      SDK_REVIEW_SKILL_INSTALL_ROOT: ${{ github.workspace }}/.github/skills/code-review
    run: node .github/workflows/scripts/prepare-sdk-review-workspaces.ts
  - name: Upload trusted SDK review context
    uses: actions/upload-artifact@v7
    with:
      name: sdk-review-trusted-context-${{ github.event.workflow_run.id }}-attempt-${{ github.run_attempt }}
      path: |
        /tmp/gh-aw/sdk-review-workspaces/sdk-review-context.json
        /tmp/gh-aw/sdk-review-input/typespec-review-context.json
      if-no-files-found: error
      retention-days: 7
network:
  allowed:
    - defaults
    - github
tools:
  bash:
    - cat
    - find
    - git
    - grep
    - head
    - jq
    - ls
    - nl
    - pwd
    - python
    - sed
    - sort
    - tail
    - wc
  cli-proxy: false
safe-outputs:
  create-issue: false
  report-failure-as-issue: false
  report-failed-jobs: false
  report-incomplete: false
  report-missing-data: false
  report-missing-tool: false
  jobs:
    publish-sdk-review:
      description: "Validate and publish the generated SDK review result"
      if: needs.detection.outputs.detection_success == 'true'
      runs-on: ubuntu-slim
      permissions:
        actions: read
        contents: read
      inputs:
        result:
          description: "The complete generated SDK review result as a JSON object string"
          required: true
          type: string
        remediation_result:
          description: "The complete TypeSpec remediation result as a JSON object string"
          required: true
          type: string
      steps:
        - name: Checkout trusted validator
          uses: actions/checkout@v7
          with:
            sparse-checkout: |
              .github/workflows/src/sdk-validation-dotnet-review-result.ts
              .github/workflows/src/sdk-validation-typespec-remediation-result.ts
            persist-credentials: false
        - name: Download trusted SDK review context
          uses: actions/download-artifact@v8
          with:
            name: sdk-review-trusted-context-${{ github.event.workflow_run.id }}-attempt-${{ github.run_attempt }}
            path: ${{ runner.temp }}/sdk-review-final
        - name: Validate SDK review and TypeSpec remediation results
          uses: actions/github-script@v9
          env:
            SDK_REVIEW_RESULT_ROOT: ${{ runner.temp }}/sdk-review-final
          with:
            script: |
              const { readFile, writeFile } = await import("node:fs/promises");
              const {
                parseSdkReviewSafeOutput,
                validateSdkReviewResult,
              } = await import(
                "${{ github.workspace }}/.github/workflows/src/sdk-validation-dotnet-review-result.ts"
              );
              const {
                parseTypeSpecRemediationSafeOutput,
                validateTypeSpecRemediationResult,
              } = await import(
                "${{ github.workspace }}/.github/workflows/src/sdk-validation-typespec-remediation-result.ts"
              );
              const root = process.env.SDK_REVIEW_RESULT_ROOT;
              const [contextText, typeSpecContextText, outputText] = await Promise.all([
                readFile(`${root}/sdk-review-workspaces/sdk-review-context.json`, "utf8"),
                readFile(`${root}/sdk-review-input/typespec-review-context.json`, "utf8"),
                readFile(process.env.GH_AW_AGENT_OUTPUT, "utf8"),
              ]);
              const output = JSON.parse(outputText);
              const result = parseSdkReviewSafeOutput(output);
              const remediationResult = parseTypeSpecRemediationSafeOutput(output);
              const validatedReport = validateSdkReviewResult(
                JSON.parse(contextText),
                result,
              );
              const normalizedRemediation = validateTypeSpecRemediationResult(
                JSON.parse(contextText),
                result,
                JSON.parse(typeSpecContextText),
                remediationResult,
              );
              await Promise.all([
                writeFile(
                  `${root}/sdk-review-result.json`,
                  `${JSON.stringify(result, null, 2)}\n`,
                  "utf8",
                ),
                writeFile(`${root}/sdk-review-result.md`, validatedReport, "utf8"),
                writeFile(
                  `${root}/typespec-remediation-result.json`,
                  `${JSON.stringify(normalizedRemediation.result, null, 2)}\n`,
                  "utf8",
                ),
                writeFile(
                  `${root}/typespec-remediation-result.md`,
                  normalizedRemediation.report,
                  "utf8",
                ),
              ]);
        - name: Upload validated SDK review result
          uses: actions/upload-artifact@v7
          with:
            name: sdk-review-result-workflow-${{ github.event.workflow_run.id }}-attempt-${{ github.run_attempt }}
            path: ${{ runner.temp }}/sdk-review-final
            if-no-files-found: error
            retention-days: 7
  noop:
    report-as-issue: false
---

# Generated .NET SDK Review

Execute the canonical `azure-sdk-for-net` code-review skill against the
reconstructed generated SDK changes. This run is report-only. Do not post,
update, label, approve, or otherwise mutate any GitHub pull request.

1. Read `/tmp/gh-aw/sdk-review-workspaces/sdk-review-context.json`.
2. Read the canonical skill file identified by `canonicalSkill.skillPath`, then
   follow that skill and its referenced repository rules.
3. Review every workspace in `workspaces`. Treat each workspace as an
   independent generated SDK change based on its exact `baselineCommitSha`.
4. Use each package's `changedFiles` as the review scope, but inspect unchanged
   surrounding package source, project files, and repository configuration when
   the canonical skill requires context.
5. Report only reproducible, high-confidence defects. Do not invent an SDK PR or
   assume prior SDK review discussion exists.
6. Prepare the SDK review result using this shape:

```json
{
  "schemaVersion": 1,
  "status": "completed",
  "skillRevision": "<canonical skill commit SHA>",
  "source": {
    "specPrNumber": 123,
    "specHeadSha": "<spec commit SHA>"
  },
  "reviews": [
    {
      "baselineCommitSha": "<SDK baseline commit SHA>",
      "packages": ["Azure.ResourceManager.Example"],
      "findings": [
        {
          "severity": "high|medium|low",
          "file": "sdk/.../GeneratedFile.cs",
          "line": 123,
          "title": "Short finding title",
          "description": "Concise technical explanation"
        }
      ]
    }
  ]
}
```

If no findings remain after applying the canonical skill's confidence gate,
include an empty `findings` array.

7. Read `/tmp/gh-aw/sdk-review-input/typespec-review-context.json`.
8. Read the management review remediation skill identified by
   `remediationSkill.skillPath`. Use it as guidance for mapping generated .NET
   findings to the service TypeSpec and C#-scoped `client.tsp`.
9. Translate every SDK review finding exactly once. Do not create new findings.
   Prepare the TypeSpec remediation result with this shape:

```json
{
  "schemaVersion": 1,
  "status": "completed",
  "skillRevision": "<remediation skill commit SHA>",
  "source": {
    "specPrNumber": 123,
    "specHeadSha": "<spec commit SHA>"
  },
  "findings": [
    {
      "reviewIndex": 0,
      "findingIndex": 0,
      "remediation": {
        "target": "typespec|client.tsp|sdk-repository|duplicate|manual-investigation",
        "specSymbol": "Optional TypeSpec symbol",
        "suggestion": "Concrete remediation or investigation guidance",
        "confidence": "high|medium|low",
        "sourceLocation": {
          "file": "specification/.../changed-file.tsp",
          "line": 123
        }
      }
    }
  ]
}
```

Only include `sourceLocation` when the exact line was added or modified by this
PR in a changed TypeSpec file from the context. Otherwise omit it so a later
publisher cannot create a misleading inline comment. Use `typespec` for language-independent
contract fixes, `client.tsp` for C#-scoped API surface adjustments,
`sdk-repository` when a spec author cannot resolve the finding, `duplicate`
only when the provided evidence proves another signal already reported it, and
`manual-investigation` when mapping or remediation is uncertain.

10. Call `publish_sdk_review` exactly once. Set `result` to the complete SDK
    review result as a JSON string and `remediation_result` to the complete
    TypeSpec remediation result as a JSON string.

The trusted safe-output job validates both structured results after threat
detection, restores canonical finding data, and generates both Markdown reports
deterministically.
