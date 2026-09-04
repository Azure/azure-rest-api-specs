<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-15
     Derived from:
       - @microsoft.azure/openapi-validator-rulesets v2.2.6
       - LintDiff test fixtures in eng/tools/lint-diff/
       - Suppression entries across specification/**/readme.md
     The upstream documents always take precedence if there is a conflict. -->

# Linter Rule Coverage Map

This reference maps linter rules that the Reviewer cites or must account for
when suggesting fixes. It is not an exhaustive substitute for the pinned
`@microsoft.azure/openapi-validator-rulesets` package; that package remains the
authoritative inventory. The goal is to cross-reference reviewer findings and
identify required CI rules whose behavior affects a suggested fix.

**How to use this file:**

- When the agent detects a violation, cite both the rule ID from the instruction
  file (e.g., `RPC-Put-V1-11`) and the linter rule ID (e.g., `PutResponseCodes`)
  if one exists.
- When reviewing CI linter failures, use this map to find the detailed guidance
  in the instruction files.
- Rules marked ❌ **GAP** need instruction file coverage added.

---

## Response Code & HTTP Method Rules

| Linter Rule ID | Name                         | Instruction Coverage                     | Status       |
| -------------- | ---------------------------- | ---------------------------------------- | ------------ |
| R4011          | DeleteOperationResponses     | arm-api-review §5.1 (RPC-Delete-V1-01)   | ✅ Covered   |
| R4028          | ValidResponseCodeRequired    | openapi-review §5                        | ✅ Covered   |
| --             | DeleteResponseCodes          | arm-api-review §5.1 (RPC-Delete-V1-01)   | ✅ Annotated |
| --             | PatchResponseCodes           | arm-api-review §4.2 (RPC-Patch-V1-06)    | ✅ Covered   |
| --             | PostResponseCodes            | arm-api-review §12.1 (RPC-POST-V1-02/03) | ✅ Covered   |
| --             | PutResponseCodes             | arm-api-review §3.1 (RPC-Put-V1-11)      | ✅ Annotated |
| R3013          | DeleteMustNotHaveRequestBody | arm-api-review §5.2                      | ✅ Covered   |
| --             | DeleteResponseBodyEmpty      | arm-api-review §5.1 (RPC-Delete-V1-04)   | ✅ Covered   |
| --             | GetMustNotHaveRequestBody    | --                                       | ❌ GAP       |
| --             | GetResponseCodes             | --                                       | ❌ GAP       |
| R2044          | InvalidVerbUsed              | openapi-review §5                        | ✅ Covered   |

## PUT / PATCH / GET Contract Rules

| Linter Rule ID | Name                                     | Instruction Coverage                   | Status       |
| -------------- | ---------------------------------------- | -------------------------------------- | ------------ |
| R2016          | PatchBodyParametersSchema                | arm-api-review §4.1 (RPC-Patch-V1-10)  | ✅ Annotated |
| --             | PatchSkuProperty                         | arm-api-review §4.3b (RPC-Patch-V1-09) | ✅ Annotated |
| --             | PatchIdentityProperty                    | arm-api-review §4.3b (RPC-Patch-V1-11) | ✅ Annotated |
| R2017          | PutRequestResponseScheme                 | arm-api-review §3.1 (RPC-Put-V1-25)    | ✅ Covered   |
| R3007          | PutGetPatchResponseSchema                | arm-api-review §3.1 (RPC-Put-V1-12)    | ✅ Covered   |
| --             | PatchPropertiesCorrespondToPutProperties | arm-api-review §4                      | ✅ Covered   |
| R2062          | XmsResourceInPutResponse                 | arm-api-review §2.1                    | ✅ Covered   |
| --             | ConsistentResponseSchemaForPut           | arm-api-review §3.1 (RPC-Put-V1-29)    | ✅ Annotated |
| --             | ConsistentPatchProperties                | arm-api-review §4.3a (RPC-Patch-V1-01) | ✅ Annotated |

## Resource Lifecycle Rules

