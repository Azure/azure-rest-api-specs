import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Confluent;

// @@clientLocation decorators for @operationId operations
// Operations interface
@@clientLocation(Operations.list, "OrganizationOperations");

// OrganizationResourceAPIKeyActions interface
@@clientLocation(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "Organization"
);
@@clientLocation(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "Organization"
);

// OrganizationResourceRoleBindingIdActions interface
@@clientLocation(OrganizationResourceRoleBindingIdActions.deleteRoleBinding,
  "Access"
);

// OrganizationResources interface
@@clientLocation(OrganizationResources.get, "Organization");
@@clientLocation(OrganizationResources.create, "Organization");
@@clientLocation(OrganizationResources.update, "Organization");
@@clientLocation(OrganizationResources.delete, "Organization");
@@clientLocation(OrganizationResources.listByResourceGroup, "Organization");
@@clientLocation(OrganizationResources.listBySubscription, "Organization");
@@clientLocation(OrganizationResources.listRegions, "Organization");
@@clientLocation(OrganizationResources.listUsers, "Access");
@@clientLocation(OrganizationResources.listServiceAccounts, "Access");
@@clientLocation(OrganizationResources.listInvitations, "Access");
@@clientLocation(OrganizationResources.inviteUser, "Access");
@@clientLocation(OrganizationResources.listEnvironments, "Access");
@@clientLocation(OrganizationResources.listClusters, "Access");
@@clientLocation(OrganizationResources.listRoleBindings, "Access");
@@clientLocation(OrganizationResources.createRoleBinding, "Access");
@@clientLocation(OrganizationResources.listRoleBindingNameList, "Access");

// ConnectorResources interface
@@clientLocation(ConnectorResources.get, "Connector");
@@clientLocation(ConnectorResources.createOrUpdate, "Connector");
@@clientLocation(ConnectorResources.delete, "Connector");
@@clientLocation(ConnectorResources.list, "Connector");

// MarketplaceAgreementsOperationGroup interface
@@clientLocation(MarketplaceAgreementsOperationGroup.list,
  "MarketplaceAgreements"
);
@@clientLocation(MarketplaceAgreementsOperationGroup.create,
  "MarketplaceAgreements"
);

// ValidationsOperationGroup interface
@@clientLocation(ValidationsOperationGroup.validateOrganization, "Validations");
@@clientLocation(ValidationsOperationGroup.validateOrganizationV2,
  "Validations"
);

// SCClusterRecords interface
@@clientLocation(SCClusterRecords.getClusterById, "Organization");
@@clientLocation(SCClusterRecords.createOrUpdate, "Cluster");
@@clientLocation(SCClusterRecords.delete, "Cluster");
@@clientLocation(SCClusterRecords.listClusters, "Organization");
@@clientLocation(SCClusterRecords.createAPIKey, "Organization");

// SCEnvironmentRecords interface
@@clientLocation(SCEnvironmentRecords.getEnvironmentById, "Organization");
@@clientLocation(SCEnvironmentRecords.createOrUpdate, "Environment");
@@clientLocation(SCEnvironmentRecords.delete, "Environment");
@@clientLocation(SCEnvironmentRecords.listEnvironments, "Organization");
@@clientLocation(SCEnvironmentRecords.listSchemaRegistryClusters,
  "Organization"
);

// SCEnvironmentRecordCluster interface
@@clientLocation(SCEnvironmentRecordCluster.getSchemaRegistryClusterById,
  "Organization"
);

// TopicRecords interface
@@clientLocation(TopicRecords.get, "Topics");
@@clientLocation(TopicRecords.create, "Topics");
@@clientLocation(TopicRecords.delete, "Topics");
// TopicRecords interface
@@clientLocation(TopicRecords.get, "Topics");
@@clientLocation(TopicRecords.create, "Topics");
@@clientLocation(TopicRecords.delete, "Topics");
@@clientLocation(TopicRecords.list, "Topics");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfluentAgreementResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SchemaRegistryClusterRecord.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegionRecord.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(APIKeyRecord.properties);

@@clientName(OrganizationResources.create::parameters.resource, "body");
@@clientName(OrganizationResources.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OrganizationResource.properties);

@@clientName(SCEnvironmentRecords.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SCEnvironmentRecord.properties);

@@clientName(SCClusterRecords.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SCClusterRecord.properties);

@@clientName(ConnectorResources.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectorResource.properties);

@@clientName(TopicRecords.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopicRecord.properties);
