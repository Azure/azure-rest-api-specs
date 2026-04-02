# Using the ARM API Reviewer Agent

The **ARM API Reviewer** is a Visual Studio Code Copilot agent that reviews Azure REST API
specifications for conformance to the [Azure REST API Guidelines][api-guidelines],
ARM Resource Provider Contract ([RPC][rpc-contract]) rules, and repository conventions.
It can also apply fixes directly to local files.

## Prerequisites

- **VS Code** with [GitHub Copilot][copilot-ext] and
  [GitHub Copilot Chat][copilot-chat-ext] extensions installed.
- **This repository** (`azure-rest-api-specs` or `azure-rest-api-specs-pr`)
  cloned and open as a workspace in VS Code.
- **GitHub authentication** — for PR reviews, the agent uses the GitHub MCP
  server which authenticates via OAuth. If prompted, authorize the GitHub
  connection when the consent dialog appears.

## How to Open the Agent

1. Open the **Copilot Chat** panel in VS Code (Ctrl+Shift+I or click the Copilot icon).
2. In the agent picker at the top of the chat, select **ARM API Reviewer**.
3. Type your request in the chat input.

## Operating Modes

The agent operates in three modes:

| Mode | When to use | What it does |
| ---- | ----------- | ------------ |
| **Review mode** (default) | Review a PR or inspect files | Read-only. Structured report with file paths, line numbers, rule IDs, and fix suggestions. |
| **Local changes mode** | Review uncommitted/staged changes in your local workspace | Read-only. Detects local git changes, asks you to scope the review (all changes or specific folder), validates directory structure and spec compliance. |
| **Fix mode** | Review **and** correct local files | Reviews first, presents findings, then applies approved fixes directly to your local files. |

The agent automatically selects the mode based on your prompt:

- Words like **"review"**, **"check"**, **"inspect"** with a PR reference trigger review mode.
- Words like **"review my changes"**, **"check my changes"** (without a PR) trigger local changes mode.
- Words like **"fix"**, **"apply"**, **"correct"**, **"update"** trigger fix mode.
- If ambiguous, the agent will ask which mode you prefer.

## Review Mode

### Reviewing a PR

Provide a PR URL or number:

```text
Review PR #41405
```

```text
Review https://github.com/Azure/azure-rest-api-specs/pull/41405
```

For the private repo, use the full URL or shorthand:

```text
Review specs-pr#23440
```

The agent will:

1. Fetch the PR metadata and changed files from GitHub.
2. Load the applicable rule sets (OpenAPI, ARM, TypeSpec).
3. Compare against the previous API version to detect breaking changes.
4. Produce a structured report with every violation tagged as **[NEW]** (introduced in this PR) or **[EXISTING]** (pre-existing).

### Reviewing Local Files

You can also point the agent at files in your workspace without a PR:

```text
Check this swagger file for ARM compliance: specification/network/resource-manager/Microsoft.Network/stable/2025-05-01/loadBalancer.json
```

```text
Review this TypeSpec project: specification/contoso/resource-manager/Microsoft.Contoso/Contoso.Management/
```

### Understanding the Report

The report is organized by severity and origin:

| Section | Meaning |
| ------- | ------- |
| **Blocking Issues — New** | Violations introduced in this PR. Must be fixed before merge. |
| **Blocking Issues — Existing** | Pre-existing violations carried forward from previous versions. Should be fixed but are not regressions. |
| **Warnings — New** | Non-blocking issues introduced in this PR. Should be fixed. |
| **Warnings — Existing** | Pre-existing non-blocking issues. Consider fixing. |
| **Suggestions** | Optional improvements. |
| **Breaking Change Analysis** | Summary of breaking changes vs. the previous API version. |

Each finding includes:

- **PR URL** — shown in the report header and summary for easy navigation
- **Rule ID** — e.g., `RPC-Put-V1-01`, `ARG001`, `TSP-2.1`
- **File path and line number** — exact location (e.g., `L42` or `L10-L15`)
- **JSON path** (for OpenAPI) — e.g., `$.paths['/widgets'].put.responses.200`
- **Issue description** — what is wrong
- **Fix suggestion** — exact code/JSON change to apply

