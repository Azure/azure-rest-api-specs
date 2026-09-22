---
applyTo:
  - ".github/*.config.{js,ts}"
  - ".oxfmtrc.json"
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

Read existing code before editing, preserve its conventions, and keep changes surgical and focused.

## Overview

The `.github` directory contains all the code and configuration for GitHub Actions that run as PR checks. This includes:

- **Actions**: Reusable composite actions in `.github/actions/`
- **Workflows**: Workflow files in `.github/workflows/`
- **Shared utilities**: Common TypeScript modules in `.github/shared/src/`
- **Tests**: Test files in `.github/workflows/test/` and `.github/shared/test/`
- **Configuration**: Root oxlint, Oxfmt, TypeScript, and Vitest configs

## Technology Stack

- **Language**: TypeScript with erasable syntax and native type annotations
- **Runtime**: Node.js 24.x (on GitHub Actions runners)
- **Type Checking**: `tsc --noEmit`; Node.js executes the `.ts` sources directly
- **Testing**: Vitest for unit and integration tests
- **Linting**: oxlint with type-aware rules from `oxlint-tsgolint`, configured in the root `.oxlintrc.json`
- **Formatting**: Oxfmt using the root `.oxfmtrc.json`; import organization and package.json sorting are disabled
- **Package Manager**: pnpm workspaces (`pnpm ci` for clean installs)

## Project Structure

```
.github/
├── actions/                    # Reusable composite actions
│   ├── setup-node-install-deps/
│   ├── install-deps-github-script/
│   └── ...
├── workflows/                  # Workflow YAML files and their scripts
│   ├── src/                   # TypeScript modules for workflows
│   ├── test/                  # Tests for workflow scripts
│   ├── *.yaml                 # Workflow definitions
│   └── cmd/                   # CLI scripts
├── shared/                    # Shared utilities used across workflows
│   ├── src/                   # Core utility modules
│   ├── test/                  # Tests for shared utilities
│   └── package.json
├── matchers/                  # Problem matchers for CI output
├── package.json               # Root dependencies (superset of shared/)
├── tsconfig.json              # TypeScript config (type-checking only)
└── vitest.config.ts           # Vitest test configuration
```

## Coding Standards

### TypeScript Style

- **File extension**: Use `.ts` for source, tests, CLI entry points, benchmarks, and Vitest configuration; do not add JavaScript files
- **Module system**: ES modules (`import`/`export`), not CommonJS
- **Type annotations**: Use interfaces, type aliases, and native parameter and return annotations, not JSDoc type declarations. Keep comments for documentation
- **Indentation**: 2 spaces (enforced by Oxfmt)
- **Quote style**: Double quotes for strings (enforced by Oxfmt)
- **Line length**: Max 100 characters (enforced by Oxfmt)
- **Naming conventions**:
  - Functions and variables: `camelCase`
  - Constants: `UPPER_SNAKE_CASE` for true constants
  - Files: `kebab-case.ts` or `camelCase.ts`
- **Exports**: Prefer named exports for new reusable helpers; preserve configuration and workflow entry-point export contracts

### TypeScript Integration

- Shared ES2024/NodeNext compiler options live in the single root `tsconfig.base.json`. Each GitHub project extends it directly, defining its own file selection and overrides that preserve the existing library, JavaScript, and unused-code checking behavior.
- TypeScript is configured with `noEmit`, `allowImportingTsExtensions`, `erasableSyntaxOnly`, and `verbatimModuleSyntax`
- Use `.ts` relative imports and `import type` for type-only dependencies
- Do not introduce enums, parameter properties, or namespaces; use frozen objects and value-union type aliases instead of enums
- Type injected `github`, `context`, and `core` values using `AsyncFunctionArguments` from `@actions/github-script`
- For helpers that take `core` separately, import the shared `Core` type from `workflows/src/github.ts`
- Type webhook payloads with `WebhookEvent<"pull-request", "labeled">` from `workflows/src/github.ts`, using GitHub OpenAPI event and action names. Omit the action to accept all actions for an event.
- Inline `actions/github-script` YAML snippets remain JavaScript; they dynamically import the `.ts` modules

See [the shared package guide](../shared/readme.md) for shared-library development conventions.

### YAML Style for Actions/Workflows

- **Indentation**: 2 spaces
- **String values**: Use double quotes (e.g., `cache: "pnpm"`) per Oxfmt conventions
- **Descriptions**: All inputs must have clear descriptions
- **naming**: Use kebab-case for YAML keys (e.g., `working-directory`, not `workingDirectory`)

## Dependencies

### Dependency Management Rules

From `package.json` comments:

