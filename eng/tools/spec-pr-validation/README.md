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

The checks cover:

- **TypeSpec Requirement:** changed OpenAPI must follow the existing TypeSpec
  usage policy, and generated OpenAPI must have TypeSpec sources in its
  specification service area. Existing OpenAPI API-version directories are
  identified against upstream `Azure/azure-rest-api-specs` **main**, independently
  of the comparison base. This lookup requires network access. Suppressions
  cannot permit new handwritten versions in a service that has migrated to
  TypeSpec; qualifying historical relocations retain their exemptions.
- **MultipleNewApiVersions:** when a project adds multiple TypeSpec API versions,
  its management-plane SDK emitters must target the oldest newly added version.
- **StaleApiVersionPin:** when a project adds one TypeSpec API version, its
  management-plane SDK emitters must not remain pinned to an older version.

SDK policies compare committed `service.yaml` manifests for projects in changed
service areas, including siblings and nested projects. They acquire compiler
metadata only when applicable and unsuppressed. Metadata generation invokes the
TypeSpec compiler with temporary output; the tool does not regenerate Swagger,
format specifications, or clean the checkout.

Independent policy failures are reported together. Failed prerequisites stop
only their dependent work. No affected specs is a successful no-applicable-checks
result. Errors and warnings are always visible; `--verbose` adds progress,
discovery details, suppression reasons, and exception details.

## Suppressions

New suppressions use `tool: SpecPrValidation` with rule names
`TypeSpecRequirement`, `MultipleNewApiVersions`, or `StaleApiVersionPin`.
For Requirement, paths must identify one specific version under `preview` or
`stable`; migration and relocation safeguards apply regardless of tool identity.

Existing `TypeSpecRequirement` suppressions remain applicable to Requirement.
Existing `TypeSpecValidation` suppressions, including whole-tool suppressions,
remain applicable only to the extracted SDK policies, never to Requirement.
`TypeSpecValidationAll` suppressions do not suppress PR policies.

```yaml
- tool: SpecPrValidation
  paths: ["Project"]
  rules: ["StaleApiVersionPin"]
  reason: "Approved exception for this project"
```

The `brownfield` result is emitted explicitly as true or false for label
automation, including when an independent SDK policy fails. If an operational
failure prevents classification, the tool does not emit a false classification.

For project correctness, continue using [TypeSpec Validation](../typespec-validation/README.md).
