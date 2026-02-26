# Skill Validation Procedures

Run these validations when reviewing or authoring skills.

## Automated Validation

```bash
cd scripts
npm run references              # Check broken links and cross-skill escapes
npm run tokens -- check         # Check token limits
```

## Validations

| # | Check | Description |
|---|-------|-------------|
| 1 | [Broken Links](broken-links.md) | Verify all markdown links point to existing files (not folders) |
| 2 | [Orphaned References](orphaned-refs.md) | Find unreferenced files in `references/` |
| 3 | [Token Splitting](token-splitting.md) | Split references exceeding 1000 tokens |
| 4 | [Duplicate Content](duplicates.md) | Consolidate repeated content |
| 5 | [Out-of-Place Guidance](out-of-place.md) | Find misplaced service-specific content |

## Quick Checklist

| Check | Action if Failed |
|-------|------------------|
| Broken links | Fix path, add `/README.md` for folder links, or delete |
| Folder links | Change to file links (e.g., `recipes/` → `recipes/README.md`) |
| Orphaned references | Delete, add link, or user decision |
| References >1000 tokens | Split into folder with README.md |
| Duplicate content | Consolidate into shared reference |
| Out-of-place guidance | Extract, create skill, add section, or user decision |
