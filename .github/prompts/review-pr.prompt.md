---
agent: api-reviewer
description: "Review an Azure REST API specification PR for guideline compliance. Provide a PR URL or number."
---

# Review Azure REST API Specification PR

Review pull request ${input:prReference:Enter the PR URL or number (e.g. https://github.com/Azure/azure-rest-api-specs/pull/41405, https://github.com/Azure/azure-rest-api-specs-pr/pull/23440, 41405, or specs-pr#23440)} for compliance with Azure REST API Guidelines.

## Instructions

1. **Resolve the PR.** Determine the target repository and PR number:
   - Full URL (e.g. `https://github.com/Azure/azure-rest-api-specs/pull/41405` or `https://github.com/Azure/azure-rest-api-specs-pr/pull/23440`) — extract the repo and number from the URL.
   - `specs-pr#<number>` — resolves to `https://github.com/Azure/azure-rest-api-specs-pr/pull/<number>`.
   - `specs#<number>` or bare `<number>` — resolves to `https://github.com/Azure/azure-rest-api-specs/pull/<number>`.
   - If ambiguous, ask the user to clarify which repository.
   Fetch the PR details and list all changed files using the GitHub MCP server tools (`get_pull_request`, `list_pull_request_files`). Both `Azure/azure-rest-api-specs` and `Azure/azure-rest-api-specs-pr` share the same directory structure and review rules.

   > **Important:** All specification files must be fetched from GitHub, not from the local workspace. Use `get_file_contents` to read files from the PR's head branch. For `azure-rest-api-specs-pr` (private repo), GitHub MCP tools with OAuth are required. If authentication has not been granted, ask the user to authorize the GitHub MCP server connection.

2. **Classify changed files.** For each file in the PR diff, determine its type:
   - ARM OpenAPI JSON (`specification/**/resource-manager/**/*.json`)
   - Data-plane OpenAPI JSON (`specification/**/data-plane/**/*.json`)
   - TypeSpec source (`specification/**/*.tsp`)
   - TypeSpec config (`specification/**/tspconfig.yaml`)
   - Example files (`specification/**/examples/*.json`)
   - Other (readme, etc.)

3. **Load the applicable rule sets** from the instruction files:
   - `.github/instructions/openapi-review.instructions.md` — for all OpenAPI JSON
   - `.github/instructions/armapi-review.instructions.md` — additionally for ARM resource-manager JSON
   - `.github/instructions/typespec-review.instructions.md` — for TypeSpec `.tsp` files and `tspconfig.yaml`

4. **Identify the previous API version.** For each modified spec, find the most recent prior API version in the repository (prior `stable/` or `preview/` folder) by listing the directory contents on the base branch using GitHub MCP `get_file_contents`. For example, if the PR introduces `stable/2025-10-01/`, locate `stable/2024-02-01/` (or whatever the latest prior version is). Record the previous version path — it will be used for both breaking change detection and new vs. existing issue classification. If no previous version exists (new service), note it and skip.

5. **Compare with previous API version for breaking changes.** Fetch both the new version (from the PR head branch) and previous version (from the base branch) spec files using GitHub MCP tools. Check for: removed properties, removed operations, type changes, narrowed enums, optional-to-required transitions, renamed paths.

6. **Run the full review checklist** from each loaded instruction file against every changed specification file. Be exhaustive — check every operation, model, property, and parameter.

7. **Classify each issue as New or Existing.** For every issue found in the new version, check whether the same violation exists in the previous API version:
   - **Fetch the corresponding file/section** from the previous version on the base branch using GitHub MCP `get_file_contents` and verify.
   - If the same violation exists in the previous version → tag as `[EXISTING]` (pre-existing technical debt, not a regression introduced by this PR).
   - If the violation is not present in the previous version, or the element (property, operation, model) did not exist in the previous version → tag as `[NEW]` (introduced by this PR).
   - If no previous version exists → all issues are `[NEW]`.
   - **Do not guess** — always fetch and read the previous version's spec from GitHub to confirm classification.

8. **Report findings** in this format:

   ```
   ## API Review: <service-name>/<api-version>

   **Previous version:** <previous-version> (or "None — new service")

   ### Blocking Issues — New (must fix before merge)
   These issues were introduced in this PR and must be resolved.
   1. **[NEW]** **[<Rule ID>]** `<file-path>` — line <N> / JSON path `<path>`
      **Issue:** <description>
      **Fix:** <exact code or JSON to apply>

   ### Blocking Issues — Existing (pre-existing, should fix)
   These issues also exist in the previous version and were not introduced by this PR.
   1. **[EXISTING]** **[<Rule ID>]** `<file-path>` — line <N> / JSON path `<path>`
      **Issue:** <description>
      **Previous version:** Also present in `<previous-version-file-path>` at `<JSON path or line>`
      **Fix:** <exact code or JSON to apply>

   ### Warnings — New (should fix)
   1. **[NEW]** **[<Rule ID>]** `<file-path>` — line <N>
      **Issue:** <description>
      **Fix:** <suggestion>

   ### Warnings — Existing (consider fixing)
   1. **[EXISTING]** **[<Rule ID>]** `<file-path>` — line <N>
      **Issue:** <description>
      **Previous version:** Also present in `<previous-version-file-path>`
      **Fix:** <suggestion>

   ### Suggestions (optional improvements)
   1. ...

   ### Breaking Change Analysis
   - Previous version: <version> | Current version: <version>
   - Breaking changes found: <count>
   - Details: ...

   ### Summary
   - Files reviewed: <count>
   - Previous version compared: <version> (or "N/A — new service")
   - **New blocking issues: <count>**
   - **Existing blocking issues: <count>**
   - New warnings: <count>
   - Existing warnings: <count>
   - Suggestions: <count>
   ```

9. **After presenting findings, ask for approval** before posting any comments to the PR. Once I confirm, post each finding as a review comment on the specific file and line in the PR. Prioritize posting **New** issues first.
