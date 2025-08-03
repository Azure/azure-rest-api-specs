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
npm ci

# Build the project
npm run build
```

## Usage

### Command Line Interface

```bash
# Basic usage
npx openapi-diff-runner --srp <spec-repo-path> --repo <github-repo> --number <pr-number>

# Example
npx openapi-diff-runner \
  --srp /path/to/azure-rest-api-specs \
  --repo Azure/azure-rest-api-specs \
  --number 12345 \
  --bb main \
  --rt SameVersion
```

### Command Line Options

| Option     | Description                         | Default                      |
| ---------- | ----------------------------------- | ---------------------------- |
| `--srp`    | Spec repository path                | `../`                        |
| `--repo`   | GitHub repository                   | `azure/azure-rest-api-specs` |
| `--number` | Pull request number                 | Required                     |
| `--bb`     | Base branch                         | `main`                       |
| `--rt`     | Run type (SameVersion/CrossVersion) | `SameVersion`                |
| `--hc`     | Head commit                         | `HEAD`                       |
| `--sb`     | Source branch                       | From PR                      |
| `--tb`     | Target branch                       | From PR                      |

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
