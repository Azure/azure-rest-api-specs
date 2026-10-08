# Spec PR Validation

Validate policies for committed specification changes, without running TSV's
project-validation, formatting, or generated-Swagger checks.

Run from the repository after `pnpm install`:

```sh
pnpm spec-pr-validation --help
pnpm spec-pr-validation --base=HEAD^ --head=HEAD
pnpm spec-pr-validation --base="$(git merge-base origin/main HEAD)" --head=HEAD
pnpm spec-pr-validation --base=HEAD^ --head=HEAD --verbose
```

`--base` is required; `--head` defaults to `HEAD`. These are exact comparison
endpoints, not an implicit merge-base comparison. CI compares the synthetic PR
merge commit (`HEAD`) with its target-branch parent (`HEAD^`).
Uncommitted changes do not affect selection. Evaluation uses the current
checkout; `--head` does not check out another revision.

The check covers:

- **TypeSpec Requirement:** changed OpenAPI must follow the existing TypeSpec
  usage policy, and generated OpenAPI must have TypeSpec sources in its
  specification service area. Existing OpenAPI API-version directories are
  identified against upstream `Azure/azure-rest-api-specs` **main**, independently
  of the comparison base. This lookup requires network access. Suppressions
  cannot permit new handwritten versions in a service that has migrated to
  TypeSpec; qualifying historical relocations retain their exemptions.

SDK API-version checks continue to run in
[TypeSpec Validation](../typespec-validation/README.md). This tool does not compile
TypeSpec, regenerate Swagger, format specifications, or clean the checkout.

Independent policy failures are reported together. Failed prerequisites stop
only their dependent work. No affected specs is a successful no-applicable-checks
result. Errors and warnings are always visible; `--verbose` adds progress,
discovery details, suppression reasons, and exception details.

## Suppressions

New suppressions use `tool: SpecPrValidation` with the rule name `TypeSpecRequirement`.
For Requirement, paths must identify one specific version under `preview` or
`stable`; migration and relocation safeguards apply regardless of tool identity.

Existing `TypeSpecRequirement` suppressions remain applicable to Requirement.
`TypeSpecValidation` and `TypeSpecValidationAll` suppressions do not suppress
Requirement policies.

```yaml
- tool: SpecPrValidation
  paths: ["data-plane/Foo/stable/2026-01-01/*.json"]
  rules: ["TypeSpecRequirement"]
  reason: "Approved legacy-version exception"
```

The `brownfield` result is emitted explicitly as true or false for label
automation, including when an independent Requirement policy fails. If an
operational failure prevents classification, the tool does not emit a false
classification.

For project correctness, continue using [TypeSpec Validation](../typespec-validation/README.md).
