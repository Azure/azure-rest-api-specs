# Sensei

> "A true master teaches not by telling, but by refining." - The Skill Sensei

Sensei automates the improvement of [Agent Skills](https://agentskills.io) frontmatter compliance using the [Ralph loop pattern](https://github.com/soderlind/ralph) - iteratively improving skills until they reach Medium-High compliance with all tests passing.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [How It Works](#how-it-works)
- [Configuration](#configuration)
- [Scoring Criteria](#scoring-criteria)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

---

## Overview

### The Problem

The [frontmatter audit](https://gist.github.com/spboyer/28c31bf0cafb87489406832633aa31a7) revealed that all Azure skills have:
- **0% High adherence** - No skills have triggers + anti-triggers + compatibility
- **46% Low adherence** - 12 skills have minimal descriptions without clear triggers
- **0/26 anti-triggers** - No skills tell agents when NOT to use them

This leads to **skill collision** - agents invoking the wrong skill for a given prompt.

### The Solution

Sensei implements the "Ralph Wiggum" technique:
1. **Read** - Load the skill's current state and token count
2. **Score** - Evaluate frontmatter compliance
3. **Improve** - Add triggers, anti-triggers, compatibility
4. **Verify** - Run tests to ensure changes work
5. **Validate References** - Check markdown links are valid
6. **Check Tokens** - Analyze token usage, gather suggestions
7. **Summary** - Display before/after with suggestions
8. **Prompt** - Ask user: Commit, Create Issue, or Skip?
9. **Repeat** - Until target score reached

---

## Quick Start

### Single Skill
```
Run sensei on appinsights-instrumentation
```

### Single Skill (Fast Mode)
```
Run sensei on appinsights-instrumentation --skip-integration
```

### Multiple Skills
```
Run sensei on azure-security, azure-observability
```

### All Low-Adherence Skills
```
Run sensei on all Low-adherence skills
```

### All Skills
```
Run sensei on all skills
```

### Flags

| Flag | Description |
|------|-------------|
| `--skip-integration` | Skip integration tests for faster iteration (unit + trigger tests only) |

> ⚠️ **Note:** Using `--skip-integration` speeds up the loop significantly but may miss runtime issues. Consider running full tests before final commit.

---

## Prerequisites

### Required

1. **Copilot CLI** - Installed and authenticated
   ```bash
   copilot --version
   ```

2. **Node.js** - For running tests
   ```bash
   node --version  # v18+ recommended
   ```

3. **Git** - For commits
   ```bash
   git --version
   ```

### Setup

```bash
# Install test dependencies
cd tests
npm install

# Verify tests run
npm test -- --testPathPattern=azure-validation
```

---

## How It Works

### The Ralph Loop

```
┌─────────────────────────────────────────────────────────┐
│  START: User invokes "Run sensei on {skill-name}"       │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  1. READ: Load plugin/skills/{skill-name}/SKILL.md      │
│           Load tests/{skill-name}/ (if exists)          │
│           Count tokens (baseline for comparison)        │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  2. SCORE: Run rule-based compliance check              │
│     • Check description length (> 150 chars?)           │
│     • Check for trigger phrases ("USE FOR:")            │
│     • Check for anti-triggers ("DO NOT USE FOR:")       │
│     • Check for compatibility field                     │
└─────────────────────┬───────────────────────────────────┘
                      ▼
              ┌───────────────┐
              │ Score >= M-H  │──YES──▶ COMPLETE ✓
              │ AND tests pass│        (next skill)
              └───────┬───────┘
                      │ NO
                      ▼
┌─────────────────────────────────────────────────────────┐
│  3. SCAFFOLD: If tests/{skill-name}/ missing:           │
│     cp -r tests/_template tests/{skill-name}            │
│     Update SKILL_NAME in test files                     │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  4. IMPROVE FRONTMATTER:                                │
│     • Add "USE FOR:" with trigger phrases               │
│     • Add "DO NOT USE FOR:" with anti-triggers          │
│     • Add compatibility if applicable                   │
│     • Keep description under 1024 chars                 │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  5. IMPROVE TESTS:                                      │
│     • Update shouldTriggerPrompts (5+ prompts)          │
│     • Update shouldNotTriggerPrompts (5+ prompts)       │
│     • Match prompts to new frontmatter triggers         │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  6. VERIFY: npm test -- --testPathPattern={skill-name}  │
│     • If tests fail → fix and retry                     │
│     • If tests pass → continue                          │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  7. VALIDATE REFERENCES:                                │
│     npm run references {skill-name}                     │
│     • Check markdown links are valid                    │
│     • Ensure links stay within skill directory          │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  8. CHECK TOKENS:                                       │
│     npm run tokens -- check plugin/skills/{skill-name}  │
│     npm run tokens -- suggest (gather optimizations)    │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  9. SUMMARY: Display before/after comparison            │
│     • Score change (Low → Medium-High)                  │
│     • Token delta (+/- tokens)                          │
│     • Unimplemented suggestions                         │
└─────────────────────┬───────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────────────┐
│  10. PROMPT USER: Choose action                         │
│     [C] Commit changes                                  │
│     [I] Create GitHub issue with suggestions            │
│     [S] Skip (discard changes)                          │
└─────────────────────┬───────────────────────────────────┘
                      ▼
              ┌───────────────┐
              │ Iteration < 5 │──YES──▶ Go to step 2
              └───────┬───────┘
                      │ NO
                      ▼
               TIMEOUT (move to next skill)
```

### Batch Processing

When running on multiple skills:
1. Skills are processed sequentially
2. Each skill goes through the full loop
3. User prompted after each skill: Commit, Create Issue, or Skip
4. Summary report at the end shows all results

---

## Configuration

| Setting | Default | Description |
|---------|---------|-------------|
| Max iterations | 5 | Per-skill iteration limit before moving on |
| Target score | Medium-High | Minimum compliance level |
| Token soft limit | 500 | SKILL.md target token count |
| User prompt | After each skill | Commit, Create Issue, or Skip |
| Continue on failure | Yes | Process remaining skills if one fails |
| Skip integration | No | Use `--skip-integration` to run only unit/trigger tests |

---

## Scoring Criteria

### Adherence Levels

| Level | Description | Criteria |
|-------|-------------|----------|
| **Low** | Basic description | No explicit triggers, no anti-triggers, often < 150 chars |
| **Medium** | Has trigger keywords | Description > 150 chars, implicit or explicit trigger phrases |
| **Medium-High** | Has triggers + anti-triggers | "USE FOR:" present AND "DO NOT USE FOR:" present |
| **High** | Full compliance | Triggers + anti-triggers + compatibility field |

### Rule-Based Checks

Per the [agentskills.io specification](https://agentskills.io/specification):

1. **Name validation**
   - Lowercase alphanumeric + hyphens only
   - No consecutive hyphens (`--`)
   - Must not start or end with hyphen
   - Matches directory name
   - ≤ 64 characters

2. **Description length**
   - Minimum: 150 characters (effective)
   - Maximum: 1024 characters (spec limit)

3. **Trigger phrases**
   - Contains "USE FOR:", "TRIGGERS:", or "Use this skill when"
   - Lists specific keywords and phrases

4. **Anti-triggers**
   - Contains "DO NOT USE FOR:" or "NOT FOR:"
   - Lists scenarios that should use other skills

5. **Compatibility** (optional for Medium-High)
   - Lists required tools/frameworks
   - Documents prerequisites
   - Max 500 characters per spec

6. **Optional spec fields** (preserve if present)
   - `license`, `metadata`, `allowed-tools`

7. **Size limits**
   - SKILL.md < 500 lines (spec recommendation)
   - SKILL.md < 500 tokens (soft), < 5000 (hard)

### Target: Medium-High

To reach Medium-High, a skill must have:
- ✅ Description > 150 characters
- ✅ Explicit trigger phrases ("USE FOR:" or equivalent)
- ✅ Anti-triggers ("DO NOT USE FOR:" or clear scope limitation)
- ✅ SKILL.md < 500 tokens (soft limit, monitored)

### Token Budget

From [skill-authoring](/.github/skills/skill-authoring):
- **SKILL.md:** < 500 tokens (soft), < 5000 (hard)
- **references/*.md:** < 1000 tokens each
- Check with: `cd scripts && npm run tokens -- check plugin/skills/{skill}/SKILL.md`

---

## Examples

### Before: Low Adherence

```yaml
---
name: appinsights-instrumentation
description: 'Instrument a webapp to send useful telemetry data to Azure App Insights'
---
```

**Problems:**
- Only 71 characters
- No trigger phrases
- No anti-triggers
- Agent doesn't know when to activate

### After: Medium-High Adherence

```yaml
---
name: appinsights-instrumentation
description: >-
  Instrument web apps to send telemetry to Azure Application Insights.
  USE FOR: "add App Insights", "instrument my app", "set up monitoring",
  "add telemetry", "track requests", "ASP.NET Core telemetry", "Node.js monitoring".
  DO NOT USE FOR: querying logs (use azure-observability), creating alerts,
  dashboard configuration, or cost analysis.
---
```

**Improvements:**
- ~350 characters (informative but under limit)
- Clear description of purpose
- Explicit trigger phrases
- Anti-triggers prevent collision with azure-observability

### Test Updates

**Before (empty):**
```javascript
const shouldTriggerPrompts = [];
const shouldNotTriggerPrompts = [];
```

**After:**
```javascript
const shouldTriggerPrompts = [
  'Add App Insights to my web app',
  'Instrument my ASP.NET Core app for monitoring',
  'Set up telemetry for my Node.js application',
  'How do I track requests in Application Insights?',
  'Add monitoring to my webapp',
];

const shouldNotTriggerPrompts = [
  'Query my Application Insights logs',
  'Create an alert for high CPU usage',
  'Show me my App Insights dashboard',
  'How much does App Insights cost?',
  'Help me with AWS CloudWatch',
];
```

---

## Troubleshooting

### Tests Failing After Improvement

**Symptom:** Tests fail after frontmatter changes

**Solution:**
1. Check that `shouldTriggerPrompts` match the new trigger phrases
2. Check that `shouldNotTriggerPrompts` match the new anti-triggers
3. Run tests manually to see specific failures:
   ```bash
   cd tests
   npm test -- --testPathPattern={skill-name} --verbose
   ```

### Skill Not Reaching Target Score

**Symptom:** Ralph loops 5 times without reaching Medium-High

**Possible causes:**
1. Description too long (> 1024 chars) - trim content
2. Anti-triggers not in recognized format - use "DO NOT USE FOR:"
3. Conflicting triggers with other skills - make more specific

### Rolling Back Changes

```bash
# Undo last commit
git reset --soft HEAD~1

# Undo all sensei commits for a skill
git log --oneline | grep "sensei: improve {skill-name}" | head -5
git reset --hard {commit-before-sensei}
```

### Viewing Progress

```bash
# See all sensei improvements
git log --oneline --grep="sensei:"

# See changes to a specific skill
git log --oneline -p plugin/skills/{skill-name}/SKILL.md
```

---

## Contributing

### Improving the Sensei Skill

The Sensei skill lives at `.github/skills/sensei/`. To improve it:

1. Edit `SKILL.md` for instruction changes
2. Edit `references/*.md` for documentation changes
3. Test on a sample skill before committing

### Adding New Scoring Rules

1. Document the rule in `references/SCORING.md`
2. Add examples in `references/EXAMPLES.md`
3. Update the rule-based checks in `SKILL.md`

### Reporting Issues

If Sensei produces unexpected results:
1. Note the skill name and starting state
2. Capture the commit history: `git log --oneline -10`
3. Open an issue with reproduction steps

---

## References

- [Ralph (Copilot CLI runner)](https://github.com/soderlind/ralph) - Original Ralph loop implementation
- [Agent Skills Specification](https://agentskills.io/specification) - Official spec
- [Frontmatter Compliance Audit](https://gist.github.com/spboyer/28c31bf0cafb87489406832633aa31a7) - Audit results
- [Anthropic Skills Best Practices](https://support.anthropic.com/en/articles/12512198-how-to-create-custom-skills) - Writing guidance

---

*Sensei - "The path to compliance begins with a single trigger."* 🥋

### Related Skills

- [markdown-token-optimizer](/.github/skills/markdown-token-optimizer) - Token analysis and optimization suggestions
- [skill-authoring](/.github/skills/skill-authoring) - Guidelines for writing compliant Agent Skills
