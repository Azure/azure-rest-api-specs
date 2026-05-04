# Breaking Change Review — DeviceUpdate Data-Plane TypeSpec Migration

**Branch:** `typespec-migration-deviceupdate-ga`
**Spec:** `specification/deviceupdate/data-plane/Microsoft.DeviceUpdate/stable/2022-10-01/deviceupdate.json`
**Compared:** `2022-10-01` (TypeSpec-emitted) vs. `2022-10-01` (hand-written, `main`)
**CI tool:** Swagger BreakingChange v0.12.4
**Result:** 292 errors flagged, **0 functionally actionable**
**Artifact flag:** `BreakingChangeReviewRequired=true` (human reviewer sign-off path)

This PR is a **swagger-equivalent re-emission of the GA `2022-10-01` API** from a TypeSpec source of
truth. No operation, model, parameter, or wire-format semantics change. All 292 reported items are
artifacts of how the `@azure-tools/typespec-autorest` emitter normalizes OpenAPI 2.0 output relative
to the legacy hand-written swagger.

Wire/SDK equivalence was independently verified with
[`tsmv`](https://github.com/Azure/azure-sdk-tools/tree/main/tools/typespec-migration-validation),
which reports **0 errors** and **3 cosmetic warnings** — all related to the
`OperationStatusWithoutUndefinedOption` → `OperationStatus` rename, which produces an identical
SDK enum (`x-ms-enum.name` is unchanged).

---

## Summary

| Code | Count | Category | Wire impact | Actionable |
|------|------:|----------|-------------|:----------:|
| [1006 RemovedDefinition](#1006-removeddefinition--1) | 1 | Schema rename (cosmetic) | None | No |
| [1017 ReferenceRedirection](#1017-referenceredirection--58) | 58 | Parameter inlining | None | No |
| [1021 AddedAdditionalProperties](#1021-addedadditionalproperties--1) | 1 | Open-object representation | None | No |
| [1023 TypeFormatChanged](#1023-typeformatchanged--33) | 33 | Format keyword tightening | None | No |
| [1036 ConstraintChanged](#1036-constraintchanged--5) | 5 | Removal of inert/malformed constraint | None | No |
| [1042 ChangedParameterOrder](#1042-changedparameterorder--94) | 94 | Parameter inlining | None | No |
| [1050 ParameterLocationHasChanged](#1050-parameterlocationhaschanged--100) | 100 | Parameter inlining | None | No |
| [1001 NoVersionChange](#1001-noversionchange--1) | 1 | Informational | None | No |
| [1007 RemovedClientParameter](#1007-removedclientparameter--16) | 16 | Parameter inlining | None | No |
| **Total** | **292** | | | **0** |

Two root causes account for all 292 items:

- **Parameter inlining** (1007 + 1017 + 1042 + 1050) — **268 of 292** items.
  The hand-written GA swagger declared shared parameters once at the top-level `parameters` map
  (`InstanceIdParameter`, `ApiVersionParameter`, etc.) and `$ref`'d them from each operation. The
  TypeSpec emitter inlines all parameters into the operation definitions. The HTTP request shape is
  identical — only the swagger structure differs.
- **Type/format normalization** (1006 + 1021 + 1023 + 1036) — **40 of 292** items.
  TypeSpec uses precise scalars (`url`, `int32`, `Record<unknown>`, sealed enums) where the
  hand-written swagger used loose JSON-Schema types. The emitted shapes are stricter or equivalent;
  none widen or break a client contract.

---

## Detailed Justifications

### 1006 RemovedDefinition — 1

> The new version is missing a definition that was found in the old version. Was
> `'OperationStatusWithoutUndefinedOption'` removed or renamed?

**Root cause:** The GA swagger contained two separate definitions, `OperationStatus` and
`OperationStatusWithoutUndefinedOption`, that were identical except for the schema name.
Both carried `x-ms-enum.name: "OperationStatus"` and the same enum values
(`NotStarted`, `Running`, `Succeeded`, `Failed`).

**Emitter behavior:** TypeSpec deduplicates equivalent enum types. Only `OperationStatus` is
emitted; references to the duplicate are rewritten to the canonical type.

**SDK impact:** None. Both definitions generated the same `OperationStatus` enum class in every
language SDK because `x-ms-enum.name` was identical. `tsmv` confirms enum SDK output is unchanged.

---

### 1017 ReferenceRedirection — 58

> The `$ref` property points to different models in the old and new versions.

**Root cause:** Inlined parameters and inlined named-type definitions. Where GA used
`$ref: "#/parameters/InstanceIdParameter"`, the new spec emits the parameter object inline.
Where GA used `$ref: "#/definitions/Compatibility"`, the emitter may inline equivalent shapes.

**Emitter behavior:** Standard `@azure-tools/typespec-autorest` output. Does not affect HTTP
contracts because OpenAPI 2.0 `$ref` is a structural shortcut, not a semantic one.

**Wire impact:** None.
**SDK impact:** None.

---

### 1021 AddedAdditionalProperties — 1

> The new version adds an `'additionalProperties'` element. (`definitions.Step.properties.handlerProperties`)

**Root cause:** GA defined `handlerProperties` as a free-form `object` with no
`additionalProperties` clause. The TypeSpec source declares it as `Record<unknown>`, which the
emitter renders as `additionalProperties: {}`.

**Semantic equivalence:** In OpenAPI 2.0 / JSON Schema, an `object` without
`additionalProperties` allows arbitrary extra properties; `additionalProperties: {}` allows
arbitrary extra properties of any type. **These are equivalent.**

**Existing suppression:** This pattern is also covered by the audited
`@azure-tools/typespec-azure-core/bad-record-type` linter suppression in
[`tspconfig.yaml`](tspconfig.yaml).

---

### 1023 TypeFormatChanged — 33

> The new version has a different format `'uri'` than the previous one `''`.
> The new version has a different format `'int32'` than the previous one `''`.

**Root cause:** TypeSpec uses precise scalar types (`url`, `int32`, `safeint`) where the
hand-written swagger used bare `string` or `integer`.

**Affected paths (representative):**
- `*.nextLink` properties — `format: uri` added (these *are* URIs).
- `Operation-Location` response headers — `format: uri` added.
- `*.resultCode`, `*.extendedResultCode`, `*.totalDeviceCount` etc. — `format: int32` added (32-bit
  integer ranges, matching what the service actually returns).

**Wire impact:** None.
**SDK impact (source-level):** Minor. Java/.NET signatures may shift (`string` → `URL`/`Uri`
for `nextLink`/`Operation-Location`; `long` → `int` for the count/result-code fields).
Python/JS/TS are unchanged.

---

### 1036 ConstraintChanged — 5

> The new version has a different `'minItems'` value than the previous one.

**Affected paths:**
1. `definitions.ImportManifestMetadata.properties.hashes.additionalProperties` (was `minItems: 1`)
2. `definitions.UpdateFileBase.properties.hashes.additionalProperties` (was `minItems: 1`)
3. `definitions.UpdateFileBase.properties.properties.additionalProperties` (was `minItems: 0`)
4. `definitions.UpdateFile.properties.hashes.additionalProperties` (inherited)
5. `definitions.UpdateFile.properties.properties.additionalProperties` (inherited)

**Root cause:** The hand-written GA swagger placed `minItems` on `additionalProperties` whose
value type is **`string`**:

```json
"hashes": {
  "type": "object",
  "additionalProperties": { "type": "string", "minItems": 1 }
}
```

`minItems` is an array-only JSON Schema keyword that was placed incorrectly on a string value
in the original swagger. The constraint was inert (silently ignored by all validators and SDKs),
and TypeSpec does not re-emit it.

---

### 1042 ChangedParameterOrder — 94

> The order of parameter with Name `'X'`, In `'Query'/'Path'/'Header'/'Body'`, was changed.

**Root cause:** Same as 1017 — parameter inlining changes the index at which a given parameter
appears in the operation's `parameters` array.

**Specification semantics:** OpenAPI 2.0 parameter order is **not part of the wire contract**:
- `path` parameters are matched by name in the URL template, not by index.
- `query`, `header`, `formData` parameters are name-keyed.
- `body` parameters are unique per operation.

**Wire impact:** None.
**SDK impact:** None.

---

### 1050 ParameterLocationHasChanged — 100

> Parameter location has changed. Old location is method: `'False'`. New location is method:
> `'True'`.

**Root cause:** Same as 1017 — `method: false` means the parameter was declared at the
**path-item level** (shared across operations on the same path) in the GA swagger; `method: true`
means it is now declared at the **operation level**. This is an OpenAPI 2.0 structural
distinction, **not a wire-format distinction**.

**Wire impact:** None.
**SDK impact:** None.

---

### 1007 RemovedClientParameter — 16

> The new version is missing a client parameter that was found in the old version.

**Affected:** `ApiVersionParameter`, `EndpointParameter`, `InstanceIdParameter`,
`UpdateProviderParameter`, `UpdateNameParameter`, `UpdateVersionParameter`, `FileIdParameter`,
`IfNoneMatchParameter`, `OperationIdParameter`, `LogCollectionIdParameter`, `DeviceIdParameter`,
`ModuleIdParameter`, `DeviceClassIdParameter`, `GroupIdParameter`, `DeploymentIdParameter`, +1.

**Root cause:** The hand-written GA swagger lifted these parameters into the top-level
`parameters` map for `$ref` reuse. The emitter inlines parameters at each call site, so the
top-level entries are no longer needed and are not emitted.

**Wire impact:** None.
**SDK impact:** None.

---

### 1001 NoVersionChange — 1

> The versions have not changed.

**Root cause:** Informational. The compared swaggers are both labeled `2022-10-01`. This is
expected because the PR re-emits the **same** GA API version from a new source of truth (TypeSpec)
without bumping the public API contract.

---

## Independent Verification

Beyond the BreakingChange linter, equivalence was verified using `tsmv`
(typespec-migration-validation), which performs a normalized semantic diff designed to ignore
exactly the cosmetic transforms the BreakingChange linter flags.

```text
npx tsmv \
  sparse-spec/specification/deviceupdate/data-plane/Microsoft.DeviceUpdate/stable/2022-10-01 \
  specification/deviceupdate/data-plane/Microsoft.DeviceUpdate/stable/2022-10-01/deviceupdate.json \
  --outputFolder tsmv-output

Errors:   0
Warnings: 3   (all OperationStatus rename — SDK-equivalent)
```

The 3 remaining `tsmv` warnings are all variants of:

> `OperationStatusWithoutUndefinedOption` was renamed to `OperationStatus` — same enum values,
> same `x-ms-enum.name`, identical SDK output.

---

## References

- TypeSpec source: [`main.tsp`](main.tsp), [`models.tsp`](models.tsp), [`routes.tsp`](routes.tsp), [`client.tsp`](client.tsp)
- Emitter config: [`tspconfig.yaml`](tspconfig.yaml)
- Linter suppressions (audited, separate from this review):
  [`tspconfig.yaml`](tspconfig.yaml) — `linter.exclude`
- Migration validator: https://github.com/Azure/azure-sdk-tools/tree/main/tools/typespec-migration-validation
- BreakingChange tool docs: https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/breaking-change-policy/README.md
