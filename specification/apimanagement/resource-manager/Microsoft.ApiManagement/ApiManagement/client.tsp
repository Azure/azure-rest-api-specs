import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;
using Http;
using Azure.ResourceManager;

// Java-specific compatibility customizations generated per TypeSpec migration guidance.
@@clientName(
  Microsoft.ApiManagement.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "java,python"
);
@@clientName(
  Microsoft.ApiManagement.ConnectivityCheckRequest.preferredIPVersion,
  "preferredIpVersion",
  "java"
);

@@clientName(
  Microsoft.ApiManagement.ApiManagementSkuCosts.meterID,
  "meterId",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.KeyVaultLastAccessStatusContractProperties.timeStampUtc,
  "timestampUtc",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementServiceBaseProperties.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementServiceBaseProperties.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementServiceBaseProperties.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.AdditionalLocation.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.AdditionalLocation.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.AdditionalLocation.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.HostnameConfiguration.hostName,
  "hostname",
  "java"
);

@@clientLocation(
  Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.get,
  "ApiManagementWorkspaceLinkOperations",
  "java"
);
@@clientLocation(
  Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources.listByService,
  "ApiManagementWorkspaceLinks",
  "java"
);
@@clientLocation(
  Microsoft.ApiManagement.ApiManagementServiceResources.performConnectivityCheckAsync,
  "ResourceProviders",
  "java"
);

@@clientName(
  CommonTypes.PrivateEndpointConnection,
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
@@clientLocation(
  ApiManagementServiceResources.performConnectivityCheckAsync,
  Microsoft.ApiManagement,
  "python"
);
@@clientName(
  CommonTypes.PrivateEndpointConnection,
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
):
  | Azure.ResourceManager.ArmResponse<Microsoft.ApiManagement.DeletedServiceContract>
  | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(
  DeletedServiceContracts.getByName,
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
):
  | ArmDeletedResponse
  | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: DeletedServiceContract;
    })
  | ArmDeletedNoContentResponse;

@@override(DeletedServiceContracts.purge, replacePurge, "go,java,python");

// Mitigate model rename: ConnectivityCheckRequestProtocolConfigurationHTTPConfiguration -> ...HttpConfiguration
@@clientName(
  ConnectivityCheckRequestProtocolConfigurationHttpConfiguration,
  "ConnectivityCheckRequestProtocolConfigurationHTTPConfiguration",
  "python"
);

// Mitigate property rename: eTag -> e_tag (should stay as etag)
@@clientName(GatewayHostnameBindingResource.eTag, "etag", "python");

@@clientName(
  TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "go"
);
@@clientLocation(
  Microsoft.ApiManagement.ApiManagementServiceResources.performConnectivityCheckAsync,
  "Client",
  "go"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  PolicyGetParameters.format,
  "xml",
  "javascript"
);

@@apiVersion(ApiContractProperties.apiVersionSet, false);
@@apiVersion(ApiRevisionInfoContract.apiVersionSet, false);
@@apiVersion(ApiManagementServiceBaseProperties.apiVersionConstraint, false);
@@apiVersion(ApiManagementSku.apiVersions, false);

// C#-specific: Rename LLMDiagnosticSettings model to avoid case-insensitive filename collision with LlmDiagnosticSettings enum
@@clientName(
  Microsoft.ApiManagement.LLMDiagnosticSettings,
  "LargeLanguageModelDiagnosticSettings",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.LLMMessageDiagnosticSettings,
  "LargeLanguageModelMessageDiagnosticSettings",
  "csharp"
);

// C#-specific: Rename PrivateEndpointConnection to avoid duplicate name with ARM common type
@@clientName(
  Microsoft.ApiManagement.PrivateEndpointConnection,
  "ApiManagementPrivateEndpointConnection",
  "csharp"
);

// C#-specific: Backward-compat type renames matching previous SDK API surface
@@clientName(
  Microsoft.ApiManagement.Verbosity,
  "TraceVerbosityLevel",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.Origin, "IssueOrigin", "csharp");
@@clientName(Microsoft.ApiManagement.Severity, "IssueSeverity", "csharp");
@@clientName(
  Microsoft.ApiManagement.NatGatewayState,
  "ApiManagementNatGatewayState",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.NameAvailabilityReason,
  "ApiManagementServiceNameUnavailableReason",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GroupType,
  "ApiManagementGroupType",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.UserState,
  "ApiManagementUserState",
  "csharp"
);

