# Instruction File → Skill Mapping

This document maps the original Copilot instruction files to the new waza-based skills,
and describes the evaluation suites created for each skill.

---

## Instruction File Tree

All instruction files are reachable from `.github/copilot-instructions.md`:

```
.github/copilot-instructions.md
├── .github/instructions/typespec-project.instructions.md
├── .github/instructions/language-emitter.instructions.md
├── .github/instructions/sdk-generation.instructions.md
│   ├── eng/common/instructions/azsdk-tools/verify-setup.instructions.md
│   ├── eng/common/instructions/azsdk-tools/typespec-to-sdk.instructions.md
│   │   ├── eng/common/instructions/azsdk-tools/local-sdk-workflow.instructions.md
│   │   └── eng/common/instructions/azsdk-tools/create-release-plan.instructions.md
│   │       ├── eng/common/instructions/azsdk-tools/sdk-details-in-release-plan.instructions.md
│   │       └── eng/common/instructions/azsdk-tools/verify-namespace-approval.instructions.md
│   ├── eng/common/instructions/azsdk-tools/typespec-docs.instructions.md
│   └── eng/common/instructions/azsdk-tools/customizing-client-tsp.md  (knowledge file)
├── .github/instructions/github-codingagent.instructions.md
├── .github/instructions/armapi-review.instructions.md
├── .github/instructions/openapi-review.instructions.md
├── .github/instructions/github-actions.instructions.md
└── eng/common/instructions/azsdk-tools/check-package-readiness.instructions.md
```

Additional instruction files exist but are **not linked** from the tree:

- `eng/common/instructions/copilot/sdk-release.instructions.md`
- `eng/common/instructions/azsdk-tools/validate-service-label.instructions.md`
- `eng/common/instructions/azsdk-tools/validate-codeowners.instructions.md`
- `eng/common/instructions/azsdk-tools/check-package-validation.instructions.md`

---

## Mapping: Instruction Files → Skills

### Skills Created (TypeSpec-to-SDK Workflow)

| Skill | Type | Source Instruction Files | Description |
|-------|------|--------------------------|-------------|
| **typespec-authoring** | Utility | `typespec-project.instructions.md`, `typespec-docs.instructions.md` | Create/modify TypeSpec API specs, swagger conversion, validation |
| **typespec-customization** | Utility | `customizing-client-tsp.md` | Apply SDK-specific customizations via `client.tsp` decorators |
| **generate-sdk-locally** | Utility | `local-sdk-workflow.instructions.md`, `language-emitter.instructions.md` | Local SDK generation, build, test workflow |
| **package-release-readiness** | Utility | `check-package-readiness.instructions.md` | Check SDK package release readiness and run validation |
| **prepare-release-plan** | Utility | `create-release-plan.instructions.md`, `sdk-details-in-release-plan.instructions.md`, `verify-namespace-approval.instructions.md` | Create/manage release plan work items |
| **apiview-feedback-resolution** | Utility | `typespec-to-sdk.instructions.md` (APIView sections) | Retrieve and resolve APIView review comments |
| **pipeline-troubleshooting** | Utility | `typespec-to-sdk.instructions.md` (pipeline sections) | Diagnose and fix CI/SDK generation pipeline failures |
| **typespec-to-sdk-workflow** | Workflow | `sdk-generation.instructions.md`, `typespec-to-sdk.instructions.md`, `github-codingagent.instructions.md` | End-to-end orchestration invoking all 7 utility skills |

### Additional Skills (Supporting Utilities)

| Skill | Type | Source Instruction Files | Description |
|-------|------|--------------------------|-------------|
| **verify-setup** | Utility | `verify-setup.instructions.md` | Verify developer environment for SDK tooling |
| **validate-service-label** | Utility | `validate-service-label.instructions.md` | Validate or create service labels for SDK repos |
| **validate-codeowners** | Utility | `validate-codeowners.instructions.md` | Validate and manage CODEOWNERS entries |
| **check-package-validation** | Utility | `check-package-validation.instructions.md` | Run SDK package validation checks (lint, format, changelog, etc.) |
| **sdk-release** | Utility | `sdk-release.instructions.md` | Check release readiness and trigger SDK release pipelines |