| Linter Rule ID | Name                                         | Instruction Coverage                                       | Status       |
| -------------- | -------------------------------------------- | ---------------------------------------------------------- | ------------ |
| R3025          | TrackedResourceGetOperation                  | tracked-resource-lifecycle.md                              | ✅ Covered   |
| R3026          | TrackedResourcePatchOperation                | tracked-resource-lifecycle.md                              | ✅ Covered   |
| R3027          | TrackedResourceListByResourceGroup           | tracked-resource-lifecycle.md                              | ✅ Covered   |
| R3028          | TrackedResourceListBySubscription            | tracked-resource-lifecycle.md                              | ✅ Covered   |
| R4014          | AllResourcesMustHaveGetOperation             | arm-api-review §2.7                                        | ✅ Covered   |
| R4015          | NestedResourcesMustHaveListOperation         | arm-api-review §2.3                                        | ✅ Covered   |
| R4016          | TopLevelResourcesListByResourceGroup         | policy-compatibility.md PLCY007                            | ✅ Covered   |
| R4017          | TopLevelResourcesListBySubscription          | policy-compatibility.md PLCY007                            | ✅ Covered   |
| R3010          | TrackedResourceListByImmediateParent         | arm-api-review §2.3                                        | ✅ Covered   |
| --             | MissingSegmentsInNestedResourceListOperation | arm-api-review §2.3                                        | ✅ Covered   |
| --             | PathForTrackedResourceTypes                  | arm-api-review §1.1 (RPC-Put-V1-01)                        | ✅ Covered   |
| --             | AllTrackedResourcesMustHaveDelete            | arm-api-review §5.1 (RPC-Delete-V1-03)                     | ✅ Covered   |
| --             | AllProxyResourcesShouldHaveDelete            | arm-api-review §5.1 (RPC-Delete-V1-05)                     | ✅ Covered   |
| --             | TrackedExtensionResourcesAreNotAllowed       | arm-api-review §1.2 (RPC-Uri-V1-12)                        | ✅ Annotated |
| --             | ReservedResourceNamesModelAsEnum             | tracked-resource-lifecycle.md (optional authoring pattern) | ⚠️ Implicit  |

## Resource Model & Properties Rules

| Linter Rule ID | Name                                     | Instruction Coverage                | Status       |
| -------------- | ---------------------------------------- | ----------------------------------- | ------------ |
| R3006          | BodyTopLevelProperties                   | arm-api-review §2.6                 | ✅ Annotated |
| R3019          | ArmResourcePropertiesBag                 | arm-api-review §2.5, §2.6           | ✅ Covered   |
| R2020          | RequiredPropertiesMissingInResourceModel | arm-api-review §2.1                 | ✅ Covered   |
| R4009          | RequiredReadOnlySystemData               | arm-api-review §20.1                | ✅ Covered   |
| --             | SystemDataDefinitionsCommonTypes         | arm-api-review §20.1                | ✅ Annotated |
| --             | SystemDataInPropertiesBag                | arm-api-review §20.1                | ✅ Covered   |
| R4034          | AzureResourceTagsSchemaValidation        | arm-api-review §1.2 (proxy no tags) | ✅ Covered   |
| --             | TagsAreNotAllowedForProxyResources       | arm-api-review §1.2                 | ✅ Covered   |
| R2057          | InvalidSkuModel                          | arm-api-review §2.6.1               | ✅ Covered   |
| R2019          | ResourceHasXMsResourceEnabled            | arm-api-review §2.1                 | ✅ Covered   |
| R4037          | MissingTypeObject                        | openapi-review §6                   | ✅ Covered   |
| R2056          | RequiredReadOnlyProperties               | property-mutability.md OAPI027      | ✅ Covered   |
| --             | AvoidAdditionalProperties                | arm-api-review §8.5                 | ✅ Covered   |

## Naming & Casing Rules

