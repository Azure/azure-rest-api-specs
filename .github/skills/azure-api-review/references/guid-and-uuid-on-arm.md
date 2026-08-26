<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-05-29
     Derived from:
       - @microsoft.azure/openapi-validator rule R3017 (GuidUsage)
       - LintDiff suppression entries across specification/**/readme.md
       - Azure REST API Guidelines: GUID/UUID usage on ARM control plane
     The upstream documents always take precedence if there is a conflict. -->

# GUID / UUID format on ARM specifications

> **Transition note (rule reversal -- 2026-05).** Earlier revisions of
> the ARM and OpenAPI review instructions recommended `format: uuid`
> (TypeSpec `uuid` scalar) for every GUID-valued property. That
> guidance has been **reversed** for ARM control-plane specs because it
> conflicts with the required `GuidUsage` LintDiff rule (`R3017`).
>
> - **In-flight PRs that already use `format: uuid`:** do **not** churn
>   the PR to remove it. Either keep the format and add the scoped
>   suppression described below (preferred when the property meets the
>   "acceptable" criteria), or drop the format in a follow-up cleanup
>   PR. The Reviewer agent will surface this as a **Suggestion**, not a
>   Blocking finding, on existing `format: uuid` properties.
> - **PRs already merged** are out of scope; do not retroactively
>   flag them.
> - **New properties going forward** must follow the new default
>   (keep `string` unless the property is on the acceptable allow-list
>   below).

## Summary

The instruction files recommend `format: uuid` (TypeSpec `uuid` scalar) for
properties that hold RFC 4122 GUIDs. On **ARM control-plane** specs this
conflicts with the required `GuidUsage` LintDiff rule (`R3017`):

> Usage of Guid is not recommended. If GUIDs are absolutely required in your
> service, please get sign-off from the Azure API review board.

The rule is a required CI check, so a recommendation that emits `format: uuid`
on an ARM spec without the accompanying suppression will block the PR.

## When `format: uuid` is acceptable on ARM (recommendation: keep)

Use `format: uuid` (or TypeSpec `uuid`) only when **all** of the following hold:

1. The property holds an **AAD / Microsoft Entra identifier** or another
   Azure-platform identifier that is documented to be a GUID and is widely
   understood as such. Examples:
   - `tenantId` (Entra tenant ID)
   - `clientId` of a Microsoft Entra application or managed identity
   - `principalId` / `objectId` of an Entra principal
   - `subscriptionId` (when surfaced as a body property, not a path parameter)
2. Customers already see and pass this value as a GUID through other Azure
   surfaces (portal, CLI, ARM templates).
3. The recommendation is paired with the **scoped** suppression below and the
   author has obtained (or commits to obtain) Azure API review board sign-off.

## When `format: uuid` is NOT acceptable on ARM (recommendation: do not introduce)

Do not recommend `format: uuid` for:

1. **Opaque platform-assigned identifiers** even when the current implementation
   happens to produce a GUID (e.g., service-generated correlation IDs, operation
   IDs, internal record IDs). These are contractually opaque; advertising a GUID
   format locks the service into a UUID forever and signals to clients that the
   format is parseable, which is rarely the intent.
2. **Resource-internal identifiers** assigned by the resource provider
   (e.g., `interconnectBlockId`, `maintenanceEventId`).
3. **Names** of any kind.

For these, keep `type: string` and convey the format via the property
description and optionally a `@pattern` constraint.

## Required suppression form when keeping `format: uuid`

The correct `where:` path depends on how the OpenAPI is produced. **Always
verify the suppression path against the actual LintDiff failure log** before
recommending it. Do not infer the path from the source property name.

> **Critical: `where:` must equal the LintDiff `jsonpath` exactly, segment for
> segment, including the trailing leaf segment (`.format`, `.type`,
> `.x-ms-secret`, etc.).** The validator does **not** treat the `where:` clause
> as an ancestor match. A `where:` that targets the parent object (for example
> `$.definitions["Azure.Core.uuid"]` when the violation is at
> `$.definitions["Azure.Core.uuid"].format`) silently does not match and the
> failure persists.

### Form A. TypeSpec-generated OpenAPI

The TypeSpec `uuid` scalar emits a single shared definition that every property
`$ref`s. LintDiff fires on the `format` leaf of that shared definition, not on
each property. The suppression must target the exact leaf:

```yaml
suppressions:
  - code: GuidUsage
    from: <openapi-file>.json
    where: $.definitions["Azure.Core.uuid"].format
    reason: >-
      Used only for <enumerate the relying properties, e.g.,
      DataEncryption.primaryFederatedIdentityClientId,
      DataEncryption.geoBackupFederatedIdentityClientId>. All are
      Microsoft Entra <client|tenant|principal> IDs (RFC 4122 UUIDs) per
      ARM identity guidelines. Approved by <reviewer GitHub handle>.
```

A single entry covers every property that uses the `uuid` scalar (they share
the definition). The `reason` MUST enumerate the relying properties so future
GUID misuse on unrelated properties is still visible at review time.

