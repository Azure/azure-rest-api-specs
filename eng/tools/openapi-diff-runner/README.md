# OpenAPI Diff Runner

A tool for detecting breaking changes in OpenAPI specifications by comparing different versions and analyzing the
differences using @azure/oad library.

## Overview

The OpenAPI Diff Runner is designed to:

- Compare OpenAPI specifications between different versions
- Generate detailed reports of comparing result
- Support both same-version and cross-version breaking change detection
- Integrate with GitHub workflow for automated validation

## Installation

Run the following commands from the **root** of the `azure-rest-api-specs` repository:

```bash
# Install dependencies (this also builds all eng tools via postinstall)
npm ci
```

The `postinstall` script automatically runs `npm run build` for all engineering tools, including
`openapi-diff-runner`. If you need to rebuild manually after making changes:

```bash
# Rebuild from the tool directory
cd eng/tools/openapi-diff-runner
npm run build
```

## Usage

### Command Line Interface

```bash
# Basic usage
npx openapi-diff-runner --pr-number <pr-number> --spec-repo-path <path>

# Example for a PR from the same repo
npx openapi-diff-runner \
  --pr-number 12345 \
  --spec-repo-path /path/to/azure-rest-api-specs \
  --run-type SameVersion

# Example for a PR from a forked repo
npx openapi-diff-runner \
  --pr-number 12345 \
  --spec-repo-path . \
  --source-repo someuser/azure-rest-api-specs \
  --target-repo Azure/azure-rest-api-specs \
  --pr-source-branch feature-branch \
  --pr-target-branch main
```

### Prerequisites for Local Testing

The tool expects the PR's source branch content to be available locally. There are several ways
to set this up:

#### Option 1: Use a Separate Clone of the Fork

If you have the forked repository cloned locally, point `--spec-repo-path` directly to it:

```bash
# Clone the fork to a separate directory
git clone https://github.com/<fork-owner>/azure-rest-api-specs.git /path/to/fork-clone
cd /path/to/fork-clone
git checkout <source-branch>

# Run the tool pointing to the fork's local clone
npx openapi-diff-runner \
  --pr-number 12345 \
  --spec-repo-path /path/to/fork-clone \
  --source-repo <fork-owner>/azure-rest-api-specs \
  --target-repo Azure/azure-rest-api-specs \
  --pr-source-branch <source-branch> \
  --pr-target-branch main
```

#### Option 2: Fetch the PR into Your Main Repo Clone

Fetch the PR's source branch into your existing `azure-rest-api-specs` clone:

```bash
# Fetch using the PR ref
git fetch origin pull/<pr-number>/head:pr-<pr-number>
git checkout pr-<pr-number>

# Or fetch from the fork directly
git fetch https://github.com/<fork-owner>/azure-rest-api-specs.git <branch>:<branch>
git checkout <branch>

# Run the tool
npx openapi-diff-runner \
  --pr-number 12345 \
  --spec-repo-path . \
  --source-repo <fork-owner>/azure-rest-api-specs \
  --target-repo Azure/azure-rest-api-specs \
  --pr-source-branch <source-branch> \
  --pr-target-branch main
```

> **Note:** In CI environments (GitHub Actions), the PR merge commit is automatically checked out,
> so the source changes are already present locally.

### Command Line Options

| Option               | Short | Description                                              | Default                      |
| -------------------- | ----- | -------------------------------------------------------- | ---------------------------- |
| `--spec-repo-path`   | `-p`  | Local path to the spec repository (must be pre-cloned)   | `..` (parent of tool dir)    |
| `--target-repo`      | `-r`  | Target GitHub repository (owner/repo) for link generation| `azure/azure-rest-api-specs` |
| `--source-repo`      | `-s`  | Source GitHub repository (owner/repo) for link generation| `azure/azure-rest-api-specs` |
| `--pr-number`        | `-n`  | Pull request number                                      | **Required**                 |
| `--run-type`         | `-t`  | Run type (`SameVersion` or `CrossVersion`)               | `SameVersion`                |
| `--base-branch`      | `-b`  | Base branch for comparison                               | `main`                       |
| `--head-commit`      | `-c`  | Head commit SHA                                          | `HEAD`                       |
| `--pr-source-branch` |       | PR source branch name                                    | `""`                         |
| `--pr-target-branch` |       | PR target branch name                                    | `""`                         |
| `--help`             | `-h`  | Show help message                                        |                              |

### Important Notes

- **`--spec-repo-path`**: This is a **local path** to an already-cloned repository. The tool does
  not clone repositories from GitHub.
- **`--source-repo` / `--target-repo`**: These are GitHub repository identifiers (e.g.,
  `Azure/azure-rest-api-specs`) used only for **generating hyperlinks** in reports. They do not
  trigger any fetching from GitHub.
- For PRs from **forked repositories**, set `--source-repo` to the fork (e.g.,
  `someuser/azure-rest-api-specs`) so report links point to the correct location.

## Breaking Change Types

### Same Version Breaking Changes

- Changes within the same API version that break backward compatibility
- Examples: Removing properties, changing required fields, modifying response schemas

### Cross Version Breaking Changes

- Changes between different API versions
- Helps ensure proper versioning and migration paths

### Workflow

1. **Initialize Context**: Parse command line arguments and setup environment
2. **Setup PR Info**: Fetch pull request details and prepare Git workspace
3. **Detect Changes**: Use OAD (OpenAPI Analysis) to compare specifications
4. **Apply Rules**: Process detected changes through rule engine
5. **Generate Report**: Create detailed output with violations and recommendations

## Development

### Prerequisites

- Node.js >= 20.0.0
- npm
- .NET 6
- Git

### Building

```bash
# Build TypeScript files
npm run build

# Run tests
npm test

# Run tests with coverage
npm run test:ci

# Lint code
npm run prettier
```
