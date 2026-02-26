# Orphaned Reference Detection

Identify files in `references/` that are never linked from SKILL.md or other references.

## Procedure

1. List all files in `references/` directory (recursively)
2. Collect all link targets from SKILL.md and linked references
3. Compare: any file not in the link targets is orphaned

## When orphaned reference found, ask user:

- a) **Delete reference** - Remove the orphaned file
- b) **Add link to reference** - Add appropriate link in SKILL.md or another reference
- c) **Something else** - User provides alternative action
