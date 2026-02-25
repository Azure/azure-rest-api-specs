---
applyTo:
  - ".github/*.config.js"
  - ".github/.prettier*"
  - ".github/cspell.yaml"
  - ".github/package*.json"
  - ".github/tsconfig.json"
  - ".github/actions/**/*"
  - ".github/matchers/**/*"
  - ".github/workflows/**/*"
  - ".github/shared/**/*"
---

# GitHub Copilot Instructions for GitHub Actions Code

This file provides instructions for GitHub Copilot when working with GitHub Actions code in this repository. The GitHub Actions infrastructure is completely separate from the TypeSpec and OpenAPI specification work that makes up the majority of this repository.

## Overview

The `.github` directory contains all the code and configuration for GitHub Actions that run as PR checks. This includes:

- **Actions**: Reusable composite actions in `.github/actions/`
- **Workflows**: Workflow files in `.github/workflows/`
- **Shared utilities**: Common JavaScript modules in `.github/shared/src/`
- **Tests**: Test files in `.github/workflows/test/` and `.github/shared/test/`
- **Configuration**: ESLint, Prettier, TypeScript, and Vitest configs

## Technology Stack

- **Language**: JavaScript (ES2020+, with JSDoc type annotations)
- **Runtime**: Node.js 24.x (on GitHub Actions runners)
- **Type Checking**: TypeScript via JSDoc comments (no `.ts` files, only `.js`)
- **Testing**: Vitest for unit and integration tests
- **Linting**: ESLint with TypeScript-aware rules
- **Formatting**: Prettier with organize-imports plugin
- **Package Manager**: npm (npm ci for clean installs)

## Project Structure

```
.github/
├── actions/                    # Reusable composite actions
│   ├── setup-node-install-deps/
│   ├── install-deps-github-script/
│   └── ...
├── workflows/                  # Workflow YAML files and their scripts
│   ├── src/                   # JavaScript modules for workflows
│   ├── test/                  # Tests for workflow scripts
│   ├── *.yaml                 # Workflow definitions
│   └── cmd/                   # CLI scripts
├── shared/                    # Shared utilities used across workflows
│   ├── src/                   # Core utility modules
│   ├── test/                  # Tests for shared utilities
│   ├── eslint.base.config.js  # Base ESLint config
│   └── package.json
├── matchers/                  # Problem matchers for CI output
├── package.json               # Root dependencies (superset of shared/)
├── eslint.config.js           # ESLint configuration
├── tsconfig.json              # TypeScript config (type-checking only)
├── vitest.config.js           # Vitest test configuration
└── .prettierrc.yaml           # Prettier formatting rules
```

## Coding Standards

### JavaScript Style

- **File extension**: Always `.js`, never `.ts` (TypeScript is used only for type-checking)
- **Module system**: ES modules (`import`/`export`), not CommonJS
- **Type annotations**: Use JSDoc comments extensively for all functions, parameters, and return types
- **Indentation**: 2 spaces (enforced by Prettier)
- **Quote style**: Double quotes for strings (enforced by Prettier)
- **Line length**: Max 100 characters (enforced by Prettier)
- **Naming conventions**:
  - Functions and variables: `camelCase`
  - Constants: `UPPER_SNAKE_CASE` for true constants
  - Files: `kebab-case.js` or `camelCase.js`
- **Exports**: Use named exports, avoid default exports

### JSDoc Type Annotations

All functions must have complete JSDoc type annotations:

```javascript
/**
 * Get a list of changed files in a git repository
 *
 * @param {Object} [options]
 * @param {string} [options.baseCommitish] Default: "HEAD^".
 * @param {string} [options.cwd] Current working directory. Default: process.cwd().
 * @param {import('./logger.js').ILogger} [options.logger]
 * @returns {Promise<string[]>} List of changed files
 */
export async function getChangedFiles(options = {}) {
  // Implementation
}
```

### TypeScript Integration

- TypeScript is configured in `tsconfig.json` with `allowJs: true` and `checkJs: true`
- Run `npm run lint:tsc` to type-check JavaScript files via JSDoc
- Never create `.ts` files; use JSDoc in `.js` files instead
- Import types with `@typedef` and `@type` JSDoc tags

### YAML Style for Actions/Workflows

- **Indentation**: 2 spaces
- **String values**: Use double quotes (e.g., `cache: "npm"`) per Prettier conventions
- **Descriptions**: All inputs must have clear descriptions
- **naming**: Use kebab-case for YAML keys (e.g., `working-directory`, not `workingDirectory`)

## Dependencies

### Dependency Management Rules

From `package.json` comments:

