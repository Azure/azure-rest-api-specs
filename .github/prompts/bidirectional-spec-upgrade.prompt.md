---
mode: agent
---

Perform the approval-gated TypeSpec branch sync between `main` and `typespec-next`.

The routine sync is `main` into `typespec-next`: merge `main`, fix TypeSpec Validation - All
(TSV) failures, and keep `typespec-next` on its `"next"` package pins while preserving commit
ancestry. Only use the reverse direction when a specific `typespec-next` change is intentionally
being promoted into `main`.

`main` must use the latest compatible stable TypeSpec packages. `typespec-next` intentionally uses
the `"next"` TypeSpec packages to find upcoming compatibility issues. Preserve that difference while
keeping the branches' commit histories connected.

## Non-negotiable rules

- Use real merge commits. Do not use squash merge or rebase merge.
- Preserve ancestry. After each phase, `git merge-base --is-ancestor <merged-source> <candidate-tip>`
  must succeed.
- Do not copy files with `git checkout <ref> -- <path>`; that copies content without preserving
  source-branch ancestry.
- Do not overwrite the root `package.json` wholesale.
- Run `npm install` after every root dependency-manifest update and commit the generated root
  `package-lock.json`.
- Do not start Phase 2 until the Phase 1 PR is approved and landed.
- If either PR is already open, inspect and update it rather than creating a duplicate.

## Required validation gate

The existing **TypeSpec Validation - All** workflow is the primary validation gate. Do not modify
that workflow as part of this upgrade.

It runs all specifications in three parallel shards (`shard` 0, 1, and 2) on both Ubuntu and
Windows. A PR-triggered run has six validation jobs.

Before merging either PR:

1. Trigger the existing workflow against the candidate branch:

   ```bash
   gh workflow run typespec-validation-all.yaml --ref <candidate-branch>
   ```

2. Find the run and inspect every matrix job:

   ```bash
   gh run list --workflow typespec-validation-all.yaml --branch <candidate-branch> --limit 1
   gh run view <run-id>
   ```

3. Require all six jobs to pass. One successful shard or operating system is not a successful run.
4. If any job fails, inspect logs for every failed shard and operating system:

   ```bash
   gh run view <run-id> --log-failed
   ```

   Fix every reported specification failure, rerun the complete matrix, and repeat until all jobs
   pass. A failure in one shard does not prove the other shards are clean.

## Phase 1: merge `main` into `typespec-next` (normal branch-sync path)

Goal: prepare and land a draft PR that merges `main` into `typespec-next`, fixing all TypeSpec
Validation - All failures while retaining the branch's `"next"` TypeSpec package pins.

1. Fetch both branches and create a working branch from the current `typespec-next`:

   ```bash
   git fetch origin main typespec-next
   git switch --create <phase-1-branch> origin/typespec-next
   git merge --no-ff origin/main -m "Merge main into typespec-next"
   ```

2. Resolve conflicts with this policy:
   - `specification/`, `.github/`, `eng/`, `.vscode/`, and normal repository content: merge
     `main` normally. Preserve a `typespec-next` change only when it is a deliberate,
     branch-specific requirement.
   - Root `package.json`: keep `typespec-next`'s package manifest and its `"next"` TypeSpec pins.
   - Root `package-lock.json`: regenerate with `npm install`.

3. Confirm the intended package policy and ancestry:

   ```bash
   git diff --quiet origin/typespec-next HEAD -- package.json
   git merge-base --is-ancestor origin/main HEAD
   ```

   Both commands must succeed. The first proves the root manifest kept the `typespec-next` package
   policy; the second proves `main`'s actual commits are ancestors of the candidate tip.

4. Complete the required validation gate, then create a draft PR targeting `typespec-next`:

   ```bash
   gh pr create --base typespec-next --head <phase-1-branch> --draft --fill
   ```

5. Wait for approval and landing. Record the landed `typespec-next` SHA before continuing.

## Phase 2: merge approved `typespec-next` into `main` (intentional promotion only)

Run this phase only when a specific `typespec-next` change must be promoted into `main`. Do not
start it as part of a routine between-release sync.

1. Fetch the `typespec-next` commit containing the approved Phase 1 PR, then create a working
   branch from `main`:

   ```bash
   git fetch origin main typespec-next
   git switch --create <phase-2-branch> origin/main
   git merge --no-ff origin/typespec-next -m "Merge typespec-next into main"
   ```

2. Resolve conflicts with this policy:
   - `specification/`: integrate the intended TypeSpec changes from `typespec-next`.
   - Root `package.json`: keep `main`'s dependency set and update every `@typespec/*` and
     `@azure-tools/typespec-*` package to the latest compatible **stable** release. Never leave a
     TypeSpec package pinned to `"next"` in `main`.
   - Root `package-lock.json`: regenerate with `npm install`.
   - `eng/`, `.github/`, and other tooling: retain `main` unless a concrete `typespec-next` change
     is required by the promoted specification changes.

3. Confirm the root package policy and ancestry:

   ```bash
   git grep -n '"next"' -- package.json
   git merge-base --is-ancestor origin/typespec-next HEAD
   ```

   The first command must not show TypeSpec package dependencies. The second command must succeed.

4. Run `npm install`, commit the resulting lockfile, complete the required validation gate, and
   create a draft PR targeting `main`:

   ```bash
   gh pr create --base main --head <phase-2-branch> --draft --fill
   ```

5. Wait for approval and landing. Record the landed `main` SHA before continuing.

## Landing the history-preserving merge

GitHub squash and rebase merge both flatten the two-parent merge commit and break the ancestry this
upgrade preserves. If repository settings do not allow merge commits, an authorized maintainer must
fast-forward the reviewed branch tip directly:

```bash
git fetch origin
git push origin <reviewed-tip-sha>:refs/heads/<target-branch>
```

Immediately verify the result:

```bash
git fetch origin <target-branch>
git merge-base --is-ancestor <source-branch-or-sha> origin/<target-branch>
```

The verification command must succeed before declaring the phase complete.
