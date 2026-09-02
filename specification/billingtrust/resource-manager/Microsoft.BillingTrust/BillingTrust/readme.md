# BillingTrust

> see https://aka.ms/autorest

This is the AutoRest configuration file for BillingTrust.

## Configuration

### Basic Information

This is a TypeSpec project so we only want to readme to default the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2026-03-17
```

### Tag: package-preview-2026-03-17

These settings apply only when `--tag=package-preview-2026-03-17` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-03-17'
input-file:
  - preview/2026-03-17-preview/openapi.json

directive:
  - suppress: ConsistentPatchProperties
    from:
      - openapi.json
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.BillingTrust/assessments/default/rules/{ruleName}"].patch.parameters[3].schema
    reason: |
      By design: this RP exposes Rules as polymorphic on `kind`, with the
      same polymorphism on the PATCH body. PATCH cannot change a rule's
      `kind`; the discriminator carries the rule's existing kind for routing
      to the kind-specific patchable subtype. Per-kind patchable fields live
      on the discriminated subtypes (e.g. `EduQualificationRulePatchProperties`,
      `BusinessVerificationRulePatchProperties`) — placing them on the base
      `RulePatchProperties` would force every kind to carry every other
      kind's fields. The runtime PATCH controller enforces both the kind
      match and the field-state preconditions at the service level. The
      `ConsistentPatchProperties` linter compares PATCH fields to the base
      `RuleProperties` and cannot reason about discriminated subtypes —
      this suppression documents the deliberate ARM design.

  - suppress: PatchBodyParametersSchema
    from:
      - openapi.json
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.BillingTrust/assessments/default/rules/{ruleName}"].patch.parameters[3].schema
    reason: |
      By design: `kind` is the polymorphic discriminator on
      `RulePatchProperties`. It must be `required` so the OpenAPI deserializer
      and SDK clients can dispatch to the correct kind-specific patchable
      subtype (`EduQualificationRulePatchProperties` or
      `BusinessVerificationRulePatchProperties`). `kind` is metadata for
      routing, NOT a patchable value: the controller rejects any PATCH whose
      body kind does not match the existing rule's kind with 400
      InvalidRequestContent. RPC-Patch-V1-10 ("PATCH body properties must
      not be required") protects callers from being forced to re-supply
      patchable field values they don't want to change — that concern does
      not apply to a discriminator that is, by construction, the rule's
      already-existing immutable kind. This is the canonical pattern for
      ARM polymorphic-PATCH resources.

  - suppress: GuidUsage
    from:
      - openapi.json
    where:
      - $.definitions["Azure.Core.uuid"].format
    reason: |
      The `tenantId` field on `DomainEntry` references a Microsoft Entra
      tenant identifier, which is a UUID/GUID by definition. Microsoft Entra
      IDs are universally GUID-formatted across Azure and matching the
      `format: uuid` schema is required for SDK type generation, schema
      validation, and consistency with other Azure RP specs that reference
      Entra tenant IDs (e.g. Microsoft.ManagedIdentity, Microsoft.Authorization).

  - suppress: WriteOnlyProperties
    from:
      - openapi.json
    where:
      - $.definitions.AssessmentProperties.properties.initialValues
    reason: |
      `initialValues` is an intentional transient seed parameter forwarded by
      the parent RP at assessment creation. The values are forwarded to the
      per-kind rule resources and are NOT persisted on the assessment itself,
      so they cannot be returned on Read. The rules themselves expose the
      read-side projection of these seeds (for example,
      `EduQualificationRuleProperties.domains` is the readable projection of
      the eduQualification seed). This is the ARM-recommended pattern for
      "create-only seed" inputs and is mirrored by the
      `x-ms-mutability: ["create"]` annotation in the schema. A round-trip
      (GET → PUT) re-issued with the same `initialValues` after the assessment
      exists is a no-op on the rules (already instantiated); a round-trip
      with a different seed that would re-seed existing rules is rejected
      with 409 Conflict — so the absence of `initialValues` in the GET
      response cannot cause What-If false drift.
```

---