- **Runtime dependencies**: Must be kept to an absolute minimum for performance
- **Transitive dependencies**: Ideally zero transitive dependencies for runtime
- **Relationship**: `.github/package.json` must be a superset of `.github/shared/package.json`
- **Updates**: When updating dependencies, update both files if the dependency is shared

### Key Dependencies

- `@actions/github-script`: GitHub Actions toolkit (devDependency)
- `@octokit/rest`, `@octokit/types`: GitHub REST API client
- `simple-git`: Git operations
- `js-yaml`: YAML parsing
- `debug`: Debug logging
- `vitest`: Testing framework
- `eslint`, `typescript-eslint`: Linting and type checking
- `prettier`: Code formatting

## Build, Test, and Validation

### Available npm Scripts

In `.github/` directory:

```bash
npm run check           # Run all checks (lint + format:check + test:ci)
npm run lint            # Run both ESLint and TypeScript checks
npm run lint:eslint     # Run ESLint only
npm run lint:tsc        # Run TypeScript type checking only
npm run format          # Format code with Prettier
npm run format:check    # Check formatting without modifying files
npm run format:check:ci # Check formatting with verbose debug output (for CI)
npm run test            # Run tests in watch mode
npm run test:ci         # Run tests once with coverage report
npm run validate        # Alias for 'check' (legacy)
```

In `.github/shared/` directory:

```bash
npm run check           # Run all checks
npm run lint            # Run ESLint and TypeScript checks
npm run format          # Format code with Prettier
npm run format:check    # Check formatting
npm run test            # Run tests in watch mode
npm run test:ci         # Run tests once with coverage report
npm run perf            # Run performance benchmarks
```

### Before Committing

Always run:

```bash
npm run check
```

This runs linting, formatting checks, and tests. All must pass before committing.

### Testing Conventions

- **Framework**: Vitest
- **Test files**: `*.test.js` files in `test/` directories
- **Mocks**: Define mocks in test files or `test/mocks.js`
- **Assertions**: Use `expect()` from Vitest
- **Coverage**: Maintained via `npm run test:ci`
- **Test structure**: Use `describe()` and `it()` blocks

Example test structure:

```javascript
import { describe, expect, it } from "vitest";
import { myFunction } from "../src/my-module.js";

describe("myFunction", () => {
  it("should do something", async () => {
    const result = await myFunction({ option: "value" });
    expect(result).toEqual(expectedValue);
  });
});
```

### Coverage Exclusions

Per `vitest.config.js`, coverage excludes:

- `**/eslint*.config.js`
- `**/cmd/**` (CLI code)
- `**/coverage/**`
- `**/test/**`

## GitHub Actions Patterns

### Composite Actions

Composite actions are defined in `.github/actions/*/action.yaml`. Key patterns:

- Use `runs.using: "composite"`
- Define clear `inputs` with descriptions and defaults
- Use `shell: bash` for run steps in composite actions
- Set environment variables with `${{ inputs.name }}` syntax
- Use `echo "::group::name"` and `echo "::endgroup::"` for output grouping

### Workflow JavaScript

Scripts in `.github/workflows/src/` are typically used with `actions/github-script@v8`:

```yaml
- uses: actions/github-script@v8
  with:
    script: |
      const { myFunction } = await import("${{ github.workspace }}/.github/workflows/src/my-script.js");
      await myFunction({ github, context, core });
```

### Common Patterns

- **GitHub API calls**: Use `github.rest.*` methods with proper error handling
- **Logging**: Use `core.info()`, `core.warning()`, `core.error()`, `core.debug()`
- **Outputs**: Use `core.setOutput()` or append to `$GITHUB_OUTPUT` file
- **Context**: Always accept `github`, `context`, `core` as parameters from github-script
- **Pagination**: Use `PER_PAGE_MAX` constant for API pagination
- **Rate limiting**: Workflows implement rate limit logging hooks

## Security and Best Practices

### Security

- **Secrets**: Never commit secrets or tokens to code
- **Pull request target**: Use `pull_request_target` carefully; only support specific actions
- **Permissions**: Define minimal `permissions` in workflow files
- **Token usage**: Use `GITHUB_TOKEN` with least privilege

### Code Quality

- **Async/await**: Prefer async/await over raw Promises
- **Error handling**: Always handle errors; use try/catch or `.catch()`
- **Logging**: Log important operations for debugging
- **Idempotency**: Workflows should be idempotent where possible
- **Comments**: Explain complex logic; avoid obvious comments

### Performance

- **Minimal dependencies**: Keep runtime dependencies minimal (per package.json comments)
- **Caching**: Use appropriate caching strategies (e.g., npm cache in setup-node)
- **Early exits**: Return early when conditions aren't met

