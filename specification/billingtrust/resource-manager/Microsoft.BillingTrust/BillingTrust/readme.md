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
tag: package-preview-2026-08-10
```

### Tag: package-preview-2026-08-10

These settings apply only when `--tag=package-preview-2026-08-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-08-10'
input-file:
  - preview/2026-08-10-preview/openapi.json

directive:
  - suppress: ConsistentPatchProperties
    from:
      - openapi.json
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.BillingTrust/assessments/{assessmentName}/rules/{ruleName}"].patch.parameters[4].schema
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

  - suppress: ConsistentPatchProperties
    from:
      - openapi.json
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.BillingTrust/assessments/{assessmentName}"].patch.parameters[3].schema
    reason: |
      By design: `draft` is a customer-writable overlay property, set only via
      this dedicated assessment PATCH and returned on read exclusively under
      `?$expandCustomerData=true` (the ARG002 PII overlay — No Customer Data in
      Control Plane Properties). It is modeled as a flat custom PATCH body
      (`AssessmentUpdateProperties`) whose single writable field is annotated
      `x-ms-mutability: ["read","update"]`, mirroring the per-resource
      custom-PATCH shape already used for Rules (see the `ConsistentPatchProperties`
      suppression above). The linter compares the flat custom-PATCH body's
      top-level fields against the resource's `properties` envelope and reports
      `draft` at the "wrong level"; the field is in fact the assessment's
      `properties.draft`, overlaid from service state on read and kept out of the
      Resource Graph / ARN projection. The runtime PATCH controller enforces the
      field and state preconditions at the service level.

  - suppress: PatchBodyParametersSchema
    from:
      - openapi.json
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.BillingTrust/assessments/{assessmentName}/rules/{ruleName}"].patch.parameters[4].schema
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
      the parent resource provider at assessment creation. The values are forwarded to the
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

  - suppress: ParametersInPointGet
    from:
      - openapi.json
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.BillingTrust/assessments/{assessmentName}/rules/{ruleName}"].get.parameters
    reason: |
      By design: the optional `$expandCustomerData` query parameter is an
      overlay for control-plane PII (ARG002 — No
      Customer Data in Control Plane Properties). Customer-supplied rule
      data (the `businessVerification` sold-to identity and tax ids, the
      `eduQualification` domains) is omitted from the default rule read
      response so it is not included in the published resource body, and is returned only when an
      authorized caller explicitly opts in via `?$expandCustomerData=true`.
      This overlay satisfies the ARG002 guideline. The sibling commerce RP
      Microsoft.BillingBenefits uses the same approach and suppresses
      `ParametersInPointGet` for its `$expand` point-GET overlays
      (`savingsPlanOrders/{id}`, `savingsPlans/{id}`). RPC-Get-V1-08
      discourages query parameters on point GETs to preserve URL-determinism;
      here the parameter is a read-only, side-effect-free projection toggle
      that does not change the resource identity, so the URL still uniquely
      identifies the rule.

  - suppress: ParametersInPointGet
    from:
      - openapi.json
    where:
      - $.paths["/{resourceUri}/providers/Microsoft.BillingTrust/assessments/{assessmentName}"].get.parameters
    reason: |
      By design: the optional `$expandCustomerData` query parameter is the same
      ARG002 PII overlay applied to the rule point-GET
      (see the `ParametersInPointGet` suppression above). Customer data on the
      assessment (for example the `eduQualification` domain names within
      `initialValues`) is omitted from the default
      read so it is not included in the published resource body, and is returned only when an
      authorized caller opts in via `?$expandCustomerData=true`. The parameter
      is a read-only, side-effect-free projection toggle that does not change
      the resource identity, so the point-GET URL still uniquely identifies the
      assessment. Peer precedent: Microsoft.BillingBenefits `$expand` point-GET
      overlays.
```

---
