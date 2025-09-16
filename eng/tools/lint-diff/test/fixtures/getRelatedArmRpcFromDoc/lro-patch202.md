# LroPatch202

## Category

ARM Error

## Applies to

ARM OpenAPI(swagger) specs

## Related ARM Guideline Code

- RPC-Patch-V1-06, RPC-Async-V1-08

## Output Message

Async PATCH should return 202.

## Description

Async PATCH should return 202.

## CreatedAt

July 07, 2022

## LastModifiedAt

July 07, 2022

## How to fix the violation

For new resource, ensure the async patch returns 202, see [updating-using-patch](https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/async-api-reference.md#updating-using-patch)