# `summarize-pr`

This tool generates a human-readable summary of changes in a Pull Request by fetching PR details from the GitHub API and categorizing the changed files.

## Usage

From the repository root:

```bash
npm exec --no -- summarize-pr --number <PR_NUMBER>
```

Or from within the tool directory:

```bash
npm exec --no -- summarize-pr --number <PR_NUMBER> --owner <OWNER> --repo <REPO>
```

## Options

- `--number, -n`: PR number (required)
- `--owner, -o`: Repository owner (default: "Azure")
- `--repo, -r`: Repository name (default: "azure-rest-api-specs")
- `--output, -f`: Output file path (optional, defaults to stdout)
- `--help, -h`: Show help message

## Environment Variables

- `GITHUB_TOKEN`: GitHub personal access token (optional, for higher rate limits and private repositories)

## Examples

```bash
# Summarize PR #38517 from the default repo
npm exec --no -- summarize-pr --number 38517

# Summarize and save to file
npm exec --no -- summarize-pr --number 38517 --output summary.md

# Summarize a PR from a different repository
npm exec --no -- summarize-pr --number 100 --owner microsoft --repo typespec

# Use with GitHub token for authenticated requests
GITHUB_TOKEN=ghp_xxx npm exec --no -- summarize-pr --number 38517
```

## Output

The tool generates a markdown summary including:

- **PR Metadata**: title, author, state, creation/update dates, commit count
- **Change Statistics**: total files changed, lines added/deleted
- **Description**: the PR body/description
- **Changes by Category**: files grouped by type with detailed statistics
  - OpenAPI Specs
  - TypeSpec
  - Examples
  - Documentation
  - Configuration
  - CI/CD
  - Tests
  - Scripts
  - Other

Each file includes:
- Status indicator (🆕 added, ✏️ modified, 🗑️ removed, 📝 renamed)
- File path
- Line additions and deletions

## Sample Output

See [examples/example-output.md](examples/example-output.md) for a complete example of the tool's output.

## Development

```bash
# Install dependencies (from repo root)
npm ci

# Build the tool
npm run build

# Run tests
npm test

# Format code
npm run format
```