| Linter Rule ID | Name                                 | Instruction Coverage                | Status      |
| -------------- | ------------------------------------ | ----------------------------------- | ----------- |
| R3020          | PathResourceProviderNamePascalCase   | arm-api-review §1.3                 | ✅ Covered  |
| R3021          | PathResourceTypeNameCamelCase        | arm-api-review §1.6                 | ✅ Covered  |
| R3030          | PathResourceProviderMatchNamespace   | arm-api-review §1.3 (RPC-Uri-V1-03) | ✅ Covered  |
| R3014          | BodyPropertiesNamesCamelCase         | naming-conventions.md               | ✅ Covered  |
| R3016          | DefinitionsPropertiesNamesCamelCase  | naming-conventions.md               | ✅ Covered  |
| R1001          | OperationIdNounVerb                  | openapi-review §14                  | ✅ Covered  |
| R2055          | OneUnderscoreInOperationId           | openapi-review §14                  | ⚠️ Implicit |
| R1003          | ListInOperationName                  | openapi-review §14                  | ⚠️ Implicit |
| R1005          | GetInOperationName                   | openapi-review §14                  | ⚠️ Implicit |
| R1006          | PutInOperationName                   | openapi-review §14                  | ⚠️ Implicit |
| R1007          | PatchInOperationName                 | openapi-review §14                  | ⚠️ Implicit |
| R1009          | DeleteInOperationName                | openapi-review §14                  | ⚠️ Implicit |
| R2066          | PostOperationIdContainsUrlVerb       | openapi-review §14                  | ⚠️ Implicit |
| R2063          | OperationIdNounConflictingModelNames | openapi-review §14                  | ✅ Covered  |
| R4004          | OperationIdRequired                  | openapi-review §14                  | ✅ Covered  |
| --             | SchemaNamesConvention                | naming-conventions.md               | ⚠️ Implicit |

## Enum & Type Rules

| Linter Rule ID | Name                      | Instruction Coverage                                                       | Status                                                                                                                                                                                                                                                                                                           |
| -------------- | ------------------------- | -------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| R3018          | EnumInsteadOfBoolean      | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R3015          | EnumMustHaveType          | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R4040          | EnumMustRespectType       | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R3024          | EnumUniqueValue           | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R3029          | EnumMustNotHaveEmptyValue | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R2027          | DefaultMustBeInEnum       | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R4005          | UniqueXmsEnumName         | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R2018          | XmsEnumValidation         | enum-best-practices.md                                                     | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| R3017          | GuidUsage                 | arm-api-review §8.4 + [guid-and-uuid-on-arm.md](./guid-and-uuid-on-arm.md) | ⚠️ Conflict-aware: §8.4 previously recommended `format: uuid` unconditionally, which trips `GuidUsage` on ARM specs. The reference file documents the ARM decision tree (acceptable/unacceptable property lists) and the required scoped-suppression form. Do not blanket-recommend `format: uuid` on ARM specs. |
| R4013          | IntegerTypeMustHaveFormat | openapi-review §6                                                          | ⚠️ Implicit                                                                                                                                                                                                                                                                                                      |
| R2003          | ValidFormats              | openapi-review §6                                                          | ✅ Covered                                                                                                                                                                                                                                                                                                       |
| --             | SchemaTypeAndFormat       | openapi-review §6                                                          | ⚠️ Implicit                                                                                                                                                                                                                                                                                                      |

## LRO & Async Rules

| Linter Rule ID | Name                                          | Instruction Coverage                  | Status       |
| -------------- | --------------------------------------------- | ------------------------------------- | ------------ |
| R2007          | LongRunningOperationsWithLongRunningExtension | arm-api-review §6.6 (RPC-Async-V1-15) | ✅ Covered   |
| R2005          | LongRunningResponseStatusCode                 | arm-api-review §6.1 (RPC-Async-V1-01) | ✅ Covered   |
| R2010          | LongRunningOperationsOptionsValidator         | lro-final-state-via.md                | ✅ Annotated |
| R2064          | LROStatusCodesReturnTypeSchema                | arm-api-review §6.7                   | ✅ Covered   |
| R4023          | RPaasPutLongRunningOperation201Only           | arm-api-review §6.1                   | ✅ Covered   |
| R4026          | RPaasPostLongRunningOperation202Only          | arm-api-review §6.4                   | ✅ Covered   |
| R4025          | DeleteOperationAsyncResponseValidation        | arm-api-review §5.1, §6.3             | ✅ Covered   |
| --             | LroPatch202                                   | arm-api-review §6.2 (RPC-Async-V1-08) | ✅ Covered   |
| --             | LroLocationHeader                             | arm-api-review §6.6 (RPC-Async-V1-07) | ✅ Covered   |
| --             | LroExtension                                  | arm-api-review §6.6 (RPC-Async-V1-15) | ✅ Covered   |
| --             | LroErrorContent                               | arm-api-review §6.7                   | ⚠️ Implicit  |
| --             | LroPostReturn                                 | arm-api-review §6.4 (RPC-Async-V1-11) | ✅ Covered   |
| --             | ProvisioningStateMustBeReadOnly               | arm-api-review §6.5 (RPC-Async-V1-02) | ✅ Annotated |
| R4031          | RPaasResourceProvisioningState                | provisioning-state.md                 | ✅ Covered   |
| --             | ProvisioningStateSpecifiedForLROPut           | provisioning-state.md                 | ✅ Covered   |
| --             | ProvisioningStateSpecifiedForLROPatch         | provisioning-state.md                 | ✅ Covered   |

