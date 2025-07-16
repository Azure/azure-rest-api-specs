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
@@clientName(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "GetClusterAPIKey"
);
@@clientLocation(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "Organization"
);
@@clientName(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "DeleteClusterAPIKey"
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
@@clientName(SCClusterRecords.createAPIKey, "CreateApiKey");

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
@@clientLocation(TopicRecords.list, "Topics");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConfluentAgreementResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SchemaRegistryClusterRecord.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RegionRecord.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(APIKeyRecord.properties);

@@clientName(OrganizationResources.create::parameters.resource, "body");
@@clientName(OrganizationResources.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(OrganizationResource.properties);

@@clientName(SCEnvironmentRecords.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SCEnvironmentRecord.properties);

@@clientName(SCClusterRecords.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SCClusterRecord.properties);

@@clientName(ConnectorResources.createOrUpdate::parameters.resource, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConnectorResource.properties);

@@clientName(TopicRecords.create::parameters.resource, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TopicRecord.properties);