- **Runtime dependencies**: Must be kept to an absolute minimum for performance
- **Transitive dependencies**: Ideally zero transitive dependencies for runtime
- **Relationship**: `.github/package.json` must be a superset of `.github/shared/package.json`
- **Versions**: Reference external dependencies with `catalog:` and define their versions in the root `pnpm-workspace.yaml` catalog. Keep internal links as `workspace:*`.

### Key Dependencies

- `@actions/github-script`: GitHub Actions toolkit (devDependency)
- `@octokit/rest`, `@octokit/types`: GitHub REST API client
- `simple-git`: Git operations
- `js-yaml`: YAML parsing
- `debug`: Debug logging
- `vitest`, `@vitest/coverage-v8`: Root development dependencies for testing and coverage
- `oxlint`, `oxlint-tsgolint`: Root development dependencies for linting
- `typescript`: Root development dependency for type checking
- `oxfmt`: Code formatting

## Build, Test, and Validation

### Available pnpm Scripts

Run from `.github/` or `.github/shared/` unless noted:

```bash
pnpm run build           # Run this package's TypeScript check
pnpm run check           # Run all checks (lint + format:check + test:ci)
pnpm run lint            # Run both oxlint and TypeScript checks
pnpm run lint:oxlint     # Run oxlint only
pnpm run lint:tsc        # Run TypeScript type checking only
pnpm run format          # Format code with Oxfmt
pnpm run format:check    # Check formatting without modifying files
pnpm run test            # Run tests in watch mode
pnpm run test:ci         # Run tests once with coverage report
pnpm run validate        # Run the same checks (legacy, .github only)
pnpm run perf            # Run performance benchmarks (.github/shared only)
```

Use `pnpm run format` rather than adjusting formatting manually.

Root `pnpm build` delegates to package build scripts with `pnpm -r`; `lint:tsc`
remains a package-local alias for `build`. Root `pnpm test`/`pnpm test:ci` run the
Vitest workspace and root `pnpm check` runs all contributor checks. Package-local
Vitest commands still run directly and do not forward to the root.

`eng.yml` validates the workspace, runs root `pnpm build` once on Linux, and runs
the Vitest workspace on Ubuntu and Windows. `github-test.yaml` retains production-only module import
checks on both OSes, plus actionlint and compiled agentic workflow lock checks on Linux.

These read-only engineering workflows cancel superseded runs of the same PR and have
explicit job timeouts. Concurrency groups include the workflow and event; non-PR runs
use a unique run ID so pushes and manual runs do not cancel each other. Do not extend
this policy to status/label publishers or workflows with downstream artifact consumers
without reviewing their cancellation behavior.

