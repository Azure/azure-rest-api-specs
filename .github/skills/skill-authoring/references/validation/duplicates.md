# Duplicate Content Consolidation

Find repeated content that can be extracted into a shared reference.

## Indicators of duplication

- Same code blocks appearing in multiple files
- Identical troubleshooting steps across references
- Repeated tables or command lists

## Consolidation Procedure

1. Identify duplicate content (3+ lines repeated in 2+ files)
2. Extract to a new reference file (e.g., `references/common-commands.md`)
3. Replace duplicates with links to the consolidated reference
4. Ensure consolidated file is self-contained

## Example consolidation

```markdown
# Before (in multiple files)

## Authentication

Run `az login` to authenticate...
[same 10 lines repeated]

# After

## Authentication

See [Authentication Setup](common/authentication.md) for details.
```
