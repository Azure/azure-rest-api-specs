# OpenAPI Specifications Authoring - Automated Guidelines #

This document lists the set of automated rules that can be validated against OpenAPI(swagger) spec by running [validation tools](https://github.com/Azure/azure-openapi-validator#how-to-run-locally). Please visit [here for Manual guidelines](openapi-authoring-manual-guidelines.md).

It is a requirement to conform to all manual and automated rules with severity "Error" before sending a pull request for review.

We request OpenAPI(Swagger) spec authoring be assigned to engineers who have an intimate knowledge of a service endpoint and its developer experience to avoid feeding inefficiencies into teams that focus on Azure developer experiences and the rest of the Azure eco-system.

## Index
* [Error vs. Warning](#error-vs-warning)
* [Automated Rules](#automated-rules)
  * [ARM Violations](#arm-violations)
    * [ARM Errors](#arm-errors)
    * [ARM Warnings](#arm-warnings)
  * [SDK Violations](#sdk-violations)
    * [SDK Errors](#sdk-errors)
    * [SDK Warnings](#sdk-warnings)
  * [Documentation](#documentation)
    * [Documentation Errors](#documentation-errors)
* [Rule Descriptions](#rule-descriptions)

## Error vs Warning
- Rules with severity "Error" have to be addressed for the OpenAPI(swagger) spec to be approved by the reviewers. If there is a strong reason for why the rule cannot be addressed in an OpenAPI(swagger) spec it will be a permanent exception, then [suppression process](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/85/Swagger-Suppression-Process) must be followed.

- Rules with severity "Warning" are either strong recommendations made by Azure developer experience team for better SDK/Documentation experience or they point out something to evaluate, for example, the warning for booleans asks the user to evaluate whether the property should be a boolean or not. 

## Automated Rules

### ARM Violations

#### ARM Errors

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R3012](#r3012) | [APIVersionPattern](#r3012) | ARM OpenAPI(swagger) specs |
| [R3019](#r3019) | [ARMResourcePropertiesBag](#r3019) | ARM and Data plane OpenAPI(swagger) specs |
| [R3014](#r3014) | [BodyPropertiesNamesCamelCase](#r3014) | ARM and Data plane OpenAPI(swagger) specs |
| [R3016](#r3016) | [DefinitionsPropertiesNamesCamelCase](#r3016)  | ARM and Data plane OpenAPI(swagger) specs |
| [R3006](#r3006) | [BodyTopLevelProperties](#r3006) | ARM OpenAPI(swagger) specs |
| [R3008](#r3008) | [CollectionObjectPropertiesNaming](#r3008) | ARM and Data plane OpenAPI(swagger) specs |
| [R2044](#r2044) | [InvalidVerbUsed](#r2044) | ARM and Data plane OpenAPI(swagger) specs |
| [R3023](#r3023) | [OperationsAPIImplementation](#r3023) | ARM OpenAPI(swagger) specs |
| [R3007](#r3007) | [PutGetPatchResponseSchema](#r3007) | ARM and Data plane OpenAPI(swagger) specs |
| [R3025](#r3025) | [TrackedResourceGetOperation](#r3025) | ARM OpenAPI(swagger) specs |
| [R3026](#r3026) | [TrackedResourcePatchOperation](#r3026) | ARM OpenAPI(swagger) specs |
| [R3030](#R3030) | [PathResourceProviderMatchNamespace](#R3030) | ARM OpenAPI(swagger) specs |
| [R2016](#r2016) | [PatchBodyParametersSchema](#r2016) | ARM and Data plane OpenAPI(swagger) specs |
| [R2062](#r2062) | [XmsResourceInPutResponse](#r2062) | ARM OpenAPI(swagger) specs |
| [R3011](#r3011) | [DescriptionMustNotBeNodeName](#r3011) | ARM and Data plane OpenAPI(swagger) specs |
| [R2020](#r2020) | [RequiredPropertiesMissingInResourceModel](#r2020) | ARM OpenAPI(swagger) specs |
| [R3020](#r3020) | [PathResourceProviderNamePascalCase](#r3020) | ARM OpenAPI(swagger) specs |
| [R3021](#r3021) | [PathResourceTypeNameCamelCase](#r3021) | ARM OpenAPI(swagger) specs |
| [R4004](#r4004) | [OperationIdRequired](#r4004) | ARM OpenAPI(swagger) specs |
| [R4007](#r4007) | [DefaultErrorResponseSchema](#r4007) | ARM OpenAPI(swagger) specs |
| [R4010](#r4010) | [RequiredDefaultResponse](#r4010) | ARM OpenAPI(swagger) specs |
| [R4011](#r4011) | [DeleteOperationResponses](#r4011) | ARM OpenAPI(swagger) specs |
| [R4015](#r4015) | [NestedResourcesMustHaveListOperation](#r4015) | ARM OpenAPI(swagger) specs |
| [R4016](#r4016) | [TopLevelResourcesListByResourceGroup](#r4016) | ARM OpenAPI(swagger) specs |
| [R4017](#r4017) | [TopLevelResourcesListBySubscription](#r4017) | ARM OpenAPI(swagger) specs |
| [R4018](#r4018) | [OperationsApiResponseSchema](#r4018) | ARM OpenAPI(swagger) specs |
| [R4019](#r4019) | [GetCollectionResponseSchema](#r4019) | ARM OpenAPI(swagger) specs |
| [R4009](#r4009) | [RequiredReadOnlySystemData](#r4009) | ARM OpenAPI(swagger) specs |

#### ARM Warnings

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R3018](#r3018) | [EnumInsteadOfBoolean](#r3018) | ARM and Data plane OpenAPI(swagger) specs |
| [R3017](#r3017) | [GuidUsage](#r3017) | ARM and Data plane OpenAPI(swagger) specs |
| [R2057](#r2057) | [InvalidSkuModel](#r2057) | ARM OpenAPI(swagger) specs |
| [R3010](#r3010) | [TrackedResourceListByImmediateParent](#r3010) | ARM OpenAPI(swagger) specs |
| [R3027](#r3027) | [TrackedResourceListByResourceGroup](#r3027) | ARM OpenAPI(swagger) specs |
| [R3028](#r3028) | [TrackedResourceListBySubscription](#r3028) | ARM OpenAPI(swagger) specs |
| [R2004](#r2004) | [NonApplicationJsonType](#r2004) | ARM OpenAPI(swagger) specs |
| [R4014](#r4014) | [AllResourcesMustHaveGetOperation](#r4014) | ARM OpenAPI(swagger) specs |
### SDK Violations

#### SDK Errors

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R2024](#r2024) | [AnonymousBodyParameter](#r2024) | ARM and Data plane OpenAPI(swagger) specs |
| [R2026](#r2026) | [AvoidAnonymousTypes](#r2026) | ARM and Data plane OpenAPI(swagger) specs |
| [R2014](#r2014) | [SubscriptionIdParameterInOperations](#r2014) | ARM and Data plane OpenAPI(swagger) specs |
| [R2027](#r2027) | [DefaultMustBeInEnum](#r2027) | ARM and Data plane OpenAPI(swagger) specs |
| [R1001](#r1001) | [OperationIdNounInVerb](#r1001) | ARM and Data plane OpenAPI(swagger) specs |
| [R2055](#r2055) | [OneUnderscoreInOperationId](#r2055) | ARM and Data plane OpenAPI(swagger) specs |
| [R2003](#r2003) | [ValidFormats](#r2003)  | ARM and Data plane OpenAPI(swagger) specs |
| [R2005](#r2005) | [LongRunningResponseStatusCode](#r2005) | ARM and Data plane OpenAPI(swagger) specs |
| [R2008](#r2008) | [MutabilityWithReadOnlyRule](#r2008) | ARM and Data plane OpenAPI(swagger) specs |
| [R2025](#r2025) | [NextLinkPropertyMustExist](#r2025) | ARM and Data plane OpenAPI(swagger) specs |
| [R2028](#r2028) | [NonEmptyClientName](#r2028) | ARM and Data plane OpenAPI(swagger) specs |
| [R2060](#r2060) | [PageableRequires200Response](#r2060) | ARM and Data plane OpenAPI(swagger) specs |
| [R2019](#r2019) | [ResourceHasXMsResourceEnabled](#r2019) | ARM OpenAPI(swagger) specs |
| [R2058](#r2058) | [XmsPathsMustOverloadPaths](#r2058) | ARM and Data plane OpenAPI(swagger) specs |
| [R2012](#r2012) | [XmsClientNameParameter](#r2012) | ARM and Data plane OpenAPI(swagger) specs |
| [R2013](#r2013) | [XmsClientNameProperty](#r2013) | ARM and Data plane OpenAPI(swagger) specs |
| [R2047](#r2047) | [NamePropertyDefinitionInParameter](#r2047) | ARM and Data plane OpenAPI(swagger) specs |
| [R2056](#r2056) | [RequiredReadOnlyProperties](#r2056) | ARM and Data plane OpenAPI(swagger) specs |
| [R2054](#r2054) | [SecurityDefinitionsStructure](#r2054) | ARM OpenAPI(swagger) specs |
| [R2006](#r2006) | [ControlCharactersNotAllowed](#r2006) | ARM and Data plane OpenAPI(swagger) specs |
| [R2009](#r2009) | [ArraySchemaMustHaveItems](#r2009) | ARM and Data plane OpenAPI(swagger) specs |
| [R2018](#r2018) | [XmsEnumValidation](#r2018) | ARM and Data plane OpenAPI(swagger) specs |
| [R3013](#r3013) | [DeleteMustNotHaveRequestBody](#r3013) | ARM and Data plane OpenAPI(swagger) specs |
| [R4001](#r4001) | [XmsParameterLocation](#r4001) | ARM and Data plan OpenAPI(swagger) specs |
| [R3015](#r3015) | [EnumMustHaveType](#r3015) | ARM and Data plan OpenAPI(swagger) specs |
| [R3024](#r3024) | [EnumUniqueValue](#r3024) | ARM and Data plan OpenAPI(swagger) specs |
| [R3029](#r3029) | [EnumMustNotHaveEmptyValue](#r3024) | ARM and Data plan OpenAPI(swagger) specs |
| [R4005](#r4005) | [UniqueXmsEnumName](#r4005) | ARM and Data plane OpenAPI(swagger) specs |
| [R4008](#r4008) | [AvoidEmptyResponseSchema](#r4008) | ARM OpenAPI(swagger) specs |
| [R4012](#r4012) | [XmsPageableMustHaveCorrespondingResponse](#r4012) | ARM OpenAPI(swagger) specs |
| [R4013](#r4013) | [IntegerTypeMustHaveFormat](#r4013) | ARM OpenAPI(swagger) specs |
| [R4028](#r4028) | [ValidResponseCodeRequired](#r4028) | ARM and Data Plane OpenAPI(swagger) specs |
| [R4029](#r4029) | [UniqueClientParameterName](#r4029) | ARM OpenAPI(swagger) specs |
| [R4032](#r4032) | [MissingXmsErrorResponse](#r4032) | ARM OpenAPI(swagger) specs |
| [R4033](#r4033) | [UniqueModelName](#r4033) | ARM OpenAPI(swagger) specs |
| [R4034](#r4034) | [AzureResourceTagsSchemaValidation](#r4034) | ARM OpenAPI(swagger) specs |
| [R4035](#r4035) | [PrivateEndpointResourceSchemaValidation](#r4035) | ARM OpenAPI(swagger) specs |
| [R4036](#r4036) | [ImplementPrivateEndpointAPIs](#r4036) | ARM OpenAPI(swagger) specs |
| [R4037](#r4037) | [MissingTypeObject](#r4037) | ARM and Data plan OpenAPI(swagger) specs |
| [R4039](#r4039) | [ParametersOrder](#r4039) | ARM and Data plan OpenAPI(swagger) specs |
| [R4040](#r4040) | [EnumMustRespectType](#r4040) | ARM and Data plan OpenAPI(swagger) specs |
| [R4041](#r4041) | [XmsIdentifierValidation](#r4041) | ARM OpenAPI(swagger) specs |
#### SDK Warnings

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R4000](#r4000) | [ParameterDescriptionRequired](#r4000) | ARM and Data plane OpenAPI(swagger) specs |
| [R4020](#r4000-3) | [DescriptiveDescriptionRequired](#r4000-3) | ARM and Data plane OpenAPI(swagger) specs |
| [R4021](#r4000-4) | [DescriptionAndTitleMissing](#r4000-4) | ARM and Data plane OpenAPI(swagger) specs |
| [R4022](#r4000-5) | [OperationDescriptionOrSummaryRequired](#r4000-5)  | ARM and Data plane OpenAPI(swagger) specs |
| [R2001](#r2001) | [AvoidNestedProperties](#r2001) | ARM and Data plane OpenAPI(swagger) specs |
| [R4002](#r4002) | [LocationMustHaveXmsMutability](#r4002) | ARM OpenAPI(swagger) specs |
| [R2066](#r2066) | [PostOperationIdContainsUrlVerb](#r2066) | ARM and Data plane OpenAPI(swagger) specs |
| [R2015](#r2015) | [ParameterNotDefinedInGlobalParameters](#r2015) | ARM and Data plane OpenAPI(swagger) specs |
| [R1010](#r1010) | [AvoidMSDNReferences](#r1010) | ARM and Data plane OpenAPI(swagger) specs |
| [R2017](#r2017) | [PutRequestResponseScheme](#r2017) | ARM and Data plane OpenAPI(swagger) specs |
| [R1009](#r1009) | [DeleteInOperationName](#r1009) | ARM and Data plane OpenAPI(swagger) specs |
| [R1005](#r1005) | [GetInOperationName](#r1005) | ARM and Data plane OpenAPI(swagger) specs |
| [R1003](#r1003) | [ListInOperationName](#r1003) | ARM and Data plane OpenAPI(swagger) specs |
| [R1006](#r1006) | [PutInOperationName](#r1006) | ARM and Data plane OpenAPI(swagger) specs |
| [R1007](#r1007) | [PatchInOperationName](#r1007) | ARM and Data plane OpenAPI(swagger) specs |
| [R1011](#r1011) | [HttpsSupportedScheme](#r1011) | ARM OpenAPI(swagger) specs |
| [R2065](#r2065) | [LicenseHeaderMustNotBeSpecified](#r2065) | ARM and Data plane OpenAPI(swagger) specs |
| [R3060](#r3060) | [XmsPageableListByRGAndSubscriptions](#r3060) | ARM OpenAPI(swagger) specs |
| [R2063](#r2063) | [OperationIdNounConflictingModelNames](#r2063) | ARM and Data plane OpenAPI(swagger) specs |
| [R2064](#r2064) | [LROStatusCodesReturnTypeSchema](#r2064) | ARM and Data plane OpenAPI(swagger) specs |
| [R2023](#r2023) | [SummaryAndDescriptionMustNotBeSame](#r2023) | ARM and Data plane OpenAPI(swagger) specs |
| [R2010](#r2010) | [LongRunningOperationsOptionsValidator](#r2010) | ARM and Data plane OpenAPI(swagger) specs |
| [R2007](#r2007) | [LongRunningOperationsWithLongRunningExtension](#r2007) | ARM OpenAPI(swagger) specs |
| [R2029](#r2029) | [PageableOperation](#r2029) | ARM and Data plane OpenAPI(swagger) specs |
| [R4006](#r4006) | [DeprecatedXmsCodeGenerationSetting](#r4006) | ARM and Data plane OpenAPI(swagger) specs |
| [R4024](#r4024) | [PreviewVersionOverOneYear](#r4024) | ARM OpenAPI(swagger) specs |
| [R4030](#r4030) | [UniqueXmsExample](#r4030) | ARM OpenAPI(swagger) specs |


### RPaaS Violations

#### RPaaS Errors

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [R4023](#r4023) | [RPaasPutLongRunningOperation201Only](#r4023) | ARM OpenAPI(swagger) specs |
| [R4025](#r4025) | [RPaasDeleteLongRunningOperation202Only](#r4025) | ARM OpenAPI(swagger) specs |
| [R4026](#r4026) | [RPaasPostLongRunningOperation202Only](#r4026) | ARM OpenAPI(swagger) specs |
| [R4031](#r4031) | [RPaasResourceProvisioningState](#r4031) | ARM OpenAPI(swagger) specs |
| [R4038](#r4038) | [ExtensionResourcePathPattern](#r4038) | ARM OpenAPI(swagger) specs |
### Documentation

#### Documentation Errors

| Id | Rule Name | Applies to |
| --- | --- | --- |
| [D5001](#d5001) | [XmsExamplesRequired](#d5001) | ARM and Data plane OpenAPI(swagger) specs |

## Rule Descriptions

### <a name="r3012" />R3012 APIVersionPattern 
**Category** : ARM Error

**Applies to**: ARM OpenAPI(swagger) specs

**Output Message**: API Version must be in the format: yyyy-MM-dd, optionally followed by -preview, -alpha, -beta, -rc, -privatepreview.

**Description**: The API Version parameter MUST be in the Year-Month-Date format (i.e. 2016-07-04.)  NOTE that this is the en-US ordering of month and date.  

The date MAY optionally be followed by one of:
* -preview - Indicates the API version is in (public) preview
* -alpha
* -beta
* -rc (release candidate)
* -privatepreview

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), API version should follow a consistent date format.

**How to fix the violation**: Adopt API version format as indicated by the rule.

**Impact on generated code**: The API version specified wil be used by the generated client.

**Good Examples**: Examples of valid version patterns include:
* 2016-07-04
* 2016-07-04-preview

**Bad Examples**: The following would be invalid:
* 97-07-04 - Date should be YYYY, not YY
* 2016/07/04 - Date should use "-", not "/"
* 1842-07-04 - Year should be accurate; we didn't have Azure in 1842 :(
* 2150-07-04 - Year should be current, not in the future; though we'll hopefully get here eventually :)
* 2016-07-04-publicpreview - Use "-preview" to indicate a public preview
* 2016-07-04-rc0 - Just use "rc", not "rc" + number

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3014" />R3014 BodyPropertiesNamesCamelCase
 Please refer to [R3016](#r3016)

### <a name="r3016" />R3016 DefinitionsPropertiesNamesCamelCase
**Category** : ARM Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message**: Property named: "{0}", must follow camelCase style. Example: "{1}".
**Output Message**: Property named: "{0}", for definition: "{1}" must follow camelCase style. Example: "{2}".

**Description**: Property names must use lowerCamelCase style. 
If the property is a single word (ex: foo, bar, etc.) it will be all lowercase. 
Two-letter acronyms (ex: ID, IO, IP, etc.) should be capitalized. 
Three-letter acronyms (ex: API, URL, etc.) should only have the first letter capitalized (ex: Api, Url, etc.) 
For more capitalization guidance, see: [https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx](https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx)

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), properties should follow camel case format as specified at [https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx](https://msdn.microsoft.com/en-us/library/141e06ef(v=vs.71).aspx).

**How to fix the violation**: Adopt camel case format as indicated by the rule. Please note that this may require a service side update and may cause a breaking change.

**Impact on generated code**: Serialization of the property by the SDK will follow casing as defined in the spec file. Make sure casing matches the service implementation.

**Good Examples**: Examples of lowerCamelCase style:
* camelCase
* foo
* bar
* fooBarBaz
* resourceKey
* resourceApiKey
* publicIPAddress
* enableSsl

**Bad Examples**: The following would be invalid:
* PascalCase
* UpperCamelCase
* resourceAPIKey
* enableSSL

**Bad Examples**: The following violate these guidelines but would not be caught by automation: 
* alllowercase - If there are multiple words, please capitalize starting with the second word
* miXeDcApItAlIzAtIoN - Please capitalize the first letter of each word (and not seemingly random letters)
* resourceAPIkey - Automation would incorrectly recognize "Ikey" as a word and not flag the property name

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3025" />R3025 TrackedResourceGetOperation
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Tracked resource '{0}' must have a get operation.

**Description**: Verifies if a tracked resource has a corresponding GET operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a GET operation.

**How to fix the violation**: Add a GET operation that returns the tracked resource pointed out by the rule - if the operation does not exist for the service, this fix requires a service side change. 
If the resource pointed by the rule is not a tracked resource, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding GET operation only if it's present in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3026" />R3026 TrackedResourcePatchOperation
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Tracked resource '{0}' must have patch operation that at least supports the update of tags.

**Description**: Verifies if a tracked resource has a corresponding PATCH operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a PATCH operation supporting at least the update of tags.

**How to fix the violation**: Add a PATCH operation that allows at least the update of tags for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. 
If the resource pointed by the rule is not a tracked resource, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding PATCH operation only if it's present in the specification. If PATCH operation only supports updating tags, then you will potentially have two operations in the SDK: "Update" & "CreateOrUpdate", the first updates only tags while the second allows updating a bigger set of properties, which is not the best customer experience. Please strongly consider adding all mutable properties to the "Update" operation.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3027" />R3027 TrackedResourceListByResourceGroup
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The tracked resource, '{0}', must have a list by resource group operation.

**Description**: Verifies if a tracked resource has a corresponding ListByResourceGroup operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a corresponding ListByResourceGroup operation.

**How to fix the violation**: Add a corresponding ListByResourceGroup operation for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists and it is not named following the naming convention "ListbyResourceGroup", consider updating the operation name. 
If the resource pointed by the rule is not a tracked resource or the operation that allows listing by resource group does not follow the naming convention "ListByResourceGroup", this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding ListByResourceGroup operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3028" />R3028 TrackedResourceListBySubscription
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The tracked resource, '{0}', must have a list by subscriptions operation.

**Description**: Verifies if a tracked resource has a corresponding ListByResourceGroup operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a corresponding ListBySubscription operation.

**How to fix the violation**: Add a corresponding ListBySubscription operation for the tracked resource - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists and it is not named following the naming conventions: List, ListBySubscriptionId, ListBySubscription or ListBySubscriptions, consider updating the operation name. 
If the resource pointed by the rule is not a tracked resource or the operation that allows listing by subscription ID does not follow the naming convention mentioned above, this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding ListBySubscription operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3010" />R3010 TrackedResourceListByImmediateParent
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The child tracked resource, '{0}' with immediate parent '{1}', must have a list by immediate parent operation.

**Description**: Verifies if a tracked resource has a corresponding list by immediate parent operation. 
What's a tracked resource? A Tracked Resource is an ARM Resource with "location" as a required property.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each tracked resource must have a corresponding "list by immediate parent" operation.

**How to fix the violation**: Add an operation that allows listing the tracked resource by its immediate parent - if the operation does not exist for the service, this fix requires a service side change. If the operation already exists, please double check the name of the operation, our rule is matching the parent and child resource names to the operation names, if those don't match 100%, this warning may be a false positive, please evaluate whether the named picked is appropriate or needs update. 
If the resource pointed by the rule is not a tracked resource this warning may be a false positive, please clarify this with your PR reviewer.

**Impact on generated code**: Generated SDK code will expose the corresponding "list by immediate parent" operation as included in the specification.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3018" />R3018 EnumInsteadOfBoolean
**Category** : ARM Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Booleans are not descriptive and make them hard to use. Consider using string enums with allowed set of values defined. Property: {0}.

**Description**: Booleans properties are not descriptive in all cases and can make them to use, evaluate whether is makes sense to keep the property as boolean or turn it into an enum. 

**Why the rule is important**: Evaluate whether the property is really a boolean or not, the intent is to consider if there could be more than 2 values possible for the property in the future or not. If the answer is no, then a boolean is fine, if the answer is yes, there could be other values added in the future, making it an enum can help avoid breaking changes in the SDKs in the future.

**How to fix the violation**: Create an enum property, follow autorest [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) guidelines.

**Impact on generated code**: Boolean property will turn into a String or an Enum (if SDK language supports it), this will depend on "modelAsString" property value as specified in [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) guidelines.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4002" />R4002 LocationMustHaveXmsMutability
**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Property 'location' must have '\"x-ms-mutability\":[\"read\", \"create\"]' extension defined. Resource Model: '{0}'

**Description**: A tracked resource's `location` property must have the `x-ms-mutability` properties set as `read`, `create`.

**Why the rule is important**: Location is a property that is set once and non-updatable for a tracked resource. Hence, per ARM guidelines the only operations allowed are `read` and `create`.

**How to fix the violation**: Ensure that the `location` property in the tracked resource's hierarchy has `x-ms-mutability` correctly set to `read` and `create`.
For example:
```json
"location": {
  "type": "string",
  "description": "location of the resource",
  "x-ms-mutability": [ "create", "read" ]
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2028" />R2028 NonEmptyClientName
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Empty x-ms-client-name property.

**Description**: The [`x-ms-client-name`](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) extension is used to change the name of a parameter or property in the generated code.

**Why the rule is important**: This value cannot be empty, because we need to use it as the identifier for a property or model.

**How to fix the violation**: Add a non-empty value for `x-ms-client-name`.

**Impact on generated code**: Generated SDK code will expose the corresponding client name on property or model.

**Examples**:
```json
...
"x-ms-client-name": "name"
...
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2066" />R2066 PostOperationIdContainsUrlVerb
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: OperationId should contain the verb: '{0}' in:'{1}'

**Description**: A POST operation's operationId should contain the verb indicated at the end of the corresponding url.

**Why the rule is important**: The url indicates the action performed by it, the corresponding POST operationId should therefore contain this verb for semantic consistency.

**How to fix the violation**: Ensure that the operationId for POST operation contains the verb indicated at the end of the url.

**Good Examples**: Examples of url and corresponding POST operationIds:
* Url: /foo/{someResource}/activate
* OperationId: SomeResourceTypes_ActivateResource

**Bad Examples**: Examples of url and corresponding POST operationIds:
* Url: /foo/{someResource}/activate
* OperationId: SomeResourceTypes_StartResource

**Impact on generated code**: Method generated for the POST operation will be named as indicated after the '__underscore__'. For eg., OperationId *SomeResourceTypes_ActivateResource* will generate a method named *ActivateResource*

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2009" />R2009 ArraySchemaMustHaveItems
**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message**: Please provide an items property for array type: '{0}'.

**Description**: A schema of `array` type must always contain an `items` property. without it, AutoRest will fail to generate an SDK.

**Why the rule is important**: AutoRest needs to know the type of item contained in the array so that it can correctly generate the corresponding code.

**How to fix the violation**: Correctly specify the `items` section for given array type. The items can be of any primitive type or can be a reference to another object type.

**Good Examples**:
Example with primitive type.
```json
"MyPrimitiveArray":{
  "type": "array",
  "items": {
    type: "number"
  }
}
```
Example with object reference type
```json
"MyComplexArray":{
  "type": "array",
  "items": {
    "$ref": "#/definitions/MySimpleObject"
  }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2012" />R2012 XmsClientNameParameter
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Value of 'x-ms-client-name' cannot be the same as '{0}' Property/Model.

**Description**: The [`x-ms-client-name`](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) extension is used to change the name of a parameter or property in the generated code. By using the 'x-ms-client-name' extension, a name can be defined for use specifically in code generation, separately from the name on the wire. It can be used for query parameters and header parameters, as well as properties of schemas. This name is case sensitive.

**Why the rule is important**: This value cannot be same as parameter name or property name, because having the same name invalidates the usage.

**How to fix the violation**: Please specify non-empty `x-ms-client-name`, different from the model/property name that you'd like to be generated.

**Impact on generated code**: Generated SDK code will expose the corresponding client name on property or model.

**Examples**:
```json
  "parameters": [
    {
      "name": "If-Match",
      "in": "header",
      "required": false,
      "type": "string",
      "x-ms-client-name": "IfMatch",
      "description": "The ETag of the resource to match."
    },
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2013" />R2013 XmsClientNameProperty
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Value of 'x-ms-client-name' cannot be the same as '{0}' Property/Model.

**Description**: The [`x-ms-client-name`](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-client-name) extension is used to change the name of a parameter or property in the generated code. By using the 'x-ms-client-name' extension, a name can be defined for use specifically in code generation, separately from the name on the wire. It can be used for query parameters and header parameters, as well as properties of schemas. This name is case sensitive.

**Why the rule is important**: This value cannot be same as parameter name or property name, because having the same name invalidates the usage.

**How to fix the violation**: Please specify non-empty `x-ms-client-name`, different from the model/property name that you'd like to be generated.

**Impact on generated code**: Generated SDK code will expose the corresponding client name on property or model.

**Examples**:
```json
{
  "definitions": {
    "Product": {
      "x-ms-external" : true,
      "properties": {
        "product_id": {
          "type": "string",
          "x-ms-client-name": "SKU"
        }
     }
  }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1010" />R1010 AvoidMsdnReferences
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: For better generated code quality, remove all references to "msdn.microsoft.com".

**Description**: The documentation is being generated from the OpenAPI(swagger) and published at "docs.microsoft.com". From that perspective, documentation team would like to avoid having links to the "msdn.microsoft.com" in the OpenAPI(swagger) and SDK documentations.

**Why the rule is important**: Facilitate decoupling of "msdn.microsoft.com" from "docs.microsoft.com".

**How to fix the violation**: Please avoid using references to "msdn.microsoft.com" in title and descriptions.

**Impact on generated code**: N/A.

**Examples**: N/A.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1009" />R1009 DeleteInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'DELETE' operation '{0}' should use method name 'Delete'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'DELETE' operation on a resource should have "delete" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Delete` or `Delete`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Delete
* Delete
* StorageAccounts_delete
* delete

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1005" />R1005 GetInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'GET' operation '{0}' should use method name 'Get' or Method name start with 'List'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'GET' operation on a resource should have "get" or "list" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Get`, `NOUN_List`, `Get` or `List`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Get
* Resources_List
* Get
* List

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1003" />R1003 ListInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Since operation '{0}' response has model definition '{1}', it should be of the form "*_list*".

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines when response contains array of items.

**Why the rule is important**: Per ARM SDK guidelines, each 'GET' operation on a resource should have "list" in the name when operation has [x-ms-pageable](https://github.com/Azure/autorest/tree/master/docs/extensions#x-ms-pageable) extension. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_List`, `NOUN_ListBy***` or `List`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_List
* Resources_ListBySubscriptions
* List

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1006" />R1006 PutInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'PUT' operation '{0}' should use method name 'Create'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'PUT' operation on a resource should have "create" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Create` or `Create`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Create
* Resources_CreateOrUpdate
* Create

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1007" />R1007 PatchInOperationName
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'PATCH' operation '{0}' should use method name 'Update'. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: Verifies whether value for `operationId` is named as per ARM guidelines.

**Why the rule is important**: Per ARM SDK guidelines, each 'PATCH' operation on a resource should have "update" in the name. Guidelines are in place for a more consistent customer experience among ARM services SDKs.

**How to fix the violation**: Make sure that `operationId` is in the form of `NOUN_Update` or `Update`.

**Impact on generated code**: Operation name in the generated SDK will be named based on this.

**Examples**:
* Resources_Update
* Update

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3017" />R3017 GuidUsage
**Category** : ARM Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Guid used in model definition '{1}' for property '{0}'. Usage of Guid is not recommended. If GUIDs are absolutely required in your service, please get sign off from the Azure API review board.

**Description**: Verifies whether format is specified as "uuid" or not.

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), GUID usage are discouraged.

**How to fix the violation**: If GUIDs are absolutely required in your service, please get sign off from the Azure API review board.

**Impact on generated code**: Based on each language generator, this may affect SDK.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1011" />R1011 HttpsSupportedScheme
**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Azure Resource Management only supports HTTPS scheme.

**Description**: Verifies whether specification supports HTTPS scheme or not.

**Why the rule is important**: All the ARM specification should support HTTPS endpoint.

**How to fix the violation**: Please add `schemes` to the specification as shown in example below.

**Impact on generated code**: N/A.

**Examples**:
```json
"schemes": [
  "https"
]
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2004" />R2004 NonApplicationJsonType
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Only content-type 'application/json' is supported by ARM..

**Description**: Verifies whether operation supports "application/json" as consumes or produces section.

**Why the rule is important**: Per [ARM SDK guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-details.md#client-request-headers) only content-type 'application/json' is supported.

**How to fix the violation**: Make sure to include only 'application/json' in the spec consumes/produces. Make sure your service supports 'application/json'.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="R3030" />R3030 PathResourceProviderMatchNamespace
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The last resource provider '{0}' doesn't match the namespace.

**Description**: Verifies whether the last resource provider matches namespace or not. E.g the path /providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.Insights/extResource/{extType}' is allowed only if Microsoft.Insights matches the namespace (Microsoft.Insights). 

**Why the rule is important**: Per the [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each OpenAPI(swagger) specification must contain one resource provider. So the last resource provider must match with the resource provider namespace.

**How to fix the violation**: One OpenAPI(swagger) specification must locate in proper namespace. Namespace is parent folder. E.g. Microsoft.Insights. Please make sure the last resource provider name matches the namespace name. 
[Literate Configuration](https://github.com/Azure/autorest/blob/185e337137c990b9cc1b8ebbb272e76eeeef43a1/docs/user/literate-file-formats/configuration.md).

**Impact on generated code**: N/A.

**Examples**: 
**Bad Examples**: Following example contains 2 resource providers. **Microsoft.Compute** and **Microsoft.Network**.
```json
"paths": {
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces": {
      "get": {
        "tags": [
          "NetworkInterfaces"
        ],
        "operationId": "NetworkInterfaces_ListVirtualMachineScaleSetVMNetworkInterfaces",
        "description": "Gets information about all network interfaces in a virtual machine in a virtual machine scale set.",
        "parameters": [
          {
            "name": "resourceGroupName",
            "in": "path",
            "required": true,
            "type": "string",
            "description": "The name of the resource group."
          },
      ....
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways": {
      "get": {
        "tags": [
          "ApplicationGateways"
        ],
        "operationId": "ApplicationGateways_List",
        "description": "Lists all application gateways in a resource group.",
        "parameters": [
          {
            "name": "resourceGroupName",
            "in": "path",
            "required": true,
            "type": "string",
            "description": "The name of the resource group."
          },
      ....
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2006" />R2006 ControlCharactersNotAllowed
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: May not contain control characters:  Characters:'{0}' in:'{1}'

**Description**: Verifies whether if a specification does not have any control characters in it.
Control characters are not allowed in a specification.

**Why the rule is important**: Per ARM guidelines, a specification must not contain any control characters.

**How to fix the violation**: Remove the control characters in the specification.

**Examples**: A list of control characters in unicode can be found [here](https://unicode-table.com/en/).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2008" />R2008 MutabilityWithReadOnly
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**:  When property is modeled as "readOnly": true then x-ms-mutability extension can only have "read" value. When property is modeled as "readOnly": false then applying x-ms-mutability extension with only "read" value is not allowed. Extension contains invalid values: '{0}'

**Description**: Verifies whether a model property which has a readOnly property set has the appropriate `x-ms-mutability` options. If `readonly: true`, `x-ms-mutability` must be `["read"]`. If `readonly: false`, `x-ms-mutability` can be any of the `x-ms-mutability` options. More details about this extension can be found [here]( https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-mutability).

**Why the rule is important**: Not adhering to the rule violates how the x-ms-mutability extension works. A property cannot be `readonly: true` and yet allow `x-ms-mutability` as `["create", "update"]`. 

**How to fix the violation**: Based on the value of the `readOnly` property, assign appropriate `x-ms-mutability` options. 

**Bad Example**:
```json
  "prop0":{
    "type": "string",
    "readOnly":true,
    "x-ms-mutability": ["read", "update"]
  }
```
**Good Example**:
```json
  "prop0":{
    "type": "string",
    "readOnly": false,
    "x-ms-mutability": ["read", "update"]
  }
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2058" />R2058 XmsPathsMustOverloadPaths 
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Paths in x-ms-paths must overload a normal path in the paths section, i.e. a path in the x-ms-paths must either be same as a path in the paths section or a path in the paths sections followed by additional parameters. 

**Description**: The `x-ms-paths` extension allows us to overload an existing path based on path parameters. We cannot specify an `x-ms-paths` without a path that already exists in the `paths` section. For more details about this extension please refer [here](https://github.com/Azure/azure-rest-api-specs/blob/dce4da0d748565efd2ab97a43d0683c2979a974a/documentation/swagger-extensions.md#x-ms-paths).

**Why the rule is important**: The `x-ms-paths` overload an existing path only, not adhering to this rule would violate the applicability of the extension itself.

**How to fix the violation**: Ensure that the `x-ms-paths` is overloading an existing url path in the `paths` section.

**Good Example**:
```json
  "paths":{
    "/foo":{
      ...
    }
  },
  "x-ms-paths":{
    "/foo?op=baz":{
      ...
    }
  }
```
**Bad Example**:
```json
  "paths":{
    "/foo":{
      ...
    }
  },
  "x-ms-paths":{
    "/bar?op=baz":{
      ...
    }
  }
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2001" />R2001 AvoidNestedProperties
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Consider using x-ms-client-flatten to provide a better end user experience

**Description**: Nested properties can result into bad user experience especially when creating request objects. `x-ms-client-flatten` flattens the model properties so that the users can analyze and set the properties much more easily.

**Why the rule is important**: Overly nested properties (especially required ones) can result into a non optimal user experience.

**How to fix the violation**: Either eliminate nesting or use the `x-ms-client-flatten` property for a better user experience. More details about the extension can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/dce4da0d748565efd2ab97a43d0683c2979a974a/documentation/swagger-extensions.md#x-ms-client-flatten).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3008" />R3008 CollectionObjectPropertiesNaming
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Collection object '{0}' returned by list operation '{1}' with 'x-ms-pageable' extension, has no property named 'value'. 

**Description**: Per ARM guidelines, a model returned by an `x-ms-pageable` operation must have a property named `value`. This property indicates what type of array the object is.

**Why the rule is important**: To maintain consistency on how `x-ms-pageable` operations and corresponding response objects are modeled and to enable execution of other validation rules based on this consistent structure. More documentation about the extension can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-extensions.md#x-ms-pageable).

**How to fix the violation**: Ensure that the response object has a property named `value` of `array` type.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2027" />R2027 DefaultMustBeInEnum
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The default value is not one of the values enumerated as valid for this element.

**Description**: The value assigned as a default for an enum property must be present in the enums' list.

**Why the rule is important**: Generated SDKs in types languages may fail to compile if we try to enforce a default value that is not a part of the enums defined in the list and in other languages may fail in serialization/deserialization phases.

**How to fix the violation**: Ensure that the default desired actually exists in the enums' list.

**Bad Example**:
```json
"status":{
  "type": "string",
  "enum": [
    "Succeeded",
    "Updating",
    "Deleting",
    "Failed"
  ],
  "default": "Terminated"
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2047" />R2047 NamePropertyDefinitionInParameter
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Parameter Must have the "name" property defined with non-empty string as its value.

**Description**: A parameter must have a `name` property for the SDK to be properly generated. 

**Why the rule is important**: AutoRest fails to generate code if the `name` property is not provided for a parameter.

**How to fix the violation**: Add a non-empty `name` property to the parameter.

**Good Example**:
```json
"MyParam":{
  "name":"myParam",
  "type": "string",
  "in": "path",
  "description": "sample param"
}
```

**Bad Example**:
```json
"MyParam":{
  "type": "string",
  "in": "path",
  "description": "sample param"
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r1001" />R1001 OperationIdNounVerb
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Per the Noun_Verb convention for Operation Ids, the noun '{0}' should not appear after the underscore.

**Description**: OperationId should be of the form `Noun_Verb`. 

**Impact on generated code**: AutoRest breaks the operation id into its `Noun` and `Verb` where `Noun` becomes name of the operations class and the `Verb` becomes the name of the method in that class, i.e., operations are grouped inside the operations class named after the noun. Not adhering to this format can either cause AutoRest to fail or can generate semantically incorrect SDK.

**How to fix the violation**: Ensure operationId is of the form `Noun_Verb`.

**Bad Example**:
```
Activate_Certificate
CertificateActivate
```
**Good Example**:
```
Certificate_Activate
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2055" />R2055 OneUnderscoreInOperationId
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Only 1 underscore is permitted in the operation id, following Noun_Verb conventions.

**Description**: An operationId can have exactly one underscore, not adhering to it can cause errors in code generation.

**Why the rule is important**: Given an operationId of the form `Noun_Verb`, AutoRest breaks the operation id into its `Noun` and `Verb` where `Noun` becomes name of the operations class and the `Verb` becomes the name of the method in that class. Not adhering to this format can cause AutoRest to fail during code generation.

**How to fix the violation**: Ensure operationId is of the form `Noun_Verb` and contains exactly one underscore.

**Bad Example**:
```
Activate_Primary_Certificate
```
**Good Example**:
```
PrimaryCertificate_Activate
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3023" />R3023 OperationsAPIImplementation
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Operations API must be implemented for '{0}'.

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), each RP must expose an operations API that returns information about all the operations available with the service.

**Why the rule is important**: For better user experience. Users can query the service to get a list of all possible operations on a service and decide what they have to do.

**How to fix the violation**: Add an operations API endpoint (if not already present) and add details regarding this endpoint in the corresponding OpenAPI document. Examples can be found for most RPs in this repo.

**Example**: A typical operations path would look like
```json
"/providers/Microsoft.ResourceProviderName/operations": {
    "get": {
        "tags": [
            "Operations"
        ],
        "description": "Lists all of the available RP operations.",
        "operationId": "ListOperations",
        "parameters": [{
            "$ref": "#/parameters/apiVersionParameter"
        }],
        "responses": {
            "200": {
                "description": "OK. The request has succeeded.",
                "schema": {
                    "$ref": "#/definitions/OperationListResult"
                }
            },
            "default": {
                "description": "Resource Provider error response describing why the operation failed.",
                "schema": {
                    "$ref": "#/definitions/ErrorResponse"
                }
            }
        },
        "x-ms-pageable": {
            "nextLinkName": "nextLink"
        }
    }
}
```
A typical `OperationsList` and `Operation` model would look like
```json

"Operation": {
  "description": "REST API operation",
  "type": "object",
  "properties": {
    "name": {
      "description": "Operation name: {provider}/{resource}/{operation}",
      "type": "string"
    },
    "display": {
      "description": "The object that represents the operation.",
      "properties": {
        "provider": {
          "description": "Service provider: Microsoft.ResourceProvider",
          "type": "string"
        },
        "resource": {
          "description": "Resource on which the operation is performed: Profile, endpoint, etc.",
          "type": "string"
        },
        "operation": {
          "description": "Operation type: Read, write, delete, etc.",
          "type": "string"
        }
      }
    }
  }
},
"OperationListResult": {
  "description": "Result of the request to list Resource Provider operations. It contains a list of operations and a URL link to get the next set of results.",
  "properties": {
    "value": {
      "type": "array",
      "items": {
        "$ref": "#/definitions/Operation"
      },
      "description": "List of Resource Provider operations supported by the Resource Provider resource provider."
    },
    "nextLink": {
      "type": "string",
      "description": "URL to get the next set of operation list results if there are any."
    }
  }
},
```


Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2015" />R2015 ParameterNotDefinedInGlobalParameters
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Parameter "{0}" is referenced but not defined in the global parameters section of Service Definition

**Description**: Per ARM guidelines, if `subscriptionId` is used anywhere as a path parameter, it must always be defined as global parameter. `api-version` is almost always an input parameter in any ARM spec and must also be defined as a global parameter.

**Why the rule is important**: To reduce duplication, maintain consistent structure in ARM specifications.

**Impact on generated code**: `subscriptionId` and `api-version` are created as client properties in the generated code.

**How to fix the violation**: Ensure `subscriptionId` and `api-version` are declared in the global parameters section of the document.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2020" />R2020 RequiredPropertiesMissingInResourceModel
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Model definition '{0}' must have the properties 'name', 'id' and 'type' in its hierarchy and these properties must be marked as readonly.

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), a `Resource` model must have the `name`, `id` and `type` properties defined as `readOnly` in its hierarchy.

**Why the rule is important**: `name`, `type` and `id` are readonly properties set on the service end. Also, per ARM guidelines each `Resource` type model must have these properties defined in its hierarchy. An example `Resource` definition can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/master/specification/common-types/resource-management/v1/types.json#L9).

**How to fix the violation**: Ensure the `Resource` type model has the properties `name`, `type` and `id` and they are marked as `readOnly:true`. 

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2056" />R2056 RequiredReadOnlyProperties
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Property '{0}' is a required property. It should not be marked as 'readonly'.

**Description**: A model property cannot be both `readOnly` and `required`. A `readOnly` property is something that the server sets when returning the model object while `required` is a property to be set when sending it as a part of the request body.

**Why the rule is important**: SDK generation fails when this rule is violated.

**How to fix the violation**: Ensure that the given property is either marked as `readonly: true` or `required` but not both.

**Bad Example**:
```json
"MyModel": {
  "properties":{
    "MyProp":{
      "type": "string",
      "description": "sample prop",
      "readOnly": true
    }
  },
  "required": ["MyProp"]
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2014" />R2014 SubscriptionIdParameterInOperations
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Parameter "subscriptionId" is not allowed in the operations section, define it in the global parameters section instead/Parameter "{0}" is referenced but not defined in the global parameters section of Service Definition

**Description**: `subscriptionId` must not be an operation parameter and must be declared in the global parameters section.

**Why the rule is important**: Per ARM guidelines, `subscriptionId` must be set as a property on the generated client instead of the method signature. 

**How to fix the violation**: Remove `subscriptionId` from the operation parameters and add it to the global parameters section if it doesn't exist there.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2003" />R2003 ValidFormats
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: '{0}' is not a known format.

**Description**: Only valid types are allowed for properties.

**Why the rule is important**: Invalid formats can cause errors during code generation or result in erroneous generated code.

**How to fix the violation**: Ensure format defined for property is valid. Please refer [here](https://github.com/Azure/autorest/blob/81d4d31d06637f4f9ef042d7f2ec64cfea29892f/docs/developer/validation-rules/valid-formats.md) for allowed types in OpenAPI.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="d5001" />D5001 XmsExamplesRequired
**Category** : Documentation Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Please provide x-ms-examples describing minimum/maximum property set for response/request payloads for operations.{0}.

**Description**: Verifies whether [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples) are provided for each operation or not.

**Why the rule is important**: [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples) are used in model validation. [Benefits](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#benefits-of-x-ms-examples-extension)

**How to fix the violation**: Please refer the documentation of [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples).

**Impact on generated code**: N/A.

**Examples**: Please refer the documentation of [x-ms-examples](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/x-ms-examples.md#why-x-ms-examples).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2065" />R2065 LicenseHeaderMustNotBeSpecified
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: License header must not be specified inside x-ms-code-generation-settings. The license can vary for different SDKs generated and is passed via command line/config file when generating the SDK.

**Description**: `x-ms-code-generation-settings` must not have the license section specified in the OpenAPI documents since each generated SDK can have a different licensing header. This information must be provided either from the command line or the configuration file when actually generating the sdk.

**How to fix the violation**: Ensure the `x-ms-code-generation-settings` section does not have `header` property.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2025" />R2025 NextLinkPropertyMustExist
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The property '{0}' specified by nextLinkName does not exist in the 200 response schema. Please, specify the name of the property that provides the nextLink. If the model does not have the nextLink property then specify null.

**Description**: Per definition of AutoRest [x-ms-pageable extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable), the property specified by nextLinkName must exist in the 200 response schema.

**Why the rule is important**: Generated SDK may not work, as the nextLink won't be tied to a property of the response schema. 

**How to fix the violation**: Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable).

**Impact on generated code**: NextLink may be broken as property may not be found, paging may not work. Please note this may cause a breaking change in the generated SDK.

**Examples**: Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable) and [examples](https://github.com/Azure/azure-rest-api-specs/tree/master/documentation/x-ms-pageable).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2060" />R2060 PageableRequires200Response
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: A response for the 200 HTTP status code must be defined to use x-ms-pageable.

**Description**: Per definition of AutoRest [x-ms-pageable extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable), the response schema must contain a 200 response schema.

**Why the rule is important**: Pageable operation needs to have a response schema to be used by the SDK to serialize/deserialize the result. 

**How to fix the violation**: Add a 200 status code response with corresponding schema. Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable). Note that this may require a service side change and may be a breaking change.

**Impact on generated code**: Response schema is used to serialize/deserialize result, if 200 response is not specified, the generated SDK operation may not return the proper results, with the link its next page.

**Examples**: Please refer the documentation of [x-ms-pageable](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2024" />R2024 AnonymousBodyParameter
**Category** : SDK Error

**Applies to** : ARM specs

**Output Message**: Inline/anonymous models must not be used, instead define a schema with a model name in the "definitions" section and refer to it. This allows operations to share the models.

**Description**: This rule appears if in the parameter definition you have anonymous types. 

**Why the rule is important**: Anonymous parameters will be autogenerated as non-descriptive parameters which the client will not be able to share across operations or provide good documentation for, thereby resulting in poor user experience.

**How to fix the violation**: Move the schema to the definitions section and reference it using $ref.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2026" />R2026 AvoidAnonymousTypes
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Inline/anonymous models must not be used, instead define a schema with a model name in the "definitions" section and refer to it. This allows operations to share the models.

**Description**: This rule appears when you define a model type inline, rather than in the definitions section. If the model represents the same type as another parameter in a different operation, then it becomes impossible to reuse that same class for both operations.

**Why the rule is important**: Anonymous parameters will be autogenerated as non-descriptive parameters which the client will not be able to share across operations or provide good documentation for, thereby resulting in poor user experience.

**How to fix the violation**: Move the schema to the definitions section and reference it using $ref.

**Impact on generated code**: 

**Before**

Spec:
```json5
…
"parameters":[
    {
        "name": "foo",
        "in": "body",
        "schema": {
            "type": "object",
            "properties": {
                …
            }
        }
    }
]
…
```
Generated code:
```csharp
public class FooParameter1 {
    …
}
```
**After**

Spec:
```json5
…
"parameters": [
    {
        "name": "foo",
        "in": "body",
        "schema": {
            "$ref": "#/definition/FooCreationSettings"
        }
    }
],
…
"definitions": {
    "FooCreationSettings": {
        "type": "object",
        "properties": {
            …
        }
    }
}
…
```
Generated code:
```csharp
public class FooCreationSettings {
    …
}
```

**Examples**: N/A.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3019" />R3019 ArmResourcePropertiesBag
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Top level property names should not be repeated inside the properties bag for ARM resource '{0}'. Properties [{1}] conflict with ARM top level properties. Please rename these.

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), top level properties should not be repeated inside the properties bag for ARM resources.

**Why the rule is important**: [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md).

**How to fix the violation**: Rename or remove conflicting property. Note that this may require a change on the service side and may cause a breaking change.

**Examples**: 
**Bad example**: "id" property is repeated in the model, as "Resource" already contains "id".
```json5
"VersionedApplicationType": {
  "description": "The versioned application type resource",
  "properties": {
    "properties": {
      "id": {
        "type": "string",
        "description": "The name of the application type"
      }
    }
  },
  "allOf": [
  {
    "$ref": "#/definitions/Resource"
  }
  ]
},
"Resource":{  
  "properties":{  
    "id":{  
      "readOnly":true,
      "type":"string",
      "description":"Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
    },
    "name":{  
      "readOnly":true,
      "type":"string",
      "description":"The name of the resource"
    },
    "type":{  
      "readOnly":true,
      "type":"string",
      "description":"The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts."
    }
  },
  "x-ms-azure-resource": true
}
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3006" />R3006 BodyTopLevelProperties
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Top level properties should be one of name, type, id, location, properties, tags, plan, sku, etag, managedBy, identity, systemData, extendedlocation. Model definition '{0}' has extra properties ['{1}'].

**Description**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), top level properties of a resource should be only ones from the allowed set.

**CreatedAt** : N/A

**LastModifiedAt** : February 18, 2020

**Why the rule is important**: [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md). 

**How to fix the violation**: Consider moving extra properties into "properties" bag of the resource model.

**Examples**: 
**Bad example**: "extraProperty" is not allowed at top level of the resource model.
```json5
"VersionedApplicationType": {
  "description": "The versioned application type resource",
  "properties": {
    "extraProperty": {
      "type": "string",
      "description": "Extra property description"
    }
  },
  "allOf": [
  {
    "$ref": "#/definitions/Resource"
  }
  ]
}
```
**Good example**: Notice that "extraProperty" is inside "properties" bag, and not at top level.
```json5
"VersionedApplicationType": {
  "description": "The versioned application type resource",
  "properties": {
    "properties":{
      "extraProperty": {
        "type": "string",
        "description": "Extra property description"
      }
    }
  },
  "allOf": [
  {
    "$ref": "#/definitions/Resource"
  }
  ]
}
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2057" />R2057 InvalidSkuModel
**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Sku Model definition '{0}' is not valid. A Sku model must have 'name' property. It can also have 'tier', 'size', 'family', 'capacity' as optional properties.

**Description**: Sku model definition needs to follow [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md) and can contain only a certain set of properties as described in the message. 

**Why the rule is important**: Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md).

**How to fix the violation**: Update the sku model definition.

**Examples**: N/A

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2018" />R2018 XmsEnumValidation
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The enum types should have x-ms-enum type extension set with appropriate options. Property name: {0}.

**Description**: AutoRest defines [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) to provide more flexibility for enum types, please refer to the documentation.

**Why the rule is important**: Including [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) provides more flexibility for enum types in SDK generated code.

**How to fix the violation**: Include the [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum) per indicated in its documentation. Consider setting "modelAsString": true, if you'd like the enum to be modeled as a string in generated SDKs, no enum validation will happen, though the values are exposed to the user for a better experience.

**Examples**: Please refer to [x-ms-enum extension](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-enum).

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2063" />R2063 OperationIdNounConflictingModelNames
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: OperationId has a noun that conflicts with one of the model names in definitions section. The model name will be disambiguated to '{0}Model'. Consider using the plural form of '{1}' to avoid this. Note: If you have already shipped an SDK on top of this spec, fixing this warning may introduce a breaking change.

**Description**: The first part of an operation Id separated by an underscore i.e., `Noun` in a `Noun_Verb` should not conflict with names of the models defined in the definitions section. If this happens, AutoRest appends `Model` to the name of the model to resolve the conflict (`NounModel` in given example) with the name of the client itself (which will be named as `Noun` in given example). This can result in an inconsistent user experience.

**Why the rule is important**: To ensure all models are named consistently and exactly as defined in the spec.

**How to fix the violation**: Ensure operation Ids are named in such a way that the `Noun` in `Noun_Verb` is of the plural form and does not conflict with the names of any models in the definitions section of the spec.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2054" />R2054 SecurityDefinitionsStructure
**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: Every OpenAPI(swagger) spec/configuration must have a security definitions section and it must adhere to the structure described [here](https://github.com/Azure/azure-openapi-validator/blob/master/docs/security-definitions-structure-validation.md)

**Description**: Each OpenAPI json document must contain a security definitions section and the section must adhere to a certain format.

**Why the rule is important**: Missing security definitions section does not describe the Azure services security model accurately. This is an ARM specific requirement which describes the security mechanism to access the services.

**How to fix the violation**: Ensure that the document has a security definition section as described [here](https://github.com/Azure/azure-openapi-validator/blob/master/docs/security-definitions-structure-validation.md)

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2019" />R2019 ResourceHasXMsResourceEnabled
**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: A 'Resource' definition must have x-ms-azure-resource extension enabled and set to true.

**Description**: A 'Resource' definition must have x-ms-azure-resource extension enabled and set to true. This will indicate that the model is an Azure resource.

**Why the rule is important**: This will ensure that the 'Resource' definition is designed correctly in code generation.Please refer [here](./swagger-extensions.md#x-ms-azure-resource) for further details.

**How to fix the violation**: Ensure that the 'Resource' definition has x-ms-azure-resource extension enabled and set to true.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2017" />R2017 PutRequestResponseScheme
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: A PUT operation request body schema should be the same as its 200 response schema, to allow reusing the same entity between GET and PUT. If the schema of the PUT request body is a superset of the GET response body, make sure you have a PATCH operation to make the resource updatable. Operation: '{0}' Request Model: '{1}' Response Model: '{2}'

**Description**: The request & response('200') schema of the PUT operation must be same.

**Why the rule is important**: This will provide a consistent experience to the user, i.e. the user could use the same model object to perform various operations. Also, within the SDK, this will encourage reuse of the same model objects.

**How to fix the violation**: Ensure the request & response('200') schema of the PUT operation must be same. This might involve a service side change which will result cause a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2005" />R2005 LongRunningResponseStatusCode
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: A '{0}' operation '{1}' with x-ms-long-running-operation extension must have a valid terminal success status code {2}.

**Description**: For ARM spec, the allowed response status codes for a long DELETE operation are "200" & "204"; the allowed response status codes for a POST operation are "200", "201" ,"202", & "204"; the allowed response status codes for a PUT/PATCH operation are  "200" & "201".
                 For Data plane spec, the allowed response status codes for a long DELETE operation are "200","202", & "204"; the allowed response status codes for a POST operation are "200", "201" ,"202", & "204"; the allowed response status codes for a PUT/PATCH operation are  "200","201", & "202".

**Why the rule is important**: This will ensure that the DELETE/POST/PUT operations are designed correctly.Please refer [here](./swagger-extensions.md#x-ms-long-running-operation) for further details.

**How to fix the violation**: Ensure that the DELETE/POST/PUT operations have the allowed response codes.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2044" />R2044 InvalidVerbUsed
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Permissible values for HTTP Verb are DELETE, GET, PUT, PATCH, HEAD, OPTIONS, POST, TRACE.

**Description**: Each operation definition must have a HTTP verb and it must be DELETE/GET/PUT/PATCH/HEAD/OPTIONS/POST/TRACE.

**Why the rule is important**: DELETE/GET/PUT/PATCH/HEAD/OPTIONS/POST/TRACE are the only valid HTTP operations.

**How to fix the violation**: Provide a correct HTTP verb.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3007" />R3007 PutGetPatchResponseSchema
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} has different responses for PUT/GET/PATCH operations. The PUT/GET/PATCH operations must have same schema response.

**Description**: For a given path with PUT, GET and PATCH operations, the schema of the response must be the same.

**Why the rule is important**: This will provide a consistent experience to the user, i.e. the user could use the same model object to perform various operations. Also, within the SDK, this will encourage reuse of the same model objects.

**How to fix the violation**: Ensure that, for a given path with PUT, GET and PATCH operations, the schema of the response is same. This might involve a service side change which will result in a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3013" />R3013 DeleteMustNotHaveRequestBody
**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 'Delete' operation '{0}' must not have a request body.

**Description**: The request body of a delete operation must be empty.

**Why the rule is important**: This will ensure that the delete operation aligns with the [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md).

**How to fix the violation**: Ensure that the request body of the delete operation is empty. This may involve a service side change and may cause a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2062" />R2062 XmsResourceInPutResponse
**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: The 200 response model for an ARM PUT operation must have x-ms-azure-resource extension set to true in its hierarchy. Operation: '{0}' Model: '{1}'.

**Description**: The 200 response model for an ARM PUT operation must have x-ms-azure-resource extension set to true in its hierarchy. Operation: '{0}' Model: '{1}'.

**Why the rule is important**: This will ensure that the PUT operation actually returns a resource model.Please refer [here](./swagger-extensions.md#x-ms-azure-resource) for details on x-ms-azure-resource extension.

**How to fix the violation**: Ensure that the 200 response model for an ARM PUT operation must have x-ms-azure-resource extension set to true in its hierarchy.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3060" />R3060 XmsPageableListByRGAndSubscriptions
**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message**: For the tracked resource '{0}', the x-ms-pageable extension values must be same for list by resource group and subscriptions operations.

**Description**: When a tracked resource has list by resource group and subscription operations, the x-ms-pageable extension values must be same for both operations. A tracked resource is a resource with a 'location' property as required. If this rule flags a resource which does not have a 'location' property, then it might be a false positive.

**Why the rule is important**: This will provide a consistent experience to the user, i.e. the user could expect the same behavior for both list by subscription and resource group. Please refer [here](./swagger-extensions.md#x-ms-pageable) for details on the x-ms-pageable extension.

**How to fix the violation**: Ensure that when a tracked resource has list by resource group and subscription operations, the x-ms-pageable extension values are same for both operations. This might involve a service side change which will result in a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2064" />R2064 LROStatusCodesReturnTypeSchema
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: 200/201 Responses of long running operations must have a schema definition for return type. OperationId: '{0}', Response code: '{1}'

**Description**: The '200'/'201' responses of the long running operation must have a schema definition. 

**Why the rule is important**: Please refer [here](./swagger-extensions.md#x-ms-long-running-operation) for details on the x-ms-long-running-operation. The '201' response code indicates 'Created' & '200' response code indicates 'Success'. In either case, it is logical for the response to be the same.

**How to fix the violation**: Ensure that the '200'/'201' responses of the long running operation has a schema definition. This might involve a service side change which will result in a breaking change in the generated SDK.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2016" />R2016 PatchBodyParametersSchema
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Properties of a PATCH request body must not be {0}. PATCH operation: '{1}' Model Definition: '{2}' Property: '{3}'

**Description**: A request parameter of the Patch Operation must not have a required/default value.
But it's allowed when the only required properties is marked as discriminator, because the discriminator must be required.

**CreatedAt** : N/A

**LastModifiedAt** : February 18, 2020

**Why the rule is important**: A PATCH operation is used to update properties of a resource. So, If the resource has 'X' number of properties and if you wish to change one of them, then a PATCH request could be sent with a value for that specified property. In other words, all the properties in the PATCH request are updated. Now, if any of the values are marked as required/default, it would force the system to update it always which is not the intention of the PATCH operation.

**How to fix the violation**: Ensure that the request parameter of the Patch Operation does not have a required/default value.A recommended way is to define a new model that only contains the patchable properties to replace the original parameter in request body. 

**Good Examples**: The following is a good example:
```json
......
......
  "patch": {
    "tags": [
      "SampleTag"
    ],
    "operationId": "Foo_Update",
    "description": "Test Description",
    "parameters": [
      {
        "name": "foo_patch",
        "in": "body",
        "schema": {
          "$ref": "#/definitions/FooRequestParams"
        },
        "description": "foo patch request"
      }
    ]
 }
......
......
  "definitions": {
    "FooRequestParams": {
      "properties": {
        "prop0": {
          "type": "string"
        }
      },
      "required": []
    }
  }
......
......
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4000" />R4000 ParameterDescriptionRequired
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} lacks 'description' property. Consider adding a 'description' element. Accurate description is essential for maintaining reference documentation.

**Description**: A parameter must have 'description' property.

**Why the rule is important**: Appropriate documentation could not be generated without the 'description' property.

**How to fix the violation**: For each parameter, provide a 'description' property.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4000-3" />R4020 DescriptiveDescriptionRequired
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The value provided for description is not descriptive enough. Accurate and descriptive description is essential for maintaining reference documentation.

**Description**: The value of the 'description' property must be descriptive. It cannot be spaces or empty description.

**Why the rule is important**: Appropriate documentation could not be generated without a detailed 'description' value.

**How to fix the violation**: For each 'description' property, provide a detailed description value.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4000-4" />R4021 DescriptionAndTitleMissing
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} lacks 'description' and 'title' property. Consider adding a 'description'/'title' element. Accurate description/title is essential for maintaining reference documentation.

**Description**: The definition must have at least one of the properties - description/title.

**Why the rule is important**: Appropriate documentation could not be generated without the 'description'/'title' property.

**How to fix the violation**: For each definition, provide at least one of the properties - description/title.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4000-5" />R4022 OperationDescriptionOrSummaryRequired
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: {0} lacks 'description' and 'summary' property. Consider adding a 'description'/'summary' element. Accurate description/summary is essential for maintaining reference documentation.

**Description**: Every operation must have a 'description'/'summary' property.

**Why the rule is important**: Appropriate documentation could not be generated without the 'description'/'summary' property.

**How to fix the violation**: For each operation, provide at least one of the property - description/summary.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2023" />R2023 SummaryAndDescriptionMustNotBeSame
**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: The summary and description values should not be same.

**Description**: Each operation has a summary and description values. They must not be same.

**Why the rule is important**: The summary must provide a short summary of the operation. The description must provide a detailed description of the operation. This will ensure that all the operations are well documented. 

**How to fix the violation**: Provide a short summary for the summary section and a detailed description for the description section.

**Good Examples**: The following operation is a good example:
```json
......
......
"put": {
  "summary": "Creates or Updates an availability set",
  "description": "This operation creates or updates an availability set. This takes the resourceGroupName and availabilitySetName as input. If an availability set with the same name exists, then the same is updated. Else a new availability set is created.",
  .....
  .....
}
......
......
```

**Bad Examples**: The following would be invalid:
```json
......
......
"put": {
  "summary": "Creates or Updates an availability set",
  "description": "Creates or Updates an availability set",
  .....
  .....
}
......
......
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3011" />R3011 DescriptionMustNotBeNodeName
**Category** : ARM Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message**: Description must not match the name of the node it is supposed to describe.

**Description**: Description section must provide details on the current operation or model. Using the name of node in description does not provide any value.

**Why the rule is important**: The description must provide a detailed description of the current context. This will ensure that all the operations and models are well documented. 

**How to fix the violation**: Provide detailed description of the node in the description section.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4001" ></a>R4001 XmsParameterLocation

**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : The parameter '{your parameter name}' is defined in global parameters section without 'x-ms-parameter-location' extension. This would add the parameter as the client property. Please ensure that this is exactly you want. If so, apply the extension "x-ms-parameter-location": "client". Else, apply the extension "x-ms-parameter-location": "method".

**Description** : SDKs generated by AutoRest have two types of operation parameters: method arguments and client fields. The `x-ms-parameter-location` extension gives the Swagger author control of how an operation-parameter will be interpreted by AutoRest, and as such is one of few things in a Swagger document that has semantic value only relevant to the shape of the generated SDKs.

Some parameters, such as API Version and Subscription ID will make sense as part of nearly every request. For these, having developers specify them for each method call would be burdensome; attaching them to the client and automatically including them in each request makes way more sense. Other parameters will be very operation specific and should be provided each time the method is called.

**Why this rule is important**: Without providing the parameter-location, constructor parameter lists end up incorporating entries that are only relevant to one of the methods that belong to a type. Needless to say, this can spiral out of control and turn your SDKs into gunk.

**How to fix the violation**: For each parameter in the document-level "parameters" section of your document provide either:
``` json
"x-ms-parameter-location":"method"
```

or 

``` json
"x-ms-parameter-location":"client"
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2010" ></a>R2010 LongRunningOperationsOptionsValidator

**Category** : SDK Warning

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : A LRO Post operation with return schema must have "x-ms-long-running-operation-options" extension enabled.

**Description** : This is a rule introduced to make the understanding of Long Running Operations more clear. 

In case of LRO Post operation with return schema, it MAY be ambiguous for the SDK to understand automatically what the return schema is modeling. To avoid any confusion that would lead SDK to incorrectly instantiate the return type, service team needs to explain if the return schema is modeling a result from a "Location" header, or from an "Azure-AsyncOperation" header.

More details on LRO operation could be found [here](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-long-running-operation)

**How to fix the violation**: For a Post LRO operation, add "x-ms-long-running-operation-options" extension with "final-state-via" property.
``` json
"x-ms-long-running-operation-options": {
  "final-state-via": "location"
}
```

or

``` json
"x-ms-long-running-operation-options": {
  "final-state-via": "azure-async-operation"
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)


### <a name="r4004" ></a>R4004 OperationIdRequired

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : Missing operationId. path:'${operation path}' operation:'${operation}'.

**Description** : Each operation must have a unique operationId.

**CreatedAt** : February 18, 2020

**LastModifiedAt** : February 18, 2020

**Why this rule is important**: Per [creating-swagger](creating-swagger.md#Paths),The operationId is used to determine the generated method name.

**How to fix the violation**: Add the right operationId for each operation

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3020" ></a>R3020 PathResourceProviderNamePascalCase

**Category** : ARM Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : Resource provider naming must follow the pascal case. Path: {your path}

**Description** :

Resource provider naming in path SHOULD follow the pascal case. (e.g. Microsoft.Insights/components/proactiveDetectionConfigs)

For more detail, pls refer to https://github.com/microsoft/api-guidelines/blob/vNext/Guidelines.md#172-casing 

**CreatedAt**: February 18, 2020

**LastModifiedAt**: February 18, 2020

**How to fix the violation**: 

Rename resource provider as pascal case in path.

Eg: In this case, you need to replace `Microsoft.computer` with `Microsoft.Computer` to follow pascal case.


Invalid: 

```
paths : { "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.computer/{name}" : {
    "get": {
       ...
    }
    "post": {
      ...
    }
  }
}
```

Valid:


```
paths : { "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Computer/{name}" : {
    "get": {
       ...
    }
    "post": {
      ...
    }
  }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3021" ></a>R3021 PathResourceTypeNameCamelCase

**Category** : ARM Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : Resource type naming SHOULD follow camel case. Path: {your path}

**Description** : Resource type or other identifiers (include: namespace, entityTypes) SHOULD follow camel case. (e.g. Microsoft.Insights/components/proactiveDetectionConfigs, not ProactiveDetectionConfig)

For more detail, pls refer to https://github.com/microsoft/api-guidelines/blob/vNext/Guidelines.md#172-casing 

**CreatedAt**: February 18, 2020

**LastModifiedAt**: February 18, 2020

**How to fix the violation**: 

Rename resource type or other identifiers as camel case in path.

Eg: In this case, you need to replace `ResourceGroups` with `resourceGroups` to follow camel case.


Invalid: 

```
paths : { "/subscriptions/{subscriptionId}/ResourceGroups/{resourceGroupName}/providers/Microsoft.Computer/{name}" : {
    "get": {
       ...
    }
    "post": {
      ...
    }
  }
}
```

Valid:


```
paths : { "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Computer/{name}" : {
    "get": {
       ...
    }
    "post": {
      ...
    }
  }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3024" ></a>R3024 EnumUniqueValue

**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : Enum must not contain duplicated value (case insensitive).

**Description** : Enum must not contain duplicated value (case insensitive).

**CreatedAt**: February 18, 2020

**LastModifiedAt**: February 18, 2020

**How to fix the violation**: 

Remove duplicated value in enum.

Eg: In this case, you need to remove 'Failed' or 'FAILED'.


Invalid: 

```
"enum": [
            "Success",
             "Failed",
             "FAILED"
]
```

Valid:


```
"enum": [
            "Success",
             "Failed",
]
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r3015" ></a>R3015 EnumMustHaveType

**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : Enum must define its type. All values in an enum must adhere to the specified type. 

**Description** : Enum must define type, and type must not be object. Or it will fail SDK auto-generation.

**CreatedAt**: February 18, 2020

**LastModifiedAt**: February 20, 2020

**How to fix the violation**: 

Define type in enum.

Invalid: 

```
"status":{ 
   "description":"The state code.",
   "enum":[ 
      "Success",
      "Failed"
   ],
   "readOnly":true,
   "x-ms-enum":{ 
      "name":"RespStatus",
      "modelAsString":true
   }
}
```

Valid:


```
"status":{ 
   "description":"The state code.",
   "enum":[ 
      "Success",
      "Failed"
   ],
   "readOnly":true,
   "type": "string",
   "x-ms-enum":{ 
      "name":"RespStatus",
      "modelAsString":true
   }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)


### <a name="r3029" ></a>R3029 EnumMustNotHaveEmptyValue

**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : Enum value must not contain empty value.

**Description** : Enum must not be empty, or contain special character, like space, tab, etc. It will lead to code generation failure in downstream pipeline.

**CreatedAt**: February 18, 2020

**LastModifiedAt**: February 18, 2020

**How to fix the violation**: 

Remove empty string from enum.

Invalid: 

```
"enum":[ 
   "Success",
   "Failed",
   "       "
]
```

Valid:


```
"enum":[ 
   "Success",
   "Failed",
]
```


Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r2007" ></a>R2007 LongRunningOperationsWithLongRunningExtension

**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The operation '{0}' returns 202 status code, which indicates a long running operation, please enable 'x-ms-long-running-operation'.  

**Description** : Per [x-ms-long-running-operation](./swagger-extensions.md#x-ms-long-running-operation) ,The operation which returns 202 status code indicates a long running operation. Every long running operation must have the x-ms-long-running-operation enabled.

**How to fix the violation**: 
Having the "x-ms-long-running-operation" enabled.
Eg:
```json
......
......
 "put": {
        "operationId": "Foo_Create",
        "responses": {
          "202": {
            "description": ""
          },
          "x-ms-long-running-operation": true
        }
      }
......
......
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)


### <a name="r2029" ></a>R2029 PageableOperation

**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message** : Based on the response model schema, operation '${operationId}' might be pageable. Consider adding the x-ms-pageable extension.  

**Description** : This rule was introduced to check if a pageable operation has x-ms-pageable enabled.

**How to fix the violation**: 
Having the x-ms-pageable enabled if the operation is pageable.
Eg:
```json
......
......
  "get": {
        "operationId": "Foo_List",
        "responses": {
          "200": {
            "description": ". ",
            "schema": {
              "$ref": "#/definitions/ant"
            }
          }
        },
        "x-ms-pageable": {
          "nextLinkName": "nextLink"
        }
      }
......
......
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4005" ></a>R4005 UniqueXmsEnumName

**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message** : Must not have duplicate name in x-ms-enum extension , make sure every x-ms-enum name unique.  

**Description** : This rule will check all the swagger files with the same api-version, and ensure there is no duplicate x-ms-enum name. 
The following cases are deemed as violation:
1. if two enums have the same x-ms-enum name , but types are different.
2. if two enums have the same x-ms-enum name , but 'modelAsString' are different.
3. if two enums have the same x-ms-enum name , but include different values.
4. if two enums have the same x-ms-enum name and 'modelAsString' is false , but enums' values have different order.

**CreatedAt**: March 18, 2020

**LastModifiedAt**: January 14, 2021

**How to fix the violation**: Update the duplicate x-ms-enum name :

The following would be invalid:
```json
    "State": {
        "description": "The state of the configuration store.",
        "enum": [
            "Failed",
            "Canceled"
        ],
        "type": "string",
        "readOnly": true,
        "x-ms-enum": {
            "name": "DuplicateName",
            "modelAsString": true
        }
    },
    "status": {
        "description": "The state code.",
        "enum": [
            "Success",
            "FAILED"
        ],
        "readOnly": true,
        "type": "string",
        "x-ms-enum": {
            "name": "DuplicateName",
            "modelAsString": true
        }
    }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4006" ></a>R4006 DeprecatedXmsCodeGenerationSetting

**Category** : SDK Warning

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message** : The x-ms-code-generation-setting extension is being deprecated. Please remove it and move settings to readme file for code generation.

**Description** : The x-ms-code-generation-settings is being deprecated. AutoRest (v3) is using settings in readme file for code generation and will stop supporting it inside the swagger file. Please ensure to remove the parameter from swagger spec and move settings to readme.

**CreatedAt**: March 18, 2020

**LastModifiedAt**: March 18, 2020

**How to fix the violation**: Since the only value of this extension today is to override the client name, which could be done with a 'title' line in the readme file,you could remove the extension from swagger spec and move settings to readme.

The following would be invalid:

```json
 "info": {
    "version": "2016-05-16",
    "x-ms-code-generation-settings": {
      "name": "AnalysisServicesManagementClient"
    }
  }
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4007" ></a>R4007 DefaultErrorResponseSchema

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The default error response schema SHOULD correspond to the schema documented at https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-details.md#error-response-content.

**Description** : The default error response schema SHOULD correspond to the schema documented at [common-api-details](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-details.md#error-response-content).

**CreatedAt**: April 2, 2020

**LastModifiedAt**: April 2, 2020

**How to fix the violation**: Following the ARM specification to modify the schema in the swagger file.
It's recommended to refer to the 'ErrorResponse' in [v2/types.json](https://github.com/Azure/azure-rest-api-specs/blob/master/specification/common-types/resource-management/v2/types.json#L273) which is provided for fixing the error.

The following would be invalid:

```json
"definitions": {
  "ErrorResponse": {
     "properties": {
       "code": {
         "readOnly": true,
         "type": "string",
         "description": "The error code."
       },
       "message": {
         "readOnly": true,
         "type": "string",
         "description": "The error message."
       }
       ...
     }
  }
}
```

the correct schema:

```json
"definitions": {
  "ErrorResponse": {
     "properties": {
        "error": {
          "type": "object",
          "description": "The error object.",
          "properties": {
            "code": {
              "readOnly": true,
              "type": "string",
              "description": "The error code."
            },
            "message": {
              "readOnly": true,
              "type": "string",
              "description": "The error message."
            }
            ...
        }
     }
  }
}

```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4008" ></a>R4008 AvoidEmptyResponseSchema

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : Response schema must not be empty.

**Description** : Response schema must not be empty, or it will block code generation.

**CreatedAt**: April 2, 2020

**LastModifiedAt**: April 2, 2020

**How to fix the violation**: Add the correct definition of the schema in the response or remove it if don't need.

The following would be invalid:

```json
...
 "response":{
   "default": {
     "schema":{
     }
  }
 }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4009" ></a>R4009 RequiredReadOnlySystemData

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : 
1. if missing the systemData , output:
The response of operation '{operationId}' is defined without 'systemData'. Consider adding the systemData to the response.

2. if the systemData is not read only, output:
The property systemData in the response of operation:'${operationId}' is not read only. Please add the readonly for the systemData.

**Description** : Per [common-api-contracts](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-contracts.md#system-metadata-for-all-azure-resources), all Azure resources should implement the `systemData` object property in new api-version. The systemData should be readonly.

**CreatedAt**: May 21, 2020

**LastModifiedAt**: February 26, 2021

**How to fix the violation**: For each response in the GET/PUT/PATCH operation add a readonly systemData property. 
It's recommended to refer to the 'systemData' defined in [v2/types.json](https://github.com/Azure/azure-rest-api-specs/blob/7dddc4bf1e402b6e6737c132ecf05b74e2b53b08/specification/common-types/resource-management/v2/types.json#L445) which is provided for fixing the error.
``` json
"MyResource": {
  "properties": {
    ...
    ...
    "systemData": {
      "$ref": "v2/types.json#/definitions/systemData",
       "readOnly" : true
    }
  }
}

```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4010" ></a>R4010 RequiredDefaultResponse

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The response is defined without a default error response implementation,please add it. 

**Description** : Per ARM Specs, every operation must have a default error response implementation.

**CreatedAt**: May 21, 2020

**LastModifiedAt**: May 21, 2020

**How to fix the violation**: For each operation response, please add a default error response implementation:
The following would be valid:

```json
...
 "responses":{
   "default": {
     "schema":{
       "$ref":#/definition/Error
     }
  }
 }
...
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)


### <a name="r4011" ></a>R4011 DeleteOperationResponses

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The delete operation is defined without a 200 or 204 error response implementation,please add it. 

**Description** : Per ARM Specs, all DELETE methods must have responses code implementation: 200, 204.   

**CreatedAt**: May 21, 2020

**LastModifiedAt**: May 21, 2020

**How to fix the violation**: For each operation response, please add the missing code response implementation:

The following would be valid:

```json
...
"path1":{
 "delete": {
   "parameters": [
     .....
     .....
   ]
  "response":{
   "default": {
     "schema":{
       "$ref":#/definition/Error
     }
   },
   "200": {
     "schema":{
       "$ref":#/definition/response
     }
   },
   "204": {
     "schema":{
       "$ref":#/definition/response
     }
   }
  }
 }
}
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4012" ></a>R4012 XmsPageableMustHaveCorrespondingResponse

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The operation: '{operation name}' is defined with x-ms-pageable enabled,but can not find the corresponding nextLink property in the response, please add it.

**Description** :  Per [extensions](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-pageable) ,when specifying a x-ms-pageable/nextLinkName, the corresponding nextlink property must be defined in the response schema.

**CreatedAt**: May 21, 2020

**LastModifiedAt**: May 21, 2020

**How to fix the violation**: Add the missing corresponding property like nextLink in response:

The following would be valid:

```json
...
"get":{
  ....
   "x-ms-pageable": {
          "nextLinkName": "nextLink"
  },
  ....
  "response":{
   "200": {
     "schema":{
       "description": "The list of metric items.",
        "type": "object",
        "properties": {
          "nextLink": {
            "description": "The link used to get the next page of operations.",
            "type": "string"
          }
        ....
     }
   }
  }
  ....
 }
}
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4013" ></a>R4013 IntegerTypeMustHaveFormat

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The integer type does not have a format, please add it.

**Description** :  The type:integer must have a required format. Possible value for format are int32 and int64.

**CreatedAt**: May 21, 2020

**LastModifiedAt**: May 21, 2020

**Why this rule is important**: Right now it's possible to type a field as integer, but not specifying format. It actually creates problems for generate when the number of bits matter, like C#.

**How to fix the violation**: Add the correct format for integer type:

The following would be valid:

```json
...
  "incomingChanges": {
          "type": "integer",
          "format": "int64",
      ....
  }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4014" ></a>R4014 AllResourcesMustHaveGetOperation

**Category** : ARM Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The resource "{0}" does not have get operation, please add it.

**Description** : Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md) ,all the resources ,including top-level and nested resources, must have a get operation. 

**CreatedAt**: July 13, 2020

**LastModifiedAt**: July 13, 2020

**How to fix the violation**: 
Since all the models that having 'x-ms-azure-resource' enabled are considered as ARM resource,
If the output resource is not exactly a ARM resource,you should remove the extension from the model. 
Otherwise,for each resource which doesn't have a get operation,add the corresponding get operation. 

For example:

```json
"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MyNameSpace/MyResourceType/{Name}/SubResource/{subName}": {
      "get": {
         ...
        "operationId": "SubResource_Get",
        "parameters": [
         
        ],
        "responses": {
          "200": {
            "schema": {
              "$ref": "#/definitions/SubResource"
            }
          },
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4015" ></a>R4015 NestedResourcesMustHaveListOperation

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The nested resource "{0}" does not have list operation, please add it.

**Description** : Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), all the nested must have a list operation which returns the collection of the resource.

**CreatedAt**: July 13, 2020

**LastModifiedAt**: July 13, 2020

**How to fix the violation**: For each nested resource, add the corresponding list operation.

For example:

```json
...
   "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MyNameSpace/MyTopLevelResourceType/{name}/MySubResource": {
      "get": {
        ...
        ...
        "description": "Handles requests to list all resources in a service.",
        "operationId": "MySubResource_List",
        ...
        "responses": {
          "200": {
            "description": "Success. The response describes the list of Services in the service.",
            "schema": {
              "$ref": "#/definitions/MySubResourceList"
            }
          }
        },
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4016" ></a>R4016 TopLevelResourcesListByResourceGroup

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The top-level resource "{0}" does not have list by resource group operation, please add it.

**Description** : Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), all the top-level resources must have a list by resource group operation which returns the collection of the resource. 

**CreatedAt**: July 13, 2020

**LastModifiedAt**: July 13, 2020

**How to fix the violation**: For each top-level resource, add the corresponding list by resource group operation.

For example:

```json
...
   "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MyNameSpace/MyTopLevelResourceType": {
      "get": {
        ...
        ...
        "description": "Handles requests to list all resources in a resource group.",
        "operationId": "Services_ListByRG",
        ...
        "responses": {
          "200": {
            "description": "Success. The response describes the list of Services in the subscription.",
            "schema": {
              "$ref": "#/definitions/MyTopLevelResourceList"
            }
          }
        },
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4017" ></a>R4017 TopLevelResourcesListBySubscription

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The top-level resource "{0}" does not have list by subscription operation, please add it.

**Description** : Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md), all the top-level resources must have a list by subscription operation which returns the collection of the resource. 

**CreatedAt**: July 13, 2020

**LastModifiedAt**: July 13, 2020

**How to fix the violation**: For each top-level resource, add the corresponding list operation.

For example:

```json
...
  "/subscriptions/{subscriptionId}/providers/Microsoft.MyNameSpace/MyTopLevelResourceType": {
      "get": {
        ...
        ...
        "description": "Handles requests to list all resources in a subscription.",
        "operationId": "Services_ListBySubscription",
        ...
        "responses": {
          "200": {
            "description": "Success. The response describes the list of Services in the subscription.",
            "schema": {
              "$ref": "#/definitions/MyTopLevelResourceList"
            }
          }
        },
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4018" ></a>R4018 OperationsApiResponseSchema

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The response schema of operations API "{0}" does not match the ARM specification. Please standardize the schema.

**Description** : The operations API should have a response body schema consistent with the [contract spec](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/proxy-api-reference.md#exposing-available-operations). The required properties such as `isDataAction`,`display.description` and `display.resource`,must be included.

**CreatedAt**: July 13, 2020

**LastModifiedAt**: July 13, 2020

**How to fix the violation**:  For each operations API ,provide a schema which consistent with the above contract.

The following response is a good example::

```json
...
 "AvailableOperations": {
    "description": "Available operations of the service",
    "type": "object",
    "properties": {
      "value": {
        "description": "Collection of available operation details",
        "uniqueItems": false,
        "type": "array",
        "items": {
          "$ref": "#/definitions/OperationDetail"
        }
      },
      "nextLink": {
        "description": "URL client should use to fetch the next page (per server side paging).\r\nIt's null for now, added for future use.",
        "type": "string"
      }
    }
  },
  "OperationDetail": {
    "description": "Operation detail payload",
    "type": "object",
    "properties": {
      "name": {
        "description": "Name of the operation",
        "type": "string"
      },
      "isDataAction": {
        "description": "Indicates whether the operation is a data action",
        "type": "boolean"
      },
      "display": {
        "$ref": "#/definitions/OperationDisplay",
        "description": "Display of the operation"
      },
      "origin": {
        "description": "Origin of the operation",
        "type": "string"
      },
      "properties": {
        "$ref": "#/definitions/OperationProperties",
        "description": "Properties of the operation"
      }
    }
  },
  "OperationDisplay": {
    "description": "Operation display payload",
    "type": "object",
    "properties": {
      "provider": {
        "description": "Resource provider of the operation",
        "type": "string"
      },
      "resource": {
        "description": "Resource of the operation",
        "type": "string"
      },
      "operation": {
        "description": "Localized friendly name for the operation",
        "type": "string"
      },
      "description": {
        "description": "Localized friendly description for the operation",
        "type": "string"
      }
    }
  }
....
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4019" ></a>R4019 GetCollectionResponseSchema

**Category** : ARM Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The response model in the GET collection operation "{0}" does not match with the response model in the individual GET operation "{1}".

**Description** : Per [ARM guidelines](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md#get-resource), for all resources (top-level and nested), collection GETs should have a response definition with a property "value" containing an array of the "resource" schema.The definition returned in the collection "value" array should be the same as the response body for the individual GET.

**CreatedAt**: July 13, 2020

**LastModifiedAt**: July 13, 2020

**How to fix the violation**: Make sure the collection GETs return an array and its items schema the same as the response schema in corresponding individual GET. 

The following response is a good example:

```json
...

 "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MyNameSpace/MyResourceType/{Name}": {
      "get": {
        ...
        ...
        "responses": {
          "200": {
            "description": "Success. The response describes the corresponding Service.",
            "schema": {
              "$ref": "#/definitions/MyResourceSchema"
            }
          }

...
...

 "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MyNameSpace/MyResourceType": {
      "get": {
        .....
        "responses": {
          "200": {
            "description": "Success. The response describes the list of Services in the resource group.",
            "schema": {
              "$ref": "#/definitions/MyResourceList"
            }
          },
...
...
"MyResourceList":{
   "type": "object", 
     "properties": { 
       "value": { 
           "type": "array", 
           "items": { 
               "$ref": "#/definitions/MyResourceSchema" 
           } 
       },
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4023" ></a>R4023 RPaasPutLongRunningOperation201Only

**Category** : RPaaS Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : [RPaaS] Only 201 is the supported response code for PUT async response

**Description** : An async PUT operation response include status code 201 with 'Azure-async-operation' header. Must also support status code 200, for simple updates that can be completed synchronously (ex: tags). Operation must also add "x-ms-long-running-operation and x-ms-long-running-operation-options" to mark that it is a long running operation (in case of 201) and how it is tracked (Azure-async-operation header).

**CreatedAt**: August 10, 2020

**LastModifiedAt**: August 10, 2020

**Why this rule is important**: RPaaS only supports 201 for async PUT operations. This is enforced at runtime via swagger validation.

**How to fix the violation**: Add the following for async PUT operations.

The following would be valid:

```json
...
  "responses": {
      "201": {
        "description": "Created",
        "schema": {
          "$ref": "#/definitions/MySimpleObject"
        }
      },
      "200": {
        "description": "Succeeded",
        "schema": {
          "$ref": "#/definitions/MySimpleObject"
        }
      },
      "default": {
        "description": "Error response describing why the operation failed.",
        "schema": {
          "$ref": "#/definitions/ErrorResponse"
        }
      }
    },
    "x-ms-long-running-operation": true,
    "x-ms-long-running-operation-options": {
      "final-state-via": "azure-async-operation"
  }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or[Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4024" ></a>R4024 PreviewVersionOverOneYear

**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The API version:{api-version} having been in a preview state over one year , please move to GA or retire.

**Description** : Per [Retirement-of-Previews](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37683/Retirement-of-Previews), service, feature, API, and SKU in preview for over one year need to move to GA or retire.

**CreatedAt**: Sep 8, 2020

**LastModifiedAt**: Sep 8, 2020

**How to fix the violation**: 
   Consider retiring or moving to GA. 
   
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4025"></a>R4025 RPaasDeleteLongRunningOperation202Only

**Category** : RPaaS Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : [RPaaS] DELETE async supports

**Description** : An async DELETE operation response include status code 202 with 'Location' header. Must support status code 200 if operation can be completed synchronously. Must support 204 (resource doesn't exists). Operation must also add "x-ms-long-running-operation and x-ms-long-running-operation-options" to mark that it is a long running operation (in case of 202) and how it is tracked (Location header).

**CreatedAt**: November 12, 2020

**LastModifiedAt**: November 12, 2020

**Why this rule is important**: RPaaS only supports 202 for async DELETE operations. This is enforced at runtime via swagger validation.

**How to fix the violation**: Add the following for async DELETE operations.

The following would be valid:

```json
...
  "responses": {
      "202": {
        "description": "Delete operation accepted",
      },
      "200": {
        "description": "Delete operation succeeded"
      },
      "204": {
        "description": "Resource doesn't exist. Delete operation completed."
      },
      "default": {
        "description": "Error response describing why the operation failed.",
        "schema": {
          "$ref": "#/definitions/ErrorResponse"
        }
      }
    },
    "x-ms-long-running-operation": true,
    "x-ms-long-running-operation-options": {
      "final-state-via": "location"
  }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4026"></a>R4026 RPaasPostLongRunningOperation202Only

**Category** : RPaaS Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : [RPaaS] POST async supports

**Description** : An async POST operation response include status code 202 with 'Location' header. Must support status code 200 if operation can be completed synchronously. Operation must also add "x-ms-long-running-operation and x-ms-long-running-operation-options" to mark that it is a long running operation (in case of 202) and how it is tracked (Location header).

**CreatedAt**: November 12, 2020

**LastModifiedAt**: November 12, 2020

**Why this rule is important**: RPaaS only supports 202 for async POST operations. This is enforced at runtime via swagger validation.

**How to fix the violation**: Add the following for async POST operations.

The following would be valid:

```json
...
  "responses": {
      "202": {
        "description": "Operation accepted",
      },
      "200": {
        "description": "Operation completed"
      },
      "default": {
        "description": "Error response describing why the operation failed.",
        "schema": {
          "$ref": "#/definitions/ErrorResponse"
        }
      }
    },
    "x-ms-long-running-operation": true,
    "x-ms-long-running-operation-options": {
      "final-state-via": "location"
  }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4028" ></a>R4028 ValidResponseCodeRequired

**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** :  There is no declared valid status code.

**Description** : Every operation response must contain a valid code like "200","201","202" or "204" which indicates the operation is succeed and it's not allowed that a response schema just contains a "default" code. 

**Why this rule is important**: If a Swagger just contains "default" status code, this actually means "everything is an error". All track2 SDK will systematically raise an exception at runtime, if there is no declared valid status code.

**CreatedAt**: November 23, 2020

**LastModifiedAt**: November 23, 2020

**How to fix the violation**: Add a valid response code .
The following would be valid:

```json
...
  "responses": {
      "200": {
        "description": "Succeeded",
        "schema": {
          "$ref": "#/definitions/MySimpleResource"
        }
      },
      "default": {
        "description": "Error response describing why the operation failed.",
        "schema": {
          "$ref": "#/definitions/ErrorResponse"
        }
      }
    }
  }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4029" ></a>R4029 UniqueClientParameterName

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** :  Do not have duplicate name of client parameter name, make sure every client parameter name unique.

**Description** : This may cause a problem when different swagger files come together. If two APIs with different client name have the same client parameter subscriptionId, but with different reference name in swaggers, the generated model will also have two clients with two client parameters subscriptionId and subscriptionId1 (the latter one has been renamed to avoid collision). We should ensure that the client parameters are all unique in the same API version.

**Why this rule is important**: Make sure no conflict in SDK generation.

**CreatedAt**: November 30, 2020

**LastModifiedAt**: November 30, 2020

**How to fix the violation**: Remove duplicate client parameter, ref to the same one.
The following would be valid:

```json
...
 "/api": {
      "get": {
        "parameters": [
          {
            "$ref": "#/parameters/ApiVersionParameter"
          },
          {
            // ref to the same subcriptionId
            "$ref": "#/parameters/subscriptionIdParameter"
          },
        ],
     },
     "patch": [
          {
            "$ref": "#/parameters/ApiVersionParameter"
          },
          {
            "$ref": "#/parameters/subscriptionIdParameter"
          },
     ]
  }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4030" ></a>R4030 UniqueXmsExample

**Category** : SDK Warning

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** :  Do not have duplicate name of x-ms-example, make sure every x-ms-example name unique. Duplicate x-ms-example: {ExampleName}

**Description** : x-ms-example name should be unique in the same API version.

**Why this rule is important**: Duplicate example name will bring trouble for test codegen. For example: hard to config used example.

**CreatedAt**: November 30, 2020

**LastModifiedAt**: November 30, 2020

**How to fix the violation**: Rename duplicate x-ms-example name
The following would be valid:

```json
...
"x-ms-examples": {
          "Create resource": {
            "$ref": "./examples/createResource"
          },
          "Update resource":{
            "$ref": "./examples/updateResource"
          }
          
        }
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4031"></a>R4031 RPaasResourceProvisioningState

**Category** : RPaaS Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : [RPaaS] The resource {0} is defined without 'provisioningState' in properties bag, consider adding the provisioningState for it.

**Description** : Verifies if a Azure resource has a corresponding 'provisioningState' property. If the 'provisioningState' is not defining explicitly , the client will drop the state when the service does return it. 

**CreatedAt**: January 15, 2021

**LastModifiedAt**: January 15, 2021

**Why this rule is important**: Per [Azure RPC](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#provisioningstate-property), all Azure resources must support "provisioningState" property. 

**How to fix the violation**: Add the 'provisioningState' for every Azure resource.

The following would be valid:

```json
...
resourceDefinition": {
  "description": "resource definition",
  "type": "object",
  "properties": {
    "properties": {
    "type": "object",
      "properties" :{
        "provisioningState": {
          "type": "string",
          "readOnly": true
        }
        ...
      }
    }
  }
}
...
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4032"></a>R4032 MissingXmsErrorResponse

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The response code {0} is defined without a x-ms-error-response.

**Description** :  If defines response code 4xx or 5xx ,  x-ms-error-response:true is required. There is one exception: a HEAD operation with 404 SHOULD have x-ms-error-response:false, as it is often used to check for existence of resources, the HEAD with 404 means the resource doesn’t exist.

**CreatedAt**: February 23, 2021

**LastModifiedAt**: February 23, 2021

**Why this rule is important**: As some SDK may treat the 4xx or 5xx as exceptional code, if don't specified x-ms-error-response:true, the SDK will not handle the error schema correctly instead it will throw an exception.

**How to fix the violation**: Add the x-ms-error-response:true for the error response code or remove it.

The following would be valid:

```json
 "responses": {
    "400": {
      "description": "Bad Request",
      "x-ms-error-response": true
    }
 }
```
The following would be invalid:

```json
 "responses": {
    "400": {
      "description": "Bad Request",
    }
 }
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4033"></a>R4033 UniqueModelName

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** :  The model name {0} is duplicated with {1} .

**Description** :  Do not rely on case sensitivity to differentiate models.

**CreatedAt**: February 23, 2021

**LastModifiedAt**: February 23, 2021

**Why this rule is important**: In Python SDK, model names are converted to forms starting with capital. So all of "AAAA", "aaaa", "Aaaa" will be transformed to "Aaaa". So differentiating model names by their case sensitivities would break Python SDK generation.

**How to fix the violation**: Rename the duplicate name .

The following would be invalid:

```json
"definitions": {
  "SKU": {
    "type": "string",
    "description": "SKU in request"
  },
  "sku": {
    "type": "string",
    "description": "SKU in response"
  }
}
```

The following would be valid:

```json
"definitions": {
  "requestSKU": {
    "type": "string",
    "description": "SKU in request"
  },
  "responseSKU": {
    "type": "string",
    "description": "SKU in response"
  }
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4034"></a>R4034 AzureResourceTagsSchemaValidation

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** :  The property tags in the resource "{0}" does not conform to the common type definition.

**Description** :  This rule is to check if the tags definition of a resource conforms to the common tags definition.

**CreatedAt**: February 23, 2021

**LastModifiedAt**: February 23, 2021

**Why this rule is important**: It will block the SDK generation for Terraform, as it's only accepted that the Golang type for tags is map[string]*string .

**How to fix the violation**: Please reference to the common tags definition in [v2/types.json](https://github.com/Azure/azure-rest-api-specs/blob/0e18f46fd2c210f85b5ec0f9dd9be664242bee82/specification/common-types/resource-management/v2/types.json#L146).

The following would be invalid:

```json
"tags": {
  "type": "object",
  "description": "Resource Tags"
}
```

The following would be valid:

```json
"tags": {
  "type": "object",
  "additionalProperties": {
    "type": "string"
  },
  "x-ms-mutability": [
    "read",
    "create",
    "update"
  ],
  "description": "Resource Tags"
}
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4035"></a>R4035 PrivateEndpointResourceSchemaValidation

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** :  The private endpoint model "{0}" schema does not conform to the common type definition.

**Description** :  This rule is to check if the schemas used by private endpoint conform to the common [privateLink](https://github.com/Azure/azure-rest-api-specs/blob/master/specification/common-types/resource-management/v1/privatelinks.json). The rule will check the schemas of following models and their properties:
1. PrivateEndpointConnection
2. PrivateEndpointConnectionProperties
3. PrivateEndpointConnectionListResult
4. PrivateLinkResource
5. PrivateLinkResourceProperties
6. PrivateLinkResourceListResult

**CreatedAt**: February 23, 2021

**LastModifiedAt**: February 23, 2021

**Why this rule is important**: The schemas used by private endpoint should have same definition. 

**How to fix the violation**: Please reference to the common private endpoint definition in [privateLink](https://github.com/Azure/azure-rest-api-specs/blob/master/specification/common-types/resource-management/v1/privatelinks.json).


Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings) 

### <a name="r4036"></a>R4036 ImplementPrivateEndpointAPIs

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The private endpoint API: {apiPath} is missing.

**Description** :  This rule is to check if all the APIs for private endpoint are implemented. Per design spec, for supporting private endpoint, the service should implement the following APIs:

PUT/DELETE/GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.[Service]/{resourceType}/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}?api-version=[version]
 
GET https://management.azure.com/subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.[Service]/[resources]/{resourceName}/privateEndpointConnections?api-version=[version]
 
GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.[Service]/[resources]/[resourceName]/privateLinkResources?api-version=[version]

**CreatedAt**: February 23, 2021

**LastModifiedAt**: February 23, 2021

**Why this rule is important**: To meet the private endpoint design.

**How to fix the violation**: Please add the missing private endpoint API path and operation to the swagger.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)


### <a name="r4037"></a>R4037 MissingTypeObject

**Category** : SDK Error

**Applies to** : ARM and Data plane OpenAPI(swagger) specs

**Output Message** : The schema '{json path}' is considered an object but without a 'type:object', please add the missing 'type:object'.

**Description**: The rule should apply to any schema with "properties" or "additionalProperties". It is to ensure a schema with "properties" or "additionalProperties" must have explicit "type:object" statement, which means a schema is an object. 

**CreatedAt**: May 24, 2021

**LastModifiedAt**: May 24, 2021

**Why this rule is important**: The semantics of with and without "type:object" are different. With “type:object” means “it has to be an object”. Without “type: object” means “it could be any type”. Azure SDK Track 2 generator will honor the difference, and generate different SDK codes.
A free-form object would like:

**How to fix the violation**:
Just add the missing 'type:object'.

The following would be valid:

```json
 "foo": {
    "type":"object",
    "properties": {
      "a" : {
        "type":"string"
      }
      ...
    }
 }
```
The following would be invalid by default (unless you do it on purpose , then a suppression is required):

```json
 "foo": {
    "properties": {
      "a" : {
        "type":"string"
      }
      ...
    }
```
Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)


### <a name="r4038"></a>R4038 ExtensionResourcePathPattern

**Category** : RPaaS Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : The path '{api path}' which is for extension routing resource type, shouldn't include the parent scope.

**Description**: Path (operation) for 'extension routing type' (that has additional /providers/ segment in parent scope) must be of the form '{scope}/provider/RPNamespace/resourceTypeName' (shouldn't include parent scope)

**CreatedAt**: November 8, 2021

**LastModifiedAt**: November 8, 2021

**Why this rule is important**: The parent scope won't be passed over to PRaaS, and the API will fail in RPaaS validation.

**How to fix the violation**:
Move the parent resource URI to the 'scope' parameter which is string type.

The following would be invalid:
```json
"/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerNamespace}/{resourceType}/{resourceName}/providers/Microsoft.MyProvider/defenderSettings/default"
```
The following would be valid :

```json
"{scope}/providers/Microsoft.MyProvider/defenderSettings/default"
```

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4039"></a>R4039 ParametersOrder

**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : The parameters should be kept in the same order as they present in the path.

**Description**: The rule is to ensure the parameters in the same order as they are ranked in the path. Since it can introduce a breaking change when updating parameter order, for services that have already shipped public versions, you may request to suppress the rule following the process documented here: https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/85/Swagger-Suppression-Process

**CreatedAt**: November 8, 2021

**LastModifiedAt**: November 8, 2021

**Why this rule is important**: AutoRest generates SDKs with parameters in the order as they are defined in the Swagger. The only exceptional cases are:
1. 'body' should be always at last;
2. 'required' should be always placed before 'optional'

**How to fix the violation**:
re-order the parameters as the order in the api path.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4040"></a>R4040 EnumMustRespectType

**Category** : SDK Error

**Applies to** : ARM and Data Plane OpenAPI(swagger) specs

**Output Message** : Enum values should respect the type.

**Description**: This rule is to check if the enum values conform to the type.

**CreatedAt**: November 10, 2021

**LastModifiedAt**: November 10, 2021

**Why this rule is important**: It will lead to code generation failure in SDK generation pipeline.

**How to fix the violation**:
Just change the enum value to the right type.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)

### <a name="r4041"></a>R4041 XmsIdentifierValidation

**Category** : SDK Error

**Applies to** : ARM OpenAPI(swagger) specs

**Output Message** : Missing identifier {0} in array item property.

**Description**: This rule is to check the `id` property or identifier of objects in the array. See more here: [x-ms-identifiers](https://github.com/Azure/autorest/tree/main/docs/extensions#x-ms-identifiers).

**CreatedAt**: Decenmber 15, 2021

**LastModifiedAt**: Decenmber 15, 2021

**Why this rule is important**: Using [x-ms-identifiers](https://github.com/Azure/autorest/tree/main/docs/extensions#x-ms-identifiers) will provide more flexibility for array types in SDK generated code.

**How to fix the violation**:
If you don't need identifier in array, leave `x-ms-identifiers` as an empty array. Otherwise, add the identifying property in the object or correct the `x-ms-identifiers`.

Links: [Index](#index) | [Error vs. Warning](#error-vs-warning) | [Automated Rules](#automated-rules) | [ARM](#arm-violations): [Errors](#arm-errors) or [Warnings](#arm-warnings) | [SDK](#sdk-violations): [Errors](#sdk-errors) or [Warnings](#sdk-warnings)
