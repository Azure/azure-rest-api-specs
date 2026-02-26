# Optimization Patterns

Techniques for reducing token count while maintaining clarity.

## Content Restructuring

### Move Details to References

**Before (in SKILL.md):**
```markdown
## API Reference

| Endpoint | Method | Parameters | Response |
|----------|--------|------------|----------|
| /users | GET | limit, offset | User[] |
| /users/:id | GET | id | User |
| /users | POST | name, email | User |
... (50 more rows)
```

**After:**
```markdown
## API Reference

See [references/API.md](references/API.md) for the complete endpoint list.
```

**Savings:** 200+ tokens for large tables

### Use Reference Links for Repeated Content

**Before:**
```markdown
Run `az login --tenant YOUR_TENANT_ID` to authenticate.
...
Make sure you've run `az login --tenant YOUR_TENANT_ID` first.
...
If not authenticated, use `az login --tenant YOUR_TENANT_ID`.
```

**After:**
```markdown
Run `az login --tenant YOUR_TENANT_ID` to authenticate.
...
Make sure you've authenticated (see above).
...
If not authenticated, see the authentication step above.
```

**Savings:** ~20 tokens per removed duplicate

## Text Optimization

### Replace Verbose Phrases

| Verbose | Concise | Savings |
|---------|---------|---------|
| "In order to" | "To" | 2 tokens |
| "It is important to note that" | "Note:" | 5 tokens |
| "At this point in time" | "Now" | 4 tokens |
| "Due to the fact that" | "Because" | 4 tokens |
| "In the event that" | "If" | 3 tokens |
| "For the purpose of" | "To" / "For" | 3 tokens |
| "A large number of" | "Many" | 3 tokens |
| "In close proximity to" | "Near" | 3 tokens |

### Consolidate Similar Sections

**Before:** Three identical prerequisite sections (Windows/macOS/Linux)

**After:**
```markdown
## Prerequisites (All Platforms)
- Node.js 18+
- Azure CLI

Platform-specific: [references/INSTALL.md](references/INSTALL.md)
```

**Savings:** 50+ tokens

## Formatting Optimization

### Tables vs Lists

**Before (verbose list):**
```markdown
- **Storage Account**: Minimum 3 characters, maximum 24 characters, 
  only lowercase letters and numbers allowed, must be globally unique.
- **Key Vault**: Minimum 3 characters, maximum 24 characters,
  alphanumerics and hyphens allowed, must be globally unique.
```

**After (compact table):**
```markdown
| Resource | Min | Max | Allowed | Global |
|----------|-----|-----|---------|--------|
| Storage | 3 | 24 | a-z, 0-9 | Yes |
| Key Vault | 3 | 24 | a-z, 0-9, - | Yes |
```

**Savings:** ~30 tokens per 5 items

### Inline Code vs Code Blocks

**Before:**
```markdown
To list resources, run:

\`\`\`bash
az resource list --resource-group mygroup
\`\`\`
```

**After:**
```markdown
List resources: `az resource list -g mygroup`
```

**Savings:** ~10 tokens per instance

## Structural Patterns

### Progressive Disclosure Structure

```
SKILL.md (< 500 tokens)
├── Overview (what + when)
├── Quick workflow (numbered steps)
├── Key commands/tools table
└── Links to references

references/
├── DETAILED-GUIDE.md (< 1000 tokens each)
├── TROUBLESHOOTING.md
└── EXAMPLES.md
```

### Header Consolidation

**Before:**
```markdown
## Overview
## Introduction  
## About This Skill
## What This Does
```

**After:**
```markdown
## Overview
```

**Savings:** ~15 tokens per removed header + content
