import "./main.tsp";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;
using Http;
using Azure.ResourceManager;

/**
 * C# compatibility replacement that preserves the previous `ResourceData` base type for the API
 * gateway patch model. The original TypeSpec model extends `ApimResource`; this replacement
 * extends the ARM common `Resource` envelope and copies the original non-envelope properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "C# compatibility model intentionally uses the CSharp prefix to mirror the previous SDK type name."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Preserve previous C# ResourceData base type during MPG migration"
model CSharpApiGatewayPatch extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<
    ApiManagementGatewayUpdateParameters,
    "id" | "name" | "type"
  >;
}

/**
 * C# compatibility replacement that preserves the previous `ResourceData` base type for the API
 * Management service patch model. It extends the ARM common `Resource` envelope and copies the
 * original non-envelope properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "C# compatibility model intentionally uses the CSharp prefix to mirror the previous SDK type name."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Preserve previous C# ResourceData base type during MPG migration"
model CSharpApiManagementServicePatch
  extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<
    ApiManagementServiceUpdateParameters,
    "id" | "name" | "type"
  >;
}

/**
 * C# compatibility enum surfaced by the previous AutoRest SDK for association provisioning state.
 * Kept in client.tsp and applied with `@@alternateType` so the OpenAPI output remains unchanged.
 */
union AssociationEntityProvisioningState {
  string,

  /**
   * Created.
   */
  Created: "created",
}

