import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Confluent;

@@clientName(Microsoft.Confluent, "ConfluentManagementClient", "javascript");
// Added Java Configuration to pass specs CI check.
// Need to revisit before SDK release.
@@clientName(APIKeyResourceEntity, "ApiKeyResourceEntity", "java,csharp");
@@clientName(APIKeyOwnerEntity, "ApiKeyOwnerEntity", "java,csharp");
@@clientName(CreateAPIKeyModel, "CreateApiKeyModel", "java");
@@clientName(APIKeySpecEntity, "ApiKeySpecEntity", "java,csharp");
@@clientName(APIKeyProperties, "ApiKeyProperties", "java");
@@clientName(APIKeyRecord, "ApiKeyRecord", "java");
@@clientName(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "getClusterApiKey",
  "java,csharp"
);
@@clientName(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "deleteClusterApiKey",
  "java,csharp"
);
@@clientName(SCClusterRecords.createAPIKey, "createApiKey", "java,csharp");
@@clientLocation(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "OrganizationResourceApiKeyActions",
  "java"
);
@@clientLocation(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "OrganizationResourceApiKeyActions",
  "java"
);

// hide Operations.list method in csharp clients
@@scope(Operations.list, "!csharp");
@@clientName(ProvisionState, "ConfluentProvisionState", "csharp");
@@clientName(UserDetail, "ConfluentUserDetail", "csharp");
@@clientName(OfferDetail, "ConfluentOfferDetail", "csharp");
@@clientName(SaaSOfferStatus, "ConfluentSaaSOfferStatus", "csharp");
@@clientName(APIKeyRecord, "ConfluentApiKeyRecord", "csharp");