CI runs `pnpm lint` once from the repository root in `lint.yaml`, covering `.github`
and `eng/tools`. Do not add lint or type-check steps to the test OS matrix.
`.github/workflows/format.yaml` runs `pnpm format:check` once from the repository
root for `.github`, `eng/tools`, and `vitest.config.mts`. Do not add formatting steps to package/OS
test matrices. Package-local format commands inherit the root `.oxfmtrc.json`,
including fixture, generated-file, and unmanaged-content exclusions.
See [the engineering guide](../../eng/README.md#linting-and-formatting) for package
exclusions for packages not yet linted.

### Before Committing

Run `pnpm run check` in each affected package. All lint, formatting, and test checks must pass before committing. Ensure changes do not break other workflows.

### Testing Conventions

Cover new or changed behavior and bug regressions with focused tests of repository-owned behavior and integration contracts. Reuse adequate existing coverage for mechanical refactors and dependency/API substitutions; add tests for uncovered repository behavior or compatibility risks, not to reproduce upstream test matrices. Preserve configured coverage requirements and justify removing existing tests.

- **Framework**: Vitest
- **Test files**: `*.test.ts` files in `test/` directories
- **Mocks**: Define mocks in test files or `test/mocks.ts`; prefer typed `vi.fn` and `vi.mocked` over casts
- **Assertions**: Use `expect()` from Vitest
- **Coverage**: Maintained via `pnpm run test:ci`
- **Test structure**: Use `describe()` and `it()` blocks

### Coverage Exclusions

Package configs inherit `defaultVitestConfig` from root `vitest.config.mts`, not
its workspace project list. Shared defaults exclude:

- `**/cmd/**` (CLI code)
- `**/coverage/**`
- `**/test/**`

The shared package retains its independent 100% gate for standalone runs.
Workspace coverage has a root-configured 100% threshold for shared sources.

## GitHub Actions Patterns

### Composite Actions

Composite actions are defined in `.github/actions/*/action.yaml`. Key patterns:

- Use `runs.using: "composite"`
- Define clear `inputs` with descriptions and defaults
- Use `shell: bash` for run steps in composite actions
- Set environment variables with `${{ inputs.name }}` syntax
- Use `echo "::group::name"` and `echo "::endgroup::"` for output grouping

### Workflow TypeScript

Scripts in `.github/workflows/src/` are typically used with `actions/github-script@v8`:

```yaml
- uses: actions/github-script@v8
  with:
    script: |
      const { myFunction } = await import("${{ github.workspace }}/.github/workflows/src/my-script.ts");
      await myFunction({ github, context, core });
```

### Common Patterns

- **GitHub API calls**: All GitHub API calls go through `github.rest.*` (Octokit)
- **Logging**: Use `core.info()`, `core.warning()`, `core.error()`, `core.debug()`
- **Outputs**: Use `core.setOutput()` or append to `$GITHUB_OUTPUT` file
- **Context**: Always accept `github`, `context`, `core` as parameters from github-script
- **Pagination**: Use `PER_PAGE_MAX` constant for API pagination
- **Rate limiting**: Workflows use rate limiting hooks to log API usage

## Security and Best Practices

### Security

- **Secrets**: Never commit secrets or tokens to code
- **Pull request target**: Use `pull_request_target` carefully; only support specific actions
- **Permissions**: Define minimal `permissions` in workflow files
- **Token usage**: Use `GITHUB_TOKEN` with least privilege

### Code Quality

- **Async/await**: Prefer async/await over raw Promises
- **Error handling**: Always handle errors; use try/catch or `.catch()` and log caught errors with `core.error()`
- **Logging**: Log important operations for debugging
- **Idempotency**: Workflows should be idempotent where possible
- **Comments**: Explain complex logic; avoid obvious comments
- **Documentation**: Update this file if adding new patterns

### Performance

- **Caching**: Use appropriate caching strategies (e.g., pnpm cache in setup-node)
- **Early exits**: Return early when conditions aren't met

## Common Tasks

### Adding a New Shared Utility

1. Create the module in `.github/shared/src/my-utility.ts`
2. Add native TypeScript annotations and documentation comments where needed
3. Export named functions
4. Add exports to `.github/shared/package.json` under `exports` field
5. Write tests in `.github/shared/test/my-utility.test.ts`
6. Run the [required checks](#before-committing) in both `.github/shared/` and `.github/`.

### Adding a New Workflow

1. Create workflow YAML in `.github/workflows/my-workflow.yaml`
2. Create workflow scripts in `.github/workflows/src/my-workflow.ts`
3. Write tests in `.github/workflows/test/my-workflow.test.ts`
4. Add workflow to `github-test.yaml` if it needs validation
5. Run the [required checks](#before-committing).

### Updating Dependencies

1. Update the dependency's entry in the root `pnpm-workspace.yaml` catalog.
2. For a new dependency, add or reuse its catalog entry and add `catalog:` references to the appropriate manifest sections.
3. Run `pnpm install` once from the **repo root** — `.github` and `.github/shared` are pnpm workspace packages, so a single install updates the single root `pnpm-lock.yaml` for the whole workspace. Do not edit the lockfile manually.
4. Include the catalog, affected manifests, and generated lockfile together. Review actual dependency resolutions and isolate impactful upgrades from mechanical catalog conversions.
5. Run the [required checks](#before-committing) in both directories and check affected engineering consumers.

### Node.js Version Management

- Use `actions/setup-node@v6` with `node-version` input
- The `setup-node-install-deps` composite action handles Node.js setup
- For ubuntu-slim workflows, use empty string for `node-version` to use cached version

## Debugging

### Local Development

```bash
# Install dependencies
cd .github
pnpm install

# Debug a specific test
pnpm run test -- path/to/test.test.ts
```

### Debugging Workflows

- Enable debug logging: Set repository secret `ACTIONS_STEP_DEBUG=true`
- Use `core.isDebug()` to conditionally log verbose information
- Check workflow logs on GitHub Actions tab
- Re-run with debug enabled to replay context

### Common Issues

- **Type errors**: Check native TypeScript declarations; run `pnpm run lint:tsc`
- **Import errors**: Verify relative file paths use `.ts` and type-only imports use `import type`
- **Test failures**: Check mock data matches expected GitHub API responses
- **Formatting errors**: Run `pnpm run format` to auto-fix

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

## Related Files

- Main Copilot instructions: [`.github/copilot-instructions.md`](../copilot-instructions.md)
- Other instruction files: [`.github/instructions/`](.)
- GitHub Actions docs: https://docs.github.com/en/actions
- Vitest docs: https://vitest.dev/
- oxlint docs: https://oxc.rs/docs/guide/usage/linter
