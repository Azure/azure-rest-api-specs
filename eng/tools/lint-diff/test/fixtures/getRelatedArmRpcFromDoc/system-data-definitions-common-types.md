# SystemDataDefinitionsCommonTypes

## Category

ARM Error

## Applies to

ARM OpenAPI(swagger) specs

## Related ARM guideline code

- RPC-SystemData-V1-01
- RPC-SystemData-V1-02

## Description

System data references must utilize common types.

## How to fix the violation

Ensure that references to system data use the common types definition for system data. Common-types system data is
defined in types.json [here](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/common-types/resource-management/).

### Invalid example

```json
"Resource": {
  "properties": {
    "systemData": {
      "$ref": "../not/common/types",
    },
  }
}
```

### Valid example

```json
"Resource": {
  "properties": {
    "systemData": {
      "$ref": "../../../../../common-types/resource-management/v2/types.json#/definitions/systemData",
    },
  }
}
```