## Pagination Rules

| Linter Rule ID | Name                                     | Instruction Coverage                | Status                                                                  |
| -------------- | ---------------------------------------- | ----------------------------------- | ----------------------------------------------------------------------- |
| R2025          | NextLinkPropertyMustExist                | arm-api-review §13.1                | ✅ Covered                                                              |
| R2029          | PageableOperation                        | arm-api-review §13.1                | ✅ Covered                                                              |
| R2060          | PageableRequires200Response              | arm-api-review §13.1                | ✅ Covered                                                              |
| R4012          | XmsPageableMustHaveCorrespondingResponse | arm-api-review §13.1                | ✅ Covered                                                              |
| R4019          | GetCollectionResponseSchema              | arm-api-review §13.1                | ✅ Covered                                                              |
| R3060          | XmsPageableListByRGAndSubscriptions      | arm-api-review §2.2                 | ✅ Covered                                                              |
| R3008          | CollectionObjectPropertiesNaming         | arm-api-review §13.1                | ✅ Covered                                                              |
| --             | QueryParametersInCollectionGet           | arm-api-review §2.2 (RPC-Uri-V1-09) | ⚠️ Staging-only; false-positives on RPC-defined `$top` and `$skipToken` |
| --             | ParametersInPointGet                     | arm-api-review §2.2 (RPC-Get-V1-08) | ✅ Covered                                                              |
| --             | ValidQueryParametersForPointOperations   | arm-api-review §2.2                 | ⚠️ Staging-only; broader point-operation rule                           |

## Operations API Rules

| Linter Rule ID | Name                               | Instruction Coverage                 | Status       |
| -------------- | ---------------------------------- | ------------------------------------ | ------------ |
| R3023          | OperationsAPIImplementation        | arm-api-review §1.4 (ARM-OPERATIONS) | ✅ Covered   |
| R4018          | OperationsApiResponseSchema        | arm-api-review §1.4                  | ✅ Covered   |
| --             | OperationsApiSchemaUsesCommonTypes | arm-api-review §1.4, §2.8            | ✅ Covered   |
| --             | OperationsApiTenantLevelOnly       | arm-api-review §1.4 (ARM-OPERATIONS) | ✅ Annotated |

## Description & Documentation Rules

| Linter Rule ID | Name                                  | Instruction Coverage | Status     |
| -------------- | ------------------------------------- | -------------------- | ---------- |
| R4000          | ParameterDescriptionRequired          | openapi-review §17   | ✅ Covered |
| R4020          | DescriptiveDescriptionRequired        | openapi-review §17   | ✅ Covered |
| R4021          | DescriptionAndTitleMissing            | openapi-review §17   | ✅ Covered |
| R4022          | OperationDescriptionOrSummaryRequired | openapi-review §17   | ✅ Covered |
| R2023          | SummaryAndDescriptionMustNotBeSame    | --                   | ❌ GAP     |
| R3011          | DescriptionMustNotBeNodeName          | openapi-review §17   | ✅ Covered |
| --             | SchemaDescriptionOrTitle              | openapi-review §17   | ✅ Covered |
| R1010          | AvoidMsdnReferences                   | --                   | ❌ GAP     |

## Extension & Annotation Rules

