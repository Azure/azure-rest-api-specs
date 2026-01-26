## Swagger Changes

### Changes for `Availability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Availability__deleted` | deleted | `{"type":"object","properties":{"timeGrain":{"type":"string"},"retention":{"type":"string"},"blobDura...` |

### Changes for `Dimension`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Dimension__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"internalNam...` |

### Changes for `LogSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogSpecification__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"blobDuratio...` |

### Changes for `MetricSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricSpecification__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"displayDesc...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"display":{"type":"object","properties":{"pr...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OperationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"serviceSpecification":{"type":"object","properties":{"metricSpecific...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/providers/microsoft.Network/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `./common.json/definitions/OperationListResult` |
| `paths['/providers/microsoft.Network/operations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

