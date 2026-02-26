# Reference Loading Behavior

This document explains how Agent Skills load reference files and best practices for structuring them efficiently.

## How References Load

### Just-In-Time (JIT) Loading

Reference files (`references/`, `scripts/`, `assets/`) are **NOT** loaded when a skill activates. They load **only when explicitly referenced** via a markdown link or file path in the skill instructions.

```markdown
<!-- This triggers a load -->
See [the guide](references/guide.md) for details.

<!-- This does NOT trigger a load -->
Documentation is available in the references folder.

<!-- This does NOT work - folder links don't load content -->
See [recipes](references/recipes/) for options.
```

### Link to Files, Not Folders

**Critical:** Always link to actual files, never directories. Folder references don't trigger content loading.

| ❌ Won't Load | ✅ Will Load |
|---------------|--------------|
| `[Recipes](references/recipes/)` | `[Recipes](references/recipes/README.md)` |
| `[AZD](references/recipes/azd)` | `[AZD](references/recipes/azd/README.md)` |
| `[Services](references/services)` | `[Services](references/services/README.md)` |

Use `README.md` as the entry point for folder-organized content.

### No Caching Between Requests

Per [agentskills Issue #97](https://github.com/agentskills/agentskills/issues/97):

> Reference files should be **fully loaded each time they are referenced**, regardless of whether they were previously read.

Implications:
- Don't assume the agent remembers previous file contents
- Write each reference as a **self-contained unit**
- Include necessary context within each file

### Whole File Loading

When a reference is loaded, the **entire file** loads - not just a section:

| Link | What Loads |
|------|------------|
| `[guide](references/guide.md)` | Entire guide.md |
| `[guide](references/guide.md#section-2)` | Entire guide.md (anchor is hint only) |

This means:
- Split large topics into separate files
- Keep each file < 1,000 tokens
- Don't create monolithic reference documents

## Token Efficiency Patterns

### Selective Loading with Recipes

```markdown
<!-- In SKILL.md - user picks ONE option -->
## Deployment Method

Choose your approach:
- [AZD](references/recipes/azd/README.md) - Quick start
- [Bicep](references/recipes/bicep/README.md) - IaC-first
- [Terraform](references/recipes/terraform/README.md) - Multi-cloud

<!-- Result: Only chosen recipe loads (~300 tokens) -->
<!-- Not all recipes (~900 tokens) -->
```

## Self-Contained Reference Example

```markdown
# AZD Deployment Errors

Quick reference for Azure Developer CLI deployment issues.

## Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `CONTAINER_REGISTRY_UNAUTHORIZED` | ACR login expired | `az acr login --name <registry>` |
| `QUOTA_EXCEEDED` | Resource limits | Request increase or change region |

## Troubleshooting Steps

1. Check deployment logs: `azd deploy --debug`
2. Verify authentication: `az account show`
3. Check resource status: `azd show`

## Related

- [AZD Commands](README.md)
- [Verification](verify.md)
```

Note: This file works standalone without requiring other files to be loaded first.

## Skill Visibility Limits

From [GitHub Copilot CLI Issue #1130](https://github.com/github/copilot-cli/issues/1130):

- With many skills installed, not all appear in available skills list
- Only ~31 of 49 skills visible in one example due to token limits
- Hidden skills can still be invoked but aren't discoverable

**Best practices:**
- Keep `description` concise but keyword-rich
- Front-load trigger phrases for discoverability
- Don't rely on users seeing all skills

## Summary

| Behavior | Implication |
|----------|-------------|
| JIT loading | Only explicitly linked files load |
| No caching | Write self-contained references |
| Whole file loads | Split large content into small files |
| Token limits | Structure for selective loading |
