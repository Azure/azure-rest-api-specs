---
mode: agent
---

Keep `typespec-next` in sync with `main`, or move `main` to a new TypeSpec release. Read
[documentation/typespec-next.md](../../documentation/typespec-next.md) first.

`typespec-next` only holds spec changes that need the upcoming TypeSpec release. CI installs the
`next` packages for it, so it never carries tooling or dependency changes. Check that invariant
before and after every step:

```bash
git diff --quiet origin/main HEAD -- . ':!specification'
```

## Validation gate

Run **TypeSpec Validation - All** on the candidate branch and require every matrix job to pass:

```bash
gh workflow run typespec-validation-all.yaml --ref <candidate-branch> -f typespec-channel=next
gh run list --workflow typespec-validation-all.yaml --branch <candidate-branch> --limit 1
gh run view <run-id> --log-failed
```

Use `-f typespec-channel=stable` when validating a PR into `main`.

## Sync `main` into `typespec-next`

1. Create a branch from `origin/typespec-next` and merge `origin/main`.
2. Resolve conflicts, which can only occur under `specification/`. Keep a `typespec-next` change
   only if it still needs the upcoming release; drop it if `main` already has an equivalent.
3. Move any change that also compiles with the current release (suppressions, APIs that already
   exist) to a separate PR into `main`.
4. Pass the validation gate with `next`, then open a draft PR into `typespec-next`.

## Move `main` to a new TypeSpec release

1. Create a branch from `origin/main` and merge `origin/typespec-next`.
2. Set the new TypeSpec versions in the `catalog` (and the `@typespec/asset-emitter` override) of
   `pnpm-workspace.yaml`, run `pnpm install`, and commit `pnpm-workspace.yaml` and `pnpm-lock.yaml`.
3. Apply the `typespec-next-generated-changes-*` patches from the latest scheduled run, or run
   `pnpm tsv --all` without `--git-clean`, and commit the regenerated files.
4. Confirm no TypeSpec package resolves to a prerelease: `git grep -n -- '-dev\.' pnpm-workspace.yaml`
   must print nothing.
5. Pass the validation gate with `stable`, then open a draft PR into `main`.
6. After it merges, reset `typespec-next` to `main`.
