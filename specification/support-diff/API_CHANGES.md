## Swagger Changes

### Changes for `x-typespec-generated`

| Path | Change Type | Value |
|------|------------|-------|
| `info['x-typespec-generated__added']` | added | `[{"emitter":"@azure-tools/typespec-autorest"}]` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}'].put.parameters[0].pattern__deleted` | deleted | `^[0-9a-zA-Z_\\-. ]+$` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Support/fileWorkspaces/{fileWorkspaceName}'].put.parameters[0].pattern__deleted` | deleted | `^[0-9a-zA-Z_\\-. ]+$` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"display":{"properties":{"de...` |

### Changes for `OperationsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationsListResult__deleted` | deleted | `{"properties":{"value":{"type":"array","items":{"$ref":"#/definitions/Operation"},"x-ms-identifiers"...` |

### Changes for `TranscriptContentType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TranscriptContentType__added` | added | `{"type":"string","x-nullable":false}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ChatTranscriptsListResult.required__added` | added | `["value"]` |
| `definitions.CommunicationsListResult.required__added` | added | `["value"]` |
| `definitions.FilesListResult.required__added` | added | `["value"]` |
| `definitions.SupportTicketsListResult.required__added` | added | `["value"]` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommunicationDetails.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |
| `definitions.ProblemClassification.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |
| `definitions.Service.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |
| `definitions.SupportTicketDetails.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}...` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommunicationDetails.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ProblemClassification.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Service.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.SupportTicketDetails.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommunicationDetails.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ProblemClassification.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Service.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.SupportTicketDetails.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CommunicationDetails.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.MessageProperties.properties.contentType.type__deleted` | deleted | `string` |
| `definitions.ProblemClassification.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Service.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.SupportTicketDetails.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MessageProperties.properties.contentType['x-ms-enum__deleted']` | deleted | `{"name":"TranscriptContentType","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MessageProperties.properties.contentType.$ref__added` | added | `#/definitions/TranscriptContentType` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProblemClassificationsListResult.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.ProblemClassificationsListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |
| `definitions.ServicesListResult.description__added` | added | `[Placeholder] Discription for page model` |
| `definitions.ServicesListResult.properties.value.description__added` | added | `[Placeholder] Discription for value property` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProblemClassificationsListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.ServicesListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/providers/Microsoft.Support/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationsListResult` | `../../../../../common-types/resource-management/v5/types.json#/definitions/OperationListResult` |

