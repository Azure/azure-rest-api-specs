# TypeSpec Validation

Run from the repository root after installing dependencies with `pnpm install`:

```sh
pnpm tsv specification/<service>/<project>
pnpm tsv --all
pnpm tsv --all specification/<service> --shard=1/3
pnpm tsv --changed
pnpm tsv --changed --base=origin/main --head=HEAD --dry-run
```

Use `--verbose` (or `-v`) to include command traces, captured command output, Git
debug logging, and changed-file discovery details:

```sh
pnpm tsv specification/<service>/<project> --verbose
pnpm tsv --changed --verbose
pnpm tsv --all specification/<service> --verbose
```

Rule errors, actionable warnings, and CI annotations remain visible without this
flag. Existing `DEBUG` environment selections are respected; TSV does not enable
Git tracing merely by being imported.

The `EmitAutorest` rule uses TypeSpec-style formatting with a stable `tsv/`
diagnostic code, an affected file, and fix guidance:

```text
specification/example/data-plane/Example/tspconfig.yaml - error tsv/emit-autorest: The default emit list must include "@azure-tools/typespec-autorest".
  help: Add "@azure-tools/typespec-autorest" to "emit".
```

YAML parser errors include line/column locations and a source excerpt when a
file path is provided. Structured diagnostics go to stderr; use `2>&1` to capture
them together with stdout.
Colors are enabled in terminals and GitHub Actions; `NO_COLOR` disables them and
takes precedence over `FORCE_COLOR`. `FORCE_COLOR=1` enables colors for redirected
output, while `FORCE_COLOR=0` disables them.

Validation still stops after the first failed rule in each project, and batch
runs continue to later projects. Suppression rule names are unchanged. Other
rules, including SDK configuration validation, retain their existing output
format. Compiler and formatter output, including emitted-file lists, is unchanged.

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

Changed-project validation passes the base/head commits to each project's rules.
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
