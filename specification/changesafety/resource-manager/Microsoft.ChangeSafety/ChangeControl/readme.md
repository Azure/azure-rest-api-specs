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
  operations retained.
- Uses one URL per Link entry, complete optional parameter PATCH fields, canonical
  management-group paths, and native ARM identifiers.
- Declares no stable identity for Link array items. Link names are not required
  to be unique.
- Uses explicit JSON dictionaries for opaque object values so generated clients
  preserve their contents.
- Uses kind-specific ApiOperations and Targets schemas for change definitions,
  including partial details for PATCH requests. PATCH preserves the stored kind;
  changing kind requires PUT.
- Stores only the method and URI of each planned operation. Full target-provider
  bodies belong only to the transient `verifyChangeValidity` request.
- Separates read-only observed `status` from client-owned `requestedStatus`.
  Automatic status updates preserve the client's last request.
- Replaces the untyped snapshot union with `StageMapSnapshot` entries containing
  `resourceId` and optional captured StageMap properties.
- Proposes typed AcquirePolicyToken and PolicyEvaluation payloads for their
  `2026-01-01` event schema version. Service owners must confirm field coverage and
  requiredness; these illustrative examples are not production captures.

Next-stage planning uses GET at both existing `retrieveNextStages` paths.
It reads the ChangeRecord, snapshots, and progressions without advancing them.
The November backend and ProviderHub registrations must expose these GET routes
before publication. No latency-based POST exception is claimed.

`requestedStatus` is persisted and echoed, not an alias for the current status.
Create accepts `Initialized` or `InProgress`. Updates apply the existing transition
and completion checks. A valid repeated request can reassert a pause after the
observed status changes. An identical stored request that has been superseded is
acknowledged without moving the observed status backward. A new invalid request
is rejected. PATCH omission preserves the request. PUT omission removes the
request without resetting the observed status.

The following work is required before publication. These are implementation and
owner gates, not guarantees provided by a schema build.

| Area                      | Required task                                                                                                                                                                                              |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Stored operations         | Reject `changeDefinition.details.operations[].body` on November writes. Persist only method and URI. Keep full bodies transient in verification.                                                           |
| Shared records            | Add version-aware reads so November never exposes bodies stored through January. Keep January responses unchanged. The service owner must decide existing-body retention and cross-version status mapping. |
| Status ownership          | Persist `requestedStatus` and accepted observed-status changes atomically. Preserve client fields during StageProgression cascades. Implement repeated-request, omission, and transition rules.            |
| PATCH                     | Apply merge-patch semantics, replace supplied arrays, reject cross-kind details, and require PUT for kind changes.                                                                                         |
| Routing and authorization | Register the November version and both next-stage GET routes in ProviderHub. Confirm their permission names and cross-scope snapshot authorization.                                                        |
| Resource serialization    | Implement event reads, properties-only snapshots, and typed event payloads. Confirm event-version field coverage, supported parent scopes, and actual asynchronous DELETE headers.                         |
| Review and release        | Obtain current ARM exception approval, package-name approvals, Python namespace reservation, and release-owner confirmation of backend availability.                                                       |

JavaScript uses modular TypeSpec generation for the required SDK validation.
Other language-emitter migrations remain deferred. Their retained readiness
exemptions apply only to configuration validation and do not waive
`SDK Validation Status`. Python package-name onboarding remains a release gate.

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
  - suppress: AvoidAdditionalProperties
    reason: |
      These property-scoped exceptions preserve customer-defined parameters, stage variables, and orchestration metadata. Values are defined by the parameter or by the orchestrator. Current ARM review is required.
    from: ChangeControl.json
    where:
      - $.definitions.Parameter.properties.metadata
      - $.definitions.ObjectParameter.properties.defaultValue
      - $.definitions.ObjectParameter.properties.allowedValues.items
      - $.definitions.StageMapProperties.properties.parameters
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
      PATCH retains customer-defined parameters, metadata, and orchestration JSON. Unspecified fields remain omitted. Each property-scoped exception requires current ARM review.
    from: ChangeControl.json
    where:
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
[tspconfig.yaml](./tspconfig.yaml).

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
