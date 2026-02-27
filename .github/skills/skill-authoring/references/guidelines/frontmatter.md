# Frontmatter Requirements

## Required Fields

```yaml
---
name: my-skill-name
description: A clear description of what this skill does and when to use it.
---
```

**`name` rules:**

- 1-64 characters
- Lowercase letters, numbers, and hyphens only (`a-z`, `0-9`, `-`)
- Must not start or end with `-`
- Must not contain consecutive hyphens (`--`)
- Must match the parent directory name

**`description` rules:**

- 1-1024 characters
- Should describe BOTH what the skill does AND when to use it
- Include keywords that help agents identify relevant tasks

## Optional Fields

```yaml
---
name: my-skill-name
description: Description here.
license: Apache-2.0
compatibility: Requires az CLI and docker
metadata:
  author: your-org
  version: "1.0"
---
```

## Activation Triggers

```yaml
# Good - specific keywords and scenarios
description: Performs Azure compliance assessments using azqr. Use when users
  ask to check compliance, assess Azure resources, run azqr, or review security posture.
```

```yaml
# Bad - too vague
description: Helps with Azure stuff.
```
