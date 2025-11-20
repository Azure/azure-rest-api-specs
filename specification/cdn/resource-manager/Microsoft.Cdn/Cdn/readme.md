# Cdn

> see https://aka.ms/autorest

This is the AutoRest configuration file for Cdn.

---

## Getting Started

To build the SDK for Cdn, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Cdn API.


``` yaml
title: CdnManagementClient
description: Cdn Management Client
openapi-type: arm
tag: package-2025-06
```

### Tag: package-preview-2025-09

These settings apply only when `--tag=package-preview-2025-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-09'
input-file:
  - preview/2025-09-01-preview/openapi.json
suppressions:
  - code: PatchBodyParametersSchema
    reason: This is the API design and therefore exempted
  - code: ProvisioningStateMustBeReadOnly
    reason: These errors are from the previous API versions
  - code: PutResponseCodes
    reason: These errors are from the previous API versions
  - code: PostResponseCodes
    reason: These errors are from the previous API versions
  - code: DeleteResponseCodes
    reason: These errors are from the previous API versions
  - code: PatchResponseCodes
    reason: These errors are from the previous API versions
  - code: ResourceNameRestriction
    reason: These errors are from the previous API versions
  - code: RepeatedPathInfo
    reason: These errors are from the previous API versions
  - code: OperationsApiSchemaUsesCommonTypes
    reason: These errors are from the previous API versions
  - code: LroLocationHeader
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/afdEndpoints/{endpointName}"].delete
  - code: ArmResourcePropertiesBag
    reason: This is the API design and therefore exempted
    where: $.definitions.KnowledgeSource
  - code: ConsistentPatchProperties
    reason: This is the API design and therefore exempted
modelerfour:
  lenient-model-deduplication: true
  prenamer: true
```

### Tag: package-preview-2025-07