// Java-specific compatibility customizations generated per TypeSpec migration guidance.
@@clientName(
  Microsoft.ApiManagement.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(
  Microsoft.ApiManagement.TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "java,python,javascript"
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
  "python,go,csharp"
);

@@alternateType(
  ApiManagementGatewayUpdateParameters,
  CSharpApiGatewayPatch,
  "csharp"
);
@@clientName(
  ApiManagementGatewayUpdateParameters,
  "ApiGatewayPatchGenerated",
  "csharp"
);
@@clientName(CSharpApiGatewayPatch, "ApiGatewayPatch", "csharp");
@@alternateType(
  ApiManagementServiceUpdateParameters,
  CSharpApiManagementServicePatch,
  "csharp"
);
@@clientName(
  ApiManagementServiceUpdateParameters,
  "ApiManagementServicePatchGenerated",
  "csharp"
);
@@clientName(
  CSharpApiManagementServicePatch,
  "ApiManagementServicePatch",
  "csharp"
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

  @path
  serviceName: string,

  @path
  location: Azure.Core.azureLocation,
):
  | Azure.ResourceManager.ArmResponse<Microsoft.ApiManagement.DeletedServiceContract>
  | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(
  DeletedServiceContracts.getByName,
  replaceGetByName,
  "go,java,python,javascript"
);

/**
 * override for DeletedServiceContracts.purge
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "matches the original DeletedServiceContracts.purge operation"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "matches the original DeletedServiceContracts.purge operation"
op replacePurge(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @path
  serviceName: string,

  @path
  location: Azure.Core.azureLocation,
):
  | ArmDeletedResponse
  | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: DeletedServiceContract;
    })
  | ArmDeletedNoContentResponse;

@@override(
  DeletedServiceContracts.purge,
  replacePurge,
  "go,java,python,javascript"
);

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

@@clientName(
  GatewayHostnameConfigurationContractProperties.negotiateClientCertificate,
  "IsClientCertificateRequired",
  "csharp"
);
@@clientName(
  ApiManagementServiceBaseProperties.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  GatewayHostnameBindingResource,
  "GatewayHostnameBinding",
  "csharp"
);
@@alternateType(GatewayHostnameBindingResource.eTag, Azure.Core.eTag, "csharp");
@@clientName(
  BackendTlsProperties.validateCertificateChain,
  "ShouldValidateCertificateChain",
  "csharp"
);
@@clientName(
  BackendTlsProperties.validateCertificateName,
  "ShouldValidateCertificateName",
  "csharp"
);
@@clientName(
  HostnameConfiguration.defaultSslBinding,
  "IsDefaultSslBindingEnabled",
  "csharp"
);
@@clientName(
  HostnameConfiguration.negotiateClientCertificate,
  "IsClientCertificateNegotiationEnabled",
  "csharp"
);
@@clientName(
  PortalSettingsContractProperties.enabled,
  "IsRedirectEnabled",
  "csharp"
);
@@clientName(
  PortalSigninSettingProperties.enabled,
  "IsRedirectEnabled",
  "csharp"
);
@@clientName(TermsOfServiceProperties.enabled, "IsDisplayEnabled", "csharp");
@@clientName(
  TermsOfServiceProperties.consentRequired,
  "IsConsentRequired",
  "csharp"
);
@@clientName(
  TenantConfigurationSyncStateContractProperties.isExport,
  "IsExported",
  "csharp"
);
@@clientName(
  AccessInformationSecretsContract.enabled,
  "IsDirectAccessEnabled",
  "csharp"
);
@@clientName(
  PortalSignupSettingsProperties.enabled,
  "IsSignUpDeveloperPortalEnabled",
  "csharp"
);
@@clientName(
  AccessInformationContractProperties.enabled,
  "IsDirectAccessEnabled",
  "csharp"
);
@@clientName(
  RequestReportRecordContract.subscriptionId,
  "SubscriptionResourceId",
  "csharp"
);
@@alternateType(
  RequestReportRecordContract.subscriptionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  ReportRecordContract.subscriptionId,
  "SubscriptionResourceId",
  "csharp"
);
@@alternateType(
  ReportRecordContract.subscriptionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  SubscriptionsDelegationSettingsProperties,
  "SubscriptionDelegationSettingProperties",
  "csharp"
);
@@clientName(
  RegistrationDelegationSettingsProperties,
  "RegistrationDelegationSettingProperties",
  "csharp"
);
@@clientName(
  OpenidConnectProviderContract,
  "ApiManagementOpenIdConnectProvider",
  "csharp"
);
@@clientName(
  OpenidConnectProviderUpdateContract,
  "ApiManagementOpenIdConnectProviderPatch",
  "csharp"
);
@@clientName(OpenidConnectProviderContract.name, "openId", "csharp");
@@clientName(VirtualNetworkConfiguration.vnetid, "VnetId", "csharp");
@@clientName(AccessInformationContract, "TenantAccessInfo", "csharp");
@@clientName(
  AccessInformationContractProperties.id,
  "AccessInfoType",
  "csharp"
);
@@clientName(AccessIdName, "AccessName", "csharp");
@@clientName(AccessIdName.access, "TenantAccess", "csharp");
@@clientName(AccessIdName.gitAccess, "TenantGitAccess", "csharp");
@@clientName(ApiContract, "Api", "csharp");
@@clientName(
  NetworkStatusContractByLocation,
  "NetworkStatusContractWithLocation",
  "csharp"
);
@@clientName(ApiManagementServiceResource, "ApiManagementService", "csharp");
@@clientName(ApiReleaseContract, "ApiRelease", "csharp");
@@clientName(BackendUpdateParameters, "ApiManagementBackendPatch", "csharp");
@@clientName(
  CertificateCreateOrUpdateParameters,
  "ApiManagementCertificateCreateOrUpdateContent",
  "csharp"
);
@@clientName(LoggerUpdateContract, "ApiManagementLoggerPatch", "csharp");
@@clientName(OperationContract, "ApiOperation", "csharp");
@@clientName(SchemaContract, "ApiSchema", "csharp");
@@clientName(TagDescriptionContract, "ApiTagDescription", "csharp");
@@clientName(
  ApiManagementServiceBackupRestoreParameters,
  "ApiManagementServiceBackupRestoreContent",
  "csharp"
);
@@clientName(
  OperationResultContract,
  "GitOperationResultContractData",
  "csharp"
);
@@clientName(ConfigurationIdName, "ConfigurationName", "csharp");
@@clientName(SaveConfigurationParameter, "ConfigurationSaveContent", "csharp");
@@clientName(
  SaveConfigurationParameterProperties.force,
  "ForceUpdate",
  "csharp"
);
@@clientName(
  DeployConfigurationParameters,
  "ConfigurationDeployContent",
  "csharp"
);
@@clientName(ApiVersionSetContract, "ApiVersionSet", "csharp");
@@clientName(
  AuthorizationServerContract,
  "ApiManagementAuthorizationServer",
  "csharp"
);
@@clientName(BackendContract, "ApiManagementBackend", "csharp");
@@clientName(BackendBaseParameters.resourceId, "resourceUri", "csharp");
@@alternateType(BackendBaseParameters.resourceId, url, "csharp");
@@clientName(BackendBaseParameters.type, "typePropertiesType", "csharp");
@@alternateType(BackendContractProperties.url, url, "csharp");
@@alternateType(BackendUpdateParameterProperties.url, url, "csharp");
@@clientName(CacheContract, "ApiManagementCache", "csharp");
@@clientName(CertificateContract, "ApiManagementCertificate", "csharp");
@@clientName(
  CertificateContractProperties.expirationDate,
  "ExpireOn",
  "csharp"
);
@@clientName(
  CertificateContractProperties.keyVault,
  "KeyVaultDetails",
  "csharp"
);
@@clientName(
  CertificateCreateOrUpdateProperties.keyVault,
  "KeyVaultDetails",
  "csharp"
);
@@clientName(ContentTypeContract, "ApiManagementContentType", "csharp");
@@clientName(
  ContentTypeContractProperties.id,
  "ContentTypeIdentifier",
  "csharp"
);
@@clientName(ContentTypeContractProperties.name, "ContentTypeName", "csharp");
@@clientName(EmailTemplateContract, "ApiManagementEmailTemplate", "csharp");
@@clientName(GatewayContract, "ApiManagementGateway", "csharp");
@@clientName(GlobalSchemaContract, "ApiManagementGlobalSchema", "csharp");
@@clientName(GroupContract, "ApiManagementGroup", "csharp");
@@clientName(GroupContractProperties.type, "ApiManagementGroupType", "csharp");
@@clientName(GroupContractProperties.builtIn, "IsBuiltIn", "csharp");
@@clientName(
  IdentityProviderContract,
  "ApiManagementIdentityProvider",
  "csharp"
);
@@clientName(LoggerContract, "ApiManagementLogger", "csharp");
@@clientName(NamedValueContract, "ApiManagementNamedValue", "csharp");
@@clientName(
  NamedValueContractProperties.keyVault,
  "KeyVaultDetails",
  "csharp"
);
@@clientName(NotificationContract, "ApiManagementNotification", "csharp");
@@clientName(
  PolicyDescriptionContract,
  "PolicyDescriptionContractData",
  "csharp"
);
@@clientName(
  PortalDelegationSettings,
  "ApiManagementPortalDelegationSetting",
  "csharp"
);
@@clientName(PortalRevisionContract, "ApiManagementPortalRevision", "csharp");
@@clientName(PortalSettingsContract, "PortalSettingsContractData", "csharp");
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
@@clientName(ProductContract, "ApiManagementProduct", "csharp");
@@clientName(TenantSettingsContract, "ApiManagementTenantSetting", "csharp");
@@clientName(ConnectivityCheckResponse, "ConnectivityCheckResult", "csharp");
@@clientName(
  QuotaCounterValueUpdateContract,
  "QuotaCounterValueUpdateContent",
  "csharp"
);
@@clientName(ContentItemContract, "ApiManagementContentItem", "csharp");
@@clientName(DeletedServiceContract, "ApiManagementDeletedService", "csharp");
@@clientName(
  DeletedServiceContractProperties.deletionDate,
  "DeletedOn",
  "csharp"
);
@@clientName(
  EmailTemplateUpdateParameters,
  "ApiManagementEmailTemplateCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  GatewayCertificateAuthorityContract,
  "ApiManagementGatewayCertificateAuthority",
  "csharp"
);
@@clientName(
  GatewayHostnameConfigurationContract,
  "ApiManagementGatewayHostnameConfiguration",
  "csharp"
);
@@clientName(IssueAttachmentContract, "ApiIssueAttachment", "csharp");
@@clientName(IssueCommentContract, "ApiIssueComment", "csharp");
@@clientName(ProductState, "ApiManagementProductState", "csharp");
@@clientName(UserState, "ApiManagementUserState", "csharp");
@@clientName(
  TagCreateUpdateParameters,
  "ApiManagementTagCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  SubscriptionContractProperties.expirationDate,
  "ExpireOn",
  "csharp"
);
@@clientName(
  SubscriptionContractProperties.notificationDate,
  "NotifiesOn",
  "csharp"
);
@@clientName(UserContractProperties.registrationDate, "RegistriesOn", "csharp");
@@clientName(
  AccessInformationSecretsContract,
  "TenantAccessInfoSecretsDetails",
  "csharp"
);
@@clientName(AccessInformationSecretsContract.id, "AccessInfoType", "csharp");
@@clientName(
  ApiManagementServiceCheckNameAvailabilityParameters,
  "ApiManagementServiceNameAvailabilityContent",
  "csharp"
);
@@clientName(
  ApiManagementServiceNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  NameAvailabilityReason,
  "ApiManagementServiceNameUnavailableReason",
  "csharp"
);
@@clientName(ApiType.websocket, "WebSocket", "csharp");
@@clientName(ApiType.graphql, "GraphQL", "csharp");
@@clientName(AuthenticationSettingsContract.openid, "OpenId", "csharp");
@@clientName(CertificateInformation.expiry, "ExpireOn", "csharp");
@@clientName(Confirmation, "ConfirmationEmailType", "csharp");
@@clientName(Confirmation.signup, "SignUp", "csharp");
@@clientName(ConnectivityCheckProtocol.TCP, "Tcp", "csharp");
@@clientName(ConnectivityStatusContract.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(
  ConnectivityStatusContract.lastStatusChange,
  "lastStatusChangedOn",
  "csharp"
);
@@clientName(ContentFormat.openapi, "OpenApi", "csharp");
@@clientName(
  ConnectivityCheckRequestProtocolConfigurationHttpConfiguration,
  "ConnectivityCheckRequestHttpConfiguration",
  "csharp"
);
@@clientName(Method, "HttpMethodConfiguration", "csharp");
@@clientName(Method.GET, "Get", "csharp");
@@clientName(HttpHeader, "HttpHeaderConfiguration", "csharp");
@@usage(HttpHeader, Usage.input | Usage.output);
@@clientName(NotificationName.BCC, "Bcc", "csharp");
@@clientName(
  OpenIdAuthenticationSettingsContract.openidProviderId,
  "OpenIdProviderId",
  "csharp"
);
@@clientName(
  OperationResultContractProperties.id,
  "OperationResultIdentifier",
  "csharp"
);
@@clientName(OperationResultContractProperties.started, "StartedOn", "csharp");
@@clientName(OperationResultContractProperties.updated, "UpdatedOn", "csharp");
@@clientName(OperationNameFormat.Url, "Uri", "csharp");
@@clientName(PolicyContentFormat.rawxml, "RawXml", "csharp");
@@clientName(PolicyIdName, "PolicyName", "csharp");
@@clientName(
  ProductEntityBaseParameters,
  "ProductEntityBaseProperties",
  "csharp"
);
@@clientName(SettingsTypeName, "SettingsType", "csharp");
@@clientName(TagResourceContract, "TagResourceContractDetails", "csharp");
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
  OperationTagResourceContractProperties.urlTemplate,
  "UriTemplate",
  "csharp"
);
@@usage(OperationTagResourceContractProperties, Usage.input | Usage.output);
@@clientName(
  ProductTagResourceContractProperties,
  "AssociatedProductProperties",
  "csharp"
);
@@clientName(AuthorizationMethod.HEAD, "Head", "csharp");
@@clientName(AuthorizationMethod.OPTIONS, "Options", "csharp");
@@clientName(AuthorizationMethod.TRACE, "Trace", "csharp");
@@clientName(AuthorizationMethod.GET, "Get", "csharp");
@@clientName(AuthorizationMethod.POST, "Post", "csharp");
@@clientName(AuthorizationMethod.PUT, "Put", "csharp");
@@clientName(AuthorizationMethod.PATCH, "Patch", "csharp");
@@clientName(AuthorizationMethod.DELETE, "Delete", "csharp");
@@clientName(GroupType, "ApiManagementGroupType", "csharp");
@@clientName(AccessType, "StorageAccountAccessType", "csharp");
@@clientName(
  GatewayKeyRegenerationRequestContract,
  "GatewayKeyRegenerateContent",
  "csharp"
);
@@clientName(KeyType, "TokenGenerationUsedKeyType", "csharp");

// C# compat: the old SDK had a separate enum GatewayRegenerateKeyType for the gateway context.
// Define a copy and apply @@alternateType so the generator uses it instead of TokenGenerationUsedKeyType.
/** The Key being regenerated. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "C# SDK backward compatibility: fixed enum needed to match old SDK type"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Documented via doc comments"
enum GatewayRegenerateKeyType {
  /** Primary key. */
  primary,

  /** Secondary key. */
  secondary,
}
@@alternateType(
  GatewayKeyRegenerationRequestContract.keyType,
  GatewayRegenerateKeyType,
  "csharp"
);
@@clientName(Verbosity, "TraceVerbosityLevel", "csharp");
@@clientName(State, "IssueState", "csharp");
@@clientName(Severity, "IssueSeverity", "csharp");
@@clientName(Origin, "IssueOrigin", "csharp");
@@clientName(Protocol, "ApiOperationInvokableProtocol", "csharp");
@@clientName(PolicyExportFormat.rawxml, "RawXml", "csharp");
@@clientName(
  ResourceSkuResult,
  "AvailableApiManagementServiceSkuResult",
  "csharp"
);
@@clientName(SkuType, "ApiManagementServiceSkuType", "csharp");
@@clientName(ApiManagementSkuRestrictions.type, "RestrictionsType", "csharp");
@@clientName(HostnameConfiguration.type, "HostnameType", "csharp");
@@clientName(
  Microsoft.ApiManagement.PrivateLinkResource,
  "ApiManagementPrivateLinkResource",
  "csharp"
);
@@clientName(HostnameConfiguration.keyVaultId, "keyVaultSecretUri", "csharp");
@@clientName(ParameterContract.required, "IsRequired", "csharp");
@@clientName(ParameterContract.type, "ParameterContractType", "csharp");
@@usage(ParameterContract, Usage.input | Usage.output);
@@clientName(SchemaType, "ApiSchemaType", "csharp");
@@clientName(ApiRevisionContract.privateUrl, "privateUriString", "csharp");
@@clientName(ApiContractProperties.serviceUrl, "serviceLink", "csharp");
@@alternateType(
  ApiContractProperties.sourceApiId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ApiUpdateContract, "ApiPatch", "csharp");
