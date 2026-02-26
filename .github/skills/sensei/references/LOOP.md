# Ralph Loop Workflow

Detailed workflow documentation for the Ralph loop pattern.

## Overview

The Ralph loop is an iterative improvement cycle inspired by the ["Ralph Wiggum" technique](https://www.humanlayer.dev/blog/brief-history-of-ralph) - letting AI implement features one at a time until complete.

## Loop States

```
         ┌──────────────────┐
         │      START       │
         │  (skill-name)    │
         └────────┬─────────┘
                  │
                  ▼
         ┌──────────────────┐
         │    1. READ       │◀──────────────────┐
         │  Load SKILL.md   │                   │
         │  Count tokens    │                   │
         └────────┬─────────┘                   │
                  │                             │
                  ▼                             │
         ┌──────────────────┐                   │
         │    2. SCORE      │                   │
         │  Rule-based      │                   │
         │  compliance      │                   │
         └────────┬─────────┘                   │
                  │                             │
                  ▼                             │
         ┌──────────────────┐                   │
         │  Score >= M-H?   │──NO───┐           │
         │  Tests pass?     │       │           │
         └────────┬─────────┘       │           │
                  │ YES             │           │
                  ▼                 ▼           │
         ┌──────────────────┐       │           │
         │  7. CHECK TOKENS │       │           │
         │  Get suggestions │       │           │
         └────────┬─────────┘       │           │
                  │                 │           │
                  ▼                 │           │
         ┌──────────────────┐       │           │
         │  8. SUMMARY      │       │           │
         │  Before/After    │       │           │
         └────────┬─────────┘       │           │
                  │                 │           │
                  ▼                 │           │
         ┌──────────────────┐       │           │
         │  9. PROMPT USER  │       │           │
         │  Commit/Issue?   │       │           │
         └────────┬─────────┘       │           │
                  │                 │           │
                  ▼                 │           │
         ┌──────────────────┐       │           │
         │    COMPLETE      │       │           │
         │  Next skill      │       │           │
         └──────────────────┘       │           │
                                    ▼           │
                           ┌──────────────────┐ │
                           │   3. SCAFFOLD    │ │
                           │  (if no tests)   │ │
                           └────────┬─────────┘ │
                                    │           │
                                    ▼           │
                           ┌──────────────────┐ │
                           │   4. IMPROVE     │ │
                           │   FRONTMATTER    │ │
                           └────────┬─────────┘ │
                                    │           │
                                    ▼           │
                           ┌──────────────────┐ │
                           │   5. IMPROVE     │ │
                           │   TESTS          │ │
                           └────────┬─────────┘ │
                                    │           │
                                    ▼           │
                           ┌──────────────────┐ │
                           │   5b. VERIFY     │ │
                           │   Run tests      │ │
                           └────────┬─────────┘ │
                                    │           │
                                    ▼           │
                           ┌──────────────────┐ │
                           │ 5c. VALIDATE     │ │
                           │   REFERENCES     │ │
                           └────────┬─────────┘ │
                                    │           │
                                    ▼           │
                           ┌──────────────────┐ │
                           │  Iteration < 5?  │─┘
                           └────────┬─────────┘
                                    │ NO
                                    ▼
                           ┌──────────────────┐
                           │    TIMEOUT       │
                           │   → SUMMARY      │
                           └──────────────────┘
```

## Step Details

### Step 1: READ

**Action:** Load the skill's current state

**Files to read:**
```
plugin/skills/{skill-name}/SKILL.md    # Required
tests/{skill-name}/unit.test.ts        # If exists
tests/{skill-name}/triggers.test.ts    # If exists
tests/{skill-name}/integration.test.ts # If exists
```

**Extract:**
- Frontmatter (name, description, compatibility)
- Current trigger/anti-trigger phrases
- Existing test prompts

### Step 2: SCORE

**Action:** Evaluate frontmatter compliance per the [agentskills.io specification](https://agentskills.io/specification)

**Checks:**
1. **Name validation** (spec-required):
   - Lowercase alphanumeric + hyphens only
   - No consecutive hyphens (`--`)
   - Must not start or end with `-`
   - Must match parent directory name
   - Length 1-64 characters
2. Description length >= 150 chars
3. Description ≤ 1024 chars (spec hard limit)
4. Contains trigger phrases ("USE FOR:" etc.)
5. Contains anti-triggers ("DO NOT USE FOR:" etc.)
6. Has compatibility field (optional for Medium-High)
7. Optional fields preserved if present (`license`, `metadata`, `allowed-tools`)

**Output:** Invalid | Low | Medium | Medium-High | High

> ⚠️ **Warning:** If name validation fails, report as **Invalid** and fix before proceeding. A name like `azure--deploy` or `-azure-deploy` violates the spec.

### Step 3: SCAFFOLD (Conditional)

**Condition:** `tests/{skill-name}/` does not exist

**Action:** Create test directory from template

**Commands:**
```bash
cp -r tests/_template tests/{skill-name}
```

**Then update in each test file:**
```javascript
const SKILL_NAME = '{skill-name}';  // Replace placeholder
```

### Step 4: IMPROVE FRONTMATTER

**Action:** Enhance the SKILL.md frontmatter

**Goals:**
1. Add "USE FOR:" section with trigger phrases
2. Add "DO NOT USE FOR:" section with anti-triggers
3. Keep description under 1024 characters
4. Maintain clarity and usefulness

**Strategy:**
- Read skill content to understand purpose
- Identify related skills for anti-triggers
- Extract keywords that should trigger this skill
- Identify scenarios that should NOT trigger this skill

**Template:**
```yaml
---
name: {skill-name}
description: >-
  [What the skill does - 1-2 sentences]
  USE FOR: [phrase1], [phrase2], [phrase3], [phrase4], [phrase5]
  DO NOT USE FOR: [scenario1] (use other-skill), [scenario2] (use another-skill)
---
```

### Step 5: IMPROVE TESTS

**Action:** Update test prompts to match new frontmatter

**Files to update:**
- `tests/{skill-name}/triggers.test.ts`

**Updates needed:**

1. **shouldTriggerPrompts** (minimum 5):
   - Match the "USE FOR:" phrases
   - Include variations and natural language
   - Cover the skill's primary use cases

2. **shouldNotTriggerPrompts** (minimum 5):
   - Match the "DO NOT USE FOR:" scenarios
   - Include unrelated topics (weather, poetry)
   - Include other cloud providers (AWS, GCP)
   - Include related but different Azure services

### Step 5b: VERIFY

**Action:** Run tests to ensure changes work

**Command:**
```bash
# Standard (unit + trigger tests only - fast)
cd tests && npm test -- --testPathPattern={skill-name} --testPathIgnorePatterns=integration

# With integration tests (slower, requires Copilot SDK)
cd tests && npm test -- --testPathPattern={skill-name}
```

**Skip Integration Tests Flag:**

When invoking Sensei, you can skip integration tests for faster iteration:
```
Run sensei on azure-deploy --skip-integration
```

This runs only unit and trigger tests, which are fast and don't require the Copilot SDK. Integration tests can be run separately after the loop completes.

> ⚠️ **Note:** Skipping integration tests may affect confidence in skill quality. Consider running full tests before final commit.

**Expected outcome:**
- All tests pass
- Snapshots may need updating (auto-update is OK)

**If tests fail:**
- Analyze failure
- Adjust frontmatter or test prompts
- Re-run (counts as sub-iteration)

### Step 5c: VALIDATE REFERENCES

**Action:** Check that all markdown links in skill files are valid and don't escape the skill directory

**Command:**
```bash
cd scripts && npm run references {skill-name}
```

**What it checks:**
1. Every local markdown link points to an actual file or directory
2. Every local markdown link stays within the skill's own directory
3. External links (http://, https://, mailto:) are ignored
4. Fragment-only links (#anchor) are ignored

**Expected outcome:**
- ✅ All references are valid and contained within skill directory

**If validation fails:**
- Review broken or escaped references
- Fix invalid links or move referenced files into skill directory
- Re-run validation (counts as sub-iteration)

**Example issues caught:**
- Broken link: `[CLI Commands](references/CLI-COMMANDS.md)` when file doesn't exist
- Escaped reference: `[Other skill](../../other-skill/SKILL.md)` crosses skill boundary

### Step 6: CHECK TOKENS

**Action:** Analyze token usage, line count, and gather optimization suggestions

**Commands:**
```bash
cd scripts && npm run tokens -- check plugin/skills/{skill-name}/SKILL.md
cd scripts && npm run tokens -- suggest plugin/skills/{skill-name}/SKILL.md
```

**Line count check (per spec):**
```bash
wc -l plugin/skills/{skill-name}/SKILL.md
```
Report a warning if SKILL.md exceeds 500 lines (spec recommendation).

**Token Budgets** (from [skill-authoring](/.github/skills/skill-authoring)):
- SKILL.md: < 500 tokens (soft limit), < 5000 (hard limit)
- references/*.md: < 1000 tokens each

**Capture:**
- Current token count
- Token delta from start
- Optimization suggestions (for summary)

**Note:** Token optimizations are captured but NOT automatically applied. The user decides whether to implement them or create an issue for follow-up.

See [TOKEN-INTEGRATION.md](TOKEN-INTEGRATION.md) for details on token optimization patterns.

### Step 7: SUMMARY

**Action:** Generate before/after comparison for user review

**Display format:**
```
╔══════════════════════════════════════════════════════════════════╗
║  SENSEI SUMMARY: {skill-name}                                    ║
╠══════════════════════════════════════════════════════════════════╣
║  BEFORE                          AFTER                           ║
║  ──────                          ─────                           ║
║  Score: Low                      Score: Medium-High              ║
║  Tokens: 623                     Tokens: 589                     ║
║  Triggers: 0                     Triggers: 5                     ║
║  Anti-triggers: 0                Anti-triggers: 3                ║
║                                                                  ║
║  SPEC RECOMMENDATIONS:                                           ║
║  • Add license field (e.g., license: MIT)                        ║
║  • Add metadata.version (e.g., metadata: { version: "1.0" })    ║
║                                                                  ║
║  SUGGESTIONS NOT IMPLEMENTED:                                    ║
║  • Remove emoji decorations (-12 tokens)                         ║
║  • Consolidate duplicate headings (-8 tokens)                    ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
```

**Captured metrics:**
- Score change (Low → Medium-High)
- Token delta (+/- tokens)
- Trigger count change
- Anti-trigger count change
- Spec recommendations (missing `license`, `metadata.version`)
- Unimplemented token suggestions

### Step 8: PROMPT USER

**Action:** Ask user how to proceed with changes

**Options:**
```
Choose an action:
  [C] Commit changes - Save improvements with "sensei: improve {skill-name}"
  [I] Create issue   - Open GitHub issue with summary and suggestions
  [S] Skip           - Discard changes and move to next skill
```

**Commit flow:**
```bash
git add plugin/skills/{skill-name}/SKILL.md
git add tests/{skill-name}/
git commit -m "sensei: improve {skill-name} frontmatter

- Score: {before} → {after}
- Tokens: {before} → {after}
- Added USE FOR triggers
- Added DO NOT USE FOR anti-triggers"
```

**Issue flow:**
Creates a GitHub issue with:
- Title: `[sensei] Token optimization suggestions for {skill-name}`
- Body: Summary table + unimplemented suggestions
- Labels: `enhancement`, `skill-quality`

### Step 9: REPEAT or EXIT

**Check:** Has the target been reached?

**Exit conditions (move to next skill):**
- Score >= Medium-High AND tests pass
- Iteration count >= 5 (timeout)
- Unrecoverable error

**Continue condition:**
- Score < Medium-High OR tests failing
- Iteration count < 5

---

## Batch Processing

When multiple skills are queued:

```
Skills: [skill-a, skill-b, skill-c]

┌─────────────────────────────────────────┐
│  Process skill-a                        │
│  └─ Loop until complete or timeout      │
│  └─ Commit                              │
├─────────────────────────────────────────┤
│  Process skill-b                        │
│  └─ Loop until complete or timeout      │
│  └─ Commit                              │
├─────────────────────────────────────────┤
│  Process skill-c                        │
│  └─ Loop until complete or timeout      │
│  └─ Commit                              │
├─────────────────────────────────────────┤
│  SUMMARY REPORT                         │
│  ├─ skill-a: Low → Medium-High ✓        │
│  ├─ skill-b: Medium → Medium-High ✓     │
│  └─ skill-c: Low → Medium (timeout)     │
└─────────────────────────────────────────┘
```

---

## Error Handling

### Test Failures

1. Log the specific failure
2. Attempt to fix (adjust prompts or frontmatter)
3. Re-run tests
4. If still failing after 2 attempts, commit partial progress and note in message

### Git Conflicts

1. Stash changes: `git stash`
2. Pull latest: `git pull --rebase`
3. Apply changes: `git stash pop`
4. Resolve conflicts manually if needed

### Skill Not Found

1. Verify skill exists: `ls plugin/skills/{skill-name}`
2. Check spelling (case-sensitive)
3. Report error and skip to next skill

---

## Progress Tracking

Sensei tracks progress via git commits. To review:

```bash
# See all sensei improvements
git log --oneline --grep="sensei:"

# See specific skill history
git log --oneline -- plugin/skills/{skill-name}/SKILL.md

# See diff for a commit
git show {commit-hash}
```
