## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Network/operations'].get.tags__added` | added | `["Operations"]` |
| `tags__added` | added | `[{"name":"Operations"}]` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.type__deleted` | deleted | `object` |
| `definitions.OperationPropertiesFormat.properties.serviceSpecification.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.properties__deleted` | deleted | `{"provider":{"type":"string","description":"Service provider: Microsoft Network."},"resource":{"type...` |
| `definitions.OperationPropertiesFormat.properties.serviceSpecification.properties__deleted` | deleted | `{"metricSpecifications":{"type":"array","description":"Operation service specification.","items":{"$...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.$ref__added` | added | `./common.json/definitions/OperationDisplay` |
| `definitions.OperationPropertiesFormat.properties.serviceSpecification.$ref__added` | added | `./common.json/definitions/OperationPropertiesFormatServiceSpecification` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/providers/microsoft.Network/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `./common.json/definitions/OperationListResult` |
| `paths['/providers/microsoft.Network/operations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