### Posting Comments on a PR

After reviewing the report, you can ask the agent to post findings as PR review comments:

```text
Post the approved review comments on PR #41405
```

The agent will always present findings in chat first and wait for your
explicit approval before posting anything to the PR.

### Comment Reconciliation on Repeat Reviews

When the agent reviews a PR that already has review comments (from a prior run
of the agent, another ARM reviewer, or automated checks), it reconciles its
findings against the existing comments before posting anything. This prevents
duplicate noise and keeps the PR thread clean.

The agent builds an inventory of **all** existing review comment threads —
including resolved, outdated, and collapsed ones — and handles each finding
according to these scenarios:

| Scenario | Condition | What happens |
| -------- | --------- | ------------ |
| **A — Already covered** | Same rule, same file, same line | Finding is skipped. No new comment posted. |
| **B — Line shifted (same author)** | Same rule, but the code moved to a different line. The old comment was from the agent or the same engineer. | The outdated comment is **resolved** and a new comment is posted at the correct line, with a link back to the old thread. |
| **C — Line shifted (different reviewer)** | Same rule, code moved, but the old comment was from a different human reviewer. | The agent **does not** resolve the other reviewer's comment or post a duplicate. Instead, it **adds a reply** to the existing thread noting the new line number, so the author and reviewer can find the right code. |
| **D — No new findings** | Every finding is already covered by existing comments. | No new comments are posted. The agent reports: *"All findings are already covered by existing comments on the PR."* It lists each matching existing thread with its **clickable comment URL** so the reviewer can navigate directly to verify. |
| **E — Violation fixed** | An existing unresolved comment flags a violation that no longer exists in the latest code. | The agent reports which comments have been addressed — each with its **clickable comment URL** so the reviewer can navigate and verify the fix — and **proposes resolving** them, but only with your explicit consent. If the comment was from a different reviewer, the agent replies noting the fix instead of resolving. |

Before executing any actions, the agent presents a **reconciliation summary**:

```text
Reconciliation plan:
• Post 3 new comments (2 blocking, 1 warning)
• Resolve & repost 1 comment (line shifted from L42 → L58) [Scenario B]
• Reply to 1 existing comment from @reviewer (line shifted to L120) [Scenario C]
• Skip 4 findings — already covered by existing threads [Scenario A]
• Propose resolving 2 comments — violations addressed in latest changes [Scenario E]

Approve this plan?
```

You confirm the plan before any comments are posted, resolved, or replied to.

### Updating PR Labels

After posting review comments, the agent can also propose label changes on the PR:

- **Add** `ARMChangesRequested` to signal the PR author needs to address feedback.
- **Remove** `WaitForARMFeedback` (if present) since ARM feedback has been provided.

The agent will propose these changes and wait for your explicit approval
before modifying any labels.

### Suppression Continuity Analysis

When a PR adds or modifies a `readme.md` containing `directive` / `suppress`
entries, the agent performs a **suppression continuity analysis** by comparing
the new version's suppressions against the previous API version's `readme.md`:

| Scenario | What the agent does |
| -------- | ------------------- |
| **Carried-over suppression** — same rule ID exists in both versions | Acceptable. No action needed. |
| **Dropped suppression** — exists in previous version but missing in new | Investigates whether the PR's spec changes fix the underlying violation. If yes, notes it as a positive finding. If not, flags a **warning** that the author may have accidentally dropped a required suppression (which would cause CI failures). |
| **New suppression** — exists in new version but not previous | Checks for a clear, specific `reason`. Flags suppressions with missing/vague reasons, security-related rule suppressions (`secret-prop`, `security-definition-missing`), or suppressions that mask issues the spec should fix. |
| **First version** — no previous `readme.md` exists | All suppressions are treated as new and validated per the rules above. |

This analysis helps catch accidentally dropped suppressions that would break CI,
as well as unjustified new suppressions that mask real compliance issues.

## Local Changes Mode

Local changes mode is for engineers who have modified or introduced an API locally
and want to validate compliance **before** pushing a PR. The agent detects local
git changes, asks you to choose the review scope, validates the directory
structure, and reviews specs for TypeSpec and RPC compliance.

### Basic Usage

```text
Review my changes
```