// C#-specific: Backward-compat resource type renames to restore previously shipped Data/Resource/Collection type names.
@@clientName(
  Microsoft.ApiManagement.AccessInformationContract,
  "TenantAccessInfo",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.ApiContract, "Api", "csharp");
@@clientName(
  Microsoft.ApiManagement.ApiReleaseContract,
  "ApiRelease",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiVersionSetContract,
  "ApiVersionSet",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AuthorizationServerContract,
  "ApiManagementAuthorizationServer",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.BackendContract,
  "ApiManagementBackend",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.CacheContract,
  "ApiManagementCache",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.CertificateContract,
  "ApiManagementCertificate",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.DeletedServiceContract,
  "ApiManagementDeletedService",
  "csharp"
);
// C#-specific: DiagnosticContract intentionally NOT renamed so the data class
// keeps its GA name `DiagnosticContractData`. The Resource/Collection still
// get `ApiManagementDiagnostic*` via ResourceName overrides in DiagnosticContract.tsp.
@@clientName(
  Microsoft.ApiManagement.EmailTemplateContract,
  "ApiManagementEmailTemplate",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GatewayCertificateAuthorityContract,
  "ApiManagementGatewayCertificateAuthority",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.GatewayContract, "ApiGateway", "csharp");
@@clientName(
  Microsoft.ApiManagement.GatewayHostnameConfigurationContract,
  "ApiManagementGatewayHostnameConfiguration",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GlobalSchemaContract,
  "ApiManagementGlobalSchema",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GroupContract,
  "ApiManagementGroup",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.IdentityProviderContract,
  "ApiManagementIdentityProvider",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.IssueAttachmentContract,
  "ApiIssueAttachment",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.IssueCommentContract,
  "ApiIssueComment",
  "csharp"
);
// C#-specific: IssueContract intentionally NOT renamed so the data class
// keeps its GA name `IssueContractData`. The Resource/Collection still
// get `ApiManagementIssue*` via ResourceName overrides in IssueContract.tsp.
@@clientName(
  Microsoft.ApiManagement.LoggerContract,
  "ApiManagementLogger",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.NamedValueContract,
  "ApiManagementNamedValue",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.NotificationContract,
  "ApiManagementNotification",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.OpenidConnectProviderContract,
  "ApiManagementOpenIdConnectProvider",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.OperationContract,
  "ApiOperation",
  "csharp"
);
// C#-specific: PolicyContract intentionally NOT renamed so the data class
// keeps its GA name `PolicyContractData`. The Resource/Collection still
// get `ApiManagementPolicy*` via ResourceName overrides in PolicyContract.tsp.
@@clientName(
  Microsoft.ApiManagement.PortalRevisionContract,
  "ApiManagementPortalRevision",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PrivateLinkResource,
  "ApiManagementPrivateLinkResource",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductContract,
  "ApiManagementProduct",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.SchemaContract, "ApiSchema", "csharp");
// C#-specific: SubscriptionContract intentionally NOT renamed so the data class
// keeps its GA name `SubscriptionContractData`. The Resource/Collection still
// get `ApiManagementSubscription*` via ResourceName overrides in SubscriptionContract.tsp.
@@clientName(
  Microsoft.ApiManagement.TagDescriptionContract,
  "ApiTagDescription",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TenantSettingsContract,
  "ApiManagementTenantSetting",
  "csharp"
);
// C#-specific: UserContract intentionally NOT renamed so the data class
// keeps its GA name `UserContractData`. The Resource/Collection still
// get `ApiManagementUser*` via ResourceName overrides in UserContract.tsp.
@@clientName(Microsoft.ApiManagement.SchemaType, "ApiSchemaType", "csharp");

// C#-specific: Backward-compat enum/union renames for properties scoped under parent resources
@@clientName(
  Microsoft.ApiManagement.SkuType,
  "ApiManagementServiceSkuType",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductState,
  "ApiManagementProductState",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.Protocol,
  "ApiOperationInvokableProtocol",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.KeyType,
  "TokenGenerationUsedKeyType",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AccessType,
  "StorageAccountAccessType",
  "csharp"
);

