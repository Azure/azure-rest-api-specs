# ChangeSafety

> see https://aka.ms/autorest

This is the AutoRest configuration file for ChangeSafety.

## November preview draft

This project proposes `2026-11-01-preview` only. It is independent of the
[current-version publication PR](https://github.com/Azure/azure-rest-api-specs/pull/47463)
and does not change `2026-01-01-preview`, deploy a backend, or release an SDK.

- Retains StageMaps, ChangeRecords and their StageProgressions, ChangeActivityEvents,
  provider Operations, and change-validity verification.
- Omits the entire ChangeState resource family, `retrieveAllStages`, and
  `retrieveAuditTrail`: 34 current-version operations are excluded, with 42
  operations retained before the next-stage design decision.
- Uses one URL per Link entry, complete optional parameter PATCH fields, canonical
  management-group paths, and native ARM identifiers.
- Uses explicit JSON dictionaries for free-form object values so generated clients
  preserve their contents instead of serializing them as empty models.
- Replaces the untyped snapshot union with `StageMapSnapshot` entries containing
  `resourceId` and optional captured `stageMap` contents.
- Proposes typed AcquirePolicyToken and PolicyEvaluation payloads for their
  `2026-01-01` event schema version. Service owners must confirm field coverage and
  requiredness; these illustrative examples are not production captures.

The existing synchronous `retrieveNextStages` POST is retained provisionally.
Its replacement with a computed GET or a justified asynchronous POST remains an
explicit ARM/backend design decision; this draft does not claim an approved
POST-retrieval exception.

**Release gates:** backend support for event reads, PATCH merge behavior, typed
snapshot/event serialization, version-specific resource/action registration,
consumer migration, current ARM/suppression approvals, and SDK package onboarding.
Do not treat passing schema or SDK generation checks as deployed runtime support.

## Getting Started

To build the SDKs for ChangeSafety, install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the settings for the ChangeControl.

```yaml
openapi-type: arm
tag: package-2026-11-01-preview
openapi-subtype: providerHub
```

### Tag: package-2026-11-01-preview

These settings apply only when `--tag=package-2026-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-11-01-preview'
input-file:
  - preview/2026-11-01-preview/ChangeControl.json
directive:
  - suppress: AvoidAdditionalProperties
    from: ChangeControl.json
    where: $.definitions.ArmResourceOperation.properties.body
    reason: |
      VCV carries ARM deployment engine-generated request bodies unchanged. Their fields and value types are defined by the target resource provider and API version, not by ChangeSafety. This scoped exception requires ARM API review approval.
```

---

## Suppression

```yaml
directive:
  - suppress: AvoidAdditionalProperties
    reason: |
      These property-scoped exceptions preserve customer-defined parameter, metadata, and stage-variable keys, or flexible orchestration/change-definition payloads. They require current ARM review; no historical approval is claimed for this draft.
    from: ChangeControl.json
    where:
      - $.definitions.Parameter.properties.metadata
      - $.definitions.ObjectParameter.properties.defaultValue
      - $.definitions.ObjectParameter.properties.allowedValues.items
      - $.definitions.StageMapProperties.properties.parameters
      - $.definitions.ChangeDefinition.properties.details
      - $.definitions.Stage.properties.stageVariables
      - $.definitions.NestedStageMap.properties.parameters
      - $.definitions.ChangeRecordProperties.properties.parameters
      - $.definitions.ChangeRecordProperties.properties.additionalData
      - $.definitions.ChangeRecordStageProgressionProperties.properties.stageVariables
      - $.definitions.ChangeRecordStageProgressionUpdateProperties.properties.stageVariables
      - $.definitions.ChangeRecordStageProgressionProperties.properties.additionalData
      - $.definitions.ChangeRecordStageProgressionUpdateProperties.properties.additionalData
      - $.definitions.ChangeRecordStageProgressionProperties.properties.parameters
      - $.definitions.ChangeRecordStageProgressionUpdateProperties.properties.parameters
      - $.definitions.ChangeRecordRetrieveNextStagesResponseItem.properties.stageVariables
      - $.definitions.ChangeRecordRetrieveNextStagesResponseItem.properties.additionalData
      - $.definitions.ChangeRecordRetrieveNextStagesResponseItem.properties.parameters
  - suppress: AvoidAdditionalProperties
    reason: |
      PATCH parameter names and metadata keys are customer-defined. Change-definition and orchestration metadata retain their existing flexible JSON shapes. These PATCH-only selectors require current ARM review and are not covered automatically by historical approval labels.
    from: ChangeControl.json
    where:
      - $.definitions.ChangeDefinitionPatch.properties.details
      - $.definitions.ChangeRecordUpdateProperties.properties.additionalData
      - $.definitions.ChangeRecordUpdateProperties.properties.parameters
      - $.definitions.ParameterPatch.properties.metadata
      - $.definitions.StageMapUpdateProperties.properties.parameters
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```

## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

TypeScript uses the modular `@azure-tools/typespec-ts` emitter configured in
[tspconfig.yaml](./tspconfig.yaml), not the retired AutoRest high-level client
generation path.

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
