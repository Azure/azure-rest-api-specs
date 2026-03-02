# TypeSpec-to-SDK Workflow Skills

Copilot skills that guide AI agents through the Azure TypeSpec-to-SDK release workflow.
These skills are consumed by GitHub Copilot (CLI, VS Code, and Coding Agent) when users work
with TypeSpec API specifications and Azure SDK generation in this repository.

---

## Available Skills

| Skill                                                               | Triggers                                                    | Description                                                  |
| ------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------------------------------------------------ |
| [sdk-release](sdk-release/SKILL.md)                                 | "release SDK", "trigger release", "check release readiness" | Check SDK release readiness and trigger the release pipeline |
| [prepare-release-plan](prepare-release-plan/SKILL.md)               | "create release plan", "link SDK PR to plan"                | Create and manage release plan work items                    |
| [pipeline-troubleshooting](pipeline-troubleshooting/SKILL.md)       | "pipeline failed", "build failure", "CI check failing"      | Diagnose and resolve SDK CI and generation pipeline failures |
| [apiview-feedback-resolution](apiview-feedback-resolution/SKILL.md) | "APIView comments", "resolve API review feedback"           | Retrieve and resolve APIView review feedback                 |

---

## Skill Anatomy

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

---

## Tooling

| Tool                                                        | Purpose                                      | Install                                              |
| ----------------------------------------------------------- | -------------------------------------------- | ---------------------------------------------------- |
| [**waza**](https://spboyer.github.io/waza/getting-started/) | Scaffold skills, run evals, check compliance | `go install github.com/spboyer/waza/cmd/waza@latest` |

### Quick Commands

```bash
cd .github/skills

# Check all skills for compliance
waza check

# Run all eval suites
waza run --discover

# Check a single skill
waza check sdk-release
```

---

## Developing a New Skill

### 1. Scaffold with waza

```bash
cd .github/skills
waza new my-skill
```

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
  USE FOR: "trigger phrase 1", "trigger phrase 2".
  DO NOT USE FOR: out-of-scope task (use other-skill).
  INVOKES: azsdk_tool_1, azsdk_tool_2.
  FOR SINGLE OPERATIONS: Use azsdk_tool_1 directly for quick checks.
---
```

**Key rules:**

- Keep total SKILL.md **under 500 tokens** (offload detail to `references/*.md`)
- Use quoted trigger phrases in `USE FOR:` for routing accuracy
- Include `(use <skill-name>)` redirects in `DO NOT USE FOR:`
- Add `INVOKES:` listing MCP tools and CLI commands
- Add `FOR SINGLE OPERATIONS:` for quick single-tool guidance

### 3. Write eval tasks

Create 4–5 task YAML files in `my-skill/tasks/`:

| Task Type  | Purpose                                      |
| ---------- | -------------------------------------------- |
| `basic`    | Happy-path usage                             |
| `edge`     | Error handling / uncommon scenarios          |
| `negative` | Should NOT trigger for out-of-scope requests |
| `domain`   | Domain-specific complex scenario             |

### 4. Test

```bash
waza check my-skill
waza run my-skill/eval.yaml
```

---

## Further Reading

- [agentskills.io spec](https://agentskills.io) — Skill frontmatter specification
- [waza docs](https://spboyer.github.io/waza/getting-started/) — Scaffold, check, and eval skills
- [Skills Guidelines](https://github.com/Azure/azure-sdk-tools/blob/main/tools/azsdk-cli/docs/skills-guidelines.md) — Azure SDK skill guidelines
- [TypeSpec-to-SDK Workflow Spec](https://github.com/Azure/azure-sdk-tools/blob/main/tools/azsdk-cli/docs/specs/typespec-to-sdk-release-workflow.spec.md) — Workflow reference