@@clientName(ApiContractUpdateProperties.serviceUrl, "serviceLink", "csharp");
@@clientName(ApiCreateOrUpdateParameter, "ApiCreateOrUpdateContent", "csharp");
@@clientName(
  ApiEntityBaseContract.termsOfServiceUrl,
  "termsOfServiceLink",
  "csharp"
);
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
  AuthorizationContracts.post,
  "PostAuthorizationLoginLink",
  "csharp"
);
@@clientName(ProductUpdateParameters, "ApiManagementProductPatch", "csharp");
@@clientName(
  NamedValueUpdateParameters,
  "ApiManagementNamedValuePatch",
  "csharp"
);
@@clientName(
  GroupCreateParameters,
  "ApiManagementGroupCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  GroupCreateParametersProperties.type,
  "ApiManagementGroupType",
  "csharp"
);
@@clientName(GroupUpdateParameters, "ApiManagementGroupPatch", "csharp");
@@clientName(
  GroupUpdateParametersProperties.type,
  "ApiManagementGroupType",
  "csharp"
);
@@clientName(ApiVersionSetUpdateParameters, "ApiVersionSetPatch", "csharp");
@@clientName(OperationUpdateContract, "ApiOperationPatch", "csharp");
@@clientName(
  NamedValueCreateContract,
  "ApiManagementNamedValueCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  ApiManagementGatewayConfigConnectionResource,
  "ApiGatewayConfigConnection",
  "csharp"
);
@@clientName(ApiManagementGatewayResource, "ApiGateway", "csharp");
@@clientName(
  ApiManagementGatewayResources.listAvailableSkus,
  "GetAvailableSkusApiManagementGatewaySkus",
  "csharp"
);
@@clientName(
  ApiManagementWorkspaceLinksResource,
  "ApiManagementWorkspaceLinks",
  "csharp"
);
@@alternateType(
  AllPoliciesContractProperties.referencePolicyId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  DiagnosticContractProperties.logClientIp,
  "IsLogClientIPEnabled",
  "csharp"
);
@@alternateType(
  AuthorizationProviderOAuth2FederatedIdentityCredentialsGrantType.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  AuthorizationAccessPolicyContractProperties.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  ApiManagementServiceIdentity.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ApiManagementSku.locations, Azure.Core.azureLocation, "csharp");