// C#-specific: Backward-compat list-result / request / response model renames to match previously shipped SDK conventions
@@clientName(Microsoft.ApiManagement.ApiCollection, "ApiListResult", "csharp");
@@clientName(
  Microsoft.ApiManagement.ApiReleaseCollection,
  "ApiReleaseListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiVersionSetCollection,
  "ApiVersionSetListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.BackendCollection,
  "BackendListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.CertificateCollection,
  "CertificateListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.DiagnosticCollection,
  "DiagnosticListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GlobalSchemaCollection,
  "GlobalSchemaListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GroupCollection,
  "GroupListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.IssueCollection,
  "IssueListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.LoggerCollection,
  "LoggerListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.NamedValueCollection,
  "NamedValueListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.NotificationCollection,
  "NotificationListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PolicyCollection,
  "PolicyListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PolicyDescriptionCollection,
  "PolicyDescriptionListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PolicyFragmentCollection,
  "PolicyFragmentListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PortalSettingsCollection,
  "PortalSettingsListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductApiLinkCollection,
  "ProductApiLinkListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductCollection,
  "ProductListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductGroupLinkCollection,
  "ProductGroupLinkListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.QuotaCounterCollection,
  "QuotaCounterListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.RecipientEmailCollection,
  "RecipientEmailListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.RecipientUserCollection,
  "RecipientUserListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ResourceCollection,
  "ResourceListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.SubscriptionCollection,
  "SubscriptionListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TagApiLinkCollection,
  "TagApiLinkListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TagOperationLinkCollection,
  "TagOperationLinkListResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TagProductLinkCollection,
  "TagProductLinkListResult",
  "csharp"
);

@@clientName(
  Microsoft.ApiManagement.ApiCreateOrUpdateParameter,
  "ApiCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AccessInformationCreateParameters,
  "TenantAccessInfoCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementServiceApplyNetworkConfigurationParameters,
  "ApiManagementServiceApplyNetworkConfigurationContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementServiceBackupRestoreParameters,
  "ApiManagementServiceBackupRestoreContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementServiceCheckNameAvailabilityParameters,
  "ApiManagementServiceNameAvailabilityContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiVersionSetUpdateParameters,
  "ApiVersionSetPatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.BackendUpdateParameters,
  "ApiManagementBackendPatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.CertificateCreateOrUpdateParameters,
  "ApiManagementCertificateCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.DeployConfigurationParameters,
  "ConfigurationDeployContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GroupCreateParameters,
  "ApiManagementGroupCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.GroupUpdateParameters,
  "ApiManagementGroupPatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.NamedValueUpdateParameters,
  "ApiManagementNamedValuePatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductEntityBaseParameters,
  "ProductEntityBaseProperties",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductUpdateParameters,
  "ApiManagementProductPatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.SaveConfigurationParameter,
  "ConfigurationSaveContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.SubscriptionCreateParameters,
  "ApiManagementSubscriptionCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.SubscriptionUpdateParameters,
  "ApiManagementSubscriptionPatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TagCreateUpdateParameters,
  "ApiManagementTagCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TagDescriptionCreateParameters,
  "ApiTagDescriptionCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.UserCreateParameters,
  "ApiManagementUserCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.UserTokenParameters,
  "UserTokenContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ConnectivityCheckRequest,
  "ConnectivityCheckContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ConnectivityCheckResponse,
  "ConnectivityCheckResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PrivateEndpointConnectionRequest,
  "PrivateEndpointConnectionContent",
  "csharp"
);

