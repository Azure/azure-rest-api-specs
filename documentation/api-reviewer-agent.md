# Using the ARM API Reviewer Agent

The **ARM API Reviewer** is a Visual Studio Code Copilot agent that reviews Azure REST API
specification PRs for conformance to the [Azure REST API Guidelines][api-guidelines],
ARM Resource Provider Contract ([RPC][rpc-contract]) rules, and repository conventions.
It validates OpenAPI (Swagger), TypeSpec, and example files against 100+ codified rules
derived from the RPC, Azure REST API Guidelines, and patterns identified by analyzing
review comments from tens of thousands of PRs across both repos.

## Prerequisites

- **VS Code** with [GitHub Copilot][copilot-ext] and
  [GitHub Copilot Chat][copilot-chat-ext] extensions installed.
- **The public repository** ([Azure/azure-rest-api-specs][public-repo])
  cloned and open as a workspace in VS Code. The agent definition,
  instructions, skills, and prompts all live in this repository.
  Stay on the **`main` branch** -- you do not need to check out the PR
  branch. The agent fetches PR files directly from GitHub.
- **GitHub authentication** -- the agent uses the GitHub MCP
  server which authenticates via OAuth. If prompted, authorize the GitHub
  connection when the consent dialog appears. This authentication also
  enables the agent to review PRs in the private repository
  (`azure-rest-api-specs-pr`).

## How to Open the Agent

1. Open the **Copilot Chat** panel in VS Code (Ctrl+Shift+I or click the Copilot icon).
2. In the agent picker at the top of the chat, select **ARM API Reviewer**.
3. Type your request in the chat input.

## Reviewing a PR

In the agent chat, type your request directly:

Provide a PR number, URL, or shorthand:

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

**How the agent resolves PR references:**

| Input                      | Resolved repository                                                                                                                                                                                                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Bare number (e.g. `41405`) | Defaults to `Azure/azure-rest-api-specs`. If not found, asks whether the PR is in the private repo.                                                                                                                                                                               |
| `specs#<number>`           | `Azure/azure-rest-api-specs`                                                                                                                                                                                                                                                      |
| `specs-pr#<number>`        | `Azure/azure-rest-api-specs-pr`                                                                                                                                                                                                                                                   |
| Full URL                   | Extracted from the URL. Must be `Azure/azure-rest-api-specs`, `Azure/azure-rest-api-specs-pr`, or a fork of either. URLs pointing to other repositories are declined.                                                                                                             |
| Fork URL                   | Treated as a recognized fork if the repo's `parent.full_name` (resolvable via `gh repo view <owner>/<repo> --json parent` or the PR payload's `head.repo.parent.full_name`) equals `Azure/azure-rest-api-specs` or `Azure/azure-rest-api-specs-pr`. Otherwise the agent declines. |

If the PR is not found in the resolved repository, the agent will ask you to
clarify or confirm before trying the other repo. If the PR is not found in
either repository, the agent reports the error and stops.

## Agent Topology

The ARM API review workflow uses two agents, but **users only ever invoke
the `ARM API Reviewer`.** The second agent (`ARM API Review Critic`) is an
internal subagent invoked automatically by the Reviewer at Step 7 as a
safety gate before findings are presented for posting. On the happy path the
Critic is invisible in chat; it becomes visible only when it materially
changed a finding (downgrade, reclassification, drop) or could not run.

| Agent                 | Who invokes it                         | Why it exists                                                                                                                                                                                                                                                                  |
| --------------------- | -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ARM API Reviewer      | You                                    | Optimized for **recall**: find every spec violation that should be flagged.                                                                                                                                                                                                    |
| ARM API Review Critic | The Reviewer (automatically at Step 7) | Optimized for **precision**: independently re-fetch files, re-quote rule text verbatim, and re-classify `[NEW]`/`[EXISTING]` for every finding before it is posted. A separate agent with a narrower tool surface (read-only) is what makes the verification non-rubber-stamp. |

In VS Code the Critic is hidden from the agents picker via `user-invocable: false`.
In IDEs that don't honor that flag (Claude Code, github.com Copilot), the
Critic may appear in pickers but is still not intended for direct invocation;
if you do invoke it directly, it will tell you to switch to the Reviewer.