### Form B. Handwritten OpenAPI

When the property's schema is inlined (no shared definition), LintDiff fires at
the `format` leaf of the property. Use one entry per property, and include the
trailing `.format` segment:

```yaml
suppressions:
  - code: GuidUsage
    from: <openapi-file>.json
    where: $.definitions.<Model>.properties.<propertyName>.format
    reason: >-
      <Property> is a Microsoft Entra <client|tenant|principal> ID
      (RFC 4122 UUID) per ARM identity guidelines.
      Approved by <reviewer GitHub handle>.
```

### Common pitfalls (both forms)

1. **Ancestor `where:` does not match.** The `where:` clause is matched
   exactly against the validator's reported `jsonpath`. The trailing leaf
   segment (`.format` for `GuidUsage`) is mandatory.
2. **Per-property `where:` against TypeSpec output does not match.** Every
   property typed `uuid` resolves to a `$ref` to `Azure.Core.uuid`; LintDiff
   reports the violation on the shared definition, not on each `$ref` site.
   Use Form A for TypeSpec-generated specs.
3. **File-wide suppression (`where:` omitted) is over-broad.** It disables
   `GuidUsage` for the whole spec including future additions and will be
   flagged as a Blocking finding.
4. **`reason: Approved by Azure API review board pull request <N>` is
   circular.** The PR is what is being approved; cite the approving reviewer's
   GitHub handle (or a link to the approval comment / ADO work item).
5. **Leftover entries from earlier attempts.** A wrong-path suppression
   silently no-ops; it does not error. After fixing the path, delete the
   stale entries so the next reader is not misled into thinking they are
   load-bearing.

### Suppression review notes (both forms)

- The `reason` must name the specific identifier (e.g., "Microsoft Entra
  application client ID"), not just "GUID per ARM guidelines."
- A file-wide suppression (`where:` omitted) is a Blocking finding on its own.
  It disables `GuidUsage` for the whole spec, including future additions.
- Board sign-off must be cited in the `reason` (link to the approval comment,
  ADO work item, or reviewer GitHub handle).
- **Confirm the `where:` path from the actual LintDiff run log** before
  recommending it. The reported `jsonpath` is the authoritative location;
  guessing the suppression path from the source schema is a known failure mode
  and produces a suppression that silently does not match.

## How reviewer agents should phrase the recommendation

When an ARM spec property that meets the "acceptable" criteria above is typed as
plain `string`, the reviewer agent **MUST** present the change as a choice
between three options, not a directive:

> _Suggestion_ (not Warning): `<propertyName>` documents a GUID. Three options:
>
> 1. **Switch to `uuid` and add a scoped suppression.** Apply the correct
>    suppression form for this spec (see
>    [`guid-and-uuid-on-arm.md`](./guid-and-uuid-on-arm.md): Form A for
>    TypeSpec-generated specs, Form B for handwritten OpenAPI). Verify the
>    `where:` path against the actual LintDiff run output before posting.
>    After committing the suppression, re-run LintDiff and confirm `GuidUsage`
>    no longer fires before considering the fix settled. Delete any stale
>    per-property suppression entries left over from earlier attempts; a
>    wrong-path entry silently no-ops and misleads later readers into thinking
>    it is load-bearing.
> 2. **Keep `type: string`** and tighten the description (and optionally add a
>    `@pattern` constraint).
> 3. **ARM reviewer override** the `GuidUsage` check for this PR. The reviewer
>    may offer this when the property clearly meets the "acceptable" criteria
>    (Entra `clientId` / `tenantId` / `principalId`, etc.) and the author would
>    otherwise have to chase a separate board sign-off for an unambiguous case.

When the property does **not** meet the acceptable criteria (opaque platform
IDs, resource-internal IDs, names), the agent **MUST NOT** recommend
`format: uuid` at all.

## How reviewer agents must verify before recommending a suppression

1. **Identify the OpenAPI generator.** If the spec has `x-typespec-generated`
   at the top level, treat it as Form A. Otherwise treat it as Form B.
2. **Always read the actual LintDiff run log** when one is available on the PR.
   The `jsonpath` reported in the failure is the only authoritative location.
3. If no run log exists yet, label the suppression form as **provisional** in
   the recommendation and ask the author to confirm the path from the first
   failing run rather than committing it sight-unseen.
4. Never copy a suppression `where:` clause from a different RP's `readme.md`
   without confirming the generator matches.

## Source rule pointers

- ARM control-plane review rules:
  [`arm-api-review.instructions.md` §8.4](../../../instructions/arm-api-review.instructions.md)
- OpenAPI review rules:
  [`openapi-review.instructions.md` Types & Formats](../../../instructions/openapi-review.instructions.md)
- TypeSpec review rules:
  [`typespec-review.instructions.md` §2.2](../../../instructions/typespec-review.instructions.md)
- Linter rule coverage:
  [`linter-rule-coverage.md` R3017 row](./linter-rule-coverage.md)
