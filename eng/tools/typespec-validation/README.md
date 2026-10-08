# TypeSpec Validation

Run from the repository root after installing dependencies with `pnpm install`:

```sh
pnpm tsv --help
pnpm tsv specification/<service>/<project>
pnpm tsv --all
pnpm tsv --all specification/<service> --shard=1/3
pnpm tsv --changed
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
If compilation or formatting changes files, TSV shows an indented cyan file list,
the Git diff, and the command to fix them. The diff includes staged, unstaged, and
untracked files under the project's service folder and retains Git's colors when
color output is enabled. `--verbose` also includes Git status.

TSV still captures `tsp compile --list-files` internally to detect stale generated
Swagger files. Hiding that inventory in normal output does not disable the check.

PR policies, including SDK API-version pin checks, run separately through
[Spec PR Validation](../spec-pr-validation/README.md). TSV validates project
correctness; it does not enforce policies based on versions added by a PR.

In GitHub Actions, both TSV workflows enable `--verbose` when debug logging is
enabled. To diagnose a run without changing the normal default, choose
**Re-run jobs > Enable debug logging**, or run:

```sh
gh run rerun <run-id> --debug --repo Azure/azure-rest-api-specs
```

`--changed` compares committed changes between `--base` (default `HEAD^`) and
`--head` (default `HEAD`). It validates the current checkout, not a separate
checkout of `--head`. Uncommitted changes do not affect project selection.

For changes under `specification/<service>/`, it discovers every project in that
service folder, including sibling and nested projects. Deleted files still select
their service when it exists; deleted service folders are skipped. Projects are
deduplicated, sorted, and validated sequentially.

Changes to core tooling, root configuration, shared common types, or the root
suppression file trigger all-project validation. ARM lease metadata and
`eng/common` do not trigger this fallback. Use `--ignore-core-files` to disable
the fallback. The PR workflow enables the fallback only for PRs targeting `main`
or `RPSaaSMaster`; other target branches pass `--ignore-core-files`.

Changed-project validation retains the base/head commits in the suppression context.
`TypeSpecValidationAll` suppressions apply only to `--all` or a core-file fallback,
not scoped changed-project runs. An empty changed-project selection succeeds;
an empty all-project selection fails.

`--shard=<index>/<count>` is available only with `--all`, uses one-based indices,
and balances the sorted project list before suppressions. Each shard requires
its own checkout.

`--dry-run` lists the selected projects and context without validating or cleaning
files. It works with `--all` and `--changed`.

Validation may update generated files and formatting. By default these changes
are retained. In a disposable checkout, `--git-clean` restores tracked files and
removes untracked files and directories across the entire repository after each
project. It requires an initially clean checkout; ignored files are retained.
Do not use it while other work is in progress. `--dry-run` disables cleanup.
