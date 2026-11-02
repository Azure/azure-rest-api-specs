# Contract-change YAML

The manifest describes **net public-spec changes**, not backend implementation
changes or a TypeSpec authoring plan. Validate YAML against
[`contract-changes.schema.json`](../schemas/contract-changes.schema.json).

## Envelope

| Field             | Meaning                                                                                       |
| ----------------- | --------------------------------------------------------------------------------------------- |
| `schemaVersion`   | Manifest format version; currently `1`.                                                       |
| `provider`        | Always `Microsoft.Storage`.                                                                   |
| `typespecProject` | Always `specification/storage/Storage.Management`; a logical repository path.                 |
| `baseline.branch` | Public-spec branch explicitly selected for this run.                                          |
| `baseline.commit` | Immutable public-spec commit actually read. This is not a backend source reference.           |
| `changes`         | Needed public declaration changes; an empty array means a completed investigation found none. |

Do not include backend PR URLs, source commits, internal file paths, source
references, evidence records, unresolved questions, or local output paths.
Questions must be resolved with the author before writing this file.

## Changes

Every change has:

- `kind`: `property`, `model`, `enum`, or `operation`.
- `action`: `add`, `modify`, or `remove`.
- `target`: the existing public declaration, or a proposed public name for an
  addition. Use a qualified property/operation name where needed.
- `apiVersions`: explicit public ARM API-version strings affected by this
  change. These are never downstream `x-ms-version` values.
- `after` only for additions, `before` and `after` for modifications, or `before`
  only for removals.

States are complete for the affected declaration, not patches with implicit
defaults. Do not emit duplicate changes for the same target in the same version.
For different results in different versions, use separate entries with disjoint
`apiVersions`. A rename of an existing public declaration is a removal plus an
addition; ask about backward compatibility rather than inferring a breaking
rename from an implementation rename.

A change from read-only to writable is a `modify` on the same wire property,
not a remove/add pair. Scope it to the new public version so old-version
visibility remains unchanged. When one backend field appears in distinct public
create, update, and response models, include every target that needs a change;
do not assume their visibility or nullability is identical.

### Properties and models

A property state contains `wireName`, `type`, `required`, `nullable`, and
`visibility` (`read`, `create`, and/or `update`). `required` is a boolean when
uniform, or an object keyed by applicable lifecycle when requiredness differs.
In the latter case, provide an explicit boolean for every visible lifecycle.
Missing and null are different: optional does not imply nullable.

Use plain wire-oriented types such as `string`, `boolean`, `int32`, `int64`,
`string[]`, or a named model/enum. Define new named dependencies as separate
model/enum additions; reuse existing public types when their contract matches.
Do not use private CLR type names or TypeSpec decorator expressions.

Optional `description`, `constraints`, and `default` convey public semantics.
Include a default only when explicitly established, not a language runtime's
zero value. Use `default` only for an unconditional default in that property's
context. Describe defaults depending on another field, rule type, or state in
`description`, without a misleading constant `default`.

Constraints support lengths, patterns, item counts, `uniqueItems`, numeric
bounds, `multipleOf`, and wire `format`; put conditional invariants in
`description` when they cannot be represented by these fields. Explicitly
describe omitted/null/empty behavior when it changes the contract. For example,
PATCH omission can preserve a value while explicit null clears it, and an
omitted array can select service defaults while an empty array is rejected.

A model state contains its complete `properties` array, plus an optional
`baseModel` and `description`. List only properties declared by that model;
inherited properties belong to the named base model. Model additions include
their properties inline, not duplicate property-addition entries.

An enum state contains a scalar `type`, `extensible`, and complete wire
`values`. Wire values are not implementation identifiers. Enum modifications
carry the complete old/new states so removals and extensions are unambiguous.

### Operations

An operation state contains `method`, `path`, `parameters`, `requestBodyType`,
`responses`, and `longRunning`. Use `void` when there is no body. Parameters
record `wireName`, `location` (`path`, `query`, or `header`), `type`, and
`required`; path parameters must be required.

Responses list `statusCodes`, `bodyType`, and optional public `headers`.
Optional `errorCodes` lists contract-relevant wire error codes, not every
internal exception. Use `paging.itemName` and `paging.nextLinkName` when
pagination is established.

For `longRunning: true`, include `pollingHeaders` and `finalResponseType`.
These describe observed/agreed behavior, not assumptions from the HTTP method
or recommended ARM defaults. Synchronous operations must not carry LRO fields.

## Examples and checks

The [property delta](../examples/property-delta.yaml),
[versioned visibility](../examples/versioned-visibility.yaml),
[multi-model property](../examples/multi-model-property.yaml),
[new operation](../examples/operation-addition.yaml), and
[no public changes](../examples/no-public-changes.yaml) examples are synthetic.
They do not declare real Storage APIs or encode private historical PRs.
The [blocking disagreement case](srp-investigation.md#blocking-disagreement-do-not-produce-yaml)
deliberately has no output manifest until its contract questions are resolved.

From the repository root:

```powershell
node .github\skills\storage-rp-to-typespec\scripts\validate-manifest.ts "<yaml-path>"
```

Run the standalone checks from `.github\skills\storage-rp-to-typespec`, as with
the other skill-local Vitest suites:

```powershell
node ..\..\..\node_modules\vitest\vitest.mjs run --config vitest.config.ts
```

The checker validates YAML syntax, schema shape, version-scoped change
uniqueness, and lifecycle requiredness. It cannot establish semantic fidelity
to SRP, API design approval, or whether a named public type exists. Those remain
the investigation/review gate and the later authoring skill's responsibilities.

For a later authoring request, supply the file and explicitly ask
`azure-typespec-author` to apply it to the recorded branch. The authoring skill
still performs its own grounding, planning, and validation; this manifest does
not bypass that workflow.
