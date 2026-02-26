---
name: skill-authoring
description: "Guidelines for writing Agent Skills. TRIGGERS: create a skill, new skill, write a skill, skill template, skill structure, review skill, skill PR, skill compliance, agentskills spec, SKILL.md format, skill frontmatter, skill best practices"
---

# Skill Authoring Guide

This skill provides guidance for writing Agent Skills that comply with the [agentskills.io specification](https://agentskills.io/specification).

## When to Use

- Creating a new skill for this repository
- Reviewing a skill PR for compliance
- Checking if an existing skill follows best practices
- Understanding token budgets and progressive disclosure

## Constraints

- `name`: 1-64 chars, lowercase + hyphens, match directory
- `description`: 1-1024 chars, explain WHAT and WHEN
- SKILL.md: <500 tokens (soft), <5000 (hard)
- references/*.md: <1000 tokens each

## Structure

- `SKILL.md` (required) - Instructions
- `references/` (optional) - Detailed docs
- `scripts/` (optional) - Executable code

Frontmatter: `name` (lowercase-hyphens), `description` (WHAT + WHEN)

## Progressive Disclosure

Metadata (~100 tokens) loads at startup. SKILL.md (<5000 tokens) loads on activation. References load **only when explicitly linked** (not on activation). Keep SKILL.md lean.

## Reference Loading

References are JIT (just-in-time) loaded:
- Only files explicitly linked via `[text](references/file.md)` load
- **Link to files, not folders** - `[Recipes](references/recipes/README.md)` not `[Recipes](references/recipes/)`
- Each file loads in full (not sections)
- No caching between requests - write self-contained files
- Use recipes/services patterns for multi-option skills

See [REFERENCE-LOADING.md](references/REFERENCE-LOADING.md) for details.

## Validation

```bash
# Run from the scripts directory
cd scripts
npm run references              # Validate all skill links
npm run tokens -- check         # Check token limits
```

### Integrity Checks

When reviewing or authoring skills, verify:
1. **No broken links** - All referenced files exist
2. **No orphaned references** - All reference files are linked
3. **Token budgets** - References under 1000 tokens (split if exceeded)
4. **No duplicates** - Consolidate repeated content
5. **No out-of-place guidance** - Service-specific content belongs in service-specific references

See [Validation](references/validation/README.md) for detailed procedures.

## Reference Documentation

- [Guidelines](references/guidelines/README.md) - Detailed writing guidelines
- [Token Budgets](references/token-budgets.md) - Limits and splitting guidance
- [Reference Loading](references/REFERENCE-LOADING.md) - How references load
- [Checklist](references/CHECKLIST.md) - Pre-submission checklist
- [Validation](references/validation/README.md) - Link and reference validation
- [agentskills.io/specification](https://agentskills.io/specification) - Official spec
