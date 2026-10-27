# Table of Contents
- [Running Locally](#running-locally)
- [Adding Scoped Suppressions](#adding-scoped-suppressions)
- [TypeSpec](#typespec)

# Running Locally
https://github.com/Azure/azure-openapi-validator/wiki#usage

# Adding Scoped Suppressions
When adding suppressions for LintDiff (https://github.com/Azure/autorest/blob/main/docs/generate/suppress-warnings.md), it's recommened to use a `where` clause to scope the suppression to one instance of the error  How to find the JSON path to use for the suppression.

1. In the raw log for the "LintDiff" step of the "LintDiff" check, find the line containing the JSON object representing your error.  For example:

```
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"error","message":"Properties of a PATCH request body must not be required, property:endpointType.","code":"PatchBodyParametersSchema","details":{"jsonpath":["paths","/{scope}/providers/Microsoft.EventGrid/eventSubscriptions/{eventSubscriptionName}","patch","parameters","2","schema","properties","deadLetterDestination"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"RPC-Patch-V1-10","range":{"start":{"line":1,"column":0},"end":{"line":1,"column":0}}},"source":[{"document":"file:///mnt/vss/_work/1/azure-rest-api-specs/specification/eventgrid/resource-manager/Microsoft.EventGrid/stable/2025-02-15/EventGrid.json","position":{"line":2908,"column":13}}]}
```

2. Paste into VSCode (or another editor) to format for readability.  We are focused on the `jsonpath` property.

```
{
    "pluginName": "spectral",
    "extensionName": "@microsoft.azure/openapi-validator",
    "level": "error",
    "message": "Properties of a PATCH request body must not be required, property:endpointType.",
    "code": "PatchBodyParametersSchema",
    "details": {
        "jsonpath": [
            "paths",
            "/{scope}/providers/Microsoft.EventGrid/eventSubscriptions/{eventSubscriptionName}",
            "patch",
            "parameters",
            "2",
            "schema",
            "properties",
            "deadLetterDestination"
        ],
        ...
    },
    "source": [
        {
            "document": "file:///mnt/vss/_work/1/azure-rest-api-specs/specification/eventgrid/resource-manager/Microsoft.EventGrid/stable/2025-02-15/EventGrid.json",
            "position": {
                "line": 2908,
                "column": 13
            }
        }
    ]
}
```

3. Convert the `jsonpath` array to a string, and add to your suppression:

```
  - code: PatchBodyParametersSchema
    from: EventGrid.json
    where: $.paths["/{scope}/providers/Microsoft.EventGrid/eventSubscriptions/{eventSubscriptionName}"].patch.parameters[2].schema.properties.deadLetterDestination
```

# TypeSpec
Check `Swagger LintDiff` may fail for the OpenAPI generated from TypeSpec, even if there are no warnings or errors reported from the TypeSpec compiler.  Causes include bugs in the TypeSpec OpenAPI emitter, bugs in LintDiff rules, incompatibilities between TypeSpec and LintDiff, or checks duplicated in TypeSpec and LintDiff.

We are working to address the root causes (where possible).  Until then, we recommend you [suppress](https://aka.ms/pr-suppressions) these LintDiff errors, using a "permanent suppression" with a descriptive "reason".

## `AvoidAdditionalProperties`
The use of `Record<unknown>` in TypeSpec is discouraged, and there is a TypeSpec lint rule to enforce this.  If you still need to use `Record<unknown>`, the OpenAPI spec generated will cause many LintDiff errors of types `AvoidAdditionalProperties` and `PropertiesTypeObjectNoDefinition`.  You will need to suppress both the TypeSpec violation (in TypeSpec source code) and the LintDiff violations.

## `AvoidAnonymousParameter`
### data-plane
Data-plane specs can suppress violations of this rule, since it only exists for the benefit of SDKs generated from swagger, and data-plane SDKs are generated directly from TypeSpec.  Resource-manager specs should **not** suppress violations of this rule, since resource-manager SDKs are generated from OpenAPI, and rely on these errors being fixed.

### resource-manager
As an exception to the previous note, resource-manager specs **may** be able to suppress `AvoidAnonymousTypes`, but only if the error is inside a 202 response from a long-running operation (LRO).  It is known that SDKs do not need to generate type names for such responses.

## `AvoidAnonymousTypes`
Data-plane specs can suppress violations of this rule, since it only exists for the benefit of SDKs generated from swagger, and data-plane SDKs are generated directly from TypeSpec.  Resource-manager specs should **not** suppress violations of this rule, since resource-manager SDKs are generated from OpenAPI, and rely on these errors being fixed.

### `LongRunningResourceAction`
There is a known issue where `LongRunningResourceAction` in TypeSpec, generates swagger that causes `AvoidAnonymousTypes`.  These errors should be suppressed until the root cause is fixed.  https://github.com/Azure/typespec-azure-pr/issues/3349

## `EvenSegmentedPathForPutOperation`
If `EvenSegmentedPathForPutOperation` is failing for OpenAPI generated from TypeSpec using `@singleton` (OpenAPI path ends with `/default`), we believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/646

## `IntegerTypeMustHaveFormat`
Data-plane specs can suppress violations of this rule, since it only exists for the benefit of SDKs generated from swagger, and data-plane SDKs are generated directly from TypeSpec.  Resource-manager specs should **not** suppress violations of this rule, since resource-manager SDKs are generated from OpenAPI, and rely on these errors being fixed.

## `PatchBodyParameterSchema`
The root cause is a bug in typespec-azure:

https://github.com/Azure/typespec-azure/issues/383.

Please see the issue above for the suggested workaround and apply it directly to the spec TypeSpec sources.  The LintDiff error should **not** be ignored or suppressed.

## `PatchPropertiesCorrespondToPutProperties`
We believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/642

## `PropertiesTypeObjectNoDefinition`
The use of `Record<unknown>` in TypeSpec is discouraged, and there is a TypeSpec lint rule to enforce this.  If you still need to use `Record<unknown>`, the OpenAPI spec generated will cause many LintDiff errors of types `AvoidAdditionalProperties` and `PropertiesTypeObjectNoDefinition`.  You will need to suppress both the TypeSpec violation (in TypeSpec source code) and the LintDiff violations.

## `ProvisioningStateMustBeReadOnly`
The root cause is a limitation in how `azure-openapi-validator` and `oav` handle `$ref` siblings:

- https://github.com/Azure/azure-openapi-validator/issues/637
- https://github.com/Azure/oav/issues/848

The recommended workaround is to add `use-read-only-status-schema: true` to your `tspconfig.yaml`.

## `RequestBodyMustExistForPutPatch`
We believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/641

## `ResourceNameRestriction`
Whether `ResourceNameRestriction` should be applied to enums is an open question:

https://github.com/Azure/azure-openapi-validator/issues/501
https://github.com/Azure/azure-openapi-validator/pull/714

Until this is resolved, suppress the errors and discuss with your ARM reviewer.

## `XmsEnumValidation`
TypeSpec using `OAuth2Auth` may generate the following OpenAPI:

``` yaml
"type": {
  "type": "string",
  "description": "OAuth2 authentication",
  "enum": [
    "oauth2"
  ]
},
```

Which causes error `XmsEnumValidation`.  The recommended workaround is to add `omit-unreachable-types: true` to your `tspconfig.yaml`.

## `XmsPageableForListCalls`
If `XmsPageableForListCalls` are failing for OpenAPI generated from TypeSpec using `@singleton` (OpenAPI path ends with `/default`), we believe this is a false positive: https://github.com/Azure/azure-openapi-validator/issues/646