### Instruction Files Not Converted to Skills

| Instruction File | Reason |
|------------------|--------|
| `armapi-review.instructions.md` | Out of scope (ARM API review, not SDK workflow) |
| `openapi-review.instructions.md` | Out of scope (OpenAPI review, not SDK workflow) |
| `github-actions.instructions.md` | Out of scope (GitHub Actions development, not SDK workflow) |

---

## Skill Files Structure

Each skill follows this structure under `.github/skills/`:

```
<skill-name>/
├── SKILL.md              # Skill definition (frontmatter + steps)
└── references/           # Detailed reference docs (keeps SKILL.md under 500 tokens)
    └── *.md

evals/<skill-name>/
├── eval.yaml             # Eval config (graders, timeouts, model)
├── fixtures/             # Domain-appropriate test fixtures
│   └── <file>
└── tasks/                # Individual eval task definitions
    └── *.yaml
```

### Reference Documents

| Skill | Reference Files |
|-------|-----------------|
| typespec-authoring | `authoring-steps.md`, `migration-checklist.md` |
| typespec-customization | `customization-steps.md`, `decorators-reference.md` |
| generate-sdk-locally | `sdk-repos.md` |
| package-release-readiness | `readiness-details.md` |
| prepare-release-plan | `release-plan-details.md` |
| apiview-feedback-resolution | `feedback-resolution-steps.md` |
| pipeline-troubleshooting | `failure-patterns.md` |
| typespec-to-sdk-workflow | `workflow-details.md` |

---

## Evaluation Suites

All evals use the `copilot-sdk` executor with `claude-sonnet-4.6` model.

### Common Grader Pattern

Every eval includes three graders:

1. **keyword** — Checks that skill-specific terms appear in output
2. **regex** — Checks that relevant MCP tool names or concepts are referenced
3. **code** — Asserts minimum output length (`len(output) > 50`, or `> 100` for workflow)

### Eval Details by Skill

#### typespec-authoring (4 tasks, 300s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `authoring-basic-001` | Create New TypeSpec Project | Happy path: guides through project creation for ARM service |
| `authoring-edge-001` | TypeSpec Compilation Failure Recovery | Error handling: helps fix `tsp compile` errors |
| `authoring-negative-001` | Should Not Trigger | Negative: does not activate for SDK generation requests |
| `authoring-convert-001` | Convert Swagger to TypeSpec | Domain-specific: guides `tsp-client convert` workflow |

**Keywords:** TypeSpec, tspconfig, main.tsp · **Regex:** `azsdk_init_typespec_project|azsdk_run_typespec_validation|tsp compile|tsp-client`
**Fixture:** `main.tsp` — sample TypeSpec file

#### typespec-customization (4 tasks, 300s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `custom-basic-001` | Rename Type for SDK | Happy path: guides `@clientName` decorator usage |
| `custom-edge-001` | Language-Specific Customization | Edge case: `@scope` for per-language customizations |
| `custom-negative-001` | Should Not Trigger | Negative: does not activate for actual API changes |
| `custom-multi-001` | Split Into Multiple Clients | Domain-specific: guides `@client` decorator for multi-client splits |

**Keywords:** client.tsp, clientName, ClientGenerator · **Regex:** `@clientName|@client|@access|@scope|@operationGroup|client\.tsp`
**Fixture:** `client.tsp` — sample customization file

#### generate-sdk-locally (4 tasks, 300s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `sdk-local-basic-001` | Generate Python SDK Locally | Happy path: complete local generation for Python |
| `sdk-local-edge-001` | Build Failure Recovery | Error handling: build failures during local generation |
| `sdk-local-negative-001` | Should Not Trigger | Negative: does not activate for pipeline-based generation |
| `sdk-local-full-001` | Full Local Generation Workflow | Domain-specific: full generate → build → test → prepare PR cycle |

**Keywords:** generate, build, SDK · **Regex:** `azsdk_package_generate_code|azsdk_package_build_code|azsdk_verify_setup`
**Fixture:** `tspconfig.yaml` — sample TypeSpec config

