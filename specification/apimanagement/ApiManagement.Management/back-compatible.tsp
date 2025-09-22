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
@@flattenProperty(Operation.properties);

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

@@clientLocation(ApiManagementGatewayResources.get, "ApiGateway");
@@clientLocation(ApiManagementGatewayResources.createOrUpdate, "ApiGateway");
@@clientName(ApiManagementGatewayResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ApiManagementGatewayResources.update, "ApiGateway");
@@clientName(ApiManagementGatewayResources.update::parameters.properties,
  "parameters"
);
@@clientLocation(ApiManagementGatewayResources.delete, "ApiGateway");
@@clientLocation(ApiManagementGatewayResources.listByResourceGroup,
  "ApiGateway"
);
@@clientLocation(ApiManagementGatewayResources.list, "ApiGateway");
@@clientLocation(ApiManagementGatewayResources.listAvailableSkus,
  "ApiManagementGatewaySkus"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementGatewayResource.properties);

@@clientLocation(ApiContracts.get, "Api");
@@clientLocation(ApiContracts.getEntityTag, "Api");
@@clientLocation(ApiContracts.createOrUpdate, "Api");
@@clientName(ApiContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ApiContracts.update, "Api");
@@clientName(ApiContracts.update::parameters.properties, "parameters");
@@clientLocation(ApiContracts.delete, "Api");
@@clientLocation(ApiContracts.listByService, "Api");
@@clientLocation(ApiContracts.apiRevisionListByService, "ApiRevision");
@@clientName(ApiContracts.apiRevisionListByService, "ListByService");
@@clientLocation(ApiContracts.listByApis, "ApiProduct");
@@clientLocation(ApiContracts.listByTags, "Operation");
@@clientName(WorkspaceApi.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceApi.update::parameters.properties, "parameters");
@@clientLocation(WorkspaceApi.workspaceApiRevisionListByService,
  "WorkspaceApiRevision"
);
@@clientName(WorkspaceApi.workspaceApiRevisionListByService, "ListByService");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiContract.properties);

@@clientLocation(ApiReleaseContracts.get, "ApiRelease");
@@clientLocation(ApiReleaseContracts.getEntityTag, "ApiRelease");
@@clientLocation(ApiReleaseContracts.createOrUpdate, "ApiRelease");
@@clientName(ApiReleaseContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ApiReleaseContracts.update, "ApiRelease");
@@clientName(ApiReleaseContracts.update::parameters.properties, "parameters");
@@clientLocation(ApiReleaseContracts.delete, "ApiRelease");
@@clientLocation(ApiReleaseContracts.listByService, "ApiRelease");
@@clientName(WorkspaceApiRelease.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiRelease.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiReleaseContract.properties);

