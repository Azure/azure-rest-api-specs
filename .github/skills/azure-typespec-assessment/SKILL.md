---
name: azure-typespec-assessment
description: "Assess Azure TypeSpec Git diffs for semantic intent, REST and downstream SDK breaking changes, Azure Guidelines compliance, and documentation completeness. Generate a read-only assessment without modifying the TypeSpec source. WHEN: \"assess TypeSpec changes\", \"review TypeSpec diff\", \"check TypeSpec breaking changes\", \"assess TypeSpec against Azure Guidelines\", \"explain TypeSpec REST impact\", \"review TypeSpec documentation\". DO NOT USE FOR: editing, fixing, or otherwise modifying TypeSpec; use azure-typespec-author for authoring and remediation."
license: MIT
metadata:
  author: Microsoft
  version: "0.0.0-beta"
---

# Azure TypeSpec Assessment

Assess only the user-selected TypeSpec scope, normally before a PR exists. Never modify the user's assessed source, branch, index, or working tree; isolated temporary sparse worktrees and artifacts are allowed only under the chosen work directory.

## Before starting a local assessment

Check whether the user explicitly supplied or confirmed the baseline for this
assessment. If not, your first assessment action must be to ask:
**"Compare against origin/main, or a different branch or commit?"**
Use the host's user-question tool when available and wait for the answer.
Do not start preflight, compute a merge base, create work artifacts, or run
analysis before confirmation. Permission to assess the code is not permission
to choose its baseline; merely announcing `origin/main` is not confirmation.
Use a supplied baseline without asking again. Existing-report replay does not
need this question; for PR assessment, use the PR's actual target baseline.

For every fresh assessment, the coordinator is the first operational command.
For a PR, run `run-assessment-analysis.mjs --pr <url-or-number> --repo <repo>
--output <work>` immediately. For local code, run it immediately with
`--base`, `--specification`, `--repo`, and `--output` once the baseline is
known. Do not run separate Git status/diff/fetch/worktree, PR metadata,
dependency, or project-discovery commands first. Diagnose only a concrete
blocker returned by the coordinator.

Follow the [complete workflow](references/workflow.md). Apply the [classification rules](references/classification.md), including the detailed [downstream cases](references/downstream-breaking-cases.md), perform the [Azure Guidelines search](references/agentic-search.md) against the [official document catalog](references/reference-document-links.md), check [documentation completeness](references/document-quality.md), and produce exactly the [required outputs](references/output-contract.md).

## Boundaries

- V1 is standalone and opt-in: run only when the user explicitly requests an assessment or review. Do not invoke this skill from `azure-typespec-author`, or automatically before or after its authoring and validation workflow. Integration is deferred to a future version.
- Run complete mode only: merge-base through `HEAD`, staged, unstaged, and relevant untracked changes.
- Derive semantic intents from changed TypeSpec source. Use AutoRest only to map those intents to REST operations and assess REST compatibility; use TCGC only for downstream SDK analysis.
- Check deterministic hunk coverage in `model-input.json`. Resolve only its declared `artifactReferences` and `evidenceSetId` entries when full evidence is needed. Skip inference when all hunks have candidates or explicit deterministic classifications. For `unknown` hunks only, write and validate `inference.json` before final judgment.
- When the coordinator returns `awaiting-agent-judgment`, continue immediately in the same task. Do not stop for a progress summary or require the user to say "continue." Read `agent-workspace/agent-index.json` once, then read its single bounded `model-input.json` exactly once. Read the compact decision schema listed in the index exactly once, resolving it relative to this skill directory; do not search for schemas. Do not recursively list the work directory, scan canonical artifacts broadly, or reread schemas during normal execution.
- `api-version-publication` and `api-version-wide-change` intents are deterministic informational items. A version-wide change is identified from a `Versions` declaration with no directly owned operation and only version-transition/governance operation mappings; it does not use an operation-count threshold. Their affected operations remain in the final Semantic intents report, but they and their exclusively associated candidates are excluded from model input, inference, Azure Guidelines decisions, breaking-change relationships, and findings.
- Preserve existing semantic grouping and `intentType`; deterministic `referenceCategories` are read-only annotations, not merging rules. In the final bounded Agent phase, summarize each assessed intent once and judge every REST/downstream candidate. Retrieve its required guidance from canonical routing, resolving explicit discovery gaps against the official catalog. Do not score or rank the catalog, fetch filler documents, or impose a four-document cutoff. Reuse sufficient content and original retrieval provenance already available in this session; otherwise fetch the missing content. No persistent cache is required. Record actual retrieval source and per-intent reviewed document IDs; never reuse a previous compliance judgment. Guidance excerpts do not carry declaration IDs; use only intent-scoped qualified `declarationNames` in citing judgments. Write only `agent-workspace/agent-decisions.json` and run the indexed offline materializer. Do not assess each operation or invent URLs, operations, symbols, sources, or guidance.
- Treat a completed search with no governing guidance as `no-applicable-guidance`; count it as assessed, not proof of compliance. Required retrieval, review, and discovery must complete first. Use `not-assessed` for missing required content, blocked discovery, or otherwise incomplete Azure Guidelines assessment.
- Check documentation deterministically from compiler results only for newly added operation, model, enum, and interface declarations. A declaration is complete when the compiler returns a nonempty effective document, including inherited documentation. Missing or empty documentation creates a finding with the exact TypeSpec declaration. Never compare documentation text with code or send documentation to the Agent.
- Report Azure Guidelines and Documentation Completeness independently with explicit coverage. Documentation with no eligible newly added declarations is `not-applicable`; unavailable compiler evidence remains `not-assessed`.
- Overall safety covers REST and downstream SDK impact only.
- After successful materialization, complete the assessment with one guarded invocation of `finalize-assessment.mjs --work <work-directory>`. Do not separately assemble, validate, and render. Completion requires validated `assessment.json` and `assessment.html`; `model-input.json`, the Agent index, or a partial blocker is not completion.
- Retain blockers as **Potential limits** in the report appendix and stop after assessment. Do not author fixes or remediate TypeSpec.
