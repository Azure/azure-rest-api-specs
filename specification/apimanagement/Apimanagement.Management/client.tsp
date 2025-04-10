import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementGatewayUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AllPoliciesContract.properties);

@@clientName(ApiEntityBaseContract.type, "apiType");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiCreateOrUpdateParameter.properties);

@@clientName(ApiCreateOrUpdateProperties.apiType, "soapApiType");
@@clientName(ApiCreateOrUpdateProperties.translateRequiredQueryParameters,
  "translateRequiredQueryParametersConduct"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResolverUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SchemaContractProperties.document);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IssueUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagDescriptionCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WikiUpdateContract.properties);

@@clientName(ApiExportResult.format, "exportResultFormat");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiVersionSetUpdateParameters.properties);

@@clientName(AuthorizationContractProperties.oauth2grantType,
  "oAuth2GrantType"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationServerUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackendUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackendReconnectContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CacheUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CertificateCreateOrUpdateParameters.properties);

@@clientName(ConnectivityCheckRequestProtocolConfiguration.HTTPConfiguration,
  "httpConfiguration"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RemotePrivateEndpointConnectionWrapper.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementServiceUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DocumentationUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EmailTemplateUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AssociationContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GroupCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GroupUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IdentityProviderCreateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IdentityProviderUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LoggerUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamedValueCreateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamedValueUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RecipientUserContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RecipientEmailContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OpenidConnectProviderUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyDescriptionContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyRestrictionUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationResultContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalSettingsContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QuotaCounterValueUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GlobalSchemaContractProperties.document);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagCreateUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccessInformationCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccessInformationUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeployConfigurationParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SaveConfigurationParameter.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TenantConfigurationSyncStateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserTokenParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticUpdateContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyWithComplianceContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QuotaCounterValueContract.value);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResolverResultContract.properties);

@@clientName(ApiManagementGatewayResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApiManagementGatewayResources.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementGatewayResource.properties);

