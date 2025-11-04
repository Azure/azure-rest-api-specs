# `summarize-pr`

This tool generates a human-readable summary of changes in a Pull Request.

## Usage

```bash
npm exec --no -- summarize-pr --number <PR_NUMBER> --owner <OWNER> --repo <REPO>
```

## Options

- `--number, -n`: PR number (required)
- `--owner, -o`: Repository owner (default: "Azure")
- `--repo, -r`: Repository name (default: "azure-rest-api-specs")
- `--output, -f`: Output file path (optional, defaults to stdout)

## Example

```bash
# Summarize PR #12345
npm exec --no -- summarize-pr --number 12345

# Summarize and save to file
npm exec --no -- summarize-pr --number 12345 --output summary.md
```

## Output

The tool generates a markdown summary including:

- PR title and description
- Author information
- File change statistics (additions, deletions, modifications)
- Categorized file changes (specs, docs, tests, configs, etc.)
- List of changed files grouped by category
