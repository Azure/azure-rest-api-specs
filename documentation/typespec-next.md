# Upcoming TypeSpec releases (`typespec-next`)

`main` builds with the TypeSpec versions committed in the `catalog` of
[pnpm-workspace.yaml](../pnpm-workspace.yaml). New TypeSpec releases often require spec changes:
suppressions for new linter rules, regenerated Swagger, or moving to a new API. This page explains
where those changes go so `main` can adopt a release as soon as it ships.

## Toolchain channels

The TypeSpec version is a property of the build, not of the branch. Any checkout can switch:

```bash
# Upcoming release (npm "next" dist-tag)
node eng/scripts/typespec-channel.mts next

# Specific package version, or a single package from a TypeSpec PR build
node eng/scripts/typespec-channel.mts next --set @typespec/compiler=1.17.0-dev.10
node eng/scripts/typespec-channel.mts next --set @typespec/compiler=<tarball-url>

# Back to the committed versions
node eng/scripts/typespec-channel.mts stable
```

Channels are npm dist-tags, not versions: the compiler, TypeSpec libraries, and Azure libraries
use different version numbers. Use repeated `--set <package>=<version>` arguments to pin individual
packages to exact versions.

The script adds the requested tags or package versions to `overrides` in `pnpm-workspace.yaml`
and installs them.
While a channel is in use, `pnpm-workspace.yaml` and `pnpm-lock.yaml` stay modified so `pnpm exec`
and `pnpm tsv` keep the switched packages. Do not commit them. `stable` restores both files from git,
discarding any local edits to them. GitHub Actions restores them right after install so
`tsv --git-clean` sees a clean checkout, and invokes TSV with `node`.

CI selects the channel the same way:

| Run | Channel |
| --- | --- |
| PRs and pushes to `main` | `stable` |
| PRs into and pushes to `typespec-next` | `next` |
| Scheduled **TypeSpec Validation - All** | `stable` and `next` (`next` includes the `typespec-next` spec changes) |
| Manual **TypeSpec Validation - All** | the `typespec-channel` input, e.g. `next` |

With an upcoming release, TSV runs with `--allow-generated-changes`: generated Swagger and formatting
that differ from the committed files are reported as warnings, so only real breaks fail. PRs into
`typespec-next` fail if they change anything outside `specification/` that differs from `main`.

## Where a change goes

| Change | Works with the current release? | Target |
| --- | --- | --- |
| `#suppress` for a new linter rule | Yes, unknown rule codes are ignored | `main` |
| Moving to an API that already exists in the current release | Yes | `main` |
| Generated Swagger that changes with the new release | No | Neither. It is regenerated when `main` moves to the release |
| Moving to an API that only exists in the upcoming release | No | `typespec-next` |

Prefer `main` whenever the change compiles with both channels. `typespec-next` only ever differs
from `main` under `specification/`; tooling changes always go to `main`.

## Moving `main` to a new release

1. Merge `origin/typespec-next` into a branch from `main`.
2. Set the new versions of the TypeSpec packages in the `catalog` (and the `@typespec/asset-emitter`
   override) of `pnpm-workspace.yaml`, then run `pnpm install`.
3. Regenerate Swagger. Either apply the `typespec-next-generated-changes-*` patches from the latest
   scheduled **TypeSpec Validation - All** run (`git apply <patch>`), or run
   `pnpm tsv --all` without `--git-clean`.
4. Open the PR against `main`. After it merges, reset `typespec-next` to `main`: everything it held
   is now on `main`.

Each shard's patch combines its project changes against the committed checkout, including shared
files only once. Independent edits to a shared file are merged; conflicting generated edits fail
the run rather than producing an unusable patch. The file named by `--diff-output` is overwritten
and must be outside the checkout.