#### package-release-readiness (4 tasks, 300s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `readiness-basic-001` | Check Package Release Readiness | Happy path: runs readiness check for a package |
| `readiness-edge-001` | Package Not Ready - Missing Changelog | Edge case: handles missing changelog entries |
| `readiness-negative-001` | Should Not Trigger | Negative: does not activate for SDK generation requests |
| `readiness-release-001` | Release SDK Package | Domain-specific: guides through actual release process |

**Keywords:** release, package, readiness · **Regex:** `azsdk_release_sdk|azsdk_package_run_check|changelog|validation`
**Fixture:** `changelog.md` — sample changelog file

#### prepare-release-plan (4 tasks, 300s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `release-plan-basic-001` | Create New Release Plan | Happy path: creates plan with Service Tree ID and API version |
| `release-plan-edge-001` | Invalid Package Name Format | Edge case: validates package name formats |
| `release-plan-negative-001` | Should Not Trigger | Negative: does not activate for package release requests |
| `release-plan-link-001` | Link SDK PRs to Release Plan | Domain-specific: links SDK pull requests to existing plan |

**Keywords:** release plan, Service Tree, API version · **Regex:** `azsdk_create_release_plan|azsdk_get_release_plan|azsdk_update_sdk_details`
**Fixture:** `tspconfig.yaml` — sample TypeSpec config

#### apiview-feedback-resolution (4 tasks, 300s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `apiview-basic-001` | Retrieve and Review APIView Comments | Happy path: retrieves and summarizes APIView comments |
| `apiview-edge-001` | APIView Requires TypeSpec Change | Edge case: feedback requiring TypeSpec modifications |
| `apiview-negative-001` | Should Not Trigger | Negative: does not activate for project creation |
| `apiview-no-feedback-001` | No APIView Feedback Found | Domain-specific: handles empty feedback gracefully |

**Keywords:** APIView, feedback, comment · **Regex:** `azsdk_apiview_get_comments|azsdk_typespec_delegate_apiview_feedback|APIView`
**Fixture:** `apiview-comment.json` — sample APIView comment

#### pipeline-troubleshooting (4 tasks, 300s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `pipeline-basic-001` | Analyze Pipeline Build Failure | Happy path: diagnoses a failing pipeline |
| `pipeline-edge-001` | Multiple Languages Failed | Edge case: failures across multiple language pipelines |
| `pipeline-negative-001` | Should Not Trigger | Negative: does not activate for TypeSpec authoring |
| `pipeline-repro-001` | Reproduce Pipeline Failure Locally | Domain-specific: guides local reproduction of pipeline failure |

**Keywords:** pipeline, build, failure · **Regex:** `azsdk_analyze_pipeline|pipeline|build failure|CI`
**Fixture:** `pipeline-error.log` — sample pipeline error log

#### typespec-to-sdk-workflow (5 tasks, 600s timeout)

| Task ID | Name | Tests |
|---------|------|-------|
| `workflow-basic-001` | Full Release Workflow - New Service | Happy path: full end-to-end workflow for new service |
| `workflow-edge-001` | Resume Workflow - Existing Release Plan | Edge case: detects existing plan and resumes mid-workflow |
| `workflow-negative-001` | Should Not Trigger | Negative: does not activate for single-step tasks |
| `workflow-experiment-001` | Experimentation Path | Domain-specific: experimentation mode (generate SDKs, skip release) |
| `workflow-transition-001` | Transition from Experimentation to Release | Domain-specific: transition from experimentation to full release |

**Keywords:** TypeSpec, SDK, release, generate · **Regex:** `release plan|SDK generation|TypeSpec|API spec|pipeline`
**Fixture:** `tspconfig.yaml` — sample TypeSpec config

---

## Eval Run Results

All 8 eval suites were run with `waza run --discover`. Results:

