# Environment setup

Goal: run the **candidate** rule (from the PR under evaluation) against the target
branch of `azure-rest-api-specs`, exactly as the CI "External Integration" /
typespec-next check does.

## 1. Target branch

Most candidate rules are validated against the `typespec-next` branch (it tracks
the pre-release TypeSpec toolchain). Check out that branch (or the branch the
requester names) in your local `azure-rest-api-specs` clone. Do the work on a
throwaway branch off it, e.g. `eval-typespec-next`.

## 2. Install the candidate packages

The PR author usually publishes per-PR builds via **pkg.pr.new**. The PR (or a
pkg.pr.new template link) lists install specifiers such as:

```
@azure-tools/typespec-azure-resource-manager@https://pkg.pr.new/.../@<sha>
```

Update the repo root `package.json` dependencies to point at those specifiers,
**and** pin the matching pre-release dev-versions of the rest of the TypeSpec
toolchain (`@typespec/*`, `@azure-tools/*`) so the compiler and the candidate
rule package resolve against a consistent `next` snapshot. Then:

```powershell
npm install --registry https://registry.npmjs.org
```

The `--registry` flag matters: the `next`/dev-version pins resolve from the
public npm registry, while the pkg.pr.new URLs are absolute and fetch directly.

## 3. Confirm the rule is actually loaded

```powershell
npm ls @azure-tools/typespec-azure-resource-manager   # or the rule's package
```

Verify the installed version/URL is the candidate build, and that the rule source
under `node_modules/.../dist/src/rules/<rule>.js` is the PR version (this is also
the file you instrument for ground truth — see
`ground-truth-and-diagnostics.md`).

## 4. Run validation

From the repo, run per failing spec directory:

```powershell
npx tsv specification/<service>/<path>
```

`tsv` (`@azure-tools/typespec-validation`) recurses into every sub-directory that
contains a `tspconfig.yaml`, compiling each sub-project with
`tsp compile --warn-as-error`. So a single `tsv <service-dir>` covers all of a
service's projects — you do **not** need to enumerate sub-projects yourself.

Note: `--warn-as-error` means even a `severity: "warning"` rule fails the build,
which is why warning-level rules show up as check failures.

## Gotchas

- Keep the modified `package.json` / `package-lock.json` out of the final
  suppression commit unless the requester wants them — they are evaluation-only
  environment setup, not a spec change.
- If a spec fails to compile for reasons unrelated to the candidate rule
  (toolchain drift on `next`), note it and exclude it from rule classification.
