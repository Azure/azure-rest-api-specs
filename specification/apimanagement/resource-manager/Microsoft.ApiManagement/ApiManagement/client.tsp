import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;
using Http;
using Azure.ResourceManager;

// Java-specific compatibility customizations generated per TypeSpec migration guidance.
@@clientName(Microsoft.ApiManagement.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(Microsoft.ApiManagement.TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "java,python"
);
@@clientName(Microsoft.ApiManagement.ConnectivityCheckRequest.preferredIPVersion,
  "preferredIpVersion",
  "java"
);

@@clientName(Microsoft.ApiManagement.ApiManagementSkuCosts.meterID,
  "meterId",
  "java"
);
@@clientName(Microsoft.ApiManagement.KeyVaultLastAccessStatusContractProperties.timeStampUtc,
  "timestampUtc",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.ApiManagementServiceBaseProperties.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.AdditionalLocation.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(Microsoft.ApiManagement.HostnameConfiguration.hostName,
  "hostname",
  "java"
);

@@clientLocation(Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.get,
  "ApiManagementWorkspaceLinkOperations",
  "java"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.listByService,
  "ApiManagementWorkspaceLinks",
  "java"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementServiceResources.performConnectivityCheckAsync,
  "ResourceProviders",
  "java"
);

@@clientName(CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "java"
);

@@clientName(ExportFormat.Swagger, "SWAGGER_LINK", "java");
@@clientName(ExportFormat.Wadl, "WADL_LINK", "java");
@@clientName(ExportFormat.Wsdl, "WSDL_LINK", "java");
@@clientName(ExportFormat.Openapi, "OPENAPI_LINK", "java");
@@clientName(ExportFormat.OpenapiJson, "OPENAPI_JSON_LINK", "java");
@@clientName(ExportResultFormat.Swagger, "SWAGGER_LINK_JSON", "java");
@@clientName(ExportResultFormat.Wadl, "WADL_LINK_JSON", "java");
@@clientName(ExportResultFormat.Wsdl, "WSDL_LINK_XML", "java");
@@clientName(ExportResultFormat.OpenApi, "OPENAPI_LINK", "java");
@@clientName(SoapApiType.SoapToRest, "HTTP", "java");
@@clientName(SoapApiType.SoapPassThrough, "SOAP", "java");
@@clientName(SoapApiType.WebSocket, "WEBSOCKET", "java");
@@clientName(SoapApiType.GraphQL, "GRAPHQL", "java");
@@clientName(SoapApiType.gRPC, "GRPC", "java");

@@clientName(Microsoft.ApiManagement, "ApiManagementClient", "python");
@@clientName(HttpCorrelationProtocol.W3C, "W3_C", "python");
@@clientLocation(ApiManagementServiceResources.performConnectivityCheckAsync,
  Microsoft.ApiManagement,
  "python"
);
@@clientName(CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python,go"
);

/**
 * override for DeletedServiceContracts.getByName
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceGetByName(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  location: Azure.Core.azureLocation,
): Azure.ResourceManager.ArmResponse<Microsoft.ApiManagement.DeletedServiceContract> | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(DeletedServiceContracts.getByName,
  replaceGetByName,
  "go,java,python"
);

/**
 * override for DeletedServiceContracts.purge
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replacePurge(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  serviceName: string,
  location: Azure.Core.azureLocation,
): ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
  @bodyRoot
  _: DeletedServiceContract;
}) | ArmDeletedNoContentResponse;

@@override(DeletedServiceContracts.purge, replacePurge, "go,java,python");

// Mitigate model rename: ConnectivityCheckRequestProtocolConfigurationHTTPConfiguration -> ...HttpConfiguration
@@clientName(ConnectivityCheckRequestProtocolConfigurationHttpConfiguration,
  "ConnectivityCheckRequestProtocolConfigurationHTTPConfiguration",
  "python"
);

// Mitigate property rename: eTag -> e_tag (should stay as etag)
@@clientName(GatewayHostnameBindingResource.eTag, "etag", "python");

@@clientName(TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "go"
);
@@clientLocation(Microsoft.ApiManagement.ApiManagementServiceResources.performConnectivityCheckAsync,
  "Client",
  "go"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(PolicyGetParameters.format,
  "xml",
  "javascript"
);

// C#-specific: Rename LLMDiagnosticSettings model to avoid case-insensitive filename collision with LlmDiagnosticSettings enum
@@clientName(Microsoft.ApiManagement.LLMDiagnosticSettings,
  "LargeLanguageModelDiagnosticSettings",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.LLMMessageDiagnosticSettings,
  "LargeLanguageModelMessageDiagnosticSettings",
  "csharp"
);

// C#-specific: Rename PrivateEndpointConnection to avoid duplicate name with ARM common type
@@clientName(Microsoft.ApiManagement.PrivateEndpointConnection,
  "ApiManagementPrivateEndpointConnection",
  "csharp"
);

// C#-specific: Backward-compat type renames matching previous SDK API surface
@@clientName(Microsoft.ApiManagement.Verbosity, "TraceVerbosityLevel", "csharp");
@@clientName(Microsoft.ApiManagement.Origin, "IssueOrigin", "csharp");
@@clientName(Microsoft.ApiManagement.Severity, "IssueSeverity", "csharp");
@@clientName(Microsoft.ApiManagement.NatGatewayState, "ApiManagementNatGatewayState", "csharp");
@@clientName(Microsoft.ApiManagement.NameAvailabilityReason, "ApiManagementServiceNameUnavailableReason", "csharp");
@@clientName(Microsoft.ApiManagement.GroupType, "ApiManagementGroupType", "csharp");
@@clientName(Microsoft.ApiManagement.UserState, "ApiManagementUserState", "csharp");

// C#-specific: Backward-compat operation/resource renames to avoid duplicate generated members.
@@clientName(AccessInformationContracts.tenantAccessGitRegeneratePrimaryKey, "TenantAccessGitRegeneratePrimaryKey", "csharp");
@@clientName(AccessInformationContracts.tenantAccessGitRegenerateSecondaryKey, "TenantAccessGitRegenerateSecondaryKey", "csharp");

@@clientName(NotificationContracts.listByNotification, "NotificationRecipientUserGetByNotification", "csharp");
@@clientName(NotificationContracts.checkEntityExists, "NotificationRecipientUserCheckEntityExists", "csharp");
@@clientName(NotificationContracts.notificationRecipientUserCreateOrUpdate, "NotificationRecipientUserCreateOrUpdate", "csharp");
@@clientName(NotificationContracts.delete, "NotificationRecipientUserDelete", "csharp");
@@clientName(NotificationContracts.notificationRecipientEmailListByNotification, "NotificationRecipientEmailGetByNotification", "csharp");
@@clientName(NotificationContracts.notificationRecipientEmailCheckEntityExists, "NotificationRecipientEmailCheckEntityExists", "csharp");
@@clientName(NotificationContracts.notificationRecipientEmailCreateOrUpdate, "NotificationRecipientEmailCreateOrUpdate", "csharp");
@@clientName(NotificationContracts.notificationRecipientEmailDelete, "NotificationRecipientEmailDelete", "csharp");

@@clientName(ProductContracts.listByProduct, "ProductApiGetByProduct", "csharp");
@@clientName(ProductContracts.checkEntityExists, "ProductApiCheckEntityExists", "csharp");
@@clientName(ProductContracts.productApiCreateOrUpdate, "ProductApiCreateOrUpdate", "csharp");
@@clientName(ProductContracts.productApiDelete, "ProductApiDelete", "csharp");
@@clientName(ProductContracts.productGroupListByProduct, "ProductGroupGetByProduct", "csharp");
@@clientName(ProductContracts.productGroupCheckEntityExists, "ProductGroupCheckEntityExists", "csharp");
@@clientName(ProductContracts.productGroupCreateOrUpdate, "ProductGroupCreateOrUpdate", "csharp");
@@clientName(ProductContracts.productGroupDelete, "ProductGroupDelete", "csharp");

@@clientName(OperationStatusOperationGroup.get, "GetOperationStatus", "csharp");
@@clientName(OperationsResultsOperationGroup.get, "GetOperationResult", "csharp");

@@clientName(ApiManagementServiceResources.listByService, "AllPoliciesGetByService", "csharp");
@@clientName(ApiManagementServiceResources.networkStatusListByService, "NetworkStatusGetByService", "csharp");
@@clientName(ApiManagementServiceResources.outboundNetworkDependenciesEndpointsListByService, "OutboundNetworkDependenciesEndpointsGetByService", "csharp");
@@clientName(ApiManagementServiceResources.portalSettingsListByService, "PortalSettingsGetByService", "csharp");
@@clientName(ApiManagementServiceResources.regionListByService, "RegionGetByService", "csharp");
@@clientName(ApiManagementServiceResources.listByTags, "ApiGetByTags", "csharp");
@@clientName(ApiManagementServiceResources.productListByTags, "ProductGetByTags", "csharp");

@@clientName(ApiContracts.getEntityTag, "ApiGetEntityTag", "csharp");
@@clientName(ApiVersionSetContracts.getEntityTag, "ApiVersionSetGetEntityTag", "csharp");
@@clientName(AuthorizationServerContracts.getEntityTag, "AuthorizationServerGetEntityTag", "csharp");
@@clientName(BackendContracts.getEntityTag, "BackendGetEntityTag", "csharp");
@@clientName(CacheContracts.getEntityTag, "CacheGetEntityTag", "csharp");
@@clientName(CertificateContracts.getEntityTag, "CertificateGetEntityTag", "csharp");
@@clientName(ClientApplicationContracts.getEntityTag, "ClientApplicationGetEntityTag", "csharp");
@@clientName(DiagnosticContracts.getEntityTag, "ApiDiagnosticGetEntityTag", "csharp");
@@clientName(DocumentationContracts.getEntityTag, "DocumentationGetEntityTag", "csharp");
@@clientName(GatewayContracts.getEntityTag, "GatewayGetEntityTag", "csharp");
@@clientName(GlobalSchemaContracts.getEntityTag, "GlobalSchemaGetEntityTag", "csharp");
@@clientName(GroupContracts.getEntityTag, "GroupGetEntityTag", "csharp");
@@clientName(LoggerContracts.getEntityTag, "LoggerGetEntityTag", "csharp");
@@clientName(NamedValueContracts.getEntityTag, "NamedValueGetEntityTag", "csharp");
@@clientName(OpenidConnectProviderContracts.getEntityTag, "OpenidConnectProviderGetEntityTag", "csharp");
@@clientName(PolicyFragmentContracts.getEntityTag, "PolicyFragmentGetEntityTag", "csharp");
@@clientName(PolicyRestrictionContracts.getEntityTag, "PolicyRestrictionGetEntityTag", "csharp");
@@clientName(PortalConfigContracts.getEntityTag, "PortalConfigGetEntityTag", "csharp");
@@clientName(PortalRevisionContracts.getEntityTag, "PortalRevisionGetEntityTag", "csharp");
@@clientName(ProductContracts.getEntityTag, "ProductGetEntityTag", "csharp");
@@clientName(SubscriptionContracts.getEntityTag, "SubscriptionGetEntityTag", "csharp");
@@clientName(UserContracts.getEntityTag, "UserGetEntityTag", "csharp");
@@clientName(WorkspaceContracts.getEntityTag, "WorkspaceGetEntityTag", "csharp");
@@clientName(DelegationSettings.getEntityTag, "DelegationSettingsGetEntityTag", "csharp");
@@clientName(SignInSettings.getEntityTag, "SignInSettingsGetEntityTag", "csharp");
@@clientName(SignUpSettings.getEntityTag, "SignUpSettingsGetEntityTag", "csharp");

@@clientName(WorkspaceNotification.listByNotification, "WorkspaceNotificationRecipientUserGetByNotification", "csharp");
@@clientName(WorkspaceNotification.checkEntityExists, "WorkspaceNotificationRecipientUserCheckEntityExists", "csharp");
@@clientName(WorkspaceNotification.workspaceNotificationRecipientUserCreateOrUpdate, "WorkspaceNotificationRecipientUserCreateOrUpdate", "csharp");
@@clientName(WorkspaceNotification.delete, "WorkspaceNotificationRecipientUserDelete", "csharp");
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailListByNotification, "WorkspaceNotificationRecipientEmailGetByNotification", "csharp");
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailCheckEntityExists, "WorkspaceNotificationRecipientEmailCheckEntityExists", "csharp");
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailCreateOrUpdate, "WorkspaceNotificationRecipientEmailCreateOrUpdate", "csharp");
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailDelete, "WorkspaceNotificationRecipientEmailDelete", "csharp");

@@clientName(WorkspaceApi.getEntityTag, "WorkspaceApiGetEntityTag", "csharp");
@@clientName(WorkspaceApiVersionSet.getEntityTag, "WorkspaceApiVersionSetGetEntityTag", "csharp");
@@clientName(WorkspaceBackend.getEntityTag, "WorkspaceBackendGetEntityTag", "csharp");
@@clientName(WorkspaceCertificate.getEntityTag, "WorkspaceCertificateGetEntityTag", "csharp");
@@clientName(WorkspaceDiagnostic.getEntityTag, "WorkspaceDiagnosticGetEntityTag", "csharp");
@@clientName(WorkspaceGlobalSchema.getEntityTag, "WorkspaceGlobalSchemaGetEntityTag", "csharp");
@@clientName(WorkspaceGroup.getEntityTag, "WorkspaceGroupGetEntityTag", "csharp");
@@clientName(WorkspaceLogger.getEntityTag, "WorkspaceLoggerGetEntityTag", "csharp");
@@clientName(WorkspaceNamedValue.getEntityTag, "WorkspaceNamedValueGetEntityTag", "csharp");
@@clientName(WorkspacePolicyFragment.getEntityTag, "WorkspacePolicyFragmentGetEntityTag", "csharp");
@@clientName(WorkspaceProduct.getEntityTag, "WorkspaceProductGetEntityTag", "csharp");
@@clientName(WorkspaceSubscription.getEntityTag, "WorkspaceSubscriptionGetEntityTag", "csharp");

@@clientName(WorkspaceApiDiagnostic.getEntityTag, "WorkspaceApiDiagnosticGetEntityTag", "csharp");
@@clientName(WorkspaceApiOperation.getEntityTag, "WorkspaceApiOperationGetEntityTag", "csharp");
@@clientName(WorkspaceApiRelease.getEntityTag, "WorkspaceApiReleaseGetEntityTag", "csharp");
@@clientName(WorkspaceApiSchema.getEntityTag, "WorkspaceApiSchemaGetEntityTag", "csharp");

@@clientName(TagContracts, "OperationTag", "csharp");
@@clientName(Tag, "ApiTag", "csharp");
@@clientName(TagContractOperation, "ProductTag", "csharp");
@@clientName(TagContractOperationGroup, "ApiManagementTag", "csharp");

@@clientName(GatewayContracts.gatewayApiGetEntityTag, "GatewayApiGetEntityTag", "csharp");
@@clientName(GatewayHostnameConfigurationContracts.getEntityTag, "GatewayHostnameConfigurationGetEntityTag", "csharp");

@@clientName(IssueContracts.getEntityTag, "ApiIssueGetEntityTag", "csharp");
@@clientName(OperationContracts.getEntityTag, "ApiOperationGetEntityTag", "csharp");
@@clientName(ResolverContracts.getEntityTag, "GraphQLApiResolverGetEntityTag", "csharp");
@@clientName(SchemaContracts.getEntityTag, "ApiSchemaGetEntityTag", "csharp");
@@clientName(TagDescriptionContracts.getEntityTag, "ApiTagDescriptionGetEntityTag", "csharp");
@@clientName(ToolContracts.getEntityTag, "ApiToolGetEntityTag", "csharp");

@@clientName(IssueAttachmentContracts.getEntityTag, "ApiIssueAttachmentGetEntityTag", "csharp");
@@clientName(IssueCommentContracts.getEntityTag, "ApiIssueCommentGetEntityTag", "csharp");

// C#-specific tag resource routing to keep distinct factories/resources after back-compat locations collapse them.
@@clientLocation(TagContracts.getByOperation, "OperationTag", "csharp");
@@clientLocation(TagContracts.getEntityStateByOperation, "OperationTag", "csharp");
@@clientLocation(TagContracts.assignToOperation, "OperationTag", "csharp");
@@clientLocation(TagContracts.detachFromOperation, "OperationTag", "csharp");
@@clientLocation(TagContracts.listByOperation, "OperationTag", "csharp");

@@clientLocation(TagContractOperation.getByProduct, "ProductTag", "csharp");
@@clientLocation(TagContractOperation.getEntityStateByProduct, "ProductTag", "csharp");
@@clientLocation(TagContractOperation.assignToProduct, "ProductTag", "csharp");
@@clientLocation(TagContractOperation.detachFromProduct, "ProductTag", "csharp");
@@clientLocation(TagContractOperation.listByProduct, "ProductTag", "csharp");

@@clientLocation(TagContractOperationGroup.get, "ApiManagementTag", "csharp");
@@clientLocation(TagContractOperationGroup.getEntityState, "ApiManagementTag", "csharp");
@@clientLocation(TagContractOperationGroup.createOrUpdate, "ApiManagementTag", "csharp");
@@clientLocation(TagContractOperationGroup.update, "ApiManagementTag", "csharp");
@@clientLocation(TagContractOperationGroup.delete, "ApiManagementTag", "csharp");
@@clientLocation(TagContractOperationGroup.listByService, "ApiManagementTag", "csharp");

// C#-specific: Override ARM base Resource.id type from string to ResourceIdentifier
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C#-specific: Rename properties that shadow ResourceData base class members
@@clientName(AccessInformationContractProperties.id, "AccessInfoType", "csharp");
@@clientName(ContentTypeContractProperties.id, "ContentTypeIdentifier", "csharp");
@@clientName(ContentTypeContractProperties.name, "ContentTypeName", "csharp");
@@clientName(OperationResultContractProperties.id, "OperationResultIdentifier", "csharp");

// C#-specific: Format conversions (alternateType) for backward-compat type matching
@@alternateType(ConnectivityStatusContract.lastUpdated, utcDateTime, "csharp");
@@alternateType(ConnectivityStatusContract.lastStatusChange, utcDateTime, "csharp");
@@alternateType(ApiEntityBaseContract.termsOfServiceUrl, url, "csharp");
@@alternateType(ConnectivityHop.address, Azure.Core.ipV4Address, "csharp");
@@alternateType(ConnectivityHop.resourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ApiManagementServiceBaseProperties.publicIPAddresses, Azure.Core.ipV4Address[], "csharp");
@@alternateType(ApiManagementServiceBaseProperties.privateIPAddresses, Azure.Core.ipV4Address[], "csharp");
@@alternateType(ApiManagementServiceBaseProperties.gatewayRegionalUrl, url, "csharp");
@@alternateType(AdditionalLocation.publicIPAddresses, Azure.Core.ipV4Address[], "csharp");
@@alternateType(AdditionalLocation.privateIPAddresses, Azure.Core.ipV4Address[], "csharp");
@@alternateType(AdditionalLocation.gatewayRegionalUrl, url, "csharp");
@@alternateType(RequestReportRecordContract.url, url, "csharp");
@@alternateType(RequestReportRecordContract.ipAddress, Azure.Core.ipV4Address, "csharp");
