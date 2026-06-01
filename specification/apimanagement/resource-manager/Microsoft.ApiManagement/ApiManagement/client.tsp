import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;
using Http;
using Azure.ResourceManager;

// Java-specific compatibility customizations generated per TypeSpec migration guidance.
@@clientName(PreferredIPVersion, "PreferredIpVersion", "java");
@@clientName(
  TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "java,python"
);
@@clientName(
  ConnectivityCheckRequest.preferredIPVersion,
  "preferredIpVersion",
  "java"
);

@@clientName(ApiManagementSkuCosts.meterID, "meterId", "java");
@@clientName(
  KeyVaultLastAccessStatusContractProperties.timeStampUtc,
  "timestampUtc",
  "java"
);
@@clientName(
  ApiManagementServiceBaseProperties.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(
  ApiManagementServiceBaseProperties.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(
  ApiManagementServiceBaseProperties.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(AdditionalLocation.publicIPAddresses, "publicIpAddresses", "java");
@@clientName(
  AdditionalLocation.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(
  AdditionalLocation.outboundPublicIPAddresses,
  "outboundPublicIpAddresses",
  "java"
);
@@clientName(HostnameConfiguration.hostName, "hostname", "java");

@@clientLocation(
  ApiManagementWorkspaceLinksResources.get,
  "ApiManagementWorkspaceLinkOperations",
  "java"
);
@@clientLocation(
  ApiManagementWorkspaceLinksResources.listByService,
  "ApiManagementWorkspaceLinks",
  "java"
);
@@clientLocation(
  ApiManagementServiceResources.performConnectivityCheckAsync,
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
  ...LocationParameter,
  serviceName: string,
):
  | Azure.ResourceManager.ArmResponse<DeletedServiceContract>
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
  ...LocationParameter,
  serviceName: string,
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
  ApiManagementServiceResources.performConnectivityCheckAsync,
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
  LLMDiagnosticSettings,
  "LargeLanguageModelDiagnosticSettings",
  "csharp"
);
@@clientName(
  LLMMessageDiagnosticSettings,
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
@@clientName(Verbosity, "TraceVerbosityLevel", "csharp");
@@clientName(Origin, "IssueOrigin", "csharp");
@@clientName(Severity, "IssueSeverity", "csharp");
@@clientName(NatGatewayState, "ApiManagementNatGatewayState", "csharp");
@@clientName(
  NameAvailabilityReason,
  "ApiManagementServiceNameUnavailableReason",
  "csharp"
);
@@clientName(GroupType, "ApiManagementGroupType", "csharp");
@@clientName(UserState, "ApiManagementUserState", "csharp");

// C#-specific: Backward-compat resource type renames to restore previously shipped Data/Resource/Collection type names.
// For modern `@armResourceOperations interface XxxContracts { get is ArmResourceRead<...>; ... }`, the new
// `resolveArmResources` path used by csharp-mgmt (when `use-legacy-resource-detection: false`) only reads
// ResourceName from LegacyOperations/legacy-decorator template parameters; it does NOT read
// `@@clientOption(..., "resource-name", ...)`. So per-resource renames are done by switching the CRUD ops
// to `XxxContractOps.Read<>` / `.CreateOrUpdateAsync<>` / etc. and adding `ResourceName = "Foo"` on the
// `XxxContractOps extends LegacyOperations<...>` alias. `@@clientName` below only renames the data model.
@@clientName(AccessInformationContract, "TenantAccessInfo", "csharp");
@@clientName(ApiContract, "Api", "csharp");
@@clientName(ApiReleaseContract, "ApiRelease", "csharp");
@@clientName(ApiVersionSetContract, "ApiVersionSet", "csharp");
@@clientName(
  AuthorizationServerContract,
  "ApiManagementAuthorizationServer",
  "csharp"
);
@@clientName(BackendContract, "ApiManagementBackend", "csharp");
@@clientName(CacheContract, "ApiManagementCache", "csharp");
@@clientName(CertificateContract, "ApiManagementCertificate", "csharp");
@@clientName(DeletedServiceContract, "ApiManagementDeletedService", "csharp");
// C#-specific: DiagnosticContract intentionally NOT renamed so the data class
// keeps its GA name `DiagnosticContractData`. The Resource/Collection still
// get `ApiManagementDiagnostic*` via ResourceName overrides in DiagnosticContract.tsp.
@@clientName(EmailTemplateContract, "ApiManagementEmailTemplate", "csharp");
@@clientName(
  GatewayCertificateAuthorityContract,
  "ApiManagementGatewayCertificateAuthority",
  "csharp"
);
@@clientName(GatewayContract, "ApiGateway", "csharp");
@@clientName(
  GatewayHostnameConfigurationContract,
  "ApiManagementGatewayHostnameConfiguration",
  "csharp"
);
@@clientName(GlobalSchemaContract, "ApiManagementGlobalSchema", "csharp");
@@clientName(GroupContract, "ApiManagementGroup", "csharp");
@@clientName(
  IdentityProviderContract,
  "ApiManagementIdentityProvider",
  "csharp"
);
@@clientName(IssueAttachmentContract, "ApiIssueAttachment", "csharp");
@@clientName(IssueCommentContract, "ApiIssueComment", "csharp");
// C#-specific: IssueContract intentionally NOT renamed so the data class
// keeps its GA name `IssueContractData`. The Resource/Collection still
// get `ApiManagementIssue*` via ResourceName overrides in IssueContract.tsp.
@@clientName(LoggerContract, "ApiManagementLogger", "csharp");
@@clientName(NamedValueContract, "ApiManagementNamedValue", "csharp");
@@clientName(NotificationContract, "ApiManagementNotification", "csharp");
@@clientName(
  OpenidConnectProviderContract,
  "ApiManagementOpenIdConnectProvider",
  "csharp"
);
@@clientName(OperationContract, "ApiOperation", "csharp");
// C#-specific: PolicyContract intentionally NOT renamed so the data class
// keeps its GA name `PolicyContractData`. The Resource/Collection still
// get `ApiManagementPolicy*` via ResourceName overrides in PolicyContract.tsp.
@@clientName(PortalRevisionContract, "ApiManagementPortalRevision", "csharp");
@@clientName(
  PortalDelegationSettings,
  "ApiManagementPortalDelegationSetting",
  "csharp"
);
@@clientName(
  PortalSigninSettings,
  "ApiManagementPortalSignInSetting",
  "csharp"
);
@@clientName(
  PortalSignupSettings,
  "ApiManagementPortalSignUpSetting",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PrivateLinkResource,
  "ApiManagementPrivateLinkResource",
  "csharp"
);
@@clientName(ProductContract, "ApiManagementProduct", "csharp");
@@clientName(SchemaContract, "ApiSchema", "csharp");
// C#-specific: SubscriptionContract intentionally NOT renamed so the data class
// keeps its GA name `SubscriptionContractData`. The Resource/Collection still
// get `ApiManagementSubscription*` via ResourceName overrides in SubscriptionContract.tsp.
@@clientName(TagDescriptionContract, "ApiTagDescription", "csharp");
@@clientName(TenantSettingsContract, "ApiManagementTenantSetting", "csharp");
// C#-specific: UserContract intentionally NOT renamed so the data class
// keeps its GA name `UserContractData`. The Resource/Collection still
// get `ApiManagementUser*` via ResourceName overrides in UserContract.tsp.
@@clientName(SchemaType, "ApiSchemaType", "csharp");

// C#-specific: Backward-compat enum/union renames for properties scoped under parent resources
@@clientName(SkuType, "ApiManagementServiceSkuType", "csharp");
@@clientName(ProductState, "ApiManagementProductState", "csharp");
@@clientName(Protocol, "ApiOperationInvokableProtocol", "csharp");
@@clientName(KeyType, "TokenGenerationUsedKeyType", "csharp");
@@clientName(AccessType, "StorageAccountAccessType", "csharp");

// C#-specific: Backward-compat list-result / request / response model renames to match previously shipped SDK conventions
@@clientName(ApiCollection, "ApiListResult", "csharp");
@@clientName(ApiReleaseCollection, "ApiReleaseListResult", "csharp");
@@clientName(ApiVersionSetCollection, "ApiVersionSetListResult", "csharp");
@@clientName(BackendCollection, "BackendListResult", "csharp");
@@clientName(CertificateCollection, "CertificateListResult", "csharp");
@@clientName(DiagnosticCollection, "DiagnosticListResult", "csharp");
@@clientName(GlobalSchemaCollection, "GlobalSchemaListResult", "csharp");
@@clientName(GroupCollection, "GroupListResult", "csharp");
@@clientName(IssueCollection, "IssueListResult", "csharp");
@@clientName(LoggerCollection, "LoggerListResult", "csharp");
@@clientName(NamedValueCollection, "NamedValueListResult", "csharp");
@@clientName(NotificationCollection, "NotificationListResult", "csharp");
@@clientName(PolicyCollection, "PolicyListResult", "csharp");
@@clientName(
  PolicyDescriptionCollection,
  "PolicyDescriptionListResult",
  "csharp"
);
@@clientName(PolicyFragmentCollection, "PolicyFragmentListResult", "csharp");
@@clientName(PortalSettingsCollection, "PortalSettingsListResult", "csharp");
@@clientName(ProductApiLinkCollection, "ProductApiLinkListResult", "csharp");
@@clientName(ProductCollection, "ProductListResult", "csharp");
@@clientName(
  ProductGroupLinkCollection,
  "ProductGroupLinkListResult",
  "csharp"
);
@@clientName(QuotaCounterCollection, "QuotaCounterListResult", "csharp");
@@clientName(RecipientEmailCollection, "RecipientEmailListResult", "csharp");
@@clientName(RecipientUserCollection, "RecipientUserListResult", "csharp");
@@clientName(ResourceCollection, "ResourceListResult", "csharp");
@@clientName(SubscriptionCollection, "SubscriptionListResult", "csharp");
@@clientName(TagApiLinkCollection, "TagApiLinkListResult", "csharp");
@@clientName(
  TagOperationLinkCollection,
  "TagOperationLinkListResult",
  "csharp"
);
@@clientName(TagProductLinkCollection, "TagProductLinkListResult", "csharp");

@@clientName(ApiCreateOrUpdateParameter, "ApiCreateOrUpdateContent", "csharp");
@@clientName(
  AccessInformationCreateParameters,
  "TenantAccessInfoCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  ApiManagementServiceApplyNetworkConfigurationParameters,
  "ApiManagementServiceApplyNetworkConfigurationContent",
  "csharp"
);
@@clientName(
  ApiManagementServiceBackupRestoreParameters,
  "ApiManagementServiceBackupRestoreContent",
  "csharp"
);
@@clientName(
  ApiManagementServiceCheckNameAvailabilityParameters,
  "ApiManagementServiceNameAvailabilityContent",
  "csharp"
);
@@clientName(ApiVersionSetUpdateParameters, "ApiVersionSetPatch", "csharp");
@@clientName(BackendUpdateParameters, "ApiManagementBackendPatch", "csharp");
@@clientName(
  CertificateCreateOrUpdateParameters,
  "ApiManagementCertificateCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  DeployConfigurationParameters,
  "ConfigurationDeployContent",
  "csharp"
);
@@clientName(
  GroupCreateParameters,
  "ApiManagementGroupCreateOrUpdateContent",
  "csharp"
);
@@clientName(GroupUpdateParameters, "ApiManagementGroupPatch", "csharp");
@@clientName(
  NamedValueUpdateParameters,
  "ApiManagementNamedValuePatch",
  "csharp"
);
@@clientName(
  ProductEntityBaseParameters,
  "ProductEntityBaseProperties",
  "csharp"
);
@@clientName(ProductUpdateParameters, "ApiManagementProductPatch", "csharp");
@@clientName(SaveConfigurationParameter, "ConfigurationSaveContent", "csharp");
@@clientName(
  SubscriptionCreateParameters,
  "ApiManagementSubscriptionCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  SubscriptionUpdateParameters,
  "ApiManagementSubscriptionPatch",
  "csharp"
);
@@clientName(
  TagCreateUpdateParameters,
  "ApiManagementTagCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  TagDescriptionCreateParameters,
  "ApiTagDescriptionCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  UserCreateParameters,
  "ApiManagementUserCreateOrUpdateContent",
  "csharp"
);
@@clientName(UserTokenParameters, "UserTokenContent", "csharp");
@@clientName(ConnectivityCheckRequest, "ConnectivityCheckContent", "csharp");
@@clientName(ConnectivityCheckResponse, "ConnectivityCheckResult", "csharp");
@@clientName(
  PrivateEndpointConnectionRequest,
  "PrivateEndpointConnectionContent",
  "csharp"
);

// C#-specific: Additional backward-compat renames to restore GA model names.
@@clientName(ApiUpdateContract, "ApiPatch", "csharp");
@@clientName(LoggerUpdateContract, "ApiManagementLoggerPatch", "csharp");
@@clientName(OperationUpdateContract, "ApiOperationPatch", "csharp");
@@clientName(IssueUpdateContract, "ApiIssuePatch", "csharp");
@@clientName(
  QuotaCounterValueUpdateContract,
  "QuotaCounterValueUpdateContent",
  "csharp"
);
// NOTE: GatewayKeyRegenerationRequestContract intentionally NOT renamed.
// Renaming it to GatewayKeyRegenerateContent causes the C# emitter to compute
// the per-property enum name as `GatewayRegenerateKeyType` (rearranged from
// the new model name), but the underlying KeyType union is already renamed
// to `TokenGenerationUsedKeyType` so no `GatewayRegenerateKeyType.cs` file
// is emitted — leading to CS0234.
@@clientName(GenerateSsoUrlResult, "GenerateSsoUriResult", "csharp");
@@clientName(
  AuthorizationConfirmConsentCodeRequestContract,
  "AuthorizationConfirmConsentCodeContent",
  "csharp"
);
@@clientName(
  AuthorizationLoginRequestContract,
  "AuthorizationLoginContent",
  "csharp"
);
@@clientName(
  AuthorizationLoginResponseContract,
  "AuthorizationLoginResult",
  "csharp"
);
@@clientName(AuthorizationType, "ApiManagementAuthorizationType", "csharp");
@@clientName(AuthorizationError, "ApiManagementAuthorizationError", "csharp");
@@clientName(
  IdentityProviderCreateContract,
  "ApiManagementIdentityProviderCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  NamedValueCreateContract,
  "ApiManagementNamedValueCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  PolicyDescriptionContract,
  "PolicyDescriptionContractData",
  "csharp"
);
@@clientName(PortalSettingsContract, "PortalSettingsContractData", "csharp");

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
// Restore GA Uri-typed read-only endpoint URL properties on
// ApiManagementServiceData / ApiManagementServicePatch (both back-resolved to
// ApiManagementServiceBaseProperties). New spec models these as `string`,
// causing C# property type to regress from `Uri` to `string`.
@@alternateType(ApiManagementServiceBaseProperties.gatewayUrl, url, "csharp");
@@alternateType(ApiManagementServiceBaseProperties.portalUrl, url, "csharp");
@@alternateType(
  ApiManagementServiceBaseProperties.managementApiUrl,
  url,
  "csharp"
);
@@alternateType(ApiManagementServiceBaseProperties.scmUrl, url, "csharp");
@@alternateType(
  ApiManagementServiceBaseProperties.developerPortalUrl,
  url,
  "csharp"
);
// Restore GA ResourceIdentifier type + uppercase-IP casing on
// ApiManagementServiceData/Patch.PublicIPAddressId.
@@alternateType(
  ApiManagementServiceBaseProperties.publicIpAddressId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  ApiManagementServiceBaseProperties.publicIpAddressId,
  "PublicIPAddressId",
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

// D3 fixes from MPG API diff: restore GA property types
// (string -> ResourceIdentifier / Uri / Guid) without changing names.
@@alternateType(
  IssueCommentContractProperties.userId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(BackendContractProperties.url, url, "csharp");
@@alternateType(
  DeletedServiceContractProperties.serviceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LoggerContractProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApiReleaseContractProperties.apiId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TagDescriptionBaseProperties.externalDocsUrl,
  url,
  "csharp"
);
@@alternateType(
  AuthorizationAccessPolicyContractProperties.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  IssueContractProperties.userId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IssueContractBaseProperties.apiId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
// NOTE: @@alternateType(IssueUpdateContractProperties.userId, armResourceIdentifier)
// intentionally removed; GA 1.3.0 shipped ApiIssuePatch.UserId as `string` (not
// ResourceIdentifier). Keep the spec `string` type to avoid a property-type regression.
@@alternateType(
  AllPoliciesContractProperties.referencePolicyId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(BackendUpdateParameterProperties.url, url, "csharp");
@@alternateType(ApiContractUpdateProperties.serviceUrl, url, "csharp");
@@alternateType(PortalSettingsContractProperties.url, url, "csharp");
@@alternateType(
  ArmIdWrapper.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AdditionalLocation.publicIpAddressId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualNetworkConfiguration.vnetid, Azure.Core.uuid, "csharp");

// D3 case fixes: GA used Azure casing PublicIPAddressId / VnetId.
@@clientName(
  AdditionalLocation.publicIpAddressId,
  "PublicIPAddressId",
  "csharp"
);
@@clientName(VirtualNetworkConfiguration.vnetid, "VnetId", "csharp");

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
@@clientName(ApiManagementServiceResources, "ApiManagementService", "csharp");
@@clientName(ApiManagementGatewayResources, "ApiManagementGateway", "csharp");
@@clientName(
  ApiManagementGatewayConfigConnectionResources,
  "ApiGatewayConfigConnection",
  "csharp"
);
@@clientName(
  ApiManagementWorkspaceLinksResources,
  "ApiManagementWorkspaceLinks",
  "csharp"
);

// Policy / settings / portal: rename interfaces that emit oddly-named wrappers.
@@clientName(ProductPolicy, "ApiManagementProductPolicy", "csharp");
@@clientName(
  DelegationSettings,
  "ApiManagementPortalDelegationSetting",
  "csharp"
);
@@clientName(SignInSettings, "ApiManagementPortalSignInSetting", "csharp");
@@clientName(SignUpSettings, "ApiManagementPortalSignUpSetting", "csharp");
@@clientName(ContentItemContracts, "ApiManagementContentItem", "csharp");
@@clientName(ContentTypeContracts, "ApiManagementContentType", "csharp");

// Tag-on-Api / Tag-on-Product wrappers (renamed for parity with previously shipped names).
@@clientName(TagContractOperation, "ApiOperationTag", "csharp");
@@clientName(TagContractOperationGroup, "ApiManagementProductTag", "csharp");

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
// Restore public ctors for output-only Data/model classes that GA 1.3.0 shipped
// with constructors (D7 fixes from MPG API diff).
@@usage(DeletedServiceContract, Usage.input, "csharp");
@@usage(NotificationContract, Usage.input, "csharp");
@@usage(Microsoft.ApiManagement.PrivateEndpointConnection, Usage.input, "csharp");
@@usage(Microsoft.ApiManagement.PrivateLinkResource, Usage.input, "csharp");
@@usage(TenantSettingsContract, Usage.input, "csharp");
@@usage(AllPoliciesContract, Usage.input, "csharp");
@@usage(ErrorFieldContract, Usage.input, "csharp");
@@usage(ErrorResponseBody, Usage.input, "csharp");
@@usage(OperationResultContract, Usage.input, "csharp");
@@usage(PolicyDescriptionContract, Usage.input, "csharp");
@@usage(PortalSettingsContract, Usage.input, "csharp");
@@usage(RecipientEmailContract, Usage.input, "csharp");
@@usage(RecipientsContractProperties, Usage.input, "csharp");
@@usage(RecipientUserContract, Usage.input, "csharp");
@@usage(ResourceCollectionValueItem, Usage.input, "csharp");
@@usage(TenantConfigurationSyncStateContract, Usage.input, "csharp");

// Model renames identified from GA contract diff.
@@clientName(TagResourceContract, "TagResourceContractDetails", "csharp");
@@clientName(
  TagTagResourceContractProperties,
  "AssociatedTagProperties",
  "csharp"
);
@@clientName(
  ApiTagResourceContractProperties,
  "AssociatedApiProperties",
  "csharp"
);
@@clientName(
  OperationTagResourceContractProperties,
  "AssociatedOperationProperties",
  "csharp"
);
@@clientName(
  ProductTagResourceContractProperties,
  "AssociatedProductProperties",
  "csharp"
);
@@clientName(
  AccessInformationSecretsContract,
  "TenantAccessInfoSecretsDetails",
  "csharp"
);
@@clientName(
  OperationResultContract,
  "GitOperationResultContractData",
  "csharp"
);
@@clientName(State, "IssueState", "csharp");
@@clientName(Method, "HttpMethodConfiguration", "csharp");
// NOTE: HttpHeader rename intentionally omitted - the C# emitter emits the
// type as `HTTPHeader` (uppercase) by default; setting @@clientName here to
// the GA name `HttpHeaderConfiguration` causes the type definition file to
// not be emitted at all, leading to CS0234.
@@clientName(
  NetworkStatusContractByLocation,
  "NetworkStatusContractWithLocation",
  "csharp"
);
@@clientName(PolicyIdName, "PolicyName", "csharp");
@@clientName(SettingsTypeName, "SettingsType", "csharp");
@@clientName(AccessIdName, "AccessName", "csharp");
@@clientName(ConfigurationIdName, "ConfigurationName", "csharp");
@@clientName(Confirmation, "ConfirmationEmailType", "csharp");
// NOTE: ConnectivityCheckRequestProtocolConfigurationHttpConfiguration rename
// intentionally omitted - renaming the parent makes the emitter compute a
// context-derived name `HttpHeaderConfiguration` for the nested `headers:
// HttpHeader[]` element. The HttpHeader type is then emitted as `HTTPHeader.cs`
// while references use `HttpHeaderConfiguration`, causing CS0234.
@@clientName(ResourceSkuCapacity, "ApiManagementResourceSkuCapacity", "csharp");
@@clientName(
  ResourceSkuCapacityScaleType,
  "ApiManagementResourceSkuCapacityScaleType",
  "csharp"
);
@@clientName(
  ResourceSkuResult,
  "AvailableApiManagementServiceSkuResult",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionRequest,
  "ApiManagementPrivateEndpointConnectionCreateOrUpdateContent",
  "csharp"
);
// AssociationContractPropertiesProvisioningState rename intentionally omitted -
// the type is emitted from an inline anonymous enum on the `provisioningState`
// property, so it cannot be targeted by @@clientName.

// Back-compat property renames for GA 1.3.0 - new spec field names differ from
// the names shipped in the last GA. Re-map each new field to its GA C# name.
@@clientName(
  ApiEntityBaseContract.subscriptionRequired,
  "isSubscriptionRequired",
  "csharp"
);
@@clientName(
  ApiEntityBaseContract.termsOfServiceUrl,
  "termsOfServiceLink",
  "csharp"
);
@@clientName(ApiContractProperties.serviceUrl, "serviceLink", "csharp");
@@clientName(ApiContractUpdateProperties.serviceUrl, "serviceLink", "csharp");
@@alternateType(
  ApiContractProperties.sourceApiId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Back-compat property renames for GA 1.3.0 (continued).
// New spec field names differ from GA-shipped C# names; rename each back.
@@clientName(AuthorizationServerContractBaseProperties.clientAuthenticationMethod, "clientAuthenticationMethods", "csharp");
@@clientName(AuthorizationServerContractBaseProperties.supportState, "doesSupportState", "csharp");
@@clientName(BackendBaseParameters.type, "typePropertiesType", "csharp");
@@clientName(CertificateContractProperties.keyVault, "keyVaultDetails", "csharp");
@@clientName(CertificateCreateOrUpdateProperties.keyVault, "keyVaultDetails", "csharp");
@@clientName(GatewayHostnameConfigurationContractProperties.negotiateClientCertificate, "isClientCertificateRequired", "csharp");
@@clientName(GroupContractProperties.type, "groupType", "csharp");
@@clientName(GroupContractProperties.builtIn, "isBuiltIn", "csharp");
@@clientName(GroupCreateParametersProperties.type, "apiManagementGroupType", "csharp");
@@clientName(GroupUpdateParametersProperties.type, "apiManagementGroupType", "csharp");
@@clientName(IdentityProviderContractProperties.type, "identityProviderType", "csharp");
@@clientName(IdentityProviderCreateContractProperties.type, "identityProviderType", "csharp");
@@clientName(IdentityProviderUpdateProperties.type, "identityProviderType", "csharp");
@@clientName(IdentityProviderBaseParameters.signinPolicyName, "signInPolicyName", "csharp");
@@clientName(IdentityProviderBaseParameters.signinTenant, "signInTenant", "csharp");
@@clientName(IdentityProviderBaseParameters.signupPolicyName, "signUpPolicyName", "csharp");
@@clientName(NamedValueEntityBaseParameters.secret, "isSecret", "csharp");
@@clientName(NamedValueContractProperties.keyVault, "keyVaultDetails", "csharp");
@@clientName(PortalSigninSettingProperties.enabled, "isRedirectEnabled", "csharp");
@@clientName(PortalSignupSettingsProperties.enabled, "isSignUpDeveloperPortalEnabled", "csharp");
@@clientName(PrivateEndpointConnectionWrapperProperties.privateLinkServiceConnectionState, "connectionState", "csharp");
@@clientName(ProductEntityBaseParameters.approvalRequired, "isApprovalRequired", "csharp");
@@clientName(ProductEntityBaseParameters.subscriptionRequired, "isSubscriptionRequired", "csharp");
@@clientName(OperationTagResourceContractProperties.urlTemplate, "uriTemplate", "csharp");
@@clientName(OperationUpdateContractProperties.urlTemplate, "uriTemplate", "csharp");
@@clientName(OperationContractProperties.urlTemplate, "uriTemplate", "csharp");
@@clientName(DiagnosticContractProperties.logClientIp, "isLogClientIPEnabled", "csharp");
@@clientName(DiagnosticContractUpdateProperties.logClientIp, "isLogClientIPEnabled", "csharp");
@@clientName(ApiManagementServiceNameAvailabilityResult.nameAvailable, "isNameAvailable", "csharp");
@@clientName(ApiManagementSkuCosts.meterID, "meterId", "csharp");
@@clientName(ApiManagementSkuRestrictions.type, "restrictionsType", "csharp");
@@clientName(AuthenticationSettingsContract.openid, "openId", "csharp");
@@clientName(BackendTlsProperties.validateCertificateChain, "shouldValidateCertificateChain", "csharp");
@@clientName(BackendTlsProperties.validateCertificateName, "shouldValidateCertificateName", "csharp");
@@clientName(CertificateInformation.expiry, "expireOn", "csharp");
@@clientName(DeployConfigurationParameterProperties.force, "forceDelete", "csharp");
@@clientName(SaveConfigurationParameterProperties.force, "forceUpdate", "csharp");
@@clientName(ConnectivityHop.type, "connectivityHopType", "csharp");
@@clientName(ConnectivityIssue.type, "issueType", "csharp");
@@clientName(ConnectivityStatusContract.lastStatusChange, "lastStatusChangedOn", "csharp");
@@clientName(ConnectivityStatusContract.lastUpdated, "lastUpdatedOn", "csharp");
@@clientName(OperationResultContractProperties.started, "startedOn", "csharp");
@@clientName(OperationResultContractProperties.updated, "updatedOn", "csharp");
@@clientName(HostnameConfiguration.type, "hostnameType", "csharp");
@@clientName(OpenIdAuthenticationSettingsContract.openidProviderId, "openIdProviderId", "csharp");
@@clientName(ParameterContract.required, "isRequired", "csharp");
@@clientName(ParameterContract.type, "parameterContractType", "csharp");
@@clientName(RequestReportRecordContract.ipAddress, "iPAddress", "csharp");
@@clientName(AccessInformationContractProperties.enabled, "isDirectAccessEnabled", "csharp");
@@clientName(AccessInformationCreateParameterProperties.enabled, "isDirectAccessEnabled", "csharp");
@@clientName(AccessInformationUpdateParameterProperties.enabled, "isDirectAccessEnabled", "csharp");
@@clientName(AccessInformationSecretsContract.enabled, "isDirectAccessEnabled", "csharp");
@@clientName(TenantConfigurationSyncStateContractProperties.isExport, "isExported", "csharp");
@@clientName(TermsOfServiceProperties.consentRequired, "isConsentRequired", "csharp");
@@clientName(TermsOfServiceProperties.enabled, "isDisplayEnabled", "csharp");
@@clientName(UserTokenParameterProperties.expiry, "expireOn", "csharp");
@@clientName(SubscriptionContractProperties.notificationDate, "notifiesOn", "csharp");
@@clientName(UserContractProperties.registrationDate, "registriesOn", "csharp");

// Deep flattened wire paths (properties.subscriptions.enabled / properties.userRegistration.enabled
// on ApiManagementPortalDelegationSettingData).
@@clientName(SubscriptionsDelegationSettingsProperties.enabled, "isSubscriptionDelegationEnabled", "csharp");
@@clientName(RegistrationDelegationSettingsProperties.enabled, "isUserRegistrationDelegationEnabled", "csharp");

// Restore System.Uri (TypeSpec `url` scalar) for ApiManagementPortalDelegationSettingData.Uri,
// which GA 1.3.0 shipped as System.Uri but spec now declares as `string`.
@@alternateType(PortalDelegationSettingsProperties.url, url, "csharp");

// GA 1.3.0 shipped this model under the shorter `ConnectivityCheckRequestHttpConfiguration`
// name, but renaming `ConnectivityCheckRequestProtocolConfigurationHttpConfiguration` causes
// the emitter to compute a context-derived `HttpHeaderConfiguration` name for the nested
// `headers: HttpHeader[]` element while emitting the `HttpHeader` type itself with the wrong
// file name, breaking the build (see notes at lines ~1232 and ~1246). Tracked as a remaining
// GA back-compat gap to be addressed via a custom partial or generator fix.

// D2: Restore ApiGatewayData base class from TrackedResourceData to
// ResourceData (GA 1.3.0 shipped this as a proxy resource).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ApiManagementGatewayResource,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// D1: Restore GA names for "Patch" / "Update" DTOs that lost their friendly
// names when the TSP model gained a "Resource" suffix.
@@clientName(
  ApiManagementGatewayUpdateParameters,
  "ApiGatewayPatch",
  "csharp"
);
@@clientName(
  ApiManagementServiceUpdateParameters,
  "ApiManagementServicePatch",
  "csharp"
);
@@clientName(UserUpdateParameters, "ApiManagementUserPatch", "csharp");

// D1: Restore GA names for resources whose TSP model name has a "Resource"
// suffix (so Data/Collection no longer carry the extra "Resource" prefix).
// NOTE: empirical — @@clientName on the resource model may or may not be
// honored for derived Resource/Collection/Data class names depending on the
// generator version. If a regen shows these unchanged, the fix moves to a
// LegacyOperations / ResourceName template-arg refactor on each resource .tsp.
@@clientName(
  ApiManagementGatewayResource,
  "ApiManagementGateway",
  "csharp"
);
@@clientName(ApiManagementServiceResource, "ApiManagementService", "csharp");
@@clientName(
  ApiManagementWorkspaceLinksResource,
  "ApiManagementWorkspaceLinks",
  "csharp"
);
@@clientName(
  ApiManagementGatewayConfigConnectionResource,
  "ApiGatewayConfigConnection",
  "csharp"
);

// Map TypeSpec `If-Match` header (declared as string in spec for casing-style reasons)
// to .NET ETag for back-compat with GA Azure.ResourceManager.ApiManagement.
@@alternateType(IfMatchHeaderParameter.`If-Match`, Azure.Core.eTag, "csharp");

// D2 (Phase 3): Restore GA 1.3.0 base class for ApiManagementGatewayUpdateParameters
// and ApiManagementServiceUpdateParameters Patch DTOs. Spec models extend the custom
// `ApimResource` (id/name/type) base, but GA shipped both Patch types as ResourceData
// derivatives. Forcing the C# emit base to Foundations.ProxyResource produces
// `: ResourceData` in the generated class, matching the GA API surface.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ApiManagementGatewayUpdateParameters,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ApiManagementServiceUpdateParameters,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// Phase 3 #11: Flatten SchemaContractProperties.document so that the inner
// `value/components/definitions` properties surface directly on ApiSchemaData
// with WirePath `properties.<name>` matching GA 1.3.0 (was previously emitted
// at `properties.document.<name>` after the outer SchemaContract.properties
// flatten in back-compatible.tsp).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  SchemaContractProperties.document,
  "csharp"
);

// Phase 3 #2: Enum value case-normalization to match GA 1.3.0 C# constant names.
// Spec uses lowercase / SCREAMING_SNAKE / mixed forms; GA used PascalCase.
@@clientName(ApiType.websocket, "WebSocket", "csharp");
@@clientName(ApiType.graphql, "GraphQL", "csharp");
@@clientName(ApiType.odata, "OData", "csharp");
@@clientName(ApiType.grpc, "GRPC", "csharp");
@@clientName(Confirmation.signup, "SignUp", "csharp");
@@clientName(ConnectivityCheckProtocol.TCP, "Tcp", "csharp");
@@clientName(ConnectivityCheckProtocol.HTTP, "Http", "csharp");
@@clientName(ConnectivityCheckProtocol.HTTPS, "Https", "csharp");
@@clientName(ContentFormat.openapi, "OpenApi", "csharp");
@@clientName(ContentFormat.`openapi+json`, "OpenApiJson", "csharp");
@@clientName(ContentFormat.`openapi-link`, "OpenApiLink", "csharp");
@@clientName(ContentFormat.`openapi+json-link`, "OpenApiJsonLink", "csharp");
@@clientName(ContentFormat.`graphql-link`, "GraphQLLink", "csharp");
@@clientName(Method.GET, "Get", "csharp");
@@clientName(Method.POST, "Post", "csharp");
@@clientName(MigrateToStv2Mode.PreserveIp, "PreserveIP", "csharp");
@@clientName(NotificationName.BCC, "Bcc", "csharp");
@@clientName(OperationNameFormat.Url, "Uri", "csharp");
@@clientName(PolicyContentFormat.rawxml, "RawXml", "csharp");
@@clientName(PolicyContentFormat.`rawxml-link`, "RawXmlLink", "csharp");
@@clientName(SoapApiType.gRPC, "Grpc", "csharp");

// Phase 3 #4: Restore GA 1.3.0 `*Uri` (System.Uri) properties for fields the spec
// now declares as plain `string`. Each pair = `@@clientName` to flip the C# emit
// name to the GA `*Uri` form, plus `@@alternateType(..., url, "csharp")` to flip
// the C# type from `string` to `System.Uri`.
// NOTE: cases where GA shipped BOTH `*Link (string)` AND `*Uri (Uri)` as parallel
// shim properties (ServiceLink/ServiceUri, TermsOfServiceLink/TermsOfServiceUri)
// cannot be restored spec-side — they need Custom partial shim properties because
// a single spec field maps to only one emitted C# property.
@@clientName(BackendBaseParameters.resourceId, "resourceUri", "csharp");
@@alternateType(BackendBaseParameters.resourceId, url, "csharp");
@@clientName(CacheContractProperties.resourceId, "resourceUri", "csharp");
@@alternateType(CacheContractProperties.resourceId, url, "csharp");
@@clientName(CacheUpdateProperties.resourceId, "resourceUri", "csharp");
@@alternateType(CacheUpdateProperties.resourceId, url, "csharp");
@@clientName(HostnameConfiguration.keyVaultId, "keyVaultSecretUri", "csharp");
@@alternateType(HostnameConfiguration.keyVaultId, url, "csharp");
