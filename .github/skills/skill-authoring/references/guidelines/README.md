# Skill Writing Guidelines

Best practices for writing Agent Skills per the [Agent Skills Specification](https://agentskills.io/specification).

## Quick Reference

| Constraint | Limit | Notes |
|------------|-------|-------|
| `name` field | 1-64 chars | Lowercase, hyphens only, no consecutive hyphens |
| `description` field | 1-1024 chars | Describe what AND when to use |
| SKILL.md body | < 5000 tokens | ~500 lines max |
| Reference files | < 1000 tokens | Load on demand |

## Sections

- [Frontmatter](frontmatter.md) - Required and optional YAML fields
- [Structure](structure.md) - Directory layout and patterns
- [Writing Tips](writing-tips.md) - Effective skill authoring
- [Token Budgets](../token-budgets.md) - Limits and splitting guidance

## Resources

- [Agent Skills Specification](https://agentskills.io/specification)
- [What Are Skills](https://agentskills.io/what-are-skills)
- [Reference Loading Clarification (Issue #97)](https://github.com/agentskills/agentskills/issues/97)
- [Skill Token Limits (Issue #1130)](https://github.com/github/copilot-cli/issues/1130)