```text
Check my local changes for API guideline compliance
```

```text
Review the changes I made in C:\repos\specs\specification\app
```

```text
Review my changes in specification/compute/resource-manager/Microsoft.Compute/
```

### How It Works

1. **Detect changes** — The agent runs `git status` and `git diff --name-only`
   to find all changed, added, or untracked specification files in your workspace.

2. **Ask for scope** — The agent presents the changed directories and asks:
   - **Review all changes** across the repository, or
   - **Focus on a specific folder** — provide a relative path
     (e.g., `specification/app`) or an absolute path
     (e.g., `C:\repos\specs\specification\app`).

3. **Discover files** — The agent recursively scans the target directory to
   locate all specification artifacts: `.tsp` files, OpenAPI `.json` files,
   `tspconfig.yaml`, `readme.md`, and example files. It presents a file
   inventory grouped by service.

4. **Validate directory structure** — Before reviewing individual files, the
   agent checks the folder layout against Azure conventions:
   - ARM specs under `resource-manager/<RPNS>/<service>/`
   - Data-plane specs under `data-plane/<service>/`
   - Stable/preview version folders named correctly (`YYYY-MM-DD` / `YYYY-MM-DD-preview`)
   - Required files present (`main.tsp`, `tspconfig.yaml`, `readme.md`, `examples/`)
   - No `package.json` in TypeSpec project directories
   - ARM TypeSpec service folders end with `.Management`

5. **Review specs** — The agent applies the full review checklists:
   - **TypeSpec compliance**: decorators, doc comments, `union` vs `enum`,
     ARM resource base types, `Operations` interface
   - **RPC compliance**: ARM resource paths, CRUD completeness,
     PUT/PATCH/DELETE rules, operations API endpoint
   - **OpenAPI compliance**: naming, versioning, security definitions,
     enums, pagination, LRO, descriptions

6. **Compare versions** — If a previous API version exists locally, the agent
   compares against it for breaking changes and classifies issues as
   **[NEW]** or **[EXISTING]**.

7. **Report** — The agent presents the structured report. No files are modified.
   To apply fixes, switch to fix mode (e.g., "fix the issues you found").

### Specifying a Folder Path

You can provide either a **workspace-relative path** or an **absolute path**:

| Format | Example |
| ------ | ------- |
| Relative | `specification/app` |
| Relative (deep) | `specification/compute/resource-manager/Microsoft.Compute/ComputeRP` |
| Absolute (Windows) | `C:\repos\specs\specification\app` |
| Absolute (macOS/Linux) | `/home/user/specs/specification/app` |

The agent normalizes all paths to workspace-relative for reporting. If the
path does not exist or contains no specification files, the agent asks for
a corrected path.

## Fix Mode

Fix mode is for working on your **local branch or fork**. The agent reviews
your files, presents its findings, and then applies fixes with your approval.

### Usage

```text
Review and fix my local spec in specification/contoso/resource-manager/Microsoft.Contoso/stable/2025-01-01/
```

```text
Fix all blocking issues in specification/network/resource-manager/Microsoft.Network/stable/2025-07-01/loadBalancer.json
```

```text
Review this TypeSpec project and apply fixes: specification/contoso/resource-manager/Microsoft.Contoso/Contoso.Management/
```

### Fix Workflow

1. **Review** — The agent performs the same thorough review as review mode.
2. **Present findings** — Issues are shown in the structured report before any changes are made.
3. **Categorize fixes** — The agent groups issues into:
   - **Auto-fixable** — mechanical, unambiguous changes (e.g., adding
     missing `description`, `"type": "object"`, `x-ms-enum`, fixing casing).
   - **Requires confirmation** — judgment calls (e.g., restructuring models, adding CRUD operations, changing enum values).
4. **Get approval** — The agent asks you to confirm. You can say:
   - `"fix all"` — apply all fixes
   - `"fix blocking only"` — apply only blocking issues
   - Cherry-pick specific findings to fix
5. **Apply fixes** — minimal, precise edits in priority order (blocking before warnings, new before existing).
6. **Validate** — for TypeSpec, runs `tsp compile .` and fixes compilation
   errors. For JSON, verifies well-formed syntax and `$ref` resolution.

