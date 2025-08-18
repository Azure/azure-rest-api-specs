## Swagger Changes

### Changes for `AppServiceCertificateOrderPatchResourceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceCertificateOrderPatchResourceProperties__added` | added | `{"type":"object","properties":{"certificates":{"type":"object","additionalProperties":{"$ref":"#/def...` |

### Changes for `AppServiceCertificateOrderProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceCertificateOrderProperties__added` | added | `{"type":"object","properties":{"certificates":{"type":"object","additionalProperties":{"$ref":"#/def...` |

### Changes for `DataProviderMetadata`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataProviderMetadata__added` | added | `{"type":"object","properties":{"providerName":{"type":"string"},"propertyBag":{"type":"array","items...` |

### Changes for `DataTableResponseColumn`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataTableResponseColumn__added` | added | `{"type":"object","properties":{"columnName":{"type":"string"},"dataType":{"type":"string"},"columnTy...` |

### Changes for `DataTableResponseObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataTableResponseObject__added` | added | `{"type":"object","properties":{"tableName":{"type":"string"},"columns":{"type":"array","items":{"$re...` |

### Changes for `DetectorInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DetectorInfo__added` | added | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"name":{"type":"string","readO...` |

### Changes for `DetectorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DetectorResponse__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DetectorResponseProperties","x-ms...` |

### Changes for `DetectorResponseCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DetectorResponseCollection__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `DetectorResponseProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DetectorResponseProperties__added` | added | `{"type":"object","properties":{"metadata":{"$ref":"#/definitions/DetectorInfo"},"dataset":{"type":"a...` |

### Changes for `DiagnosticData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DiagnosticData__added` | added | `{"type":"object","properties":{"table":{"$ref":"#/definitions/DataTableResponseObject"},"renderingPr...` |

### Changes for `KeyValuePairStringObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KeyValuePairStringObject__added` | added | `{"type":"object","properties":{"key":{"type":"string","readOnly":true},"value":{"type":"object","add...` |

### Changes for `NameIdentifier`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NameIdentifier__added` | added | `{"type":"object","properties":{"name":{"type":"string"}}}` |

### Changes for `ProxyOnlyResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProxyOnlyResource__added` | added | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"name":{"type":"string","readO...` |

### Changes for `QueryUtterancesResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QueryUtterancesResult__added` | added | `{"type":"object","properties":{"sampleUtterance":{"$ref":"#/definitions/SampleUtterance"},"score":{"...` |

### Changes for `QueryUtterancesResults`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QueryUtterancesResults__added` | added | `{"type":"object","properties":{"query":{"type":"string"},"results":{"type":"array","items":{"$ref":"...` |

### Changes for `ReissueCertificateOrderRequestProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ReissueCertificateOrderRequestProperties__added` | added | `{"type":"object","properties":{"keySize":{"type":"integer","format":"int32"},"delayExistingRevokeInH...` |

### Changes for `Rendering`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Rendering__added` | added | `{"type":"object","properties":{"type":{"type":"string","enum":["NoGraph","Table","TimeSeries","TimeS...` |

### Changes for `RenewCertificateOrderRequestProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RenewCertificateOrderRequestProperties__added` | added | `{"type":"object","properties":{"keySize":{"type":"integer","format":"int32"},"csr":{"type":"string"}...` |

### Changes for `SampleUtterance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SampleUtterance__added` | added | `{"type":"object","properties":{"text":{"type":"string"},"links":{"type":"array","items":{"type":"str...` |

### Changes for `Status`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Status__added` | added | `{"type":"object","properties":{"message":{"type":"string"},"statusId":{"type":"string","enum":["Crit...` |