## Common Tasks

### Adding a New Shared Utility

1. Create the module in `.github/shared/src/my-utility.js`
2. Add JSDoc type annotations
3. Export named functions
4. Add exports to `.github/shared/package.json` under `exports` field
5. Write tests in `.github/shared/test/my-utility.test.js`
6. Run `npm run check` in `.github/shared/`
7. Run `npm run check` in `.github/` (to ensure no breakage)

### Adding a New Workflow

1. Create workflow YAML in `.github/workflows/my-workflow.yaml`
2. Create workflow scripts in `.github/workflows/src/my-workflow.js`
3. Write tests in `.github/workflows/test/my-workflow.test.js`
4. Add workflow to `github-test.yaml` if it needs validation
5. Run `npm run check` to validate

### Updating Dependencies

1. Update `.github/package.json` (root)
2. If dependency is used in shared utilities, update `.github/shared/package.json`
3. Run `npm install` in both directories
4. Commit both `package.json` and `package-lock.json` files
5. Test with `npm run check` in both directories

### Node.js Version Management

- Default Node.js version: 24.x
- Use `actions/setup-node@v6` with `node-version` input
- The `setup-node-install-deps` composite action handles Node.js setup
- For ubuntu-slim workflows, use empty string for `node-version` to use cached version

## Debugging

### Local Development

```bash
# Install dependencies
cd .github
npm ci

# Run tests in watch mode
npm run test

# Run type checking
npm run lint:tsc

# Check formatting
npm run format:check

# Debug a specific test
npm run test -- path/to/test.test.js
```

### Debugging Workflows

- Enable debug logging: Set repository secret `ACTIONS_STEP_DEBUG=true`
- Use `core.isDebug()` to conditionally log verbose information
- Check workflow logs on GitHub Actions tab
- Re-run with debug enabled to replay context

### Common Issues

- **Type errors**: Ensure all JSDoc annotations are correct; run `npm run lint:tsc`
- **Import errors**: Verify file paths use `.js` extension even for modules
- **Test failures**: Check mock data matches expected GitHub API responses
- **Formatting errors**: Run `npm run format` to auto-fix

## Architecture Patterns

### Separation of Concerns

- **`.github/shared/`**: Pure utility functions, no GitHub Actions-specific code
- **`.github/workflows/src/`**: Workflow orchestration, calls shared utilities
- **`.github/actions/`**: Reusable composite actions (YAML + shell scripts)

### Data Flow

1. Workflow triggers on GitHub event
2. Composite actions set up environment (Node.js, dependencies)
3. Workflow scripts extract context via `extractInputs()`
4. Scripts call shared utilities to perform operations
5. Scripts call GitHub API to update status/comments/labels
6. Workflow completes with success or failure

### API Communication

- All GitHub API calls go through `github.rest.*` (Octokit)
- Rate limiting hooks log API usage
- Pagination uses `PER_PAGE_MAX` constant
- Errors are caught and logged with `core.error()`

## For AI Agents

When modifying GitHub Actions code:

1. **Read existing code first**: Understand patterns before changing
2. **Run checks locally**: Always run `npm run check` before committing
3. **Update tests**: Add/modify tests when changing functionality
4. **Preserve typing**: Maintain JSDoc annotations for all changes
5. **Follow conventions**: Match existing code style and structure
6. **Minimize changes**: Make surgical, focused changes
7. **Test isolation**: Ensure changes don't break other workflows
8. **Documentation**: Update this file if adding new patterns

### Critical Don'ts

- ❌ Don't create `.ts` files (use `.js` with JSDoc)
- ❌ Don't use default exports (use named exports)
- ❌ Don't skip JSDoc annotations
- ❌ Don't commit without running `npm run check`
- ❌ Don't modify `package-lock.json` manually (use npm install)
- ❌ Don't remove existing tests without justification
- ❌ Don't change formatting manually (use `npm run format`)

### Critical Do's

- ✅ Do maintain JSDoc type annotations
- ✅ Do write tests for new functionality
- ✅ Do preserve existing code patterns
- ✅ Do run `npm run check` before committing
- ✅ Do use async/await for asynchronous operations
- ✅ Do handle errors gracefully
- ✅ Do log important operations for debugging

## Related Files

- Main Copilot instructions: [`.github/copilot-instructions.md`](../copilot-instructions.md)
- Other instruction files: [`.github/instructions/`](.)
- GitHub Actions docs: https://docs.github.com/en/actions
- Vitest docs: https://vitest.dev/
- ESLint docs: https://eslint.org/