@@alternateType(
  ApiManagementSkuRestrictionInfo.locations,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  AuthorizationProviderOAuth2FederatedIdentityCredentialsGrantType.resourceUri,
  url,
  "csharp"
);
@@alternateType(
  ApiManagementServiceGetSsoTokenResult.redirectUri,
  url,
  "csharp"
);
@@alternateType(PortalConfigCspProperties.reportUri, url, "csharp");
@@clientName(ResourceSkuCapacity, "ApiManagementResourceSkuCapacity", "csharp");
@@clientName(
  ResourceSkuCapacityScaleType,
  "ApiManagementResourceSkuCapacityScaleType",
  "csharp"
);
@@clientName(AuthorizationType, "ApiManagementAuthorizationType", "csharp");
@@clientName(AuthorizationError, "ApiManagementAuthorizationError", "csharp");
@@clientName(NatGatewayState, "ApiManagementNatGatewayState", "csharp");
@@clientName(
  ApiManagementServiceResources.listByLocation,
  "GetNetworkStatusByLocation",
  "csharp"
);
@@clientName(
  AccessInformationContracts.tenantAccessGitRegeneratePrimaryKey,
  "RegeneratePrimaryKeyForGit",
  "csharp"
);
@@clientName(
  AccessInformationContracts.tenantAccessGitRegenerateSecondaryKey,
  "RegenerateSecondaryKeyForGit",
  "csharp"
);
@@clientName(ApiContracts.listByApis, "GetApiProductsRaw", "csharp");
@@clientName(
  ApiManagementServiceResources.listAvailableServiceSkus,
  "GetAvailableApiManagementServiceSkus",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.networkStatusListByService,
  "GetNetworkStatuses",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.outboundNetworkDependenciesEndpointsListByService,
  "GetOutboundNetworkDependenciesEndpoints",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.policyDescriptionListByService,
  "GetPolicyDescriptions",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.byService,
  "ByServicePolicyRestrictionValidation",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.portalSettingsListByService,
  "GetPortalSettings",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.quotaByCounterKeysListByService,
  "GetQuotaByCounterKeys",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.quotaByCounterKeysUpdate,
  "UpdateQuotaByCounterKeys",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.quotaByPeriodKeysGet,
  "GetQuotaByPeriodKey",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.quotaByPeriodKeysUpdate,
  "UpdateQuotaByPeriodKey",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.regionListByService,
  "GetRegions",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByService,
  "GetAllPoliciesByService",
  "csharp"
);
@@clientName(
  AccessInformationContracts.deploy,
  "DeployTenantConfiguration",
  "csharp"
);
@@clientName(
  AccessInformationContracts.save,
  "SaveTenantConfiguration",
  "csharp"
);
@@clientName(
  AccessInformationContracts.validate,
  "ValidateTenantConfiguration",
  "csharp"
);
@@clientName(
  AccessInformationContracts.getSyncState,
  "GetTenantConfigurationSyncState",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.tagResourceListByService,
  "GetTagResources",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByApi,
  "GetReportsByApi",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByUser,
  "GetReportsByUser",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByOperation,
  "GetReportsByOperation",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByProduct,
  "GetReportsByProduct",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByGeo,
  "GetReportsByGeo",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listBySubscription,
  "GetReportsBySubscription",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByTime,
  "GetReportsByTime",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByRequest,
  "GetReportsByRequest",
  "csharp"
);
@@clientName(GatewayContracts.listTrace, "GetTraceRaw", "csharp");
@@clientName(
  GatewayContracts.gatewayApiGetEntityTag,
  "GetGatewayApiEntityTagRaw",
  "csharp"
);
@@clientName(GatewayContracts.gatewayApiDelete, "DeleteGatewayApi", "csharp");
@@clientName(
  GroupContracts.checkEntityExists,
  "CheckGroupUserEntityExistsRaw",
  "csharp"
);
@@clientName(GroupContracts.groupUserDelete, "DeleteGroupUser", "csharp");
@@clientName(
  NotificationContracts.notificationRecipientEmailCheckEntityExists,
  "CheckNotificationRecipientEmailEntityExistsRaw",
  "csharp"
);
@@clientName(
  NotificationContracts.checkEntityExists,
  "CheckNotificationRecipientUserEntityExistsRaw",
  "csharp"
);
@@clientName(
  ProductContracts.checkEntityExists,
  "CheckProductApiEntityExistsRaw",
  "csharp"
);
@@clientName(
  ProductContracts.productGroupCheckEntityExists,
  "CheckProductGroupEntityExistsRaw",
  "csharp"
);
@@clientName(
  ApiManagementServiceOperationGroup.checkNameAvailability,
  "CheckApiManagementServiceNameAvailability",
  "csharp"
);
@@clientName(
  ApiManagementServiceOperationGroup.getDomainOwnershipIdentifier,
  "GetApiManagementServiceDomainOwnershipIdentifier",
  "csharp"
);
@@clientName(
  DeletedServicesOperationGroup.listBySubscription,
  "GetApiManagementDeletedServices",
  "csharp"
);
@@clientName(
  ApiManagementSkusOperationGroup.list,
  "GetApiManagementSkus",
  "csharp"
);
@@clientName(ContentTypeContracts.listByService, "GetContentTypes", "csharp");
@@clientName(ContentTypeContracts.get, "GetContentType", "csharp");
@@clientName(
  ContentTypeContracts.createOrUpdate,
  "CreateOrUpdateContentType",
  "csharp"
);
@@clientName(ContentTypeContracts.delete, "DeleteContentType", "csharp");
@@clientName(ContentItemContracts.listByService, "GetContentItems", "csharp");
@@clientName(ContentItemContracts.get, "GetContentItem", "csharp");
@@clientName(
  ContentItemContracts.createOrUpdate,
  "CreateOrUpdateContentItem",
  "csharp"
);
@@clientName(ContentItemContracts.delete, "DeleteContentItem", "csharp");
@@clientName(
  ContentItemContracts.getEntityTag,
  "GetContentItemEntityTag",
  "csharp"
);
@@clientName(ProductContracts.list, "GetAllProductSubscriptionData", "csharp");
@@clientName(
  AuthorizationServerContractBaseProperties.clientAuthenticationMethod,
  "ClientAuthenticationMethods",
  "csharp"
);
@@clientName(
  ApiEntityBaseContract.subscriptionRequired,
  "IsSubscriptionRequired",
  "csharp"
);
@@clientName(CacheContractProperties.resourceId, "resourceUri", "csharp");
@@clientName(CacheUpdateProperties.resourceId, "resourceUri", "csharp");
@@alternateType(CacheContractProperties.resourceId, url, "csharp");
@@alternateType(CacheUpdateProperties.resourceId, url, "csharp");
@@clientName(
  IdentityProviderBaseParameters.type,
  "IdentityProviderType",
  "csharp"
);
@@clientName(
  IdentityProviderBaseParameters.signinTenant,
  "SignInTenant",
  "csharp"
);
@@clientName(
  IdentityProviderBaseParameters.signupPolicyName,
  "SignUpPolicyName",
  "csharp"
);
@@clientName(
  IdentityProviderBaseParameters.signinPolicyName,
  "SignInPolicyName",
  "csharp"
);
@@clientName(NamedValueEntityBaseParameters.secret, "IsSecret", "csharp");
@@clientName(
  ProductEntityBaseParameters.subscriptionRequired,
  "IsSubscriptionRequired",
  "csharp"
);
@@clientName(
  ProductEntityBaseParameters.approvalRequired,
  "IsApprovalRequired",
  "csharp"
);
@@clientName(
  AuthorizationServerContractBaseProperties.supportState,
  "DoesSupportState",
  "csharp"
);
@@clientName(
  PortalSettingsContractProperties.subscriptions,
  "IsSubscriptions",
  "csharp"
);
@@clientName(
  PortalSettingsContractProperties.userRegistration,
  "IsUserRegistration",
  "csharp"
);
@@clientName(
  SubscriptionsDelegationSettingsProperties.enabled,
  "IsSubscriptionDelegationEnabled",
  "csharp"
);
@@clientName(
  RegistrationDelegationSettingsProperties.enabled,
  "IsUserRegistrationDelegationEnabled",
  "csharp"
);
@@alternateType(PortalSettingsContractProperties.url, url, "csharp");
@@alternateType(
  IssueContractBaseProperties.apiId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IssueContractProperties.userId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LoggerContractProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ConnectivityHop.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ConnectivityHop.type, "ConnectivityHopType", "csharp");