// C#-specific: Additional backward-compat renames to restore GA model names.
@@clientName(Microsoft.ApiManagement.ApiUpdateContract, "ApiPatch", "csharp");
@@clientName(
  Microsoft.ApiManagement.LoggerUpdateContract,
  "ApiManagementLoggerPatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.OperationUpdateContract,
  "ApiOperationPatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.IssueUpdateContract,
  "ApiIssuePatch",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.QuotaCounterValueUpdateContract,
  "QuotaCounterValueUpdateContent",
  "csharp"
);
// NOTE: GatewayKeyRegenerationRequestContract intentionally NOT renamed.
// Renaming it to GatewayKeyRegenerateContent causes the C# emitter to compute
// the per-property enum name as `GatewayRegenerateKeyType` (rearranged from
// the new model name), but the underlying KeyType union is already renamed
// to `TokenGenerationUsedKeyType` so no `GatewayRegenerateKeyType.cs` file
// is emitted — leading to CS0234.
@@clientName(
  Microsoft.ApiManagement.GenerateSsoUrlResult,
  "GenerateSsoUriResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AuthorizationConfirmConsentCodeRequestContract,
  "AuthorizationConfirmConsentCodeContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AuthorizationLoginRequestContract,
  "AuthorizationLoginContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AuthorizationLoginResponseContract,
  "AuthorizationLoginResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AuthorizationType,
  "ApiManagementAuthorizationType",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AuthorizationError,
  "ApiManagementAuthorizationError",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.IdentityProviderCreateContract,
  "ApiManagementIdentityProviderCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.NamedValueCreateContract,
  "ApiManagementNamedValueCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PolicyDescriptionContract,
  "PolicyDescriptionContractData",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PortalSettingsContract,
  "PortalSettingsContractData",
  "csharp"
);

// C#-specific: Backward-compat operation/resource renames to avoid duplicate generated members.
@@clientName(
  AccessInformationContracts.tenantAccessGitRegeneratePrimaryKey,
  "TenantAccessGitRegeneratePrimaryKey",
  "csharp"
);
@@clientName(
  AccessInformationContracts.tenantAccessGitRegenerateSecondaryKey,
  "TenantAccessGitRegenerateSecondaryKey",
  "csharp"
);

@@clientName(
  NotificationContracts.listByNotification,
  "NotificationRecipientUserGetByNotification",
  "csharp"
);
@@clientName(
  NotificationContracts.checkEntityExists,
  "NotificationRecipientUserCheckEntityExists",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientUserCreateOrUpdate,
  "NotificationRecipientUserCreateOrUpdate",
  "csharp"
);
@@clientName(
  NotificationContracts.delete,
  "NotificationRecipientUserDelete",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientEmailListByNotification,
  "NotificationRecipientEmailGetByNotification",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientEmailCheckEntityExists,
  "NotificationRecipientEmailCheckEntityExists",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientEmailCreateOrUpdate,
  "NotificationRecipientEmailCreateOrUpdate",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientEmailDelete,
  "NotificationRecipientEmailDelete",
  "csharp"
);

@@clientName(
  ProductContracts.listByProduct,
  "ProductApiGetByProduct",
  "csharp"
);
@@clientName(
  ProductContracts.checkEntityExists,
  "ProductApiCheckEntityExists",
  "csharp"
);
@@clientName(
  ProductContracts.productApiCreateOrUpdate,
  "ProductApiCreateOrUpdate",
  "csharp"
);
@@clientName(ProductContracts.productApiDelete, "ProductApiDelete", "csharp");
@@clientName(
  ProductContracts.productGroupListByProduct,
  "ProductGroupGetByProduct",
  "csharp"
);
@@clientName(
  ProductContracts.productGroupCheckEntityExists,
  "ProductGroupCheckEntityExists",
  "csharp"
);
@@clientName(
  ProductContracts.productGroupCreateOrUpdate,
  "ProductGroupCreateOrUpdate",
  "csharp"
);
@@clientName(
  ProductContracts.productGroupDelete,
  "ProductGroupDelete",
  "csharp"
);

@@clientName(OperationStatusOperationGroup.get, "GetOperationStatus", "csharp");
@@clientName(
  OperationsResultsOperationGroup.get,
  "GetOperationResult",
  "csharp"
);

@@clientName(
  ApiManagementServiceResources.listByService,
  "AllPoliciesGetByService",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.networkStatusListByService,
  "NetworkStatusGetByService",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.outboundNetworkDependenciesEndpointsListByService,
  "OutboundNetworkDependenciesEndpointsGetByService",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.portalSettingsListByService,
  "PortalSettingsGetByService",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.regionListByService,
  "RegionGetByService",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByTags,
  "ApiGetByTags",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.productListByTags,
  "ProductGetByTags",
  "csharp"
);