These settings apply only when `--tag=package-preview-2025-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-07'
input-file:
  - preview/2025-07-01-preview/afdx.json
  - preview/2025-07-01-preview/cdn.json
  - preview/2025-07-01-preview/cdnwebapplicationfirewall.json
suppressions:
  - code: PatchBodyParametersSchema
    from: afdx.json
    line: 549
    reason: Swagger LintDiff false positive. Property "scenario" is only required inside parent property "mtlsSettings", so only required if "mtlsSettings" is included in PATCH request for AFDDomainUpdateParameters
  - code: PostResponseCodes
    from: afdx.json
    line: 284
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 394
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 442
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 457
    reason: Preexisting API design.
  - code: LroLocationHeader
    from: afdx.json
    line: 501
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: afdx.json
    line: 519
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 590
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 650
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: afdx.json
    line: 651
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 753
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 801
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 816
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: afdx.json
    line: 878
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 949
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1009
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: afdx.json
    line: 1010
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1076
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1128
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1231
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 1279
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 1294
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: afdx.json
    line: 1356
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 1427
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1487
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1539
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1591
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1591
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 1646
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 1664
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: afdx.json
    line: 1730
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 1808
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1875
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1927
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 1927
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 1982
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 2000
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: afdx.json
    line: 2066
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 2144
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 2256
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 2357
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 2417
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 2469
    reason: Preexisting API design.
  - code: OperationIdNounVerb
    from: afdx.json
    line: 2475
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 2521
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 2521
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 2576
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 2594
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: afdx.json
    line: 2660
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 2738
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 2850
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 2898
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 2913
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: afdx.json
    line: 2975
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 3046
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 3151
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: afdx.json
    line: 3199
    reason: Preexisting API design.
  - code: RepeatedPathInfo
    from: afdx.json
    line: 3217
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: afdx.json
    line: 3279
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 3339
    reason: Preexisting API design.
  - code: XmsPageableForListCalls
    from: afdx.json
    line: 3340
    reason: Preexisting API design.
  - code: OperationIdNounVerb
    from: afdx.json
    line: 3344
    reason: Preexisting API design.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: afdx.json
    line: 3484
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 3497
    reason: Preexisting API design.
  - code: XmsPageableForListCalls
    from: afdx.json
    line: 3498
    reason: Preexisting API design.
  - code: OperationIdNounVerb
    from: afdx.json
    line: 3502
    reason: Preexisting API design.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: afdx.json
    line: 3604
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 3617
    reason: Preexisting API design.
  - code: XmsPageableForListCalls
    from: afdx.json
    line: 3618
    reason: Preexisting API design.
  - code: OperationIdNounVerb
    from: afdx.json
    line: 3622
    reason: Preexisting API design.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: afdx.json
    line: 3650
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 3663
    reason: Preexisting API design.
  - code: XmsPageableForListCalls
    from: afdx.json
    line: 3664
    reason: Preexisting API design.
  - code: OperationIdNounVerb
    from: afdx.json
    line: 3668
    reason: Preexisting API design.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: afdx.json
    line: 3696
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 3709
    reason: Preexisting API design.
  - code: XmsPageableForListCalls
    from: afdx.json
    line: 3710
    reason: Preexisting API design.
  - code: OperationIdNounVerb
    from: afdx.json
    line: 3714
    reason: Preexisting API design.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: afdx.json
    line: 3845
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: afdx.json
    line: 3858
    reason: Preexisting API design.
  - code: XmsPageableForListCalls
    from: afdx.json
    line: 3859
    reason: Preexisting API design.
  - code: OperationIdNounVerb
    from: afdx.json
    line: 3863
    reason: Preexisting API design.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: afdx.json
    line: 3992
    reason: Preexisting API design.
  - code: AvoidAdditionalProperties
    from: afdx.json
    line: 4260
    reason: Preexisting API design.
  - code: ProvisioningStateValidation
    from: afdx.json
    line: 5890
    reason: Preexisting API design.
  - code: RequiredPropertiesMissingInResourceModel
    from: afdx.json
    line: 5922
    reason: Preexisting API design.
  - code: RequiredPropertiesMissingInResourceModel
    from: afdx.json
    line: 6006
    reason: Preexisting API design.
  - code: RequiredPropertiesMissingInResourceModel
    from: afdx.json
    line: 6065
    reason: Preexisting API design.
  - code: RequiredPropertiesMissingInResourceModel
    from: afdx.json
    line: 6096
    reason: Preexisting API design.
  - code: RequiredPropertiesMissingInResourceModel
    from: afdx.json
    line: 6159
    reason: Preexisting API design.
  - code: RequiredPropertiesMissingInResourceModel
    from: afdx.json
    line: 6240
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 118
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: cdn.json
    line: 163
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: cdn.json
    line: 234
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: cdn.json
    line: 299
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 414
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 476
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 477
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 531
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 577
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 623
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 672
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 721
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 721
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: cdn.json
    line: 773
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: cdn.json
    line: 851
    reason: Preexisting API design.
  - code: PatchBodyParametersSchema
    from: cdn.json
    line: 885
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: cdn.json
    line: 923
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 984
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 984
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 985
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1049
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1049
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 1050
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1114
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1114
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 1115
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1182
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1182
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 1183
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1250
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1250
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1312
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1312
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1368
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1368
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1424
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1424
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1424
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: cdn.json
    line: 1483
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: cdn.json
    line: 1568
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: cdn.json
    line: 1647
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1715
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1715
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1771
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1771
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 1771
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: cdn.json
    line: 1830
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: cdn.json
    line: 1915
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: cdn.json
    line: 1994
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2062
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2062
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2118
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2118
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2118
    reason: Preexisting API design.
  - code: PutRequestResponseSchemeArm
    from: cdn.json
    line: 2177
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: cdn.json
    line: 2177
    reason: Preexisting API design.
  - code: DeleteResponseCodes
    from: cdn.json
    line: 2262
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2333
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2333
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2333
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 2334
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2405
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2405
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdn.json
    line: 2405
    reason: Preexisting API design.
  - code: PostResponseCodes
    from: cdn.json
    line: 2406
    reason: Preexisting API design.
  - code: OperationsApiSchemaUsesCommonTypes
    from: cdn.json
    line: 2681
    reason: Preexisting API design.
  - code: ProvisioningStateValidation
    from: cdn.json
    line: 2955
    reason: Preexisting API design.
  - code: AvoidAdditionalProperties
    from: cdn.json
    line: 2971
    reason: Preexisting API design.
  - code: ProvisioningStateValidation
    from: cdn.json
    line: 3494
    reason: Preexisting API design.
  - code: XmsEnumValidation
    from: cdn.json
    line: 4487
    reason: Preexisting API design.
  - code: ProvisioningStateValidation
    from: cdn.json
    line: 6032
    reason: Preexisting API design.
  - code: ProvisioningStateValidation
    from: cdn.json
    line: 6192
    reason: Preexisting API design.
  - code: ProvisioningStateValidation
    from: cdn.json
    line: 6486
    reason: Preexisting API design.
  - code: RequiredPropertiesMissingInResourceModel
    from: cdn.json
    line: 6895
    reason: Preexisting API design.
  - code: ResourceNameRestriction
    from: cdnwebapplicationfirewall.json
    line: 79
    reason: Preexisting API design.
  - code: PutResponseCodes
    from: cdnwebapplicationfirewall.json
    line: 120
    reason: Preexisting API design.
  - code: PatchResponseCodes
    from: cdnwebapplicationfirewall.json
    line: 187
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 331
    reason: Preexisting API design.
  - code: TopLevelResourcesListBySubscription
    from: cdnwebapplicationfirewall.json
    line: 348
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 348
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 388
    reason: Preexisting API design.
  - code: AvoidAdditionalProperties
    from: cdnwebapplicationfirewall.json
    line: 415
    reason: Preexisting API design.
  - code: ProvisioningStateValidation
    from: cdnwebapplicationfirewall.json
    line: 422
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 455
    reason: Preexisting API design.
  - code: XmsEnumValidation
    from: cdnwebapplicationfirewall.json
    line: 486
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 516
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 580
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 626
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 715
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 768
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 790
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 818
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 835
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 854
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 885
    reason: Preexisting API design.
  - code: MissingTypeObject
    from: cdnwebapplicationfirewall.json
    line: 911
    reason: Preexisting API design.
  - code: UniqueXmsExample
    from: afdx.json
    line: 92
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: afdx.json
    line: 142
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 349
    reason: Preexisting API design.
  - code: UniqueXmsExample
    from: afdx.json
    line: 657
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 708
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: afdx.json
    line: 1082
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 1186
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: afdx.json
    line: 1493
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 2211
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: afdx.json
    line: 2423
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 2805
    reason: Preexisting API design.
  - code: PatchInOperationName
    from: afdx.json
    line: 2980
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 3106
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 3339
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3368
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3390
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3397
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3404
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3419
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3440
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3450
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3460
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3470
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 3497
    reason: Preexisting API design.
  - code: PageableOperation
    from: afdx.json
    line: 3498
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3526
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3547
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3569
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3576
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3583
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3590
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 3617
    reason: Preexisting API design.
  - code: PageableOperation
    from: afdx.json
    line: 3618
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 3663
    reason: Preexisting API design.
  - code: PageableOperation
    from: afdx.json
    line: 3664
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 3709
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3738
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3755
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3762
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3769
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3784
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3804
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3822
    reason: Preexisting API design.
  - code: MissingSegmentsInNestedResourceListOperation
    from: afdx.json
    line: 3858
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3887
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3904
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3911
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3918
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3925
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3949
    reason: Preexisting API design.
  - code: ParameterDescription
    from: afdx.json
    line: 3969
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 4115
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 4853
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 5026
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 5299
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 5841
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 6111
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 6128
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 6151
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: afdx.json
    line: 6374
    reason: Preexisting API design.
  - code: PatchSkuProperty
    from: cdn.json
    line: 256
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: cdn.json
    line: 583
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: cdn.json
    line: 629
    reason: Preexisting API design.
  - code: LongRunningOperationsOptionsValidator
    from: cdn.json
    line: 984
    reason: Preexisting API design.
  - code: LongRunningOperationsOptionsValidator
    from: cdn.json
    line: 1049
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: cdn.json
    line: 1318
    reason: Preexisting API design.
  - code: LongRunningOperationsOptionsValidator
    from: cdn.json
    line: 2333
    reason: Preexisting API design.
  - code: LongRunningOperationsOptionsValidator
    from: cdn.json
    line: 2405
    reason: Preexisting API design.
  - code: PostOperationIdContainsUrlVerb
    from: cdn.json
    line: 2627
    reason: Preexisting API design.
  - code: OperationIdNounConflictingModelNames
    from: cdn.json
    line: 2627
    reason: Preexisting API design.
  - code: SchemaDescriptionOrTitle
    from: cdn.json
    line: 3153
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 3156
    reason: Preexisting API design.
  - code: SchemaDescriptionOrTitle
    from: cdn.json
    line: 3293
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 3567
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 3571
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 3576
    reason: Preexisting API design.
  - code: AvoidNestedProperties
    from: cdn.json
    line: 3617
    reason: Preexisting API design.
  - code: AvoidNestedProperties
    from: cdn.json
    line: 3640
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4117
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4162
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4229
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4287
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4341
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4399
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4453
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4494
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4557
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4611
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4665
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4710
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4768
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4813
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4867
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4921
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 4975
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 5029
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 5074
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 5360
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 5770
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 6111
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 6737
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 6776
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 6809
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 6924
    reason: Preexisting API design.
  - code: AvoidNestedProperties
    from: cdn.json
    line: 6928
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 7074
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdn.json
    line: 7082
    reason: Preexisting API design.
  - code: PatchSkuProperty
    from: cdnwebapplicationfirewall.json
    line: 206
    reason: Preexisting API design.
  - code: UniqueXmsExample
    from: cdnwebapplicationfirewall.json
    line: 241
    reason: Preexisting API design.
  - code: UniqueXmsExample
    from: cdnwebapplicationfirewall.json
    line: 322
    reason: Preexisting API design.
  - code: EnumInsteadOfBoolean
    from: cdnwebapplicationfirewall.json
    line: 679
    reason: Preexisting API design.
```