| Linter Rule ID | Name                               | Instruction Coverage                        | Status      |
| -------------- | ---------------------------------- | ------------------------------------------- | ----------- |
| R4001          | XmsParameterLocation               | openapi-review §16                          | ✅ Covered  |
| R4041          | XmsIdentifierValidation            | openapi-review §16                          | ⚠️ Implicit |
| R2008          | MutabilityWithReadOnly             | property-mutability.md                      | ✅ Covered  |
| R4002          | LocationMustHaveXmsMutability      | availability-zones.md, arm-api-review §17.2 | ✅ Covered  |
| R2012          | XmsClientNameParameter             | openapi-review §16                          | ⚠️ Implicit |
| R2013          | XmsClientNameProperty              | openapi-review §16                          | ⚠️ Implicit |
| R4006          | DeprecatedXmsCodeGenerationSetting | --                                          | ❌ GAP      |
| R2058          | XmsPathsMustOverloadPaths          | openapi-review §16                          | ⚠️ Implicit |

## Path & Parameter Rules

| Linter Rule ID | Name                                  | Instruction Coverage                  | Status       |
| -------------- | ------------------------------------- | ------------------------------------- | ------------ |
| R2014          | SubscriptionIdParameterInOperations   | arm-api-review §1.1                   | ✅ Covered   |
| R2015          | ParameterNotDefinedInGlobalParameters | openapi-review §15                    | ✅ Covered   |
| --             | ParametersInPost                      | arm-api-review §12.1 (RPC-POST-V1-05) | ✅ Annotated |
| R4029          | UniqueClientParameterName             | openapi-review §15                    | ✅ Covered   |
| R4039          | ParametersOrder                       | openapi-review §15                    | ⚠️ Implicit  |
| R2024          | AnonymousBodyParameter                | openapi-review §15                    | ✅ Covered   |
| R2047          | NamePropertyDefinitionInParameter     | openapi-review §15                    | ✅ Covered   |
| --             | PathParameterSchema                   | openapi-review §15                    | ⚠️ Implicit  |
| --             | PathContainsResourceType              | arm-api-review §1.5                   | ✅ Covered   |
| R4038          | ExtensionResourcePathPattern          | arm-api-review §1.2                   | ✅ Covered   |
| --             | NoDuplicatePathsForScopeParameter     | arm-api-review §1.2 (RPC-Uri-V1-10)   | ✅ Annotated |
| --             | EvenSegmentedPathForPutOperation      | arm-api-review §3.1 (RPC-Put-V1-02)   | ✅ Covered   |

## Error Handling Rules

| Linter Rule ID | Name                       | Instruction Coverage | Status     |
| -------------- | -------------------------- | -------------------- | ---------- |
| R4007          | DefaultErrorResponseSchema | openapi-review §11   | ✅ Covered |
| R4010          | RequiredDefaultResponse    | openapi-review §11   | ✅ Covered |
| R4032          | MissingXmsErrorResponse    | openapi-review §11   | ✅ Covered |

## Security & Format Rules

| Linter Rule ID | Name                         | Instruction Coverage | Status      |
| -------------- | ---------------------------- | -------------------- | ----------- |
| R2054          | SecurityDefinitionsStructure | openapi-review §3    | ✅ Covered  |
| --             | ApiHost                      | --                   | ❌ GAP      |
| R1011          | HttpsSupportedScheme         | openapi-review §3    | ✅ Covered  |
| R2004          | NonApplicationJsonType       | openapi-review §21   | ⚠️ Implicit |

## Private Endpoint Rules

| Linter Rule ID | Name                                    | Instruction Coverage | Status     |
| -------------- | --------------------------------------- | -------------------- | ---------- |
| R4035          | PrivateEndpointResourceSchemaValidation | arm-api-review §9.4  | ✅ Covered |
| R4036          | ImplementPrivateEndpointAPIs            | arm-api-review §9.4  | ✅ Covered |

## Versioning Rules

| Linter Rule ID | Name                                 | Instruction Coverage | Status       |
| -------------- | ------------------------------------ | -------------------- | ------------ |
| R3012          | APIVersionPattern                    | openapi-review §2    | ✅ Covered   |
| R4024          | PreviewVersionOverOneYear            | arm-api-review §23.2 | ✅ Covered   |
| --             | VersionConvention                    | openapi-review §2    | ✅ Annotated |
| --             | LatestVersionOfCommonTypesMustBeUsed | arm-api-review §2.8  | ✅ Covered   |

## Example & Misc Rules