@@clientName(ApiContracts.getEntityTag, "ApiGetEntityTag", "csharp");
@@clientName(
  ApiVersionSetContracts.getEntityTag,
  "ApiVersionSetGetEntityTag",
  "csharp"
);
@@clientName(
  AuthorizationServerContracts.getEntityTag,
  "AuthorizationServerGetEntityTag",
  "csharp"
);
@@clientName(BackendContracts.getEntityTag, "BackendGetEntityTag", "csharp");
@@clientName(CacheContracts.getEntityTag, "CacheGetEntityTag", "csharp");
@@clientName(
  CertificateContracts.getEntityTag,
  "CertificateGetEntityTag",
  "csharp"
);
@@clientName(
  ClientApplicationContracts.getEntityTag,
  "ClientApplicationGetEntityTag",
  "csharp"
);
@@clientName(
  DiagnosticContracts.getEntityTag,
  "ApiDiagnosticGetEntityTag",
  "csharp"
);
@@clientName(
  DocumentationContracts.getEntityTag,
  "DocumentationGetEntityTag",
  "csharp"
);
@@clientName(GatewayContracts.getEntityTag, "GatewayGetEntityTag", "csharp");
@@clientName(
  GlobalSchemaContracts.getEntityTag,
  "GlobalSchemaGetEntityTag",
  "csharp"
);
@@clientName(GroupContracts.getEntityTag, "GroupGetEntityTag", "csharp");
@@clientName(LoggerContracts.getEntityTag, "LoggerGetEntityTag", "csharp");
@@clientName(
  NamedValueContracts.getEntityTag,
  "NamedValueGetEntityTag",
  "csharp"
);
@@clientName(
  OpenidConnectProviderContracts.getEntityTag,
  "OpenidConnectProviderGetEntityTag",
  "csharp"
);
@@clientName(
  PolicyFragmentContracts.getEntityTag,
  "PolicyFragmentGetEntityTag",
  "csharp"
);
@@clientName(
  PolicyRestrictionContracts.getEntityTag,
  "PolicyRestrictionGetEntityTag",
  "csharp"
);
@@clientName(
  PortalConfigContracts.getEntityTag,
  "PortalConfigGetEntityTag",
  "csharp"
);
@@clientName(
  PortalRevisionContracts.getEntityTag,
  "PortalRevisionGetEntityTag",
  "csharp"
);
@@clientName(ProductContracts.getEntityTag, "ProductGetEntityTag", "csharp");
@@clientName(
  SubscriptionContracts.getEntityTag,
  "SubscriptionGetEntityTag",
  "csharp"
);
@@clientName(UserContracts.getEntityTag, "UserGetEntityTag", "csharp");
@@clientName(
  WorkspaceContracts.getEntityTag,
  "WorkspaceGetEntityTag",
  "csharp"
);
@@clientName(
  DelegationSettings.getEntityTag,
  "DelegationSettingsGetEntityTag",
  "csharp"
);
@@clientName(
  SignInSettings.getEntityTag,
  "SignInSettingsGetEntityTag",
  "csharp"
);
@@clientName(
  SignUpSettings.getEntityTag,
  "SignUpSettingsGetEntityTag",
  "csharp"
);

@@clientName(
  WorkspaceNotification.listByNotification,
  "WorkspaceNotificationRecipientUserGetByNotification",
  "csharp"
);
@@clientName(
  WorkspaceNotification.checkEntityExists,
  "WorkspaceNotificationRecipientUserCheckEntityExists",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientUserCreateOrUpdate,
  "WorkspaceNotificationRecipientUserCreateOrUpdate",
  "csharp"
);
@@clientName(
  WorkspaceNotification.delete,
  "WorkspaceNotificationRecipientUserDelete",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailListByNotification,
  "WorkspaceNotificationRecipientEmailGetByNotification",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailCheckEntityExists,
  "WorkspaceNotificationRecipientEmailCheckEntityExists",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailCreateOrUpdate,
  "WorkspaceNotificationRecipientEmailCreateOrUpdate",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailDelete,
  "WorkspaceNotificationRecipientEmailDelete",
  "csharp"
);

@@clientName(WorkspaceApi.getEntityTag, "WorkspaceApiGetEntityTag", "csharp");
@@clientName(
  WorkspaceApiVersionSet.getEntityTag,
  "WorkspaceApiVersionSetGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceBackend.getEntityTag,
  "WorkspaceBackendGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceCertificate.getEntityTag,
  "WorkspaceCertificateGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceDiagnostic.getEntityTag,
  "WorkspaceDiagnosticGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceGlobalSchema.getEntityTag,
  "WorkspaceGlobalSchemaGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceGroup.getEntityTag,
  "WorkspaceGroupGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceLogger.getEntityTag,
  "WorkspaceLoggerGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceNamedValue.getEntityTag,
  "WorkspaceNamedValueGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspacePolicyFragment.getEntityTag,
  "WorkspacePolicyFragmentGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceProduct.getEntityTag,
  "WorkspaceProductGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceSubscription.getEntityTag,
  "WorkspaceSubscriptionGetEntityTag",
  "csharp"
);