### Changes for `SupportTopic`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SupportTopic__added` | added | `{"type":"object","properties":{"id":{"type":"string","readOnly":true},"pesId":{"type":"string","read...` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceCertificateOrder.properties.properties.type__deleted` | deleted | `object` |
| `definitions.AppServiceCertificateOrderPatchResource.properties.properties.type__deleted` | deleted | `object` |
| `definitions.AppServiceCertificatePatchResource.properties.properties.type__deleted` | deleted | `object` |
| `definitions.AppServiceCertificateResource.properties.properties.type__deleted` | deleted | `object` |
| `definitions.ReissueCertificateOrderRequest.properties.properties.type__deleted` | deleted | `object` |
| `definitions.RenewCertificateOrderRequest.properties.properties.type__deleted` | deleted | `object` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceCertificateOrder.properties.properties.properties__deleted` | deleted | `{"certificates":{"type":"object","description":"State of the Key Vault secret.","additionalPropertie...` |
| `definitions.AppServiceCertificateOrderPatchResource.properties.properties.properties__deleted` | deleted | `{"certificates":{"type":"object","description":"State of the Key Vault secret.","additionalPropertie...` |
| `definitions.ReissueCertificateOrderRequest.properties.properties.properties__deleted` | deleted | `{"keySize":{"type":"integer","format":"int32","description":"Certificate Key Size."},"delayExistingR...` |
| `definitions.RenewCertificateOrderRequest.properties.properties.properties__deleted` | deleted | `{"keySize":{"type":"integer","format":"int32","description":"Certificate Key Size."},"csr":{"type":"...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceCertificateOrder.properties.properties.required__deleted` | deleted | `["productType"]` |
| `definitions.AppServiceCertificateOrderPatchResource.properties.properties.required__deleted` | deleted | `["productType"]` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceCertificateOrder.properties.properties.$ref__added` | added | `#/definitions/AppServiceCertificateOrderProperties` |
| `definitions.AppServiceCertificateOrderPatchResource.properties.properties.$ref__added` | added | `#/definitions/AppServiceCertificateOrderPatchResourceProperties` |
| `definitions.ReissueCertificateOrderRequest.properties.properties.$ref__added` | added | `#/definitions/ReissueCertificateOrderRequestProperties` |
| `definitions.RenewCertificateOrderRequest.properties.properties.$ref__added` | added | `#/definitions/RenewCertificateOrderRequestProperties` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AppServiceCertificateOrderPatchResource.properties.tags__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.AppServiceCertificatePatchResource.properties.tags__added` | added | `{"type":"object","additionalProperties":{"type":"string"}}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.AppServiceCertificateOrder.allOf[0].$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/Resource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.AppServiceCertificateOrderPatchResource.allOf[0].$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/ProxyOnlyResource` | `#/definitions/ProxyOnlyResource` |
| `definitions.AppServiceCertificatePatchResource.allOf[0].$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/ProxyOnlyResource` | `#/definitions/ProxyOnlyResource` |
| `definitions.AppServiceCertificateResource.allOf[0].$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/Resource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.ReissueCertificateOrderRequest.allOf[0].$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/ProxyOnlyResource` | `#/definitions/ProxyOnlyResource` |
| `definitions.RenewCertificateOrderRequest.allOf[0].$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/ProxyOnlyResource` | `#/definitions/ProxyOnlyResource` |
| `paths['/providers/microsoft.CertificateRegistration/operations'].get.responses.200.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/CsmOperationCollection` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.CertificateRegistration/operations'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.CertificateRegistration/certificateOrders'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.CertificateRegistration/validateCertificateRegistrationInformation'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}'].delete.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}'].patch.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}'].put.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/certificates'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/certificates/{name}'].delete.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/certificates/{name}'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/certificates/{name}'].patch.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/certificates/{name}'].put.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/detectors'].get.responses.200.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DetectorResponseCollection` | `#/definitions/DetectorResponseCollection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/detectors'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/detectors/{detectorName}'].get.responses.200.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DetectorResponse` | `#/definitions/DetectorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/detectors/{detectorName}'].get.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/reissue'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/renew'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/resendEmail'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/resendRequestEmails'].post.parameters[1].schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/NameIdentifier` | `#/definitions/NameIdentifier` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/resendRequestEmails'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/retrieveSiteSeal'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/verifyDomainOwnership'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{name}/retrieveCertificateActions'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.CertificateRegistration/certificateOrders/{name}/retrieveEmailHistory'].post.responses.default.schema.$ref` | `../../../Microsoft.Web/stable/2024-11-01/CommonDefinitions.json#/definitions/DefaultErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

