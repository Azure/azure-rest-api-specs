# TypeSpec-to-SDK Workflow Skills

Copilot skills that guide AI agents through the Azure TypeSpec-to-SDK release workflow.
These skills are consumed by GitHub Copilot (CLI, VS Code, and Coding Agent) when users work
with TypeSpec API specifications and Azure SDK generation in this repository.

---

## Available Skills

### Workflow Skill

| Skill | Triggers | Description |
|-------|----------|-------------|
| [typespec-to-sdk-workflow](typespec-to-sdk-workflow/SKILL.md) | "full SDK release workflow", "TypeSpec to SDK end to end" | Orchestrates the full TypeSpec → SDK release process, invoking all utility skills below |

### Utility Skills

| Skill | Triggers | Description |
|-------|----------|-------------|
| [typespec-authoring](typespec-authoring/SKILL.md) | "create TypeSpec project", "convert swagger to TypeSpec", "validate TypeSpec" | Create, modify, and validate TypeSpec API specifications |
| [typespec-customization](typespec-customization/SKILL.md) | "rename type for SDK", "@clientName", "client.tsp" | Apply SDK-specific customizations via `client.tsp` decorators |
| [generate-sdk-locally](generate-sdk-locally/SKILL.md) | "generate SDK locally", "build SDK", "run SDK tests" | Generate, build, and test Azure SDKs locally from TypeSpec |
| [prepare-release-plan](prepare-release-plan/SKILL.md) | "create release plan", "link SDK PR to plan" | Create and manage release plan work items |
| [package-release-readiness](package-release-readiness/SKILL.md) | "is package ready for release", "release SDK package" | Check SDK package release readiness and trigger releases |
| [apiview-feedback-resolution](apiview-feedback-resolution/SKILL.md) | "APIView comments", "resolve API review feedback" | Retrieve and resolve APIView review feedback |
| [pipeline-troubleshooting](pipeline-troubleshooting/SKILL.md) | "pipeline failed", "build failure", "CI check failing" | Diagnose and resolve SDK CI and generation pipeline failures |
| [verify-setup](verify-setup/SKILL.md) | "verify setup", "check environment", "missing tools" | Verify developer environment for SDK development |
| [validate-service-label](validate-service-label/SKILL.md) | "check service label", "create service label" | Validate or create service labels for SDK repos |
| [validate-codeowners](validate-codeowners/SKILL.md) | "validate codeowners", "check code owners" | Validate and manage CODEOWNERS entries |
| [check-package-validation](check-package-validation/SKILL.md) | "run package check", "lint SDK", "format check" | Run SDK package validation checks |
| [sdk-release](sdk-release/SKILL.md) | "release SDK", "trigger release pipeline" | Check release readiness and trigger SDK releases |

### Development & Meta Skills