@@clientLocation(OperationContracts.get, "ApiOperation");
@@clientLocation(OperationContracts.getEntityTag, "ApiOperation");
@@clientLocation(OperationContracts.createOrUpdate, "ApiOperation");
@@clientName(OperationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(OperationContracts.update, "ApiOperation");
@@clientName(OperationContracts.update::parameters.properties, "parameters");
@@clientLocation(OperationContracts.delete, "ApiOperation");
@@clientLocation(OperationContracts.listByApi, "ApiOperation");
@@clientName(WorkspaceApiOperation.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiOperation.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationContract.properties);

@@clientLocation(PolicyContracts.get, "ApiOperationPolicy");
@@clientLocation(PolicyContracts.getEntityTag, "ApiOperationPolicy");
@@clientLocation(PolicyContracts.createOrUpdate, "ApiOperationPolicy");
@@clientName(PolicyContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(PolicyContracts.delete, "ApiOperationPolicy");
@@clientLocation(PolicyContracts.listByOperation, "ApiOperationPolicy");
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

@@clientLocation(TagContracts.getByOperation, Tag);
@@clientLocation(TagContracts.getEntityStateByOperation, Tag);
@@clientLocation(TagContracts.assignToOperation, Tag);
@@clientLocation(TagContracts.detachFromOperation, Tag);
@@clientLocation(TagContracts.listByOperation, Tag);
@@clientLocation(TagContractOperationGroup.getByProduct, Tag);
@@clientLocation(TagContractOperationGroup.getEntityStateByProduct, Tag);
@@clientLocation(TagContractOperationGroup.assignToProduct, Tag);
@@clientLocation(TagContractOperationGroup.detachFromProduct, Tag);
@@clientLocation(TagContractOperationGroup.listByProduct, Tag);
@@clientLocation(TagContractOperationGroup.get, Tag);
@@clientLocation(TagContractOperationGroup.getEntityState, Tag);
@@clientLocation(TagContractOperationGroup.createOrUpdate, Tag);
@@clientName(TagContractOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(TagContractOperationGroup.update, Tag);
@@clientName(TagContractOperationGroup.update::parameters.properties,
  "parameters"
);
@@clientLocation(TagContractOperationGroup.delete, Tag);
@@clientLocation(TagContractOperationGroup.listByService, Tag);
@@clientName(WorkspaceTag.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceTag.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagContract.properties);

@@clientLocation(ResolverContracts.get, "GraphQLApiResolver");
@@clientLocation(ResolverContracts.getEntityTag, "GraphQLApiResolver");
@@clientLocation(ResolverContracts.createOrUpdate, "GraphQLApiResolver");
@@clientName(ResolverContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ResolverContracts.update, "GraphQLApiResolver");
@@clientName(ResolverContracts.update::parameters.properties, "parameters");
@@clientLocation(ResolverContracts.delete, "GraphQLApiResolver");
@@clientLocation(ResolverContracts.listByApi, "GraphQLApiResolver");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResolverContract.properties);

@@clientLocation(ProductContracts.get, "Product");
@@clientLocation(ProductContracts.getEntityTag, "Product");
@@clientLocation(ProductContracts.createOrUpdate, "Product");
@@clientName(ProductContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ProductContracts.update, "Product");
@@clientName(ProductContracts.update::parameters.properties, "parameters");
@@clientLocation(ProductContracts.delete, "Product");
@@clientLocation(ProductContracts.listByService, "Product");
@@clientLocation(ProductContracts.listByProduct, "ProductApi");
@@clientLocation(ProductContracts.checkEntityExists, "ProductApi");
@@clientLocation(ProductContracts.productApiCreateOrUpdate, "ProductApi");
@@clientName(ProductContracts.productApiCreateOrUpdate, "CreateOrUpdate");
@@clientLocation(ProductContracts.productApiDelete, "ProductApi");
@@clientName(ProductContracts.productApiDelete, "Delete");
@@clientLocation(ProductContracts.productGroupListByProduct, "ProductGroup");
@@clientName(ProductContracts.productGroupListByProduct, "ListByProduct");
@@clientLocation(ProductContracts.productGroupCheckEntityExists,
  "ProductGroup"
);
@@clientName(ProductContracts.productGroupCheckEntityExists,
  "CheckEntityExists"
);
@@clientLocation(ProductContracts.productGroupCreateOrUpdate, "ProductGroup");
@@clientName(ProductContracts.productGroupCreateOrUpdate, "CreateOrUpdate");
@@clientLocation(ProductContracts.productGroupDelete, "ProductGroup");
@@clientName(ProductContracts.productGroupDelete, "Delete");
@@clientLocation(ProductContracts.list, "ProductSubscriptions");
@@clientName(WorkspaceProduct.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceProduct.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductContract.properties);

@@clientLocation(SchemaContracts.get, "ApiSchema");
@@clientLocation(SchemaContracts.getEntityTag, "ApiSchema");
@@clientLocation(SchemaContracts.createOrUpdate, "ApiSchema");
@@clientName(SchemaContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SchemaContracts.delete, "ApiSchema");
@@clientLocation(SchemaContracts.listByApi, "ApiSchema");
@@clientName(WorkspaceApiSchema.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SchemaContract.properties);

@@clientLocation(DiagnosticContracts.get, "ApiDiagnostic");
@@clientLocation(DiagnosticContracts.getEntityTag, "ApiDiagnostic");
@@clientLocation(DiagnosticContracts.createOrUpdate, "ApiDiagnostic");
@@clientName(DiagnosticContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DiagnosticContracts.update, "ApiDiagnostic");
@@clientName(DiagnosticContracts.update::parameters.properties, "parameters");
@@clientLocation(DiagnosticContracts.delete, "ApiDiagnostic");
@@clientLocation(DiagnosticContracts.listByService, "ApiDiagnostic");
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

@@clientLocation(IssueContracts.get, "ApiIssue");
@@clientLocation(IssueContracts.getEntityTag, "ApiIssue");
@@clientLocation(IssueContracts.createOrUpdate, "ApiIssue");
@@clientName(IssueContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(IssueContracts.update, "ApiIssue");
@@clientName(IssueContracts.update::parameters.properties, "parameters");
@@clientLocation(IssueContracts.delete, "ApiIssue");
@@clientLocation(IssueContracts.listByService, "ApiIssue");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IssueContract.properties);

@@clientLocation(IssueCommentContracts.get, "ApiIssueComment");
@@clientLocation(IssueCommentContracts.getEntityTag, "ApiIssueComment");
@@clientLocation(IssueCommentContracts.createOrUpdate, "ApiIssueComment");
@@clientName(IssueCommentContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(IssueCommentContracts.delete, "ApiIssueComment");
@@clientLocation(IssueCommentContracts.listByService, "ApiIssueComment");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IssueCommentContract.properties);

@@clientLocation(IssueAttachmentContracts.get, "ApiIssueAttachment");
@@clientLocation(IssueAttachmentContracts.getEntityTag, "ApiIssueAttachment");
@@clientLocation(IssueAttachmentContracts.createOrUpdate, "ApiIssueAttachment");
@@clientName(IssueAttachmentContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(IssueAttachmentContracts.delete, "ApiIssueAttachment");
@@clientLocation(IssueAttachmentContracts.listByService, "ApiIssueAttachment");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IssueAttachmentContract.properties);

@@clientLocation(TagDescriptionContracts.get, "ApiTagDescription");
@@clientLocation(TagDescriptionContracts.getEntityTag, "ApiTagDescription");
@@clientLocation(TagDescriptionContracts.createOrUpdate, "ApiTagDescription");
@@clientName(TagDescriptionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(TagDescriptionContracts.delete, "ApiTagDescription");
@@clientLocation(TagDescriptionContracts.listByService, "ApiTagDescription");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagDescriptionContract.properties);

@@clientLocation(WikiContracts.get, "ApiWiki");
@@clientLocation(WikiContracts.getEntityTag, "ApiWiki");
@@clientLocation(WikiContracts.createOrUpdate, "ApiWiki");
@@clientName(WikiContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(WikiContracts.update, "ApiWiki");
@@clientName(WikiContracts.update::parameters.properties, "parameters");
@@clientLocation(WikiContracts.delete, "ApiWiki");
@@clientLocation(WikiContracts.list, "ApiWikis");
@@clientName(ProductWiki.createOrUpdate::parameters.resource, "parameters");
@@clientName(ProductWiki.update::parameters.properties, "parameters");
@@clientLocation(ProductWiki.list, "ProductWikis");
@@clientName(ProductWiki.list, "list");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WikiContract.properties);

@@clientLocation(ApiVersionSetContracts.get, "ApiVersionSet");
@@clientLocation(ApiVersionSetContracts.getEntityTag, "ApiVersionSet");
@@clientLocation(ApiVersionSetContracts.createOrUpdate, "ApiVersionSet");
@@clientName(ApiVersionSetContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ApiVersionSetContracts.update, "ApiVersionSet");
@@clientName(ApiVersionSetContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(ApiVersionSetContracts.delete, "ApiVersionSet");
@@clientLocation(ApiVersionSetContracts.listByService, "ApiVersionSet");
@@clientName(WorkspaceApiVersionSet.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceApiVersionSet.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiVersionSetContract.properties);

@@clientLocation(AuthorizationProviderContracts.get, "AuthorizationProvider");
@@clientLocation(AuthorizationProviderContracts.createOrUpdate,
  "AuthorizationProvider"
);
@@clientName(AuthorizationProviderContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AuthorizationProviderContracts.delete,
  "AuthorizationProvider"
);
@@clientLocation(AuthorizationProviderContracts.listByService,
  "AuthorizationProvider"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationProviderContract.properties);

@@clientLocation(AuthorizationContracts.get, "Authorization");
@@clientLocation(AuthorizationContracts.createOrUpdate, "Authorization");
@@clientName(AuthorizationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AuthorizationContracts.delete, "Authorization");
@@clientLocation(AuthorizationContracts.listByAuthorizationProvider,
  "Authorization"
);
@@clientLocation(AuthorizationContracts.confirmConsentCode, "Authorization");
@@clientName(AuthorizationContracts.confirmConsentCode::parameters.body,
  "parameters"
);
@@clientLocation(AuthorizationContracts.post, "AuthorizationLoginLinks");
@@clientName(AuthorizationContracts.post::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationContract.properties);

@@clientLocation(AuthorizationAccessPolicyContracts.get,
  "AuthorizationAccessPolicy"
);
@@clientLocation(AuthorizationAccessPolicyContracts.createOrUpdate,
  "AuthorizationAccessPolicy"
);
@@clientName(AuthorizationAccessPolicyContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AuthorizationAccessPolicyContracts.delete,
  "AuthorizationAccessPolicy"
);
@@clientLocation(AuthorizationAccessPolicyContracts.listByAuthorization,
  "AuthorizationAccessPolicy"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationAccessPolicyContract.properties);

@@clientLocation(AuthorizationServerContracts.get, "AuthorizationServer");
@@clientLocation(AuthorizationServerContracts.getEntityTag,
  "AuthorizationServer"
);
@@clientLocation(AuthorizationServerContracts.createOrUpdate,
  "AuthorizationServer"
);
@@clientName(AuthorizationServerContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AuthorizationServerContracts.update, "AuthorizationServer");
@@clientName(AuthorizationServerContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(AuthorizationServerContracts.delete, "AuthorizationServer");
@@clientLocation(AuthorizationServerContracts.listByService,
  "AuthorizationServer"
);
@@clientLocation(AuthorizationServerContracts.listSecrets,
  "AuthorizationServer"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationServerContract.properties);

@@clientLocation(BackendContracts.get, "Backend");
@@clientLocation(BackendContracts.getEntityTag, "Backend");
@@clientLocation(BackendContracts.createOrUpdate, "Backend");
@@clientName(BackendContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(BackendContracts.update, "Backend");
@@clientName(BackendContracts.update::parameters.properties, "parameters");
@@clientLocation(BackendContracts.delete, "Backend");
@@clientLocation(BackendContracts.listByService, "Backend");
@@clientLocation(BackendContracts.reconnect, "Backend");
@@clientName(BackendContracts.reconnect::parameters.body, "parameters");
@@clientName(WorkspaceBackend.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceBackend.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackendContract.properties);

@@clientLocation(CacheContracts.get, "Cache");
@@clientLocation(CacheContracts.getEntityTag, "Cache");
@@clientLocation(CacheContracts.createOrUpdate, "Cache");
@@clientName(CacheContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(CacheContracts.update, "Cache");
@@clientName(CacheContracts.update::parameters.properties, "parameters");
@@clientLocation(CacheContracts.delete, "Cache");
@@clientLocation(CacheContracts.listByService, "Cache");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CacheContract.properties);

@@clientLocation(CertificateContracts.get, "Certificate");
@@clientLocation(CertificateContracts.getEntityTag, "Certificate");
@@clientLocation(CertificateContracts.createOrUpdate, "Certificate");
@@clientName(CertificateContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(CertificateContracts.delete, "Certificate");
@@clientLocation(CertificateContracts.listByService, "Certificate");
@@clientLocation(CertificateContracts.refreshSecret, "Certificate");
@@clientName(WorkspaceCertificate.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CertificateContract.properties);

@@clientLocation(ContentTypeContracts.get, "ContentType");
@@clientLocation(ContentTypeContracts.createOrUpdate, "ContentType");
@@clientName(ContentTypeContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ContentTypeContracts.delete, "ContentType");
@@clientLocation(ContentTypeContracts.listByService, "ContentType");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ContentTypeContract.properties);

@@clientLocation(ContentItemContracts.get, "ContentItem");
@@clientLocation(ContentItemContracts.getEntityTag, "ContentItem");
@@clientLocation(ContentItemContracts.createOrUpdate, "ContentItem");
@@clientName(ContentItemContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ContentItemContracts.delete, "ContentItem");
@@clientLocation(ContentItemContracts.listByService, "ContentItem");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ContentItemContract.properties);

@@clientLocation(DeletedServiceContracts.getByName, "DeletedServices");
@@clientLocation(DeletedServiceContracts.purge, "DeletedServices");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeletedServiceContract.properties);

@@clientLocation(ApiManagementServiceResources.get, "ApiManagementService");
@@clientLocation(ApiManagementServiceResources.createOrUpdate,
  "ApiManagementService"
);
@@clientName(ApiManagementServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.update, "ApiManagementService");
@@clientName(ApiManagementServiceResources.update::parameters.properties,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.delete, "ApiManagementService");
@@clientLocation(ApiManagementServiceResources.listByResourceGroup,
  "ApiManagementService"
);
@@clientLocation(ApiManagementServiceResources.list, "ApiManagementService");
@@clientLocation(ApiManagementServiceResources.listByService, "AllPolicies");
@@clientLocation(ApiManagementServiceResources.listByTags, "Api");
@@clientLocation(ApiManagementServiceResources.performConnectivityCheckAsync,
  ""
);
@@clientName(ApiManagementServiceResources.performConnectivityCheckAsync::parameters.body,
  "connectivityCheckRequestParams"
);
@@clientLocation(ApiManagementServiceResources.listAvailableServiceSkus,
  "ApiManagementServiceSkus"
);
@@clientLocation(ApiManagementServiceResources.restore, "ApiManagementService");
@@clientName(ApiManagementServiceResources.restore::parameters.body,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.backup, "ApiManagementService");
@@clientName(ApiManagementServiceResources.backup::parameters.body,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.migrateToStv2,
  "ApiManagementService"
);
@@clientName(ApiManagementServiceResources.migrateToStv2::parameters.body,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.getSsoToken,
  "ApiManagementService"
);
@@clientLocation(ApiManagementServiceResources.applyNetworkConfigurationUpdates,
  "ApiManagementService"
);
@@clientName(ApiManagementServiceResources.applyNetworkConfigurationUpdates::parameters.body,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.networkStatusListByService,
  "NetworkStatus"
);
@@clientName(ApiManagementServiceResources.networkStatusListByService,
  "ListByService"
);
@@clientLocation(ApiManagementServiceResources.listByLocation, "NetworkStatus");
@@clientLocation(ApiManagementServiceResources.outboundNetworkDependenciesEndpointsListByService,
  "OutboundNetworkDependenciesEndpoints"
);
@@clientName(ApiManagementServiceResources.outboundNetworkDependenciesEndpointsListByService,
  "ListByService"
);
@@clientLocation(ApiManagementServiceResources.policyDescriptionListByService,
  "PolicyDescription"
);
@@clientName(ApiManagementServiceResources.policyDescriptionListByService,
  "ListByService"
);
@@clientLocation(ApiManagementServiceResources.byService,
  "PolicyRestrictionValidations"
);
@@clientLocation(ApiManagementServiceResources.portalSettingsListByService,
  "PortalSettings"
);
@@clientName(ApiManagementServiceResources.portalSettingsListByService,
  "ListByService"
);
@@clientLocation(ApiManagementServiceResources.productListByTags, "Product");
@@clientName(ApiManagementServiceResources.productListByTags, "ListByTags");
@@clientLocation(ApiManagementServiceResources.quotaByCounterKeysListByService,
  "QuotaByCounterKeys"
);
@@clientName(ApiManagementServiceResources.quotaByCounterKeysListByService,
  "ListByService"
);
@@clientLocation(ApiManagementServiceResources.quotaByCounterKeysUpdate,
  "QuotaByCounterKeys"
);
@@clientName(ApiManagementServiceResources.quotaByCounterKeysUpdate, "Update");
@@clientName(ApiManagementServiceResources.quotaByCounterKeysUpdate::parameters.body,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.quotaByPeriodKeysGet,
  "QuotaByPeriodKeys"
);
@@clientName(ApiManagementServiceResources.quotaByPeriodKeysGet, "Get");
@@clientLocation(ApiManagementServiceResources.quotaByPeriodKeysUpdate,
  "QuotaByPeriodKeys"
);
@@clientName(ApiManagementServiceResources.quotaByPeriodKeysUpdate, "Update");
@@clientName(ApiManagementServiceResources.quotaByPeriodKeysUpdate::parameters.body,
  "parameters"
);
@@clientLocation(ApiManagementServiceResources.regionListByService, "Region");
@@clientName(ApiManagementServiceResources.regionListByService,
  "ListByService"
);
@@clientLocation(ApiManagementServiceResources.listByApi, "Reports");
@@clientLocation(ApiManagementServiceResources.listByUser, "Reports");
@@clientLocation(ApiManagementServiceResources.listByOperation, "Reports");
@@clientLocation(ApiManagementServiceResources.listByProduct, "Reports");
@@clientLocation(ApiManagementServiceResources.listByGeo, "Reports");
@@clientLocation(ApiManagementServiceResources.listBySubscription, "Reports");
@@clientLocation(ApiManagementServiceResources.listByTime, "Reports");
@@clientLocation(ApiManagementServiceResources.listByRequest, "Reports");
@@clientLocation(ApiManagementServiceResources.tagResourceListByService,
  "TagResource"
);
@@clientName(ApiManagementServiceResources.tagResourceListByService,
  "ListByService"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementServiceResource.properties);

@@clientLocation(DocumentationContracts.get, "Documentation");
@@clientLocation(DocumentationContracts.getEntityTag, "Documentation");
@@clientLocation(DocumentationContracts.createOrUpdate, "Documentation");
@@clientName(DocumentationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DocumentationContracts.update, "Documentation");
@@clientName(DocumentationContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(DocumentationContracts.delete, "Documentation");
@@clientLocation(DocumentationContracts.listByService, "Documentation");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DocumentationContract.properties);

@@clientLocation(EmailTemplateContracts.get, "EmailTemplate");
@@clientLocation(EmailTemplateContracts.getEntityTag, "EmailTemplate");
@@clientLocation(EmailTemplateContracts.createOrUpdate, "EmailTemplate");
@@clientName(EmailTemplateContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(EmailTemplateContracts.update, "EmailTemplate");
@@clientName(EmailTemplateContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(EmailTemplateContracts.delete, "EmailTemplate");
@@clientLocation(EmailTemplateContracts.listByService, "EmailTemplate");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EmailTemplateContract.properties);

@@clientLocation(ApiManagementGatewayConfigConnectionResources.get,
  "ApiGatewayConfigConnection"
);
@@clientLocation(ApiManagementGatewayConfigConnectionResources.createOrUpdate,
  "ApiGatewayConfigConnection"
);
@@clientName(ApiManagementGatewayConfigConnectionResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ApiManagementGatewayConfigConnectionResources.delete,
  "ApiGatewayConfigConnection"
);
@@clientLocation(ApiManagementGatewayConfigConnectionResources.listByGateway,
  "ApiGatewayConfigConnection"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementGatewayConfigConnectionResource.properties);

@@clientLocation(GatewayContracts.get, "Gateway");
@@clientLocation(GatewayContracts.getEntityTag, "Gateway");
@@clientLocation(GatewayContracts.createOrUpdate, "Gateway");
@@clientName(GatewayContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(GatewayContracts.update, "Gateway");
@@clientName(GatewayContracts.update::parameters.properties, "parameters");
@@clientLocation(GatewayContracts.delete, "Gateway");
@@clientLocation(GatewayContracts.listByService, "Gateway");
@@clientLocation(GatewayContracts.listKeys, "Gateway");
@@clientLocation(GatewayContracts.regenerateKey, "Gateway");
@@clientName(GatewayContracts.regenerateKey::parameters.body, "parameters");
@@clientLocation(GatewayContracts.generateToken, "Gateway");
@@clientName(GatewayContracts.generateToken::parameters.body, "parameters");
@@clientLocation(GatewayContracts.invalidateDebugCredentials, "Gateway");
@@clientLocation(GatewayContracts.listDebugCredentials, "Gateway");
@@clientName(GatewayContracts.listDebugCredentials::parameters.body,
  "parameters"
);
@@clientLocation(GatewayContracts.listTrace, "Gateway");
@@clientName(GatewayContracts.listTrace::parameters.body, "parameters");
@@clientLocation(GatewayContracts.gatewayApiListByService, "GatewayApi");
@@clientName(GatewayContracts.gatewayApiListByService, "ListByService");
@@clientLocation(GatewayContracts.gatewayApiGetEntityTag, "GatewayApi");
@@clientName(GatewayContracts.gatewayApiGetEntityTag, "GetEntityTag");
@@clientLocation(GatewayContracts.gatewayApiCreateOrUpdate, "GatewayApi");
@@clientName(GatewayContracts.gatewayApiCreateOrUpdate, "CreateOrUpdate");
@@clientName(GatewayContracts.gatewayApiCreateOrUpdate::parameters.body,
  "parameters"
);
@@clientLocation(GatewayContracts.gatewayApiDelete, "GatewayApi");
@@clientName(GatewayContracts.gatewayApiDelete, "Delete");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayContract.properties);

@@clientLocation(GatewayHostnameConfigurationContracts.get,
  "GatewayHostnameConfiguration"
);
@@clientLocation(GatewayHostnameConfigurationContracts.getEntityTag,
  "GatewayHostnameConfiguration"
);
@@clientLocation(GatewayHostnameConfigurationContracts.createOrUpdate,
  "GatewayHostnameConfiguration"
);
@@clientName(GatewayHostnameConfigurationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(GatewayHostnameConfigurationContracts.delete,
  "GatewayHostnameConfiguration"
);
@@clientLocation(GatewayHostnameConfigurationContracts.listByService,
  "GatewayHostnameConfiguration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayHostnameConfigurationContract.properties);

@@clientLocation(GatewayCertificateAuthorityContracts.get,
  "GatewayCertificateAuthority"
);
@@clientLocation(GatewayCertificateAuthorityContracts.getEntityTag,
  "GatewayCertificateAuthority"
);
@@clientLocation(GatewayCertificateAuthorityContracts.createOrUpdate,
  "GatewayCertificateAuthority"
);
@@clientName(GatewayCertificateAuthorityContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(GatewayCertificateAuthorityContracts.delete,
  "GatewayCertificateAuthority"
);
@@clientLocation(GatewayCertificateAuthorityContracts.listByService,
  "GatewayCertificateAuthority"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayCertificateAuthorityContract.properties);

@@clientLocation(GroupContracts.get, "Group");
@@clientLocation(GroupContracts.getEntityTag, "Group");
@@clientLocation(GroupContracts.createOrUpdate, "Group");
@@clientName(GroupContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(GroupContracts.update, "Group");
@@clientName(GroupContracts.update::parameters.properties, "parameters");
@@clientLocation(GroupContracts.delete, "Group");
@@clientLocation(GroupContracts.listByService, "Group");
@@clientLocation(GroupContracts.list, "GroupUser");
@@clientLocation(GroupContracts.checkEntityExists, "GroupUser");
@@clientLocation(GroupContracts.create, "GroupUser");
@@clientLocation(GroupContracts.groupUserDelete, "GroupUser");
@@clientName(GroupContracts.groupUserDelete, "Delete");
@@clientName(WorkspaceGroup.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceGroup.update::parameters.properties, "parameters");
@@clientLocation(WorkspaceGroup.list, "WorkspaceGroupUser");
@@clientLocation(WorkspaceGroup.checkEntityExists, "WorkspaceGroupUser");
@@clientLocation(WorkspaceGroup.create, "WorkspaceGroupUser");
@@clientLocation(WorkspaceGroup.workspaceGroupUserDelete, "WorkspaceGroupUser");
@@clientName(WorkspaceGroup.workspaceGroupUserDelete, "Delete");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GroupContract.properties);

@@clientLocation(UserContracts.get, "User");
@@clientLocation(UserContracts.getEntityTag, "User");
@@clientLocation(UserContracts.createOrUpdate, "User");
@@clientName(UserContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(UserContracts.update, "User");
@@clientName(UserContracts.update::parameters.properties, "parameters");
@@clientLocation(UserContracts.delete, "User");
@@clientLocation(UserContracts.listByService, "User");
@@clientLocation(UserContracts.generateSsoUrl, "User");
@@clientLocation(UserContracts.getSharedAccessToken, "User");
@@clientName(UserContracts.getSharedAccessToken::parameters.body, "parameters");
@@clientLocation(UserContracts.list, "UserGroup");
@@clientLocation(UserContracts.userIdentitiesList, "UserIdentities");
@@clientName(UserContracts.userIdentitiesList, "List");
@@clientLocation(UserContracts.send, "UserConfirmationPassword");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserContract.properties);

@@clientLocation(IdentityProviderContracts.get, "IdentityProvider");
@@clientLocation(IdentityProviderContracts.getEntityTag, "IdentityProvider");
@@clientLocation(IdentityProviderContracts.createOrUpdate, "IdentityProvider");
@@clientName(IdentityProviderContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(IdentityProviderContracts.update, "IdentityProvider");
@@clientName(IdentityProviderContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(IdentityProviderContracts.delete, "IdentityProvider");
@@clientLocation(IdentityProviderContracts.listByService, "IdentityProvider");
@@clientLocation(IdentityProviderContracts.listSecrets, "IdentityProvider");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IdentityProviderContract.properties);

@@clientLocation(LoggerContracts.get, "Logger");
@@clientLocation(LoggerContracts.getEntityTag, "Logger");
@@clientLocation(LoggerContracts.createOrUpdate, "Logger");
@@clientName(LoggerContracts.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(LoggerContracts.update, "Logger");
@@clientName(LoggerContracts.update::parameters.properties, "parameters");
@@clientLocation(LoggerContracts.delete, "Logger");
@@clientLocation(LoggerContracts.listByService, "Logger");
@@clientName(WorkspaceLogger.createOrUpdate::parameters.resource, "parameters");
@@clientName(WorkspaceLogger.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LoggerContract.properties);

@@clientLocation(NamedValueContracts.get, "NamedValue");
@@clientLocation(NamedValueContracts.getEntityTag, "NamedValue");
@@clientLocation(NamedValueContracts.createOrUpdate, "NamedValue");
@@clientName(NamedValueContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(NamedValueContracts.update, "NamedValue");
@@clientName(NamedValueContracts.update::parameters.properties, "parameters");
@@clientLocation(NamedValueContracts.delete, "NamedValue");
@@clientLocation(NamedValueContracts.listByService, "NamedValue");
@@clientLocation(NamedValueContracts.listValue, "NamedValue");
@@clientLocation(NamedValueContracts.refreshSecret, "NamedValue");
@@clientName(WorkspaceNamedValue.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceNamedValue.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NamedValueContract.properties);

@@clientLocation(NotificationContracts.get, "Notification");
@@clientLocation(NotificationContracts.createOrUpdate, "Notification");
@@clientLocation(NotificationContracts.listByService, "Notification");
@@clientLocation(NotificationContracts.listByNotification,
  "NotificationRecipientUser"
);
@@clientLocation(NotificationContracts.checkEntityExists,
  "NotificationRecipientUser"
);
@@clientLocation(NotificationContracts.notificationRecipientUserCreateOrUpdate,
  "NotificationRecipientUser"
);
@@clientName(NotificationContracts.notificationRecipientUserCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientLocation(NotificationContracts.delete, "NotificationRecipientUser");
@@clientLocation(NotificationContracts.notificationRecipientEmailListByNotification,
  "NotificationRecipientEmail"
);
@@clientName(NotificationContracts.notificationRecipientEmailListByNotification,
  "ListByNotification"
);
@@clientLocation(NotificationContracts.notificationRecipientEmailCheckEntityExists,
  "NotificationRecipientEmail"
);
@@clientName(NotificationContracts.notificationRecipientEmailCheckEntityExists,
  "CheckEntityExists"
);
@@clientLocation(NotificationContracts.notificationRecipientEmailCreateOrUpdate,
  "NotificationRecipientEmail"
);
@@clientName(NotificationContracts.notificationRecipientEmailCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientLocation(NotificationContracts.notificationRecipientEmailDelete,
  "NotificationRecipientEmail"
);
@@clientName(NotificationContracts.notificationRecipientEmailDelete, "Delete");
@@clientLocation(WorkspaceNotification.listByNotification,
  "WorkspaceNotificationRecipientUser"
);
@@clientLocation(WorkspaceNotification.checkEntityExists,
  "WorkspaceNotificationRecipientUser"
);
@@clientLocation(WorkspaceNotification.workspaceNotificationRecipientUserCreateOrUpdate,
  "WorkspaceNotificationRecipientUser"
);
@@clientName(WorkspaceNotification.workspaceNotificationRecipientUserCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientLocation(WorkspaceNotification.delete,
  "WorkspaceNotificationRecipientUser"
);
@@clientLocation(WorkspaceNotification.workspaceNotificationRecipientEmailListByNotification,
  "WorkspaceNotificationRecipientEmail"
);
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailListByNotification,
  "ListByNotification"
);
@@clientLocation(WorkspaceNotification.workspaceNotificationRecipientEmailCheckEntityExists,
  "WorkspaceNotificationRecipientEmail"
);
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailCheckEntityExists,
  "CheckEntityExists"
);
@@clientLocation(WorkspaceNotification.workspaceNotificationRecipientEmailCreateOrUpdate,
  "WorkspaceNotificationRecipientEmail"
);
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailCreateOrUpdate,
  "CreateOrUpdate"
);
@@clientLocation(WorkspaceNotification.workspaceNotificationRecipientEmailDelete,
  "WorkspaceNotificationRecipientEmail"
);
@@clientName(WorkspaceNotification.workspaceNotificationRecipientEmailDelete,
  "Delete"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NotificationContract.properties);

@@clientLocation(OpenidConnectProviderContracts.get, "OpenIdConnectProvider");
@@clientLocation(OpenidConnectProviderContracts.getEntityTag,
  "OpenIdConnectProvider"
);
@@clientLocation(OpenidConnectProviderContracts.createOrUpdate,
  "OpenIdConnectProvider"
);
@@clientName(OpenidConnectProviderContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(OpenidConnectProviderContracts.update,
  "OpenIdConnectProvider"
);
@@clientName(OpenidConnectProviderContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(OpenidConnectProviderContracts.delete,
  "OpenIdConnectProvider"
);
@@clientLocation(OpenidConnectProviderContracts.listByService,
  "OpenIdConnectProvider"
);
@@clientLocation(OpenidConnectProviderContracts.listSecrets,
  "OpenIdConnectProvider"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OpenidConnectProviderContract.properties);

@@clientLocation(PolicyFragmentContracts.get, "PolicyFragment");
@@clientLocation(PolicyFragmentContracts.getEntityTag, "PolicyFragment");
@@clientLocation(PolicyFragmentContracts.createOrUpdate, "PolicyFragment");
@@clientName(PolicyFragmentContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PolicyFragmentContracts.delete, "PolicyFragment");
@@clientLocation(PolicyFragmentContracts.listByService, "PolicyFragment");
@@clientLocation(PolicyFragmentContracts.listReferences, "PolicyFragment");
@@clientName(WorkspacePolicyFragment.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyFragmentContract.properties);

@@clientLocation(PolicyRestrictionContracts.get, "PolicyRestriction");
@@clientLocation(PolicyRestrictionContracts.getEntityTag, "PolicyRestriction");
@@clientLocation(PolicyRestrictionContracts.createOrUpdate,
  "PolicyRestriction"
);
@@clientName(PolicyRestrictionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PolicyRestrictionContracts.update, "PolicyRestriction");
@@clientName(PolicyRestrictionContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(PolicyRestrictionContracts.delete, "PolicyRestriction");
@@clientLocation(PolicyRestrictionContracts.listByService, "PolicyRestriction");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PolicyRestrictionContract.properties);

@@clientLocation(PortalConfigContracts.get, "PortalConfig");
@@clientLocation(PortalConfigContracts.getEntityTag, "PortalConfig");
@@clientLocation(PortalConfigContracts.createOrUpdate, "PortalConfig");
@@clientName(PortalConfigContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PortalConfigContracts.update, "PortalConfig");
@@clientName(PortalConfigContracts.update::parameters.properties, "parameters");
@@clientLocation(PortalConfigContracts.listByService, "PortalConfig");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalConfigContract.properties);

@@clientLocation(ClientApplicationContracts.get, "ClientApplication");
@@clientLocation(ClientApplicationContracts.getEntityTag, "ClientApplication");
@@clientLocation(ClientApplicationContracts.createOrUpdate,
  "ClientApplication"
);
@@clientName(ClientApplicationContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ClientApplicationContracts.delete, "ClientApplication");
@@clientLocation(ClientApplicationContracts.listByService, "ClientApplication");
@@clientLocation(ClientApplicationContracts.listSecrets, "ClientApplication");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClientApplicationContract.properties);

@@clientLocation(ClientApplicationProductLinkContracts.get,
  "ClientApplicationProductLink"
);
@@clientLocation(ClientApplicationProductLinkContracts.create,
  "ClientApplicationProductLink"
);
@@clientName(ClientApplicationProductLinkContracts.create::parameters.resource,
  "parameters"
);
@@clientLocation(ClientApplicationProductLinkContracts.delete,
  "ClientApplicationProductLink"
);
@@clientLocation(ClientApplicationProductLinkContracts.listByClientApplications,
  "ClientApplicationProductLink"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClientApplicationProductLinkContract.properties);

@@clientLocation(PortalRevisionContracts.get, "PortalRevision");
@@clientLocation(PortalRevisionContracts.getEntityTag, "PortalRevision");
@@clientLocation(PortalRevisionContracts.createOrUpdate, "PortalRevision");
@@clientName(PortalRevisionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PortalRevisionContracts.update, "PortalRevision");
@@clientName(PortalRevisionContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(PortalRevisionContracts.listByService, "PortalRevision");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalRevisionContract.properties);

@@clientName(SignInSettings.createOrUpdate::parameters.resource, "parameters");
@@clientName(SignInSettings.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalSigninSettings.properties);

@@clientName(SignUpSettings.createOrUpdate::parameters.resource, "parameters");
@@clientName(SignUpSettings.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalSignupSettings.properties);

@@clientName(DelegationSettings.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DelegationSettings.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PortalDelegationSettings.properties);

@@clientLocation(PrivateEndpointConnections.getByName,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnections.createOrUpdate,
  "PrivateEndpointConnection"
);
@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnectionRequest"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnections.listByService,
  "PrivateEndpointConnection"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(PrivateLinkResources.getPrivateLinkResource,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateLinkResources.listPrivateLinkResources,
  "PrivateEndpointConnection"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientLocation(SubscriptionContracts.get, "Subscription");
@@clientLocation(SubscriptionContracts.getEntityTag, "Subscription");
@@clientLocation(SubscriptionContracts.createOrUpdate, "Subscription");
@@clientName(SubscriptionContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(SubscriptionContracts.update, "Subscription");
@@clientName(SubscriptionContracts.update::parameters.properties, "parameters");
@@clientLocation(SubscriptionContracts.delete, "Subscription");
@@clientLocation(SubscriptionContracts.list, "Subscription");
@@clientLocation(SubscriptionContracts.regeneratePrimaryKey, "Subscription");
@@clientLocation(SubscriptionContracts.regenerateSecondaryKey, "Subscription");
@@clientLocation(SubscriptionContracts.listSecrets, "Subscription");
@@clientName(WorkspaceSubscription.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WorkspaceSubscription.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionContract.properties);

@@clientLocation(ProductApiLinkContracts.get, "ProductApiLink");
@@clientLocation(ProductApiLinkContracts.createOrUpdate, "ProductApiLink");
@@clientName(ProductApiLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ProductApiLinkContracts.delete, "ProductApiLink");
@@clientLocation(ProductApiLinkContracts.listByProduct, "ProductApiLink");
@@clientName(WorkspaceProductApiLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductApiLinkContract.properties);

@@clientLocation(ProductGroupLinkContracts.get, "ProductGroupLink");
@@clientLocation(ProductGroupLinkContracts.createOrUpdate, "ProductGroupLink");
@@clientName(ProductGroupLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ProductGroupLinkContracts.delete, "ProductGroupLink");
@@clientLocation(ProductGroupLinkContracts.listByProduct, "ProductGroupLink");
@@clientName(WorkspaceProductGroupLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductGroupLinkContract.properties);

@@clientLocation(GlobalSchemaContracts.get, "GlobalSchema");
@@clientLocation(GlobalSchemaContracts.getEntityTag, "GlobalSchema");
@@clientLocation(GlobalSchemaContracts.createOrUpdate, "GlobalSchema");
@@clientName(GlobalSchemaContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(GlobalSchemaContracts.delete, "GlobalSchema");
@@clientLocation(GlobalSchemaContracts.listByService, "GlobalSchema");
@@clientName(WorkspaceGlobalSchema.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GlobalSchemaContract.properties);

@@clientLocation(TenantSettingsContracts.get, "TenantSettings");
@@clientLocation(TenantSettingsContracts.listByService, "TenantSettings");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TenantSettingsContract.properties);

@@clientLocation(TagApiLinkContracts.get, "TagApiLink");
@@clientLocation(TagApiLinkContracts.createOrUpdate, "TagApiLink");
@@clientName(TagApiLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(TagApiLinkContracts.delete, "TagApiLink");
@@clientLocation(TagApiLinkContracts.listByProduct, "TagApiLink");
@@clientName(WorkspaceTagApiLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagApiLinkContract.properties);

@@clientLocation(TagOperationLinkContracts.get, "TagOperationLink");
@@clientLocation(TagOperationLinkContracts.createOrUpdate, "TagOperationLink");
@@clientName(TagOperationLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(TagOperationLinkContracts.delete, "TagOperationLink");
@@clientLocation(TagOperationLinkContracts.listByProduct, "TagOperationLink");
@@clientName(WorkspaceTagOperationLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagOperationLinkContract.properties);

@@clientLocation(TagProductLinkContracts.get, "TagProductLink");
@@clientLocation(TagProductLinkContracts.createOrUpdate, "TagProductLink");
@@clientName(TagProductLinkContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(TagProductLinkContracts.delete, "TagProductLink");
@@clientLocation(TagProductLinkContracts.listByProduct, "TagProductLink");
@@clientName(WorkspaceTagProductLink.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagProductLinkContract.properties);

@@clientLocation(AccessInformationContracts.get, "TenantAccess");
@@clientLocation(AccessInformationContracts.getEntityTag, "TenantAccess");
@@clientLocation(AccessInformationContracts.create, "TenantAccess");
@@clientName(AccessInformationContracts.create::parameters.resource,
  "parameters"
);
@@clientLocation(AccessInformationContracts.update, "TenantAccess");
@@clientName(AccessInformationContracts.update::parameters.properties,
  "parameters"
);
@@clientLocation(AccessInformationContracts.listByService, "TenantAccess");
@@clientLocation(AccessInformationContracts.regeneratePrimaryKey,
  "TenantAccess"
);
@@clientLocation(AccessInformationContracts.regenerateSecondaryKey,
  "TenantAccess"
);
@@clientLocation(AccessInformationContracts.listSecrets, "TenantAccess");
@@clientLocation(AccessInformationContracts.tenantAccessGitRegeneratePrimaryKey,
  "TenantAccessGit"
);
@@clientName(AccessInformationContracts.tenantAccessGitRegeneratePrimaryKey,
  "RegeneratePrimaryKey"
);
@@clientLocation(AccessInformationContracts.tenantAccessGitRegenerateSecondaryKey,
  "TenantAccessGit"
);
@@clientName(AccessInformationContracts.tenantAccessGitRegenerateSecondaryKey,
  "RegenerateSecondaryKey"
);
@@clientLocation(AccessInformationContracts.deploy, "TenantConfiguration");
@@clientName(AccessInformationContracts.deploy::parameters.body, "parameters");
@@clientLocation(AccessInformationContracts.save, "TenantConfiguration");
@@clientName(AccessInformationContracts.save::parameters.body, "parameters");
@@clientLocation(AccessInformationContracts.validate, "TenantConfiguration");
@@clientName(AccessInformationContracts.validate::parameters.body,
  "parameters"
);
@@clientLocation(AccessInformationContracts.getSyncState,
  "TenantConfiguration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccessInformationContract.properties);

@@clientLocation(ApiManagementWorkspaceLinksResources.get,
  "ApiManagementWorkspaceLink"
);
@@clientLocation(ApiManagementWorkspaceLinksResources.listByService,
  "ApiManagementWorkspaceLinks"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApiManagementWorkspaceLinksResource.properties);

@@clientLocation(WorkspaceContracts.get, "Workspace");
@@clientLocation(WorkspaceContracts.getEntityTag, "Workspace");
@@clientLocation(WorkspaceContracts.createOrUpdate, "Workspace");
@@clientName(WorkspaceContracts.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(WorkspaceContracts.update, "Workspace");
@@clientName(WorkspaceContracts.update::parameters.properties, "parameters");
@@clientLocation(WorkspaceContracts.delete, "Workspace");
@@clientLocation(WorkspaceContracts.listByService, "Workspace");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkspaceContract.properties);

@@clientLocation(ApiExportOperationGroup.get, "ApiExport");

@@clientLocation(DeletedServicesOperationGroup.listBySubscription,
  "DeletedServices"
);

@@clientLocation(ApiManagementServiceOperationGroup.checkNameAvailability,
  "ApiManagementService"
);
@@clientLocation(ApiManagementServiceOperationGroup.getDomainOwnershipIdentifier,
  "ApiManagementService"
);

@@clientLocation(ApiManagementSkusOperationGroup.list, "ApiManagementSkus");

@@clientLocation(WorkspaceApiExportOperationGroup.get, "WorkspaceApiExport");

@@clientLocation(OperationStatusOperationGroup.get, "OperationStatus");

@@clientLocation(OperationsResultsOperationGroup.get, "OperationsResults");