@@clientName(
  WorkspaceApiDiagnostic.getEntityTag,
  "WorkspaceApiDiagnosticGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceApiOperation.getEntityTag,
  "WorkspaceApiOperationGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceApiRelease.getEntityTag,
  "WorkspaceApiReleaseGetEntityTag",
  "csharp"
);
@@clientName(
  WorkspaceApiSchema.getEntityTag,
  "WorkspaceApiSchemaGetEntityTag",
  "csharp"
);

// Tag 4-scope and Service-link renames are now handled by §4.18 ResourceName
// friendly names in the corresponding LegacyOperations aliases inside
// TagContract.tsp, ProductApiLinkContract.tsp, etc. The previous interface-level
// @@clientName decorators here were ineffective because the generator derives
// Resource/Collection/RestOperations class names during resource detection,
// before @@clientName takes effect.

@@clientName(
  GatewayContracts.gatewayApiGetEntityTag,
  "GatewayApiGetEntityTag",
  "csharp"
);
@@clientName(
  GatewayHostnameConfigurationContracts.getEntityTag,
  "GatewayHostnameConfigurationGetEntityTag",
  "csharp"
);

@@clientName(IssueContracts.getEntityTag, "ApiIssueGetEntityTag", "csharp");
@@clientName(
  OperationContracts.getEntityTag,
  "ApiOperationGetEntityTag",
  "csharp"
);
@@clientName(
  ResolverContracts.getEntityTag,
  "GraphQLApiResolverGetEntityTag",
  "csharp"
);
@@clientName(SchemaContracts.getEntityTag, "ApiSchemaGetEntityTag", "csharp");
@@clientName(
  TagDescriptionContracts.getEntityTag,
  "ApiTagDescriptionGetEntityTag",
  "csharp"
);
@@clientName(ToolContracts.getEntityTag, "ApiToolGetEntityTag", "csharp");

@@clientName(
  IssueAttachmentContracts.getEntityTag,
  "ApiIssueAttachmentGetEntityTag",
  "csharp"
);
@@clientName(
  IssueCommentContracts.getEntityTag,
  "ApiIssueCommentGetEntityTag",
  "csharp"
);

// C#-specific tag resource routing to keep distinct factories/resources after back-compat locations collapse them.
@@clientLocation(TagContracts.getByOperation, "OperationTag", "csharp");
@@clientLocation(
  TagContracts.getEntityStateByOperation,
  "OperationTag",
  "csharp"
);
@@clientLocation(TagContracts.assignToOperation, "OperationTag", "csharp");
@@clientLocation(TagContracts.detachFromOperation, "OperationTag", "csharp");
@@clientLocation(TagContracts.listByOperation, "OperationTag", "csharp");

@@clientLocation(TagContractOperation.getByProduct, "ProductTag", "csharp");
@@clientLocation(
  TagContractOperation.getEntityStateByProduct,
  "ProductTag",
  "csharp"
);
@@clientLocation(TagContractOperation.assignToProduct, "ProductTag", "csharp");
@@clientLocation(
  TagContractOperation.detachFromProduct,
  "ProductTag",
  "csharp"
);
@@clientLocation(TagContractOperation.listByProduct, "ProductTag", "csharp");

@@clientLocation(TagContractOperationGroup.get, "ApiManagementTag", "csharp");
@@clientLocation(
  TagContractOperationGroup.getEntityState,
  "ApiManagementTag",
  "csharp"
);
@@clientLocation(
  TagContractOperationGroup.createOrUpdate,
  "ApiManagementTag",
  "csharp"
);
@@clientLocation(
  TagContractOperationGroup.update,
  "ApiManagementTag",
  "csharp"
);
@@clientLocation(
  TagContractOperationGroup.delete,
  "ApiManagementTag",
  "csharp"
);
@@clientLocation(
  TagContractOperationGroup.listByService,
  "ApiManagementTag",
  "csharp"
);