@@clientName(ApiContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(ApiContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceApi.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceApi.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiContract.properties);

@@clientName(ApiReleaseContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApiReleaseContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceApiRelease.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiRelease.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiReleaseContract.properties);

@@clientName(OperationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(OperationContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceApiOperation.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiOperation.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationContract.properties);

@@clientName(PolicyContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(GraphQLApiResolverPolicy.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApiPolicy.createOrUpdate::parameters.resource, "parameters");
@@clientName(Policy.createOrUpdate::parameters.resource, "parameters");
@@clientName(ProductPolicy.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspacePolicy.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceApiOperationPolicy.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiPolicy.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceProductPolicy.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyContract.properties);

@@clientName(TagContractOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(TagContractOperationGroup.update::parameters.properties,
  "parameters"
);
@@clientName(WorkspaceTag.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceTag.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagContract.properties);

@@clientName(ResolverContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ResolverContracts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResolverContract.properties);

@@clientName(ProductContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ProductContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceProduct.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceProduct.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductContract.properties);

@@clientName(SchemaContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceApiSchema.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SchemaContract.properties);

@@clientName(DiagnosticContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DiagnosticContracts.update::parameters.properties, "parameters");
@@clientName(Diagnostic.createOrUpdate::parameters.resource, "parameters");
@@clientName(Diagnostic.update::parameters.properties, "parameters");
@@clientName(WorkspaceDiagnostic.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceDiagnostic.update::parameters.properties, "parameters");
@@clientName(WorkspaceApiDiagnostic.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiDiagnostic.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticContract.properties);

@@clientName(IssueContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(IssueContracts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IssueContract.properties);

@@clientName(IssueCommentContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IssueCommentContract.properties);

@@clientName(IssueAttachmentContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IssueAttachmentContract.properties);

@@clientName(TagDescriptionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagDescriptionContract.properties);

@@clientName(WikiContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(WikiContracts.update::parameters.properties, "parameters");
@@clientName(ProductWiki.createOrUpdate::parameters.resource, "parameters");
@@clientName(ProductWiki.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WikiContract.properties);

@@clientName(ApiVersionSetContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApiVersionSetContracts.update::parameters.properties,
  "parameters"
);
@@clientName(WorkspaceApiVersionSet.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiVersionSet.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiVersionSetContract.properties);

@@clientName(AuthorizationProviderContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationProviderContract.properties);

@@clientName(AuthorizationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(AuthorizationContracts.confirmConsentCode::parameters.body,
  "parameters"
);
@@clientName(AuthorizationContracts.post::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationContract.properties);

@@clientName(AuthorizationAccessPolicyContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationAccessPolicyContract.properties);

@@clientName(AuthorizationServerContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(AuthorizationServerContracts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationServerContract.properties);

@@clientName(BackendContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(BackendContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceBackend.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceBackend.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackendContract.properties);

@@clientName(CacheContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(CacheContracts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CacheContract.properties);

@@clientName(CertificateContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceCertificate.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CertificateContract.properties);

@@clientName(ContentTypeContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ContentTypeContract.properties);

@@clientName(ContentItemContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ContentItemContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeletedServiceContract.properties);

@@clientName(ApiManagementServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApiManagementServiceResources.update::parameters.properties,
  "parameters"
);
@@clientName(ApiManagementServiceResources.performConnectivityCheckAsync::parameters.body,
  "connectivityCheckRequestParams"
);
@@clientName(ApiManagementServiceResources.restore::parameters.body,
  "parameters"
);
@@clientName(ApiManagementServiceResources.backup::parameters.body,
  "parameters"
);
@@clientName(ApiManagementServiceResources.quotaByCounterKeysUpdate::parameters.body,
  "parameters"
);
@@clientName(ApiManagementServiceResources.quotaByPeriodKeysUpdate::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementServiceResource.properties);

@@clientName(DocumentationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DocumentationContracts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DocumentationContract.properties);

@@clientName(EmailTemplateContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(EmailTemplateContracts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EmailTemplateContract.properties);

@@clientName(ApiManagementGatewayConfigConnectionResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementGatewayConfigConnectionResource.properties);

@@clientName(GatewayContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(GatewayContracts.update::parameters.properties, "parameters");
@@clientName(GatewayContracts.regenerateKey::parameters.body, "parameters");
@@clientName(GatewayContracts.generateToken::parameters.body, "parameters");
@@clientName(GatewayContracts.listDebugCredentials::parameters.body,
  "parameters"
);
@@clientName(GatewayContracts.listTrace::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayContract.properties);

@@clientName(GatewayHostnameConfigurationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayHostnameConfigurationContract.properties);

@@clientName(GatewayCertificateAuthorityContracts.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayCertificateAuthorityContract.properties);

@@clientName(GroupContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(GroupContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceGroup.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceGroup.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GroupContract.properties);

@@clientName(UserContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(UserContracts.update::parameters.properties, "parameters");
@@clientName(UserContracts.getSharedAccessToken::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserContract.properties);

@@clientName(IdentityProviderContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(IdentityProviderContracts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IdentityProviderContract.properties);

@@clientName(LoggerContracts.createOrUpdate::parameters.resource, "parameters");
@@clientName(LoggerContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceLogger.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceLogger.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LoggerContract.properties);

@@clientName(NamedValueContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NamedValueContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceNamedValue.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceNamedValue.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamedValueContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NotificationContract.properties);

@@clientName(OpenidConnectProviderContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(OpenidConnectProviderContracts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OpenidConnectProviderContract.properties);

@@clientName(PolicyFragmentContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspacePolicyFragment.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyFragmentContract.properties);

@@clientName(PolicyRestrictionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PolicyRestrictionContracts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyRestrictionContract.properties);

@@clientName(PortalConfigContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PortalConfigContracts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalConfigContract.properties);

@@clientName(PortalRevisionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PortalRevisionContracts.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalRevisionContract.properties);

@@clientName(PortalSigninSettingsOperationGroup, "PortalSigninSettings");
@@clientName(SignInSettings.createOrUpdate::parameters.resource, "parameters");
@@clientName(SignInSettings.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalSigninSettings.properties);

@@clientName(PortalSignupSettingsOperationGroup, "PortalSignupSettings");
@@clientName(SignUpSettings.createOrUpdate::parameters.resource, "parameters");
@@clientName(SignUpSettings.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalSignupSettings.properties);

@@clientName(PortalDelegationSettingsOperationGroup,
  "PortalDelegationSettings"
);
@@clientName(DelegationSettings.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DelegationSettings.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalDelegationSettings.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnectionRequest"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(SubscriptionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SubscriptionContracts.update::parameters.properties, "parameters");
@@clientName(WorkspaceSubscription.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceSubscription.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionContract.properties);

@@clientName(ProductApiLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceProductApiLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductApiLinkContract.properties);

@@clientName(ProductGroupLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceProductGroupLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductGroupLinkContract.properties);

@@clientName(GlobalSchemaContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceGlobalSchema.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GlobalSchemaContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TenantSettingsContract.properties);

@@clientName(TagApiLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceTagApiLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagApiLinkContract.properties);

@@clientName(TagOperationLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceTagOperationLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagOperationLinkContract.properties);

@@clientName(TagProductLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceTagProductLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagProductLinkContract.properties);

@@clientName(AccessInformationContracts.create::parameters.resource,
  "parameters"
);
@@clientName(AccessInformationContracts.update::parameters.properties,
  "parameters"
);
@@clientName(AccessInformationContracts.deploy::parameters.body, "parameters");
@@clientName(AccessInformationContracts.save::parameters.body, "parameters");
@@clientName(AccessInformationContracts.validate::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccessInformationContract.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementWorkspaceLinksResource.properties);

@@clientName(WorkspaceContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceContracts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkspaceContract.properties);