@@usage(ConnectivityHop, Usage.input | Usage.output);
@@alternateType(
  RemotePrivateEndpointConnectionWrapper.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RemotePrivateEndpointConnectionWrapper.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@clientName(
  RemotePrivateEndpointConnectionWrapper.type,
  "resourceType",
  "csharp"
);
@@alternateType(ArmIdWrapper.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  ApiReleaseContractProperties.apiId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IssueCommentContractProperties.userId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DeletedServiceContractProperties.serviceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PrivateEndpointConnectionRequest.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualNetworkConfiguration.vnetid, Azure.Core.uuid, "csharp");
@@alternateType(
  VirtualNetworkConfiguration.subnetResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ResourceSkuResult.resourceType,
  Azure.Core.armResourceType,
  "csharp"
);
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
@@alternateType(ApiManagementServiceBaseProperties.gatewayUrl, url, "csharp");
@@alternateType(
  ApiManagementServiceBaseProperties.gatewayRegionalUrl,
  url,
  "csharp"
);
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
@@alternateType(
  AdditionalLocation.publicIpAddressId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  AdditionalLocation.publicIpAddressId,
  "PublicIPAddressId",
  "csharp"
);
@@alternateType(PortalDelegationSettingsProperties.url, url, "csharp");
@@alternateType(
  TagDescriptionContractProperties.externalDocsUrl,
  url,
  "csharp"
);
@@alternateType(TagDescriptionBaseProperties.externalDocsUrl, url, "csharp");
@@clientName(ApiManagementSkuCosts.meterID, "MeterId", "csharp");
@@clientName(ConnectivityCheckProtocol.HTTP, "Http", "csharp");
@@clientName(ConnectivityCheckProtocol.HTTPS, "Https", "csharp");
@@clientName(ContentFormat.`graphql-link`, "GraphQLLink", "csharp");
@@clientName(ContentFormat.`openapi+json`, "OpenApiJson", "csharp");
@@clientName(ContentFormat.`openapi+json-link`, "OpenApiJsonLink", "csharp");
@@clientName(ContentFormat.`openapi-link`, "OpenApiLink", "csharp");
@@clientName(Method.POST, "Post", "csharp");
@@clientName(MigrateToStv2Mode.PreserveIp, "PreserveIP", "csharp");
@@clientName(PolicyContentFormat.`rawxml-link`, "RawXmlLink", "csharp");
@@clientName(RequestReportRecordContract.ipAddress, "IPAddress", "csharp");
@@clientName(SoapApiType.gRPC, "Grpc", "csharp");
@@clientName(ProductContracts.listByProduct, "GetProductApisRaw", "csharp");
@@clientName(
  ProductContracts.productApiCreateOrUpdate,
  "CreateOrUpdateProductApiRaw",
  "csharp"
);
@@clientName(ProductContracts.productApiDelete, "DeleteProductApi", "csharp");
@@clientName(
  ProductContracts.productGroupListByProduct,
  "GetProductGroupsRaw",
  "csharp"
);
@@clientName(
  ProductContracts.productGroupCreateOrUpdate,
  "CreateOrUpdateProductGroupRaw",
  "csharp"
);
@@clientName(
  ProductContracts.productGroupDelete,
  "DeleteProductGroup",
  "csharp"
);
@@clientName(
  NotificationContracts.listByNotification,
  "GetNotificationRecipientUsers",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientUserCreateOrUpdate,
  "CreateOrUpdateNotificationRecipientUser",
  "csharp"
);
@@clientName(
  NotificationContracts.delete,
  "DeleteNotificationRecipientUser",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientEmailListByNotification,
  "GetNotificationRecipientEmails",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientEmailCreateOrUpdate,
  "CreateOrUpdateNotificationRecipientEmail",
  "csharp"
);
@@clientName(
  NotificationContracts.notificationRecipientEmailDelete,
  "DeleteNotificationRecipientEmail",
  "csharp"
);
@@clientName(
  WorkspaceNotification.listByNotification,
  "GetWorkspaceNotificationRecipientUsersByNotification",
  "csharp"
);
@@clientName(UserContracts.generateSsoUrl, "GenerateSsoUri", "csharp");
@@clientName(UserContracts.send, "SendUserConfirmationPassword", "csharp");
@@clientName(UserContracts.userIdentitiesList, "GetUserIdentities", "csharp");
@@clientName(
  ApiContracts.apiRevisionListByService,
  "GetApiRevisionsByService",
  "csharp"
);
@@clientName(ApiContracts.listByTags, "GetOperationsByTags", "csharp");
@@clientName(
  WorkspaceApi.workspaceApiRevisionListByService,
  "GetWorkspaceApiRevisionsByService",
  "csharp"
);
@@clientName(WorkspaceGroup.list, "GetWorkspaceGroupUsers", "csharp");
@@clientName(WorkspaceGroup.create, "CreateWorkspaceGroupUser", "csharp");
@@clientName(
  WorkspaceGroup.workspaceGroupUserDelete,
  "DeleteWorkspaceGroupUser",
  "csharp"
);
@@clientName(
  WorkspaceNotification.checkEntityExists,
  "CheckEntityExistsWorkspaceNotificationRecipientUserRaw",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientUserCreateOrUpdate,
  "CreateOrUpdateWorkspaceNotificationRecipientUser",
  "csharp"
);
@@clientName(
  WorkspaceNotification.delete,
  "DeleteWorkspaceNotificationRecipientUser",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailListByNotification,
  "GetWorkspaceNotificationRecipientEmailsByNotification",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailCheckEntityExists,
  "CheckEntityExistsWorkspaceNotificationRecipientEmailRaw",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailCreateOrUpdate,
  "CreateOrUpdateWorkspaceNotificationRecipientEmail",
  "csharp"
);
@@clientName(
  WorkspaceNotification.workspaceNotificationRecipientEmailDelete,
  "DeleteWorkspaceNotificationRecipientEmail",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.listByTags,
  "GetApisByTags",
  "csharp"
);
@@clientName(
  ApiManagementServiceResources.productListByTags,
  "GetProductsByTags",
  "csharp"
);
@@clientName(OperationStatusOperationGroup.get, "GetOperationStatus", "csharp");
@@clientName(
  OperationsResultsOperationGroup.get,
  "GetOperationsResult",
  "csharp"
);
@@clientName(
  TagTagResourceContractProperties,
  "AssociatedTagProperties",
  "csharp"
);
// Avoid a C# case-only collision with the model `LLMDiagnosticSettings`
// (one-file-per-type can't coexist with case-insensitive MSBuild Compile items).
@@clientName(LlmDiagnosticSettings, "LlmDiagnosticLogState", "csharp");
@@clientName(
  AssociationContractProperties.provisioningState,
  "ProvisioningState",
  "csharp"
);
@@alternateType(
  AssociationContractProperties.provisioningState,
  AssociationEntityProvisioningState,
  "csharp"
);
@@clientName(ConnectivityIssue.type, "IssueType", "csharp");
@@clientName(
  ApiManagementServiceApplyNetworkConfigurationParameters,
  "ApiManagementServiceApplyNetworkConfigurationContent",
  "csharp"
);
@@clientName(PolicyCollection, "PolicyListResult", "csharp");
@@clientName(
  PolicyDescriptionCollection,
  "PolicyDescriptionListResult",
  "csharp"
);
@@clientName(QuotaCounterCollection, "QuotaCounterListResult", "csharp");
@@clientName(RecipientEmailCollection, "RecipientEmailListResult", "csharp");
@@clientName(RecipientUserCollection, "RecipientUserListResult", "csharp");
@@clientName(ConnectivityCheckRequest, "ConnectivityCheckContent", "csharp");
@@clientName(PortalSettingsCollection, "PortalSettingsListResult", "csharp");
@@clientName(ApiReleaseCollection, "ApiReleaseListResult", "csharp");
@@clientName(
  PrivateEndpointConnectionRequest,
  "ApiManagementPrivateEndpointConnectionCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.PrivateEndpointConnection,
  "ApiManagementPrivateEndpointConnection",
  "csharp"
);
@@clientName(ApiVersionSetCollection, "ApiVersionSetListResult", "csharp");
@@clientName(
  AccessInformationCreateParameters,
  "TenantAccessInfoCreateOrUpdateContent",
  "csharp"
);
@@clientName(ResourceCollection, "ResourceListResult", "csharp");
@@clientName(
  UserCreateParameters,
  "ApiManagementUserCreateOrUpdateContent",
  "csharp"
);
@@clientName(UserContract, "ApiManagementUser", "csharp");
@@clientName(UserUpdateParameters, "ApiManagementUserPatch", "csharp");
@@clientName(
  TagDescriptionCreateParameters,
  "ApiTagDescriptionCreateOrUpdateContent",
  "csharp"
);
@@clientName(ApiCollection, "ApiListResult", "csharp");
@@clientName(UserTokenParameters, "UserTokenContent", "csharp");
@@clientName(UserTokenParameterProperties.expiry, "ExpireOn", "csharp");
@@clientName(
  IdentityProviderCreateContract,
  "ApiManagementIdentityProviderCreateOrUpdateContent",
  "csharp"
);
@@clientName(GenerateSsoUrlResult, "GenerateSsoUriResult", "csharp");
@@alternateType(
  ApiManagementServiceResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
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
  WorkspaceLinksBaseProperties.gateways,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ApiManagementServiceResources.outboundNetworkDependenciesEndpointsListByService,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ApiManagementServiceResources.policyDescriptionListByService,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ApiManagementServiceResources.portalSettingsListByService,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ApiManagementServiceResources.quotaByCounterKeysListByService,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ApiManagementServiceResources.quotaByCounterKeysUpdate,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  NotificationContracts.listByNotification,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  NotificationContracts.notificationRecipientEmailListByNotification,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  WorkspaceNotification.listByNotification,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  WorkspaceNotification.workspaceNotificationRecipientEmailListByNotification,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyFragmentContracts.listReferences,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  WorkspacePolicyFragment.listReferences,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateLinkResources.listPrivateLinkResources,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyContracts.listByOperation,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ApiPolicy.listByApi,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous pageable SDK surface"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  WorkspaceProductPolicy.listByProduct,
  "csharp"
);

@@usage(ApiContract, Usage.input | Usage.output);
@@usage(CertificateContract, Usage.input | Usage.output);
@@usage(DeletedServiceContract, Usage.input | Usage.output);
@@usage(EmailTemplateContract, Usage.input | Usage.output);
@@usage(GroupContract, Usage.input | Usage.output);
@@usage(IdentityProviderContract, Usage.input | Usage.output);
@@usage(NamedValueContract, Usage.input | Usage.output);
@@usage(NotificationContract, Usage.input | Usage.output);
@@usage(
  Microsoft.ApiManagement.PrivateEndpointConnection,
  Usage.input | Usage.output
);
@@usage(
  Microsoft.ApiManagement.PrivateLinkResource,
  Usage.input | Usage.output
);
@@usage(ApiManagementWorkspaceLinksResource, Usage.input | Usage.output);
@@usage(TagDescriptionContract, Usage.input | Usage.output);
@@usage(AllPoliciesContract, Usage.input | Usage.output);
@@usage(ErrorFieldContract, Usage.input | Usage.output);
@@usage(ErrorResponseBody, Usage.input | Usage.output);
@@usage(OperationResultContract, Usage.input | Usage.output);
@@usage(KeyVaultContractProperties, Usage.input | Usage.output);
@@usage(KeyVaultLastAccessStatusContractProperties, Usage.input | Usage.output);
@@usage(PolicyDescriptionContract, Usage.input | Usage.output);
@@usage(PortalSettingsContract, Usage.input | Usage.output);
@@usage(RecipientEmailContract, Usage.input | Usage.output);
@@usage(RecipientsContractProperties, Usage.input | Usage.output);
@@usage(RecipientUserContract, Usage.input | Usage.output);
@@usage(ResourceCollectionValueItem, Usage.input | Usage.output);
@@usage(TenantConfigurationSyncStateContract, Usage.input | Usage.output);
@@usage(SubscriptionContract, Usage.input | Usage.output);
@@usage(TagContract, Usage.input | Usage.output);
@@usage(AccessInformationContract, Usage.input | Usage.output);
@@usage(UserContract, Usage.input | Usage.output);
@@usage(TenantSettingsContract, Usage.input | Usage.output);
@@usage(ConfigurationIdName, Usage.input | Usage.output);
@@usage(GroupCreateParameters, Usage.input | Usage.output);
@@usage(IdentityProviderCreateContract, Usage.input | Usage.output);
@@usage(NamedValueCreateContract, Usage.input | Usage.output);
@@usage(SubscriptionCreateParameters, Usage.input | Usage.output);
@@usage(UserCreateParameters, Usage.input | Usage.output);
@@usage(DeployConfigurationParameters, Usage.input | Usage.output);
@@usage(SaveConfigurationParameter, Usage.input | Usage.output);
@@usage(UserTokenParameters, Usage.input | Usage.output);
@@alternateType(
  DeletedServiceContract.location,
  Azure.Core.azureLocation,
  "csharp"
);

// BackendSubnetConfiguration.id -> SubnetId (ResourceIdentifier) to match old SDK surface
@@clientName(BackendSubnetConfiguration.id, "SubnetId", "csharp");
@@alternateType(
  BackendSubnetConfiguration.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Flatten pool to expose PoolServices directly on backend data/patch models
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# SDK backward compatibility: flatten pool for direct PoolServices access"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  BackendBaseParameters.pool,
  "csharp"
);
@@clientName(BackendBaseParametersPool.services, "PoolServices", "csharp");

// Property renames to preserve old SDK names after @@flattenProperty (properties bag already flattened in back-compatible.tsp)
@@clientName(OperationContractProperties.urlTemplate, "UriTemplate", "csharp");
@@clientName(
  OperationUpdateContractProperties.urlTemplate,
  "UriTemplate",
  "csharp"
);
@@clientName(
  DeployConfigurationParameterProperties.force,
  "ForceDelete",
  "csharp"
);
@@clientName(
  DiagnosticContractUpdateProperties.logClientIp,
  "IsLogClientIPEnabled",
  "csharp"
);
@@clientName(
  AccessInformationCreateParameterProperties.enabled,
  "IsDirectAccessEnabled",
  "csharp"
);
@@clientName(
  AccessInformationUpdateParameterProperties.enabled,
  "IsDirectAccessEnabled",
  "csharp"
);

// PortalDelegationSettings.properties flatten now applies to csharp (removed "!csharp" scope in back-compatible.tsp)
@@clientName(PortalDelegationSettingsProperties.url, "Uri", "csharp");
@@alternateType(PortalDelegationSettingsProperties.url, url, "csharp");

// Framework WritableSubResource is not modeled by ARM TypeSpec common-types.
// Define it here so @@alternateType can preserve the old SDK surface for { id } references.
namespace Azure.ResourceManager.Models {
  model WritableSubResource {
    id?: Azure.Core.armResourceIdentifier;
  }
}