// C#-specific: Override ARM base Resource.id type from string to ResourceIdentifier
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C#-specific: Rename properties that shadow ResourceData base class members
@@clientName(
  AccessInformationContractProperties.id,
  "AccessInfoType",
  "csharp"
);
@@clientName(
  ContentTypeContractProperties.id,
  "ContentTypeIdentifier",
  "csharp"
);
@@clientName(ContentTypeContractProperties.name, "ContentTypeName", "csharp");
@@clientName(
  OperationResultContractProperties.id,
  "OperationResultIdentifier",
  "csharp"
);

// C#-specific: Format conversions (alternateType) for backward-compat type matching
@@alternateType(ConnectivityStatusContract.lastUpdated, utcDateTime, "csharp");
@@alternateType(
  ConnectivityStatusContract.lastStatusChange,
  utcDateTime,
  "csharp"
);
// NOTE: @@alternateType for ApiEntityBaseContract.termsOfServiceUrl -> url
// intentionally removed; GA 1.3.0 shipped this as `string TermsOfServiceLink`,
// so we keep the spec string type and only @@clientName-rename it (see below).
@@alternateType(ConnectivityHop.address, Azure.Core.ipV4Address, "csharp");
@@alternateType(
  ConnectivityHop.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApiManagementServiceBaseProperties.publicIPAddresses,
  Azure.Core.ipV4Address[],
  "csharp"
);
@@alternateType(
  ApiManagementServiceBaseProperties.privateIPAddresses,
  Azure.Core.ipV4Address[],
  "csharp"
);
@@alternateType(
  ApiManagementServiceBaseProperties.gatewayRegionalUrl,
  url,
  "csharp"
);
@@alternateType(
  AdditionalLocation.publicIPAddresses,
  Azure.Core.ipV4Address[],
  "csharp"
);
@@alternateType(
  AdditionalLocation.privateIPAddresses,
  Azure.Core.ipV4Address[],
  "csharp"
);
@@alternateType(AdditionalLocation.gatewayRegionalUrl, url, "csharp");
@@alternateType(RequestReportRecordContract.url, url, "csharp");
@@alternateType(
  RequestReportRecordContract.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);

// =========================================================================
// C#-specific: All wrapper class name renames (parent-scope, workspace-scope,
// extension-scope, multi-scope shared models) are applied via the §4.18
// ResourceName positional template parameter on the LegacyOperations alias
// in the resource .tsp files. The previous interface-level @@clientName
// approach had no effect because the generator derives Resource/Collection/
// RestOperations class names during resource detection, before @@clientName
// is applied. Friendly name is the proper fix.
// =========================================================================

// Service-prefix non-workspace interfaces (product/tag link tables, sub-resources)
// and ProductWiki / GraphQLApiResolverPolicy are now handled by §4.18
// ResourceName friendly names in their respective LegacyOperations aliases
// (ProductApiLinkContract.tsp, ProductGroupLinkContract.tsp, TagApiLinkContract.tsp,
// TagOperationLinkContract.tsp, TagProductLinkContract.tsp, WikiContract.tsp,
// PolicyContract.tsp).

// Resource-suffix removal for `@armResourceOperations` interfaces whose
// MPG-derived wrapper name needlessly duplicates the word "Resource".
@@clientName(
  Microsoft.ApiManagement.ApiManagementServiceResources,
  "ApiManagementService",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementGatewayResources,
  "ApiManagementGateway",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementGatewayConfigConnectionResources,
  "ApiGatewayConfigConnection",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiManagementWorkspaceLinksResources,
  "ApiManagementWorkspaceLinks",
  "csharp"
);

// Policy / settings / portal: rename interfaces that emit oddly-named wrappers.
@@clientName(
  Microsoft.ApiManagement.ProductPolicy,
  "ApiManagementProductPolicy",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.DelegationSettings,
  "ApiManagementPortalDelegationSetting",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.SignInSettings,
  "ApiManagementPortalSignInSetting",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.SignUpSettings,
  "ApiManagementPortalSignUpSetting",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ContentItemContracts,
  "ApiManagementContentItem",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ContentTypeContracts,
  "ApiManagementContentType",
  "csharp"
);