### Tag: package-2025-06
These settings apply only when `--tag=package-2025-06` is specified on the command line.

```yaml $(tag) == 'package-2025-06'
input-file:
  - stable/2025-06-01/openapi.json
```

### Tag: package-preview-2025-05
These settings apply only when `--tag=package-preview-2025-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05'
input-file:
  - preview/2025-05-01-preview/afdwebapplicationfirewalldefinition.json
  - preview/2025-05-01-preview/afdx.json
  - preview/2025-05-01-preview/cdn.json
  - preview/2025-05-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-2025-04
These settings apply only when `--tag=package-2025-04` is specified on the command line.

```yaml $(tag) == 'package-2025-04'
input-file:
  - stable/2025-04-15/afdx.json
  - stable/2025-04-15/cdn.json
  - stable/2025-04-15/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2025-01

These settings apply only when `--tag=package-preview-2025-01` is specified on the command line.
This version only contains managed identity origin authentication preview version.

```yaml $(tag) == 'package-preview-2025-01'
input-file:
  - preview/2025-01-01-preview/afdx.json
  - preview/2025-01-01-preview/cdn.json
  - preview/2025-01-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2024-07

These settings apply only when `--tag=package-preview-2024-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-07'
input-file:
  - preview/2024-07-22-preview/edgeaction.json
