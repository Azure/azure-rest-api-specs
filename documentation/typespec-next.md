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

# Specific version, or a single package from a TypeSpec PR build
node eng/scripts/typespec-channel.mts 1.17.0-dev.10
node eng/scripts/typespec-channel.mts next --set @typespec/compiler=<tarball-url>

# Back to the committed versions
node eng/scripts/typespec-channel.mts stable
```

While a channel is in use, `pnpm-workspace.yaml` and `pnpm-lock.yaml` stay modified so `pnpm exec`
and `pnpm tsv` keep the switched packages. Do not commit them. CI passes `--clean-checkout`, which
restores both files right after install so `tsv --git-clean` sees a clean checkout.

CI selects the channel the same way:

| Run | Channel |
| --- | --- |
| PRs and pushes to `main` | `stable` |
| PRs into and pushes to `typespec-next` | `next` |
| Scheduled **TypeSpec Validation - All** | `stable` and `next` (`next` includes the `typespec-next` spec changes) |
| Manual **TypeSpec Validation - All** | the `typespec-channel` input, e.g. a dev version |

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
2. Pin the release in the catalog and lockfile:

   ```bash
   node eng/scripts/typespec-channel.mts latest --persist
   ```

3. Regenerate Swagger. Either apply the `typespec-next-generated-changes-*` patches from the latest
   scheduled **TypeSpec Validation - All** run (`git apply <patch>`), or run
   `pnpm tsv --all` without `--git-clean`.
4. Open the PR against `main`. After it merges, reset `typespec-next` to `main`: everything it held
   is now on `main`.