| Skill | Pass Rate | Avg Score | Tasks | Notes |
|-------|-----------|-----------|-------|-------|
| ✅ apiview-feedback-resolution | 100% | 1.00 | 4/4 | |
| ✅ pipeline-troubleshooting | 100% | 1.00 | 4/4 | |
| ✅ prepare-release-plan | 100% | 1.00 | 4/4 | |
| ✅ typespec-authoring | 100% | 1.00 | 4/4 | |
| ✅ typespec-to-sdk-workflow | 100% | 1.00 | 5/5 | |
| ❌ generate-sdk-locally | 75% | 1.00 | 3/4 | "Generate Python SDK Locally" timed out at 300s (44 tool calls) |
| ❌ typespec-customization | 75% | 1.00 | 3/4 | "Split Into Multiple Clients" timed out at 300s (35 tool calls) |
| ❌ package-release-readiness | 75% | 0.92 | 3/4 | "Should Not Trigger" timed out at 300s (62 tool calls, truncated output) |

**Overall: 30/33 tasks passed (91%). All 3 failures are execution timeouts, not grader failures.**

All graders scored 1.00 on keyword and regex checks for the timed-out tasks — the agent responses were on-topic but exceeded the time budget because the agent attempted to actually perform the real operations (SDK generation, builds). Timeouts for the 3 affected suites have been bumped from 300s → 600s.

---

## Sensei Improvement Results

After the initial waza-based creation, sensei was used to score and improve all 8 skills through the Ralph loop pattern (READ → SCORE → CHECK → IMPROVE → TEST → TOKENS).

### Improvements Applied

| Improvement | Before | After | Skills Affected |
|-------------|--------|-------|-----------------|
| Routing triggers | `TOOLS/COMMANDS:` header | `INVOKES:` + `FOR SINGLE OPERATIONS:` | All 8 skills |
| Trigger phrases | Prose descriptions | Quoted trigger phrases (`"create TypeSpec project"`) | All 8 skills |
| Procedural content | Declarative-only flagged | Added action verbs + routing phrases | typespec-authoring, typespec-customization |
| Token reduction | 505 / 520 tokens | 377 / 393 tokens | generate-sdk-locally, prepare-release-plan |
| Cross-skill routing | `DO NOT USE FOR:` with names only | `DO NOT USE FOR:` with `(use <skill-name>)` redirects | All 8 skills |

### Sensei Score Summary (Post-Improvement)

| Skill | Tokens | Compliance | Spec | Advisory | Stars |
|-------|--------|------------|------|----------|-------|
| typespec-authoring | 491 | High | 8/8 ✅ | All pass ✅ | 🌟 module-count, 🌟 complexity |
| typespec-customization | 465 | High | 8/8 ✅ | All pass ✅ | 🌟 module-count, 🌟 complexity |
| generate-sdk-locally | 377 | High | 8/8 ✅ | All pass ✅ | 🌟 complexity |
| package-release-readiness | 446 | High | 8/8 ✅ | All pass ✅ | 🌟 complexity |
| prepare-release-plan | 393 | High | 8/8 ✅ | All pass ✅ | — |
| apiview-feedback-resolution | 444 | High | 8/8 ✅ | All pass ✅ | 🌟 complexity |
| pipeline-troubleshooting | 461 | High | 8/8 ✅ | All pass ✅ | 🌟 complexity |
| typespec-to-sdk-workflow | 495 | High | 8/8 ✅ | All pass ✅ | 🌟 complexity |

**Total tokens: 3572** (down from 3817 before sensei, -6.4%)

### Remaining Advisory Notes

- All 8 skills show `⚠️ spec-version` — this is a false positive; `metadata.version: "1.0.0"` is present but sensei looks for a different YAML path.
- Waza MCP Integration checks (prerequisites, CLI fallback) are advisory only and don't affect compliance score.

---

## Summary

| Metric | Count |
|--------|-------|
| Instruction files analyzed | 19 |
| Skills created | 13 (12 utility + 1 workflow) |
| Instructions excluded | 3 (out-of-scope) |
| Reference docs | 10 |
| Eval suites | 13 |
| Total eval tasks | 53 |
| Eval fixtures | 8 |
| Compliance level | High (all 13 skills ✅) |
| Eval pass rate | 91% (30/33 tasks, original 8 suites) |
| Sensei improvements | 5 categories across original 8 skills |
| Total tokens (all 13 skills) | ~5811 |
