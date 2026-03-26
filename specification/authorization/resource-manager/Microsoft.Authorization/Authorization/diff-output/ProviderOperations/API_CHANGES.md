## Swagger Changes

### Changes for `SettableResource`

| Path                                  | Change Type | Value                                                                                                     |
| ------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.SettableResource__added` | added       | `{"type":"object","description":"The resource model definition for resource.","properties":{"id":{"ty...` |

### Changes for `type`

| Path                                                                | Change Type | Value                                                  |
| ------------------------------------------------------------------- | ----------- | ------------------------------------------------------ |
| `definitions.ProviderOperation.properties.properties.type__deleted` | deleted     | `object`                                               |
| `definitions.ProviderOperationsMetadata.properties.type__deleted`   | deleted     | `{"type":"string","description":"The provider type."}` |

### Changes for `allOf`

| Path                                                  | Change Type | Value                                         |
| ----------------------------------------------------- | ----------- | --------------------------------------------- |
| `definitions.ProviderOperationsMetadata.allOf__added` | added       | `[{"$ref":"#/definitions/SettableResource"}]` |

### Changes for `id`

| Path                                                            | Change Type | Value                                                |
| --------------------------------------------------------------- | ----------- | ---------------------------------------------------- |
| `definitions.ProviderOperationsMetadata.properties.id__deleted` | deleted     | `{"type":"string","description":"The provider id."}` |

### Changes for `name`

| Path                                                              | Change Type | Value                                                  |
| ----------------------------------------------------------------- | ----------- | ------------------------------------------------------ |
| `definitions.ProviderOperationsMetadata.properties.name__deleted` | deleted     | `{"type":"string","description":"The provider name."}` |

### Changes for `required`

| Path                                                               | Change Type | Value       |
| ------------------------------------------------------------------ | ----------- | ----------- |
| `definitions.ProviderOperationsMetadataListResult.required__added` | added       | `["value"]` |

## Modified Values

| Path                                                                                                                           | Old Value                                                                                     | New Value                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `paths['/providers/microsoft.Authorization/providerOperations'].get.responses.default.schema.$ref`                             | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/providers/microsoft.Authorization/providerOperations/{resourceProviderNamespace}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