These skills (from [microsoft/GitHub-Copilot-for-Azure](https://github.com/microsoft/GitHub-Copilot-for-Azure)) help with skill development itself:

| Skill | Triggers | Description |
|-------|----------|-------------|
| [sensei](sensei/SKILL.md) | "run sensei", "improve skill", "fix frontmatter" | Iteratively improve skill frontmatter compliance using the Ralph loop |
| [skill-authoring](skill-authoring/SKILL.md) | "create a skill", "new skill", "skill template" | Guidelines for writing Agent Skills per agentskills.io spec |
| [markdown-token-optimizer](markdown-token-optimizer/SKILL.md) | "optimize markdown", "reduce tokens", "token count" | Analyze markdown files for token efficiency |
| [report-test-bug](report-test-bug/SKILL.md) | "file test bug", "report test failure" | File GitHub issues for integration test failures |

### Skill Anatomy

Each skill lives in `<name>/` and contains:

```
<name>/
├── SKILL.md           # Skill definition: YAML frontmatter + steps + related skills
├── references/        # Detailed reference docs (offloaded to keep SKILL.md under 500 tokens)
│   └── *.md
├── eval.yaml          # Evaluation config (graders, timeouts, model)
├── tasks/             # Eval task definitions (4-5 per skill)
│   └── *.yaml
└── fixtures/          # Domain-specific test fixtures
    └── <files>
```

For the full mapping between original instruction files and these skills, see
[INSTRUCTION-TO-SKILL-MAPPING.md](INSTRUCTION-TO-SKILL-MAPPING.md).

---

## Tooling

Two tools are used together to develop, score, and test skills:

| Tool | Purpose | Install |
|------|---------|---------|
| [**waza**](https://spboyer.github.io/waza/getting-started/) | Scaffold skills, run evals, check compliance | `go install github.com/spboyer/waza/cmd/waza@latest` |
| [**sensei**](https://github.com/spboyer/sensei) | Score frontmatter quality, count tokens, suggest improvements | `git clone` + `npm ci` in `scripts/` |

### Installing waza

Requires **Go 1.25+**.

```bash
go install github.com/spboyer/waza/cmd/waza@latest

# Verify
waza --version
```

### Installing sensei

```bash
git clone https://github.com/spboyer/sensei.git ~/.copilot/skills/sensei
cd ~/.copilot/skills/sensei/scripts
npm ci
```

The sensei token CLI is invoked via:

```bash
node --import ~/.copilot/skills/sensei/scripts/node_modules/tsx/dist/loader.mjs \
     ~/.copilot/skills/sensei/scripts/src/tokens/cli.ts <command> [args]
```

> **Tip:** Create a shell alias for convenience:
> ```bash
> alias sensei-tokens='node --import ~/.copilot/skills/sensei/scripts/node_modules/tsx/dist/loader.mjs ~/.copilot/skills/sensei/scripts/src/tokens/cli.ts'
> ```

---

## Developing a New Skill

### 1. Scaffold with waza

```bash
cd .github/skills
waza new my-skill
```

This creates `my-skill/` with a template `SKILL.md` and eval scaffolding.

### 2. Write the SKILL.md

Follow the [agentskills.io spec](https://agentskills.io) for frontmatter:

```yaml
---
name: my-skill
license: MIT
metadata:
  version: "1.0.0"
description: |
  **UTILITY SKILL**
  One-line summary of what this skill does.
  USE FOR: "trigger phrase 1", "trigger phrase 2", "trigger phrase 3".
  DO NOT USE FOR: out-of-scope task (use other-skill), another out-of-scope task.
  INVOKES: azsdk_tool_1, azsdk_tool_2, cli_command.
  FOR SINGLE OPERATIONS: Use azsdk_tool_1 directly for quick checks.
---
```

**Key rules:**
- Keep total SKILL.md **under 500 tokens** (offload detail to `references/*.md`)
- Use quoted trigger phrases in `USE FOR:` for routing accuracy
- Include `(use <skill-name>)` redirects in `DO NOT USE FOR:`
- Add `INVOKES:` listing MCP tools and CLI commands
- Add `FOR SINGLE OPERATIONS:` for quick single-tool guidance

### 3. Add reference docs

Put detailed instructions in `my-skill/references/`:

```bash
mkdir -p my-skill/references
# Create reference files
```

**Optimal count:** 2–3 reference modules scores highest on sensei benchmarks.

### 4. Write eval tasks

Create 4–5 task YAML files in `my-skill/tasks/`:

| Task Type | Purpose | Example |
|-----------|---------|---------|
| `basic` | Happy-path usage | "Create a new TypeSpec project for ARM service" |
| `edge` | Error handling / uncommon scenarios | "Fix TypeSpec compilation errors" |
| `negative` | Should NOT trigger for out-of-scope requests | "Generate SDK for Python" (wrong skill) |
| `domain` | Domain-specific complex scenario | "Convert swagger with multiple API versions" |

Task YAML format:

```yaml
id: my-skill-basic-001
name: "Descriptive Task Name"
prompt: |
  User prompt that would trigger this skill...
graders:
  - type: keyword
    keywords: ["expected", "output", "terms"]
  - type: regex
    pattern: "tool_name|other_pattern"
  - type: code
    code: "len(output) > 50"
```

### 5. Configure eval.yaml

```yaml
skill: my-skill
engine: copilot-sdk
model: claude-sonnet-4.6
timeout: 300
tasks:
  - tasks/my-skill-basic-001.yaml
  - tasks/my-skill-edge-001.yaml
  - tasks/my-skill-negative-001.yaml
  - tasks/my-skill-domain-001.yaml
```

---

## Testing and Improving Skills

### Check compliance with waza

```bash
cd .github/skills

# Check all skills
waza check

# Check a single skill
waza check my-skill
```

Target: **High** compliance on all checks (Spec 8/8, Token ≤500, Eval found).

### Run evals with waza

```bash
# Run all eval suites (discovers skills with eval.yaml)
waza run --discover

# Run a single skill's evals
waza run my-skill/eval.yaml
```

Eval results show per-task pass/fail with grader scores. A task passes when all graders
score ≥0.5 and the agent responds within the timeout.

### Score with sensei

```bash
cd .github/skills

# Count tokens for all skills
sensei-tokens count */SKILL.md

# Score a single skill (spec compliance + advisory checks)
sensei-tokens score my-skill/

# Score all skills
for s in */; do echo "=== $(basename $s) ===" && sensei-tokens score "$s"; done
```

**Sensei checks:**
- **Spec compliance** — frontmatter structure, name, description, license, version
- **Advisory** — module count (2–3 optimal), complexity tier (detailed = best), procedural content, negative-delta risk, over-specificity

### The Ralph Loop (iterative improvement)

Sensei's recommended improvement cycle:

```
READ → SCORE → CHECK → IMPROVE → TEST → TOKENS → SUMMARY → REPEAT
```

1. **READ** — Read the SKILL.md
2. **SCORE** — Run `sensei-tokens score <name>/`
3. **CHECK** — Run `waza check <name>`
4. **IMPROVE** — Fix flagged issues (token budget, routing triggers, procedural content)
5. **TEST** — Run `waza run <name>/eval.yaml`
6. **TOKENS** — Re-count tokens to verify ≤500
7. **SUMMARY** — Document before/after metrics
8. **REPEAT** — Continue until High compliance + all advisory checks pass

### Common improvements

| Issue | Fix |
|-------|-----|
| ⚠️ Over 500 tokens | Move detail to `references/*.md`, remove MCP tools table, compress steps |
| ⚠️ Declarative-only | Add action verbs: "Create", "Apply", "Run", "Generate" in description |
| ⚠️ Missing routing triggers | Add quoted phrases in `USE FOR:` and `DO NOT USE FOR:` |
| ⚠️ No cross-skill routing | Add `(use <skill-name>)` redirects in `DO NOT USE FOR:` |
| Missing `INVOKES:` | List all MCP tools and CLI commands the skill uses |

---

## CI Integration

The `.github/workflows/eval.yml` workflow runs `waza check` and `waza run --discover`
on pull requests that modify files under `.github/skills/`.

---

## Current Compliance Status

| Skill | Type | Compliance | Tokens | MCP | Eval |
|-------|------|------------|--------|-----|------|
| typespec-to-sdk-workflow | Workflow | High | 500 ✅ | **4/4** ✅ | ✅ |
| typespec-authoring | Utility | High | 489 ✅ | **4/4** ✅ | ✅ |
| typespec-customization | Utility | High | 466 ✅ | **4/4** ✅ | ✅ |
| generate-sdk-locally | Utility | High | 488 ✅ | **4/4** ✅ | ✅ |
| prepare-release-plan | Utility | High | 472 ✅ | **4/4** ✅ | ✅ |
| package-release-readiness | Utility | High | 461 ✅ | **4/4** ✅ | ✅ |
| apiview-feedback-resolution | Utility | High | 465 ✅ | **4/4** ✅ | ✅ |
| pipeline-troubleshooting | Utility | High | 449 ✅ | **4/4** ✅ | ✅ |
| verify-setup | Utility | High | 460 ✅ | **4/4** ✅ | ✅ |
| validate-service-label | Utility | High | 419 ✅ | **4/4** ✅ | ✅ |
| validate-codeowners | Utility | High | 445 ✅ | **4/4** ✅ | ✅ |
| check-package-validation | Utility | High | 491 ✅ | **4/4** ✅ | ✅ |
| sdk-release | Utility | High | 464 ✅ | **4/4** ✅ | ✅ |
| sensei | Meta | Medium-High | 2098 ❌ | — | ⚠️ |
| skill-authoring | Meta | Medium | 675 ❌ | — | ⚠️ |
| markdown-token-optimizer | Meta | Medium | 333 ✅ | — | ⚠️ |
| report-test-bug | Meta | Medium | 606 ❌ | — | ⚠️ |

All 13 TypeSpec-to-SDK skills now pass 4/4 MCP Integration checks (prerequisites + CLI fallback documented).

---

## Project Configuration

- **`.waza.yaml`** — Default engine (`copilot-sdk`) and model (`claude-sonnet-4.6`) for evals
- **`.gitignore`** — Excludes waza output directories and temp files

## Further Reading

- [agentskills.io spec](https://agentskills.io) — Skill frontmatter specification
- [waza docs](https://spboyer.github.io/waza/getting-started/) — Scaffold, check, and eval skills
- [sensei repo](https://github.com/spboyer/sensei) — Score and improve skill quality
- [sensei SCORING.md](sensei/references/SCORING.md) — Detailed sensei scoring criteria
- [skill-authoring CHECKLIST.md](skill-authoring/references/CHECKLIST.md) — Pre-submission checklist
- [Skills Guidelines](https://github.com/Azure/azure-sdk-tools/blob/main/tools/azsdk-cli/docs/skills-guidelines.md) — Azure SDK skill guidelines
- [TypeSpec-to-SDK Workflow Spec](https://github.com/Azure/azure-sdk-tools/blob/main/tools/azsdk-cli/docs/specs/typespec-to-sdk-release-workflow.spec.md) — Workflow reference
- [INSTRUCTION-TO-SKILL-MAPPING.md](INSTRUCTION-TO-SKILL-MAPPING.md) — Maps original instruction files to skills