suppressions:
  - code: OperationsAPIImplementation
    reason: Operation APIs for Microsoft.Cdn are to be defined in cdn swagger
```

### Tag: package-2024-09

These settings apply only when `--tag=package-2024-09` is specified on the command line.

```yaml $(tag) == 'package-2024-09'
input-file:
  - stable/2024-09-01/afdx.json
  - stable/2024-09-01/cdn.json
  - stable/2024-09-01/cdnwebapplicationfirewall.json
suppressions:
  - code: MISSING_RESOURCE_ID
    reason: Keeping it for legacy tooling
```

### Tag: package-preview-2024-06

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06'
input-file:
  - preview/2024-06-01-preview/afdx.json
  - preview/2024-06-01-preview/cdn.json
  - preview/2024-06-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - preview/2024-05-01-preview/afdx.json
  - preview/2024-05-01-preview/cdn.json
  - preview/2024-05-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - stable/2024-02-01/afdx.json
  - stable/2024-02-01/cdn.json
  - stable/2024-02-01/cdnwebapplicationfirewall.json
```
### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-07'
input-file:
  - preview/2023-07-01-preview/afdx.json
  - preview/2023-07-01-preview/cdn.json
  - preview/2023-07-01-preview/cdnwebapplicationfirewall.json

suppressions:
  - code: PutRequestResponseSchemeArm
    reason: False alarm. PUT request body is not superset of GET response body. We also do not support PATCH on keyGroups resource by design.  
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