The agent will:

1. Fetch the PR metadata and changed files from GitHub.
2. **Choose a review track** based on the changed files (see [Review Tracks](#review-tracks) below).
3. Load the applicable rule sets (OpenAPI, ARM, TypeSpec).
4. Compare against the previous API version to detect breaking changes (full-review track only).
5. **Run a downstream-CI impact check** on any finding whose proposed fix
   would add or tighten a type, format, decorator, `x-ms-*` extension, or
   schema constraint. If the fix would trigger a required LintDiff rule
   (for example, `R3017 GuidUsage` on ARM control-plane GUIDs), the
   finding is phrased as a multi-option recommendation -- not a directive --
   and carries a `downstream-rule:` field in its telemetry marker. The
   conflict-aware rule catalog lives in
   [`linter-rule-coverage.md`](../.github/skills/azure-api-review/references/linter-rule-coverage.md).
6. **Run an independent critic pass** that re-verifies every finding's rule citation, line number, and
   classification before anything is shown to you. This happens silently on the happy path; you only see
   critic activity when a finding was downgraded, reclassified, dropped, or the critic could not run.
7. Produce a structured report with every violation tagged as **[NEW]** (introduced in this PR) or **[EXISTING]** (pre-existing).

### When the session is invalidated mid-review

If the PR head commit SHA changes after the agent pinned the session
(typically because the PR author pushed new commits while the review
was in flight), the critic returns `Finding accuracy = INVALIDATED`.
The report drafted against the prior SHA is unsafe to post -- the file
content the agent judged no longer matches the PR -- so the agent
emits a `SESSION INVALIDATED` message instead and asks you to choose:

- **(a) Restart** -- re-run the review against the new head SHA,
  pinning a fresh session.
- **(b) Abandon** -- stop without posting anything.

The agent does not silently re-pin and continue; auditable SHAs are
the whole point of pinning the session.

### When structural (Step 3.5) graph derivation fails

On the full-review track the agent builds resource, operation, and
data-flow graphs as a structural pass that catches findings nothing
else in the review surfaces (orphan resources, asymmetric CRUD,
secret-in-LIST, `$ref` cycles, silent breaking changes via reference
removal). If graph derivation fails -- typically a context-budget
overrun on a very large spec or a `$ref` resolver error -- the agent
follows a three-step fallback:

1. **Retry with smaller scope** (per-namespace partitioning, then
   merge). This is the default and resolves most failures silently.
2. **Continue with a visible failure banner.** If retry fails, the
   agent renders a `[!CAUTION]` block at the top of the report stating
   "Step 3.5 graph derivation failed; structural findings unavailable"
   plus a one-line cause, and proceeds with the remaining steps. The
   review is **not** mistaken for complete -- the banner makes the
   gap explicit so you can decide whether to merge as-is, ask for a
   human structural spot-check, or hold the PR. Internally the agent
   sets `graphs-produced: degraded` so telemetry and the critic can
   distinguish "attempted and failed" from "fast-path-by-design."
3. **Abort** only if you explicitly direct the agent to stop, usually
   when the PR touches secret-bearing properties or LIST operations
   where Step 3.5 is the primary detection mechanism.

The agent never silently continues a full-review PR without
structural analysis -- the banner is the contract.

## Review Tracks

The agent classifies each PR into one of two tracks to avoid spending full-review effort on trivial changes:

| Track           | When it applies                                                                                                                                                                                                                                | What's skipped                                                                       |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **Fast path**   | The PR modifies _only_ example files, description-only edits inside specs, or non-AutoRest sections of `readme.md`, AND is under 200 lines total.                                                                                              | Breaking-change comparison and cross-file consistency checks. The critic still runs. |
| **Full review** | Any change to a `.json` spec under `stable/` or `preview/`, any `.tsp` source change, any new API version directory, any `readme.md` AutoRest tag/input-file change, any `suppressions.yaml` change, or any PR with 200 or more lines changed. | Nothing. Every step runs.                                                            |

When the agent is uncertain whether a PR qualifies for the fast path, it defaults to the full review.

## Understanding the Report

The report is organized by severity and origin:

| Section                        | Meaning                                                                                                  |
| ------------------------------ | -------------------------------------------------------------------------------------------------------- |
| **Blocking Issues - New**      | Violations introduced in this PR. Must be fixed before merge.                                            |
| **Blocking Issues - Existing** | Pre-existing violations carried forward from previous versions. Should be fixed but are not regressions. |
| **Warnings - New**             | Non-blocking issues introduced in this PR. Should be fixed.                                              |
| **Warnings - Existing**        | Pre-existing non-blocking issues. Consider fixing.                                                       |
| **Suggestions**                | Optional improvements.                                                                                   |
| **Breaking Change Analysis**   | Summary of breaking changes vs. the previous API version.                                                |

Each finding includes:

- **Rule ID** -- e.g., `RPC-Put-V1-01`, `ARG001`, `TSP-2.1`
- **File path and line number** -- exact location (e.g., `line 42` or `line 10-15`)
- **JSON path** (for OpenAPI) -- e.g., `$.paths['/widgets'].put.responses.200`
- **Issue description** -- what is wrong
- **Fix suggestion** -- exact code/JSON change to apply

## Posting Comments on a PR

After reviewing the report, you can ask the agent to post findings as PR review comments:

```text
Post the approved review comments on PR #41405
```

The agent will always present findings in chat first and wait for your
explicit approval before posting anything to the PR.

## Comment Tracking Marker

Every comment posted by the agent includes a hidden HTML marker at the end
of the comment body. The marker carries per-finding metadata:

<!-- markdownlint-disable MD013 -->

```html
<!-- posted-by: arm-api-reviewer-agent | rule: <RULE-ID> | severity: blocking|warning|suggestion | classification: new|existing | critic: pass|warn|override | head-sha: <sha> [| downstream-rule: <LINTER-RULE-ID>] [| override-reason: <required-when-critic=override>] -->
```

<!-- markdownlint-enable MD013 -->

**Fields:**

- `rule` -- the rule ID of the finding (e.g., `RPC-Put-V1-11`, `SEC-SECRET-DETECT`).
  Use `summary` for comments that don't flag a single rule.
- `severity` -- one of `blocking`, `warning`, or `suggestion`.
- `classification` -- `new` (introduced in this PR) or `existing` (pre-existing technical debt).
- `critic` -- the Critic's per-finding verdict (`pass`, `warn`, or `override`).
  `override` means a Critic `FAIL` was overridden by a human reviewer.
- `head-sha` -- the PR head commit SHA the Critic re-fetched against;
  an auditable anchor for later debugging.
- `downstream-rule` -- present when the finding's suggested fix interacts
  with a conflict-aware required CI rule (for example, `R3017 GuidUsage`).
- `override-reason` -- required only when `critic: override`;
  must be a non-empty, specific justification of at least 20 characters and
  include either an instruction-file line anchor or a verbatim counter-quote
  from the cited rule.

The marker is invisible in the rendered PR view but is present in the raw
comment body returned by the GitHub API. It serves two purposes:

1. **Reconciliation** -- on repeat reviews, the agent uses the marker to
   distinguish its own prior comments from those posted by human reviewers.
   This determines whether the agent can resolve an outdated comment
   (Scenario B) or must reply instead (Scenario C). See
   [Comment Reconciliation](#comment-reconciliation-on-repeat-reviews) below.
   The reconciliation check uses a **substring match on
   `posted-by: arm-api-reviewer-agent`**, so the queries below work
   regardless of which marker fields are present.

2. **Telemetry and querying** -- the marker enables querying all
   agent-posted comments across PRs via the GitHub API. This is useful for
   gathering metrics on review volume, rule violation frequency, and
   resolution rates.

### Example queries

**List agent comments on a single PR:**

```bash
gh api repos/Azure/azure-rest-api-specs/pulls/{pr}/comments --paginate \
  --jq '.[] | select(.body | contains("posted-by: arm-api-reviewer-agent"))
    | {id, created_at, path, line}'
```

**Count agent comments on a PR:**

```bash
gh api repos/Azure/azure-rest-api-specs/pulls/{pr}/comments --paginate \
  --jq '[.[] | select(.body | contains("posted-by: arm-api-reviewer-agent"))] | length'
```

**Find PRs with agent comments (requires iterating PR numbers or using
the search API):**

```bash
gh search prs --repo Azure/azure-rest-api-specs --label ARMChangesRequested \
  --json number,title --limit 50
```

Then iterate over the returned PR numbers with the per-PR query above.

## Comment Reconciliation on Repeat Reviews

When the agent reviews a PR that already has review comments (from a prior run
of the agent, another ARM reviewer, or automated checks), it reconciles its
findings against the existing comments before posting anything. This prevents
duplicate noise and keeps the PR thread clean.

The agent builds an inventory of **all** existing review comment threads --
including resolved, outdated, and collapsed ones -- and handles each finding
according to these scenarios:

- **A -- Already covered:** same rule, same file, same line. The finding is
  skipped and no new comment is posted.
- **B -- Line shifted (agent-origin):** same rule, code moved, and the old
  comment contains `posted-by: arm-api-reviewer-agent`. The outdated agent
  comment is resolved and a replacement comment is posted at the correct line,
  with a link back to the old thread.
- **C -- Line shifted (human-origin):** same rule, code moved, but the old
  comment does not contain the agent marker. The agent does not resolve the
  human reviewer's comment or post a duplicate; it plans a reply to the
  existing thread noting the new line number.
- **D -- No new or replacement comments:** all findings are SKIP-COVERED or
  REPLY-LINE-SHIFT. No new top-level or replacement inline comments are posted.
  The agent lists each matching existing thread with its clickable comment URL.
- **E -- Agent-origin violation fixed:** an existing unresolved agent comment
  flags a violation that no longer exists in the latest code. The agent plans
  to thank the author and resolve its own thread. **Important:** approval of
  the overall plan is **bulk consent** that auto-resolves every Scenario E
  thread without a separate per-thread prompt. The plan-approval prompt makes
  this scope explicit by stating:
  - the **count** of Scenario E rows (auto-resolved) and Scenario F rows
    (per-thread approval),
  - the **URLs** of the agent threads that will be auto-resolved (first 5
    inline, rest in the plan table),
  - the **alternative**: choose **Execute selectively** to keep specific
    Scenario E rows unresolved, or **Cancel** to leave every existing
    thread untouched,
  - the **rollback cost**: a thread auto-resolved in error can be reopened
    manually on github.com, but the agent will not re-post the original
    violation -- you must re-flag it yourself.

  Human-origin fixed threads remain in Scenario F and are surfaced
  separately for explicit per-thread consent before any reply or
  resolution.

Before executing any actions, the agent presents a **reconciliation summary**:

```text
Reconciliation plan:
- Post 3 new comments (2 blocking, 1 warning)
- Resolve & re-post 1 comment (line shifted from L42 to L58) [Scenario B]
- Reply to 1 existing comment from @reviewer (line shifted to L120) [Scenario C]
- Skip 4 findings -- already covered by existing threads [Scenario A]
- Propose resolving 2 comments -- violations addressed in latest changes [Scenario E]

Approve this plan?
```

You confirm the plan before any comments are posted, resolved, or replied to.

## Updating PR Labels

After posting review comments, the agent can also propose label changes on the PR:

- **Add** `ARMChangesRequested` to signal the PR author needs to address feedback.
- **Remove** `WaitForARMFeedback` (if present) since ARM feedback has been provided.

The agent will propose these changes and wait for your explicit approval
before modifying any labels.

## Suppression Continuity Analysis

When a PR adds or modifies a `readme.md` containing `directive` / `suppress`
entries, or modifies a service-scoped `suppressions.yaml`, the agent performs
a **suppression continuity analysis** by comparing the new version's
suppressions against the base-branch version (the previous API version's
`readme.md`, or the prior `suppressions.yaml` on the base branch):

| Scenario                                                                 | What the agent does                                                                                                                                                                                                                                |
| ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Carried-over suppression** -- same rule ID exists in both versions     | Acceptable. No action needed.                                                                                                                                                                                                                      |
| **Dropped suppression** -- exists in previous version but missing in new | Investigates whether the PR's spec changes fix the underlying violation. If yes, notes it as a positive finding. If not, flags a **warning** that the author may have accidentally dropped a required suppression (which would cause CI failures). |
| **New suppression** -- exists in new version but not previous            | Checks for a clear, specific `reason`. Flags suppressions with missing/vague reasons, security-related rule suppressions (`secret-prop`, `security-definition-missing`), or suppressions that mask issues the spec should fix.                     |
| **First version** -- no previous `readme.md` or `suppressions.yaml`      | All suppressions are treated as new and validated per the rules above.                                                                                                                                                                             |

For `suppressions.yaml`, the inventory key is the `tool` + `path` + `rule` (or
`code`) tuple rather than the rule ID alone, since the same rule can be
suppressed independently for different paths.

This analysis helps catch accidentally dropped suppressions that would break CI,
as well as unjustified new suppressions that mask real compliance issues.

## What Gets Reviewed

| File pattern                                  | Rules applied                                                                 |
| --------------------------------------------- | ----------------------------------------------------------------------------- |
| `specification/**/resource-manager/**/*.json` | Generic OpenAPI + ARM-specific rules                                          |
| `specification/**/data-plane/**/*.json`       | Generic OpenAPI + data-plane checks                                           |
| `specification/**/*.tsp`                      | TypeSpec rules                                                                |
| `specification/**/tspconfig.yaml`             | TypeSpec config rules                                                         |
| `specification/**/examples/*.json`            | Validated against the spec they reference                                     |
| `specification/**/*.json`                     | Any other OpenAPI JSON -- generic rules                                       |
| `specification/**/readme.md`                  | AutoRest config -- tag configurations, input file lists, and **suppressions** |
| `specification/**/suppressions.yaml`          | Service-scoped suppression entries; continuity analysis vs. the base branch   |

### Key Rule Areas

- **Versioning** -- `YYYY-MM-DD[-preview]` format, no breaking changes, uniform versioning within a service
- **Naming** -- camelCase properties, PascalCase models, `{Resource}_{Verb}` operationIds
- **ARM resources** -- tracked resource CRUD completeness, PATCH constraints, secret handling, ARG compatibility
- **TypeSpec** -- project structure, decorators, doc comments, ARM resource patterns, `union` vs `enum`
- **Security** -- no secrets in GET responses, `x-ms-secret` annotations, proper auth definitions
- **LRO** -- correct `x-ms-long-running-operation` usage, response schemas, polling headers
- **Suppressions** -- `readme.md` and `suppressions.yaml` continuity across API versions
  (carried-over, dropped, and new suppressions)

## Tips

- **Be specific.** Include the PR number or URL in your request. This produces
  faster, higher-quality results.
- **Breaking change reviews.** Ask the agent to compare two specific
  versions: `"Compare the 2024-03-01 and 2024-07-01 versions of this
spec for breaking changes"`.
- **Re-review after updates.** After the PR author addresses feedback,
  re-run the review to confirm all issues are resolved. The agent's
  comment reconciliation will handle de-duplication automatically.

## Scope and Limitations

The agent **does**:

- Review OpenAPI v2 (Swagger) JSON specifications
- Review TypeSpec (`.tsp`) source files and `tspconfig.yaml`
- Review `readme.md` suppressions and perform suppression continuity analysis across API versions
- Detect breaking changes between API versions
- Post review comments on PRs (with your approval)
- Propose and apply PR label changes (`ARMChangesRequested` / `WaitForARMFeedback`) with your approval

The agent **does not**:

- Modify specification files -- its review of API specs is read-only
- Review local files or uncommitted changes -- it operates on PRs only
- Generate SDKs
- Author new TypeSpec projects from scratch
- Fix CI pipeline failures -- see the [CI Fix Guide](ci-fix.md)
- Review SDK code, pipeline configs, or infrastructure files

## Related Resources

### External Guidelines

- [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)
- [Azure Resource Provider Contract (RPC)](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0)
- [Getting Started with OpenAPI Specifications](Getting%20started%20with%20OpenAPI%20specifications.md)
- [Getting Started with TypeSpec Specifications](Getting-started-with-TypeSpec-specifications.md)
- [Breaking Changes Guidelines](Breaking%20changes%20guidelines.md)
- [CI Fix Guide](ci-fix.md)
- [Directory Structure](directory-structure.md)

### Agent Files (under `.github/`)

| File                                            | Purpose                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `agents/arm-api-reviewer.agent.md`              | Agent definition -- persona, workflow, PR resolution, comment reconciliation                                                                                                                                                                                                                                                                                                       |
| `instructions/arm-api-review.instructions.md`   | ARM control-plane review rules (96 rule IDs: 58 RPC + 38 additional covering policy, template deployment, what-if/preflight, secrets, property design, and more)                                                                                                                                                                                                                   |
| `instructions/openapi-review.instructions.md`   | Generic OpenAPI review rules                                                                                                                                                                                                                                                                                                                                                       |
| `instructions/typespec-review.instructions.md`  | TypeSpec review rules                                                                                                                                                                                                                                                                                                                                                              |
| `instructions/typespec-project.instructions.md` | TypeSpec project structure rules (referenced by the TypeSpec review file)                                                                                                                                                                                                                                                                                                          |
| `skills/azure-api-review/SKILL.md`              | Shared review skill manifest and maintenance guidance                                                                                                                                                                                                                                                                                                                              |
| `skills/azure-api-review/references/*.md`       | 18 cross-cutting rule references covering secret detection, property mutability, provisioning state, naming, enums, examples, tracked-resource lifecycle, policy compatibility, template deployment, availability zones, field ownership, what-if/preflight, LRO final-state-via, suppression criteria, linter coverage, design decisions, GUID/UUID on ARM, and "think in graphs" |
| `copilot-review-instructions.md`                | Instructions for Copilot Code Review (automated inline PR comments -- separate from the agent)                                                                                                                                                                                                                                                                                     |

### Evaluation Suite

The agent is validated by an automated evaluation suite covering ARM resource structure, property design,
operations, breaking changes, suppressions (both `readme.md` and
`suppressions.yaml`), example files, TypeSpec review, fast-path triage,
report format, and more. The tests run against fixture files with seeded
violations and verify the agent detects each issue.

To run the eval suite after making changes to the agent, instruction files,
or skills:

```powershell
cd .github/skills/evals/arm-api-reviewer
.\run-evals.ps1
```

The script automatically clones and builds the
<!-- cspell:words vally -->
[vally](https://github.com/microsoft/vally) framework, runs all
tests, and prints a pass/fail summary. Pass `-VallyRepo` to point to an
existing clone, `-Suite` to run a single category, or `-SkipBuild` to skip
rebuilding. Run `Get-Help .\run-evals.ps1 -Detailed` for all options.

Include the eval results in any PR that modifies the agent or its rules so
reviewers can assess the impact.

See [`.github/skills/evals/arm-api-reviewer/README.md`](../.github/skills/evals/arm-api-reviewer/README.md)
for full documentation on test categories, fixtures, graders, and adding
new tests.

### Rule Maintenance

The instruction files are derived from the authoritative upstream documents
(RPC contract, Azure REST API Guidelines, TypeSpec Azure docs). Each file
includes an `Upstream alignment` date in an HTML comment at the top,
indicating when the rules were last verified against the upstream sources.

Rules that overlap with existing linter checks are annotated with
`(Also enforced by: ...)` so the agent avoids duplicating findings that
CI linters already caught. See the "Maintenance & Upstream Alignment"
section in `SKILL.md` for the full maintenance process.

<!-- Link references -->

[api-guidelines]: https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
[rpc-contract]: https://github.com/cloud-and-ai-microsoft/resource-provider-contract
[public-repo]: https://github.com/Azure/azure-rest-api-specs
[copilot-ext]: https://marketplace.visualstudio.com/items?itemName=GitHub.copilot
[copilot-chat-ext]: https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat
