# Broken Link Verification

Check all markdown links in SKILL.md and referenced files.

## Procedure

1. Parse all `[text](path)` links in SKILL.md
2. For each link to a local file, verify the file exists
3. Recursively check links in referenced files
4. Flag any links where the target file is missing

## Link Requirements

### Always Link to Files, Not Folders

Links must point to actual files, not directories. Folder references don't trigger reference loading.

| ❌ Invalid                        | ✅ Valid                                    |
| --------------------------------- | ------------------------------------------- |
| `[Recipes](references/recipes/)`  | `[Recipes](references/recipes/README.md)`   |
| `[AZD](references/recipes/azd)`   | `[AZD](references/recipes/azd/README.md)`   |
| `[Services](references/services)` | `[Services](references/services/README.md)` |

**Why this matters:**

- Agent skills only load content from file links
- Folder links are treated as broken links (no content loaded)
- Always use `README.md` (or another `.md` file) as the folder entry point

### Use Descriptive Link Text, Not Paths

Link text should describe the content, not repeat the URL or path. This saves tokens and improves readability.

| ❌ Wasteful                                            | ✅ Concise                                   |
| ------------------------------------------------------ | -------------------------------------------- |
| `[references/guide.md](references/guide.md)`           | `[Guide](references/guide.md)`               |
| `[https://example.com/docs](https://example.com/docs)` | `[Docs](https://example.com/docs)`           |
| `See [references/errors.md](references/errors.md)`     | `See [Error Handling](references/errors.md)` |

**Avoid standalone reference columns in tables.** Instead of:

```markdown
| Error       | Fix      | Reference                                |
| ----------- | -------- | ---------------------------------------- |
| Auth failed | Re-login | [references/auth.md](references/auth.md) |
```

Use inline links:

```markdown
| Error                             | Fix      |
| --------------------------------- | -------- |
| [Auth failed](references/auth.md) | Re-login |
```

### Validation Check

Run the automated reference validator to catch broken and escaped links:

```bash
# From the scripts directory
cd scripts
npm run references              # Validate all skills
npm run references <skill-name> # Validate a single skill
```

This checks:

1. Every local markdown link resolves to an existing file
2. No link escapes the skill's own directory (cross-skill links)
3. Ignores external URLs, `mailto:`, and fragment-only links

When validating manually, also check for: 4. Links pointing to directories instead of files 5. Links where text duplicates the URL/path

## When broken link found, ask user:

- a) **Fix reference** - Update the link path to correct location (add `/README.md` for folder links)
- b) **Delete link** - Remove the link from the document
- c) **Something else** - User provides alternative action