```yaml $(tag) == 'package-2023-05'
input-file:
  - stable/2023-05-01/afdx.json
  - stable/2023-05-01/cdn.json
  - stable/2023-05-01/cdnwebapplicationfirewall.json
```
### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - preview/2022-11-01-preview/afdx.json
  - preview/2022-11-01-preview/cdn.json
  - preview/2022-11-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - preview/2022-05-01-preview/afdx.json
  - preview/2022-05-01-preview/cdn.json
  - preview/2022-05-01-preview/cdnwebapplicationfirewall.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

``` yaml $(tag) == 'package-2021-06'
input-file:
  - stable/2021-06-01/afdx.json
  - stable/2021-06-01/cdn.json
  - stable/2021-06-01/cdnwebapplicationfirewall.json
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` is specified on the command line.

``` yaml $(tag) == 'package-2020-09'
input-file:
- stable/2020-09-01/cdn.json
- stable/2020-09-01/afdx.json
- stable/2020-09-01/cdnwebapplicationfirewall.json
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04'
input-file:
- stable/2020-04-15/cdn.json
- stable/2020-04-15/cdnwebapplicationfirewall.json
```

### Tag: package-2019-12

These settings apply only when `--tag=package-2019-12` is specified on the command line.

``` yaml $(tag) == 'package-2019-12'
input-file:
- stable/2019-12-31/cdn.json
```

### Tag: package-2019-06-preview

These settings apply only when `--tag=package-2019-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-preview'
input-file:
- preview/2019-06-15-preview/cdn.json
- preview/2019-06-15-preview/cdnwebapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
- stable/2019-06-15/cdn.json
- stable/2019-06-15/cdnwebapplicationfirewall.json
```

### Tag: package-2019-04

These settings apply only when `--tag=package-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-2019-04'
input-file:
- stable/2019-04-15/cdn.json
```

### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- stable/2017-10-12/cdn.json
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- stable/2017-04-02/cdn.json
```

### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
input-file:
- stable/2016-10-02/cdn.json
```

### Tag: package-2016-04

These settings apply only when `--tag=package-2016-04` is specified on the command line.

``` yaml $(tag) == 'package-2016-04'
input-file:
- stable/2016-04-02/cdn.json
```

### Tag: package-2015-06

These settings apply only when `--tag=package-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-2015-06'
input-file:
- stable/2015-06-01/cdn.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Node

See configuration in [readme.node.md](./readme.node.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)
