---
name: "Generated .NET SDK Review (Report-Only)"
description: Run the canonical azure-sdk-for-net code-review skill against generated SDK changes captured by SDK Validation.
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
          const response = await github.rest.actions.listWorkflowRunArtifacts({
            owner: context.repo.owner,
            repo: context.repo.repo,
            run_id: context.payload.workflow_run.id,
            per_page: 100,
          });
          const artifacts = response.data.artifacts.filter(
            (artifact) =>
              !artifact.expired &&
              artifact.name.startsWith("sdk-naming-review-input-build-"),
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
  report-failure-as-issue: false
  report-failed-jobs: false
  missing-data:
    create-issue: false
  missing-tool:
    create-issue: false
post-steps:
  - name: Validate report-only SDK review result
    if: ${{ !cancelled() }}
    uses: actions/github-script@3a2844b7e9c422d3c10d287c895573f7108da1b3 # v9.0.0
    with:
      script: |
        const { readFile } = await import("node:fs/promises");
        const context = JSON.parse(
          await readFile("/tmp/gh-aw/sdk-review-workspaces/sdk-review-context.json", "utf8"),
        );
        const result = JSON.parse(
          await readFile("/tmp/gh-aw/sdk-review-result.json", "utf8"),
        );
        if (result.schemaVersion !== 1 || result.status !== "completed") {
          throw new Error("SDK review result must use schemaVersion 1 and completed status");
        }
        if (result.skillRevision !== context.canonicalSkill.skillRevision) {
          throw new Error("SDK review result does not identify the executed canonical skill revision");
        }
        if (!Array.isArray(result.reviews) ||
            result.reviews.length !== context.workspaces.length) {
          throw new Error("SDK review result must contain one review per reconstructed baseline");
        }
        const expectedBaselines = context.workspaces
          .map((workspace) => workspace.baselineCommitSha)
          .sort();
        const actualBaselines = result.reviews
          .map((review) => review.baselineCommitSha)
          .sort();
        if (new Set(actualBaselines).size !== actualBaselines.length ||
            JSON.stringify(actualBaselines) !== JSON.stringify(expectedBaselines)) {
          throw new Error("SDK review result baseline set does not match reconstructed workspaces");
        }
        for (const workspace of context.workspaces) {
          const review = result.reviews.find(
            (candidate) => candidate.baselineCommitSha === workspace.baselineCommitSha,
          );
          const expectedPackages = workspace.packages
            .map((sdkPackage) => sdkPackage.packageName)
            .sort();
          const actualPackages = [...(review?.packages ?? [])].sort();
          if (new Set(actualPackages).size !== actualPackages.length ||
              JSON.stringify(actualPackages) !== JSON.stringify(expectedPackages)) {
            throw new Error(
              `SDK review result package set does not match baseline ${workspace.baselineCommitSha}`,
            );
          }
        }
  - name: Upload report-only SDK review result
    if: ${{ !cancelled() }}
    uses: actions/upload-artifact@cf430e030ddbb5b0abf93d22962f4752f3646cd9 # v7.0.2
    with:
      name: sdk-review-result-workflow-${{ github.event.workflow_run.id }}
      path: |
        /tmp/gh-aw/sdk-review-result.json
        /tmp/gh-aw/sdk-review-result.md
        /tmp/gh-aw/sdk-review-workspaces/sdk-review-context.json
      if-no-files-found: error
      retention-days: 7
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
6. Write `/tmp/gh-aw/sdk-review-result.json` with this shape:

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

Also write a concise human-readable report to
`/tmp/gh-aw/sdk-review-result.md`. If no findings remain after applying the
canonical skill's confidence gate, include an empty `findings` array and state
that no high-confidence findings were found.
