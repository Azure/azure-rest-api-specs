# Microsoft.NetworkSecurity NeuroShield

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.NetworkSecurity NeuroShield management service.

## Getting Started

To build the SDKs for Microsoft.NetworkSecurity NeuroShield, install AutoRest via `npm` and run:

> `autorest readme.md`

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-06-01-preview
```

### Tag: package-2026-06-01-preview

These settings apply when `--tag=package-2026-06-01-preview` is specified.

```yaml $(tag) == 'package-2026-06-01-preview'
input-file:
  - preview/2026-06-01-preview/neuroShield.json
suppressions:
  - code: XmsResourceInPutResponse
    from: neuroShield.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}"].put
    reason: TypeSpec models these responses with the standard TrackedResource and ProxyResource templates from ARM common-types v6. The legacy validator does not recognize that external common-types inheritance as an ARM resource hierarchy.
  - code: RequiredPropertiesMissingInResourceModel
    from: neuroShield.json
    where:
      - $.definitions.NeuroShieldResource
      - $.definitions.NeuroShieldProtectedResource
    reason: The required read-only id, name, and type properties are inherited from the standard TrackedResource and ProxyResource definitions in ARM common-types v6. The legacy validator does not traverse this external allOf hierarchy.
  - code: AvoidNestedProperties
    from: neuroShield.json
    where:
      - $.definitions.NeuroShieldFinding.properties.properties
      - $.definitions.NeuroShieldMitigation.properties.properties
      - $.definitions.NeuroShieldPatch.properties.properties
      - $.definitions.NeuroShieldProtectedResource.properties.properties
      - $.definitions.NeuroShieldResource.properties.properties
    reason: These are the standard ARM resource properties envelopes emitted by TypeSpec. Adding legacy x-ms-client-flatten metadata would alter generated SDK shapes and is not required for the wire contract.
  - code: ValidFormats
    from: neuroShield.json
    where:
      - $.definitions.NeuroShieldMitigationProperties.properties.findingId.format
      - $.definitions.NeuroShieldProtectedResourceProperties.properties.targetResourceId.format
    reason: arm-id is the current TypeSpec ARM resource identifier format. The legacy validator predates this standard format.
  - code: RequiredReadOnlyProperties
    from: neuroShield.json
    where: $.definitions.NeuroShieldMitigationProperties.properties.findingId
    reason: findingId is a required service-generated association in this response-only mitigation model. Making it optional would weaken the response contract solely to satisfy a legacy SDK rule.
  - code: EnumInsteadOfBoolean
    from: neuroShield.json
    where: $.definitions.NeuroShieldMitigationProperties.properties.isRollbackable
    reason: isRollbackable is a genuinely binary capability flag with no meaningful third state. A string enum would add no semantic value.
  - code: EnumInsteadOfBoolean
    from: neuroShield.json
    where: $.definitions.NeuroShieldInventoryUploadRequestResult.properties.deduplicated
    reason: deduplicated reports whether the service reused an existing request and is inherently a binary result. A string enum would add no semantic value.
  - code: XmsPageableForListCalls
    from: neuroShield.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/summary"].get
    reason: The summary endpoint returns one aggregate snapshot for a single NeuroShield resource, not a collection, so pagination does not apply.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: neuroShield.json
    reason: The summary endpoint returns one aggregate snapshot for a single NeuroShield resource. The legacy validator incorrectly classifies it as a collection GET.
  - code: RequiredPropertiesMissingInResourceModel
    from: neuroShield.json
    where: $.definitions.NeuroShieldFleetSummary
    reason: NeuroShieldFleetSummary is an aggregate action result, not an ARM resource. It therefore must not expose the resource id, name, and type envelope.
  - code: ListInOperationName
    from: neuroShield.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/findings/{findingId}/mitigate"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/protectedResources/{protectedResourceName}/findings/{findingId}/rollback"].post
    reason: These are state-changing actions whose response reports all affected mitigations. Naming them as list operations would misrepresent their behavior.
  - code: ParameterNotDefinedInGlobalParameters
    from: neuroShield.json
    where: $.parameters
    reason: TypeSpec references the standard SubscriptionIdParameter and ApiVersionParameter definitions from ARM common-types v6 instead of duplicating them in the local global parameters object. The legacy validator does not recognize those external parameter references.
```
