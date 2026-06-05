# `eng/tools/suppressions`

`@azure-tools/suppressions` is the tool that reads `suppressions.yaml` files and returns the
suppressions applicable to a given tool and path. Validation tools across the
`Azure/azure-rest-api-specs` repository use it to let spec authors suppress specific checks for
specific files or directories.

This document has two audiences:

- **[Usage](#usage)** — for _users_ of the suppressions API, how to author `suppressions.yaml`
  files and query suppressions from the CLI or as a library.
- **[Folder structure & contributing](#folder-structure--contributing)** — for _developers_ of the
  suppressions tool, how the folder is organized and how to make changes.

## Usage

### Authoring `suppressions.yaml`

A `suppressions.yaml` file is a YAML array of suppression entries. When a tool checks a file or
directory, `getSuppressions` walks up the directory tree from that path to the filesystem root,
reads every `suppressions.yaml` it finds, and returns the entries matching the tool name and path.
Suppressions are ordered by file (closest to the path first), then within each file (top first).

Each entry supports the following properties:

- `tool` (required) — name of the tool the suppression applies to (matched exactly).
- `paths` — array of glob patterns, relative to the `suppressions.yaml` file, that the path under
  analysis must match. Patterns use [minimatch](https://github.com/isaacs/minimatch) syntax.
- `path` — convenience for a single pattern; if present it is inserted at the start of `paths`. At
  least one of `path` or `paths` must be present.
- `reason` (required) — human-readable explanation for the suppression.
- `rules` — optional array of rule names the suppression applies to.
- `sub-rules` — optional array of sub-rule names the suppression applies to.
- `if` — optional string of CommonJS JavaScript, evaluated in a prepared context, that must return
  truthy for the suppression to apply.

Example `suppressions.yaml`:

```yaml
- tool: TypeSpecRequirement
  paths: ["data-plane/Foo/stable/2023-01-01/*.json"]
  reason: Legacy API version predates the TypeSpec requirement.

- tool: TypeSpecValidation
  reason: Specs added as folder structure v1, not yet converted to v2
  rules: [FolderStructure]
  paths: [Automation.Management]
```

### Command line

Build the package (see [contributing](#folder-structure--contributing)), then query suppressions
with the `get-suppressions` CLI:

```
npx get-suppressions <tool-name> <path-to-file-or-directory>
```

It prints a JSON array of the suppressions (which may be empty) for the given tool that apply to the
given file or directory:

```
npx get-suppressions TypeSpecRequirement specification/foo/data-plane/Foo/stable/2023-01-01/Foo.json
[{"tool":"TypeSpecRequirement","paths":["data-plane/Foo/stable/2023-01-01/*.json"],"reason":"foo"}]
```

### Library

The package also exposes `getSuppressions` for programmatic use:

```ts
import { getSuppressions, Suppression } from "@azure-tools/suppressions";

const suppressions: Suppression[] = await getSuppressions(
  "TypeSpecRequirement",
  "specification/foo/data-plane/Foo/stable/2023-01-01/Foo.json",
);
```

`getSuppressions(tool, path)` resolves `path`, throws if it does not exist, walks up the directory
tree collecting `suppressions.yaml` files, and returns the matching `Suppression[]`.

## Folder structure & contributing

```
eng/tools/suppressions
├── cmd/      # Executable CLI entry point (exposed via package.json "bin")
├── src/      # The tool source (TypeScript)
├── test/     # Vitest unit + end-to-end tests and fixtures
├── package.json        # "bin", scripts, dependencies
├── tsconfig.json       # Type-checking / build config
├── eslint.config.js    # ESLint config
└── vitest.config.ts    # Test + coverage config
```

### `src`

- [`src/suppressions.ts`](./src/suppressions.ts) — the core implementation: `getSuppressions`,
  `getSuppressionsFromYaml`, the `Suppression` type, and the zod schema that validates
  `suppressions.yaml`.
- [`src/index.ts`](./src/index.ts) — the package entry point. Exports `getSuppressions` and
  `Suppression`, and provides `main` for the CLI.

### `cmd`

CLI entry point exposed via `package.json` `"bin"`.
[`cmd/get-suppressions.js`](./cmd/get-suppressions.js) backs `npx get-suppressions` by running the
built `dist/src/index.js`.

### `test`

[Vitest](https://vitest.dev/) tests:

- [`test/suppressions.test.ts`](./test/suppressions.test.ts) — unit tests for
  `getSuppressionsFromYaml`.
- [`test/suppressions.e2e.test.ts`](./test/suppressions.e2e.test.ts) — end-to-end tests for
  `getSuppressions` against the fixtures under `test/e2e/`.
- `test/e2e/` — sample folder trees with `suppressions.yaml` files used by the e2e tests.

### Contributing

When changing the tool, keep the source, tests, and this document in sync. Build first (the CLI runs
from `dist/`), then add or update tests under `test/`.

Useful scripts (run from `eng/tools/suppressions`):

| Command                | Description                                               |
| ---------------------- | --------------------------------------------------------- |
| `npm run build`        | Compile TypeScript to `dist/`.                            |
| `npm test`             | Run tests in watch mode (vitest).                         |
| `npm run test:ci`      | Run tests once with coverage.                             |
| `npm run lint`         | Run ESLint.                                               |
| `npm run format`       | Auto-format with prettier.                                |
| `npm run format:check` | Check formatting without writing.                         |
| `npm run check`        | Run build, lint, format check, and tests (the full gate). |