| Linter Rule ID | Name                            | Instruction Coverage                 | Status                                                                                                                    |
| -------------- | ------------------------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| D5001          | XmsExamplesRequired             | openapi-review §22                   | ✅ Covered                                                                                                                |
| R4030          | UniqueXmsExample                | openapi-review §22                   | ✅ Covered                                                                                                                |
| R4033          | UniqueModelName                 | openapi-review §6                    | ✅ Covered                                                                                                                |
| R2026          | AvoidAnonymousTypes             | openapi-review §6                    | ✅ Covered                                                                                                                |
| R2009          | ArraySchemaMustHaveItems        | openapi-review §6                    | ✅ Covered                                                                                                                |
| R4008          | AvoidEmptyResponseSchema        | openapi-review §6                    | ✅ Covered                                                                                                                |
| R2006          | ControlCharactersNotAllowed     | --                                   | ❌ GAP                                                                                                                    |
| R2065          | LicenseHeaderMustNotBeSpecified | openapi-review §1                    | ✅ Covered                                                                                                                |
| R2001          | AvoidNestedProperties           | openapi-review §16                   | ⚠️ Conflict-aware: linter recommends `x-ms-client-flatten`, which is forbidden for new specs; do not recommend it blindly |
| R2028          | NonEmptyClientName              | openapi-review §16                   | ⚠️ Implicit                                                                                                               |
| --             | RepeatedPathInfo                | openapi-review §4                    | ⚠️ Implicit                                                                                                               |
| --             | ResourceNameRestriction         | arm-api-review §15.7 (PREFLIGHT-005) | ✅ Covered                                                                                                                |
| --             | TenantLevelAPIsNotAllowed       | arm-api-review §12A (RPC-Uri-V1-11)  | ✅ Annotated                                                                                                              |

## Pattern Constraint Rules

| Linter Rule ID | Name                     | Instruction Coverage                                              | Status               |
| -------------- | ------------------------ | ----------------------------------------------------------------- | -------------------- |
| _(none)_       | DenylistPatternDetection | openapi-review §4 (OAPI-PATTERN-ALLOWLIST); pattern-validation.md | ❌ NO AUTOMATED RULE |

> ❌ **No automated linter rule** currently exists for `OAPI-PATTERN-ALLOWLIST`
> in `@microsoft.azure/openapi-validator`, `@azure-tools/typespec-azure-core`,
> or `@azure-tools/typespec-azure-resource-manager`. This check is enforced
> exclusively by the ARM API Reviewer agent during code review. A follow-up
> issue should be filed to add an automated rule to the OpenAPI validator and
> TypeSpec linter packages. The existing `ResourceNameRestriction` rule
> verifies that a `pattern` _exists_ on resource name parameters but does not
> verify whether the pattern is an allowlist or a denylist.

---

## Coverage Status Meanings

| Status            | Meaning                                                                  |
| ----------------- | ------------------------------------------------------------------------ |
| ✅ Covered        | Rule has an explicit instruction section                                 |
| ✅ Annotated      | Instruction names the corresponding linter rule                          |
| ⚠️ Implicit       | Instruction covers the concept but does not cite the linter rule name    |
| ⚠️ Conflict-aware | Linter behavior conflicts with current authoring guidance and needs care |
| ⚠️ Staging-only   | Rule is not a required production check or has known false positives     |
| ❌ GAP            | No instruction coverage exists                                           |

### GAP Rules Requiring Coverage

| Rule ID | Name                               | Recommended Location |
| ------- | ---------------------------------- | -------------------- |
| R4006   | DeprecatedXmsCodeGenerationSetting | openapi-review §16   |
| R2023   | SummaryAndDescriptionMustNotBeSame | openapi-review §17   |
| R1010   | AvoidMsdnReferences                | openapi-review §17   |
| R2006   | ControlCharactersNotAllowed        | openapi-review §6    |

### Missing Automated Linter Rules

| Rule ID  | Name                     | Status               | Follow-Up                                                                                                                                                                                                                                                                                                                               |
| -------- | ------------------------ | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _(none)_ | DenylistPatternDetection | ❌ No automated rule | File a follow-up issue to add `OAPI-PATTERN-ALLOWLIST` to `@azure-tools/typespec-azure-core` and `@microsoft.azure/openapi-validator`. Agent-level coverage: `openapi-review.instructions.md §4`, `typespec-review.instructions.md §2.2`, `arm-api-review.instructions.md §21.4`, and [`pattern-validation.md`](pattern-validation.md). |
