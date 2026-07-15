# skill-eval (CI-only npm project)

This folder exists solely to give the [Skill Evaluations GitHub Actions workflow](../../.github/workflows/skill-eval.yml) a tiny `package.json` it can `npm ci` against, so `@microsoft/vally-cli` and its full transitive dependency tree are pinned by the committed `package-lock.json` instead of resolved fresh from semver ranges on every CI run.

- Do not add runtime code here.
- The only dependency should be `@microsoft/vally-cli`, pinned to the version CI should validate skills with.
- `package-lock.json` must be committed so `npm ci` is deterministic.

## Updating the Vally CLI version

1. Bump `@microsoft/vally-cli` in `package.json`.
2. Run `npm install` locally to refresh `package-lock.json`.
3. Commit both files in the same PR. The workflow's path triggers include `eng/skill-eval/**`, so CI will re-run `vally lint` against the new version automatically.

## Local skill linting

Reproduce exactly what CI does by installing from the same lockfile and invoking the local binary:

```sh
cd eng/skill-eval
npm ci
cd ../..
./eng/skill-eval/node_modules/.bin/vally lint .
```

This matches the CI job step-for-step, so a green local run on the current lockfile means a green CI run.

A global install (`npm install -g @microsoft/vally-cli@<version>`) still works for ad-hoc iteration, but it won't match the transitive dependency tree CI uses and isn't a substitute for the steps above when validating a version bump.