// Tag-on-Api / Tag-on-Product wrappers (renamed for parity with previously shipped names).
@@clientName(
  Microsoft.ApiManagement.TagContractOperation,
  "ApiOperationTag",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TagContractOperationGroup,
  "ApiManagementProductTag",
  "csharp"
);

// Force input usage on Data/Resource contract models that have a separate
// "CreateOrUpdate" request type in spec. Without this, the C# emitter treats
// these as response-only models, producing internal-only constructors and
// read-only public properties on the Data classes — breaking GA back-compat.
@@usage(AccessInformationContract, Usage.input, "csharp");
@@usage(ApiContract, Usage.input, "csharp");
@@usage(CertificateContract, Usage.input, "csharp");
@@usage(EmailTemplateContract, Usage.input, "csharp");
@@usage(GroupContract, Usage.input, "csharp");
@@usage(IdentityProviderContract, Usage.input, "csharp");
@@usage(NamedValueContract, Usage.input, "csharp");
@@usage(UserContract, Usage.input, "csharp");
@@usage(TagDescriptionContract, Usage.input, "csharp");
@@usage(TagContract, Usage.input, "csharp");
@@usage(SubscriptionContract, Usage.input, "csharp");

// Model renames identified from GA contract diff.
@@clientName(
  Microsoft.ApiManagement.TagResourceContract,
  "TagResourceContractDetails",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.TagTagResourceContractProperties,
  "AssociatedTagProperties",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiTagResourceContractProperties,
  "AssociatedApiProperties",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.OperationTagResourceContractProperties,
  "AssociatedOperationProperties",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ProductTagResourceContractProperties,
  "AssociatedProductProperties",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AccessInformationSecretsContract,
  "TenantAccessInfoSecretsDetails",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.OperationResultContract,
  "GitOperationResultContractData",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.State, "IssueState", "csharp");
@@clientName(
  Microsoft.ApiManagement.Method,
  "HttpMethodConfiguration",
  "csharp"
);
// NOTE: HttpHeader rename intentionally omitted - the C# emitter emits the
// type as `HTTPHeader` (uppercase) by default; setting @@clientName here to
// the GA name `HttpHeaderConfiguration` causes the type definition file to
// not be emitted at all, leading to CS0234.
@@clientName(
  Microsoft.ApiManagement.NetworkStatusContractByLocation,
  "NetworkStatusContractWithLocation",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.PolicyIdName, "PolicyName", "csharp");
@@clientName(
  Microsoft.ApiManagement.SettingsTypeName,
  "SettingsType",
  "csharp"
);
@@clientName(Microsoft.ApiManagement.AccessIdName, "AccessName", "csharp");
@@clientName(
  Microsoft.ApiManagement.ConfigurationIdName,
  "ConfigurationName",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.Confirmation,
  "ConfirmationEmailType",
  "csharp"
);
// NOTE: ConnectivityCheckRequestProtocolConfigurationHttpConfiguration rename
// intentionally omitted - renaming the parent makes the emitter compute a
// context-derived name `HttpHeaderConfiguration` for the nested `headers:
// HttpHeader[]` element. The HttpHeader type is then emitted as `HTTPHeader.cs`
// while references use `HttpHeaderConfiguration`, causing CS0234.
@@clientName(
  Microsoft.ApiManagement.ResourceSkuCapacity,
  "ApiManagementResourceSkuCapacity",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ResourceSkuCapacityScaleType,
  "ApiManagementResourceSkuCapacityScaleType",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ResourceSkuResult,
  "AvailableApiManagementServiceSkuResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PrivateEndpointConnectionRequest,
  "ApiManagementPrivateEndpointConnectionCreateOrUpdateContent",
  "csharp"
);
// AssociationContractPropertiesProvisioningState rename intentionally omitted -
// the type is emitted from an inline anonymous enum on the `provisioningState`
// property, so it cannot be targeted by @@clientName.

// Back-compat property renames for GA 1.3.0 - new spec field names differ from
// the names shipped in the last GA. Re-map each new field to its GA C# name.
@@clientName(
  Microsoft.ApiManagement.ApiEntityBaseContract.subscriptionRequired,
  "isSubscriptionRequired",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiEntityBaseContract.termsOfServiceUrl,
  "termsOfServiceLink",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.ApiContractProperties.serviceUrl,
  "serviceLink",
  "csharp"
);
@@alternateType(
  Microsoft.ApiManagement.ApiContractProperties.sourceApiId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