@@clientName(OrganizationResource, "ConfluentOrganization", "csharp");
@@alternateType(OrganizationResourceProperties.organizationId, uuid, "csharp");
@@clientName(ConfluentAgreementResource, "ConfluentAgreement", "csharp");
@@clientName(ConfluentAgreementProperties.accepted, "IsAccepted", "csharp");
@@clientName(ConfluentAgreementProperties.retrieveDatetime,
  "RetrieveOn",
  "csharp"
);
@@clientName(OrganizationResourceUpdate,
  "ConfluentOrganizationPatch",
  "csharp"
);
@@clientName(ConfluentAgreementResourceListResponse,
  "ConfluentAgreementListResult",
  "csharp"
);
@@clientName(ValidationResponse,
  "ConfluentOrganizationValidationResult",
  "csharp"
);
@@clientName(CreateAPIKeyModel, "ConfluentApiKeyCreateContent", "csharp");
@@clientName(MetadataEntity.created_at, "CreatedOn", "csharp");
@@alternateType(MetadataEntity.created_at, utcDateTime, "csharp");
@@clientName(MetadataEntity.updated_at, "UpdatedOn", "csharp");
@@alternateType(MetadataEntity.updated_at, utcDateTime, "csharp");
@@clientName(MetadataEntity.deleted_at, "DeletedOn", "csharp");
@@alternateType(MetadataEntity.deleted_at, utcDateTime, "csharp");
@@clientName(SCMetadataEntity.createdTimestamp, "CreatedOn", "csharp");
@@alternateType(SCMetadataEntity.createdTimestamp, utcDateTime, "csharp");
@@clientName(SCMetadataEntity.updatedTimestamp, "UpdatedOn", "csharp");
@@alternateType(SCMetadataEntity.updatedTimestamp, utcDateTime, "csharp");
@@clientName(SCMetadataEntity.deletedTimestamp, "DeletedOn", "csharp");
@@alternateType(SCMetadataEntity.deletedTimestamp, utcDateTime, "csharp");
@@clientName(ListAccessRequestModel, "AccessListContent", "csharp");
@@clientName(AccessListClusterSuccessResponse,
  "AccessClusterListResult",
  "csharp"
);
@@clientName(ClusterRecord, "AccessClusterRecord", "csharp");
@@clientName(AccessListEnvironmentsSuccessResponse,
  "AccessEnvironmentListResult",
  "csharp"
);
@@clientName(EnvironmentRecord, "AccessEnvironmentRecord", "csharp");
@@clientName(AccessListInvitationsSuccessResponse,
  "AccessInvitationListResult",
  "csharp"
);
@@clientName(InvitationRecord, "AccessInvitationRecord", "csharp");
@@clientName(InvitationRecord.accepted_at, "AcceptedOn", "csharp");
@@alternateType(InvitationRecord.accepted_at, utcDateTime, "csharp");
@@clientName(InvitationRecord.expires_at, "ExpireOn", "csharp");
@@alternateType(InvitationRecord.expires_at, utcDateTime, "csharp");
@@clientName(ListRegionsSuccessResponse, "ConfluentRegionListResult", "csharp");
@@clientName(RegionRecord, "ConfluentRegionRecord", "csharp");
@@clientName(AccessRoleBindingNameListSuccessResponse,
  "AccessRoleBindingNameListResult",
  "csharp"
);
@@clientName(AccessListServiceAccountsSuccessResponse,
  "AccessServiceAccountListResult",
  "csharp"
);
@@clientName(ServiceAccountRecord, "AccessServiceAccountRecord", "csharp");
@@clientName(AccessCreateRoleBindingRequestModel,
  "AccessRoleBindingCreateContent",
  "csharp"
);
@@clientName(RoleBindingRecord, "AccessRoleBindingRecord", "csharp");
@@clientName(AccessInviteUserAccountModel, "AccessInvitationContent", "csharp");
@@clientName(AccessListUsersSuccessResponse, "AccessUserListResult", "csharp");
@@clientName(UserRecord, "AccessUserRecord", "csharp");
@@clientName(AccessListRoleBindingsSuccessResponse,
  "AccessRoleBindingListResult",
  "csharp"
);
@@clientName(SCClusterRecords.getClusterById, "GetCluster", "csharp");
@@clientName(SCEnvironmentRecords.getEnvironmentById,
  "GetEnvironment",
  "csharp"
);
@@clientName(SCEnvironmentRecordCluster.getSchemaRegistryClusterById,
  "GetSchemaRegistryCluster",
  "csharp"
);
@@clientName(ValidationsOperationGroup.validateOrganization,
  "ValidateOrganization",
  "csharp"
);
@@clientName(ValidationsOperationGroup.validateOrganizationV2,
  "ValidateOrganizationV2",
  "csharp"
);
@@clientName(OrganizationResources.createRoleBinding,
  "CreateAccessRoleBinding",
  "csharp"
);
@@clientName(OrganizationResourceRoleBindingIdActions.deleteRoleBinding,
  "DeleteAccessRoleBinding",
  "csharp"
);
@@clientName(OrganizationResources.listClusters, "GetAccessClusters", "csharp");
@@clientName(SCEnvironmentRecords.listEnvironments,
  "GetAccessEnvironments",
  "csharp"
);
@@clientName(OrganizationResources.listInvitations,
  "GetAccessInvitations",
  "csharp"
);
@@clientName(OrganizationResources.listRoleBindingNameList,
  "GetAccessRoleBindingNames",
  "csharp"
);
@@clientName(OrganizationResources.listServiceAccounts,
  "GetAccessServiceAccounts",
  "csharp"
);
@@clientName(OrganizationResources.listUsers, "GetAccessUsers", "csharp");
@@clientName(OrganizationResources.listRoleBindings,
  "GetAccessRoleBindings",
  "csharp"
);
@@clientName(MarketplaceAgreementsOperationGroup.create,
  "CreateMarketplaceAgreement",
  "csharp"
);
@@clientName(MarketplaceAgreementsOperationGroup.list,
  "GetMarketplaceAgreements",
  "csharp"
);
@@alternateType(OrganizationResourceProperties.ssoUrl, url, "csharp");
