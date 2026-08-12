# Synapse

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Synapse Analytics.

## Configuration

### Basic Information

```yaml
description: Azure Synapse Analytics Management Client
openapi-type: arm
azure-arm: true
tag: package-2021-06-01-preview
```

### Tag: package-2021-06-01-preview

These settings apply only when `--tag=package-2021-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-06-01-preview'
input-file:
  - preview/2021-06-01-preview/openapi.json
suppressions:
  - code: AllProxyResourcesShouldHaveDelete
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: AllTrackedResourcesMustHaveDelete
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ArmResourcePropertiesBag
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: AvoidAdditionalProperties
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: AvoidAnonymousTypes
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: BodyTopLevelProperties
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ConsistentPatchProperties
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: DeleteResponseBodyEmpty
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: DeleteResponseCodes
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: EnumInsteadOfBoolean
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: EvenSegmentedPathForPutOperation
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: GetCollectionOnlyHasValueAndNextLink
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: GetResponseCodes
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: GuidUsage
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ImplementPrivateEndpointAPIs
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: LatestVersionOfCommonTypesMustBeUsed
    reason: The TypeSpec ARM LocationParameter currently references common types v5.
  - code: ListInOperationName
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: LocationMustHaveXmsMutability
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: LroLocationHeader
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: NestedResourcesMustHaveListOperation
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: OperationIdNounConflictingModelNames
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PageableOperation
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ParameterDescription
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ParameterNotUsingCommonTypes
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PatchBodyParametersSchema
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PatchResponseCodes
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PathForNestedResource
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PathForResourceAction
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PostOperationIdContainsUrlVerb
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PostResponseCodes
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PreviewVersionOverOneYear
    reason: The TypeSpec project preserves the existing 2021-06-01-preview API version.
  - code: PrivateEndpointResourceSchemaValidation
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ProvisioningStateMustBeReadOnly
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ProvisioningStateSpecifiedForLROPatch
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ProvisioningStateValidation
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PutGetPatchResponseSchema
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PutInOperationName
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PutRequestResponseSchemeArm
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: PutResponseCodes
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: RepeatedPathInfo
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: RequiredPropertiesMissingInResourceModel
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ResourceNameRestriction
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: ResponseSchemaSpecifiedForSuccessStatusCode
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: SchemaDescriptionOrTitle
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: TrackedResourceBeyondsThirdLevel
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: TrackedResourcePatchOperation
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: TrackedResourcesMustHavePut
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: UniqueXmsExample
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: UnSupportedPatchProperties
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: XmsIdentifierValidation
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
  - code: XmsPageableForListCalls
    reason: Existing API behavior preserved during the Swagger-to-TypeSpec migration.
```
