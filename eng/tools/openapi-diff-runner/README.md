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

```bash
# Install dependencies
pnpm install

# Build the project
pnpm build
```

## Usage

### Command Line Interface

```bash
# Basic usage
pnpm exec openapi-diff-runner --spec-repo-path <spec-repo-path> --target-repo <github-repo> --pr-number <pr-number>

# Example
pnpm exec openapi-diff-runner \
  --spec-repo-path /path/to/azure-rest-api-specs \
  --target-repo Azure/azure-rest-api-specs \
  --pr-number 12345 \
  --base-branch main \
  --run-type SameVersion
```

### Command Line Options

| Option               | Alias | Description                         | Default                      |
| -------------------- | ----- | ----------------------------------- | ---------------------------- |
| `--spec-repo-path`   | `-p`  | Spec repository path                | Runner directory             |
| `--target-repo`      | `-r`  | Target GitHub repository            | `azure/azure-rest-api-specs` |
| `--source-repo`      | `-s`  | Source GitHub repository            | `azure/azure-rest-api-specs` |
| `--pr-number`        | `-n`  | Pull request number                 | Required                     |
| `--base-branch`      | `-b`  | Base branch                         | `main`                       |
| `--run-type`         | `-t`  | Run type (SameVersion/CrossVersion) | `SameVersion`                |
| `--head-commit`      | `-c`  | Head commit                         | `HEAD`                       |
| `--pr-source-branch` |       | Source branch                       | Empty                        |
| `--pr-target-branch` |       | Target branch                       | Empty                        |
| `--help`             | `-h`  | Show help and exit                  |                              |

Help is generated from the same shared CLI option definitions used for parsing.
Unknown options and positional arguments are rejected.

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
- pnpm
- .NET 6
- Git

### Building

```bash
# Build TypeScript files
pnpm build

# Run tests
pnpm test

# Run tests with coverage
pnpm test:ci

# Format code
pnpm format
```