## What Gets Reviewed

| File pattern | Rules applied |
| ------------ | ------------- |
| `specification/**/resource-manager/**/*.json` | Generic OpenAPI + ARM-specific rules |
| `specification/**/data-plane/**/*.json` | Generic OpenAPI + data-plane checks |
| `specification/**/*.tsp` | TypeSpec rules |
| `specification/**/tspconfig.yaml` | TypeSpec config rules |
| `specification/**/examples/*.json` | Validated against the spec they reference |
| `specification/**/readme.md` | AutoRest config — tag configurations, input file lists, and **suppressions** |

### Key Rule Areas

- **Versioning** — `YYYY-MM-DD[-preview]` format, no breaking changes, uniform versioning within a service
- **Naming** — camelCase properties, PascalCase models, `{Resource}_{Verb}` operationIds
- **ARM resources** — tracked resource CRUD completeness, PATCH constraints, secret handling, ARG compatibility
- **TypeSpec** — project structure, decorators, doc comments, ARM resource patterns, `union` vs `enum`
- **Security** — no secrets in GET responses, `x-ms-secret` annotations, proper auth definitions
- **LRO** — correct `x-ms-long-running-operation` usage, response schemas, polling headers
- **Suppressions** — `readme.md` suppression continuity across API versions (carried-over, dropped, and new suppressions)

## Tips

- **Be specific.** Point the agent at a specific file or directory rather
  than asking it to review "everything". This produces faster,
  higher-quality results.
- **Use local changes mode early.** Run `Review my changes` on your local
  workspace before pushing a PR to catch directory structure and compliance
  issues proactively.
- **Use fix mode early.** Run the agent on your local files before pushing
  a PR to catch issues proactively.
- **Combine with CI.** The agent checks the same rules as CI validation.
  Fixing issues locally before pushing reduces CI round-trips.
- **Scope to a folder.** When your changes span multiple services, scope
  the review to one folder at a time for faster, more focused results:
  `"Review my changes in specification/app"`.
- **Breaking change reviews.** Ask the agent to compare two specific
  versions: `"Compare the 2024-03-01 and 2024-07-01 versions of this
  spec for breaking changes"`.
- **Iterate.** After fixes are applied, ask the agent to re-review the
  same files to confirm everything is clean.

## Scope and Limitations

The agent **does**:

- Review OpenAPI v2 (Swagger) JSON specifications
- Review TypeSpec (`.tsp`) source files and `tspconfig.yaml`
- Review `readme.md` suppressions and perform suppression continuity analysis across API versions
- Detect local git changes and validate them against Azure guidelines
- Validate directory structure against Azure specification conventions
- Detect breaking changes between API versions
- Apply fixes to local files in fix mode
- Post review comments on PRs (with your approval)
- Propose and apply PR label changes (`ARMChangesRequested` / `WaitForARMFeedback`) with your approval

The agent **does not**:

- Generate SDKs — use the Azure SDK MCP tools for that
- Author new TypeSpec projects from scratch — use the
  [azure-typespec-author](../.github/skills/azure-typespec-author/SKILL.md)
  skill
- Address `client.tsp` SDK-layer customizations from review feedback —
  use the [api-review-feedback][api-review-feedback] chat mode
- Fix CI pipeline failures — see the [CI Fix Guide](ci-fix.md)
- Review SDK code, pipeline configs, or infrastructure files

## Related Resources

- [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)
- [Getting Started with OpenAPI Specifications](Getting%20started%20with%20OpenAPI%20specifications.md)
- [Getting Started with TypeSpec Specifications](Getting-started-with-TypeSpec-specifications.md)
- [Breaking Changes Guidelines](Breaking%20changes%20guidelines.md)
- [CI Fix Guide](ci-fix.md)
- [Directory Structure](directory-structure.md)

<!-- Link references -->
[api-guidelines]: https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
[rpc-contract]: https://github.com/cloud-and-ai-microsoft/resource-provider-contract
[copilot-ext]: https://marketplace.visualstudio.com/items?itemName=GitHub.copilot
[copilot-chat-ext]: https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat
[api-review-feedback]: ../.github/chatmodes/api-review-feedback.chatmode.md
