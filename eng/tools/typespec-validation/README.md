# TypeSpec Validation

Run from the repository root after installing dependencies with `pnpm install`:

```sh
pnpm tsv --help
pnpm tsv specification/<service>/<project>
pnpm tsv specification/<service>/<project> --check
pnpm tsv --all
pnpm tsv --all --fix
pnpm tsv --all specification/<service> --shard=1/3
pnpm tsv --changed
pnpm tsv --changed --fix
pnpm tsv --changed --base=origin/main --head=HEAD --dry-run
```

TSV uses `pathe` for path operations and normalizes separators to `/` on every
platform. Use ordinary relative paths or absolute drive-qualified Windows paths.
Native Windows UNC, drive-relative, and case-insensitive path-comparison semantics
are not preserved; backslashes are treated as separators even on POSIX.

Use `--help` (or `-h`) to see all command-line options without running validation.
For single-project validation, pass the folder and optional JSON context for rules
and suppressions as positional arguments:

```text
pnpm tsv <folder> [context-json]
```

Successful single-project runs print only the final rule-count summary. Errors
and warnings remain visible. When validation stops early, the summary includes
rules that were not run. A blank line separates preceding diagnostics or verbose
output from the summary; quiet successful runs have no leading blank line.

The summary uses green for passed rules, bold red for failures, yellow for
warnings, and gray for skipped, suppressed, or not-run counts. Separators are
dimmed so the results stand out; plain-text output keeps the same information.

```text
9 passed | 3 skipped
```

With `--verbose` (or `-v`), each rule also gets a compact completion indicator:
checkmark for pass, cross for failure, `!` for a non-failing warning, and `-` with
a label for skipped/suppressed rules. Verbose output also includes configuration/import details,
routine skip reasons, successful compiler/formatter output, emitted-file
inventories, Git status, command traces, and changed-file discovery:

```sh
pnpm tsv specification/<service>/<project> --verbose
pnpm tsv --changed --verbose
pnpm tsv --all specification/<service> --verbose
```

Rule errors, actionable warnings, and CI annotations remain visible without this
flag. Existing `DEBUG` environment selections are respected; TSV does not enable
Git tracing merely by being imported.

Rule findings use TypeSpec-style formatting with a stable `tsv/` diagnostic code,
an affected file or directory, and fix guidance when available:

```text
specification/example/data-plane/Example/tspconfig.yaml - error tsv/emit-autorest: The default emit list must include "@azure-tools/typespec-autorest".
  help: Add "@azure-tools/typespec-autorest" to "emit".
```

Parser errors and invalid imports include line/column locations and a source
excerpt. Diagnostics go to stderr; use `2>&1` to capture them together with stdout.
Colors are enabled in terminals and GitHub Actions; `NO_COLOR` disables them and
takes precedence over `FORCE_COLOR`. `FORCE_COLOR=1` enables colors for redirected
output, while `FORCE_COLOR=0` disables them.

Validation still stops after the first failed rule in each project, and batch
runs continue to later projects. Suppression rule names are unchanged.

Compiler and formatter failures retain their native diagnostic codes, source
excerpts, and colors, reported once beneath a TSV command-failure diagnostic.
Unexpected output from successful commands also remains visible. Successful
compiler banners, progress messages, and emitted-file lists are debug-only.
In fix mode, if compilation or formatting changes files, TSV shows an indented cyan file list,
the Git diff, and the command to fix them. The diff includes staged, unstaged, and
untracked files under the project's service folder and retains Git's colors when
color output is enabled. `--verbose` also includes Git status.

TSV still captures `tsp compile --list-files` internally to detect stale generated
Swagger files. Hiding that inventory in normal output does not disable the check.

PR policies, including SDK API-version pin checks, run separately through
[Spec Change Policies](../spec-change-policies/README.md). TSV validates project
correctness; it does not enforce policies based on versions added by a PR.

In GitHub Actions, both TSV workflows enable `--verbose` when debug logging is
enabled. To diagnose a run without changing the normal default, choose
**Re-run jobs > Enable debug logging**, or run:

```sh
gh run rerun <run-id> --debug --repo Azure/azure-rest-api-specs
```

The `DisallowedFileTypes` rule rejects JavaScript and TypeScript files anywhere
under the project's service folder (`specification/<service>/`), including shared
files and sibling projects. It checks the current filesystem, not Git history,
in single-project, `--all`, and `--changed` validation. Existing and uncommitted
files are checked too. Installed `node_modules` and `.git` directories are excluded.
The disallowed extensions are `.js`, `.ts`, `.mjs`, `.cjs`, `.mts`, `.cts`, `.jsx`,
and `.tsx` (case-insensitive, including declaration files).
File-specific `TypeSpecValidation` suppressions with `rules: [DisallowedFileTypes]`
can grandfather existing scripts without allowing new scripts in the same service.

`--changed` compares committed changes between `--base` (default `HEAD^`) and
`--head` (default `HEAD`). It validates the current checkout, not a separate
checkout of `--head`. Uncommitted changes do not affect project selection.

For changes under `specification/<service>/`, it discovers every project in that
service folder, including sibling and nested projects. Deleted files still select
their service when it exists; deleted service folders are skipped. Projects are
deduplicated, sorted, and validated sequentially.

Changes to core tooling, root configuration, shared common types, or the root
suppression file trigger all-project validation. Skill files under `.github/skills/`,
ARM lease metadata, and `eng/common` do not trigger this fallback. Skill-only changes
select no service projects and succeed without running service validation. Mixed changes
still select affected services or trigger all-project validation when core files change.
Use `--ignore-core-files` to disable the fallback. The PR workflow enables the
fallback only for PRs targeting `main`
or `RPSaaSMaster`; other target branches pass `--ignore-core-files`.

Changed-project validation retains the base/head commits in the suppression context.
`TypeSpecValidationAll` suppressions apply only to `--all` or a core-file fallback,
not scoped changed-project runs. An empty changed-project selection succeeds;
an empty all-project selection fails.

`--shard=<index>/<count>` is available only with `--all`, uses one-based indices,
and balances the sorted project list before suppressions. Each shard requires
its own checkout.

`--dry-run` lists the selected projects and context without validating or changing
files. It works with `--all` and `--changed`.

Batch validation is check-only by default. It compares
emitted contents with the checkout and checks formatting without saving files
or creating output directories. Findings list affected files and commands to fix
them. Ignored untracked outputs are not treated as missing generated files;
tracked outputs are checked even if they match an ignore rule.

Use `--fix` to apply and retain updates during `--all` or `--changed` validation.
Single-project validation still applies fixes by default; pass `--check` to
check a single project without modifying files. `--check` and `--fix` cannot
be combined.

Fix mode keeps the existing failure-on-change behavior: applying updates does
not turn the validation result into a success. The first failed rule still
stops that project's remaining rules, and batch runs continue to other projects.
Run `pnpm tsv <project>`, a batch command with `--fix`, or the reported
compiler/formatter command to apply fixes.

Rules receive an optional execution-options object through
`execute(folder, logger, { fix })`. Rules check files by default (`fix: false`);
rules that support fixes can apply them when `fix` is true. Validation-only
rules continue checking normally in either mode.

`--git-clean` optionally requires the entire checkout to be clean once before
batch validation, including staged, unstaged, and untracked changes. It never
restores or deletes files, and ignored files remain untouched. `--dry-run`
disables this check. Do not edit files concurrently if you need a consistent
validation baseline.
