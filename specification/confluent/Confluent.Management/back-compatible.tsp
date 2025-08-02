import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Confluent;

// @@clientLocation decorators for @operationId operations
// Operations interface
@@clientLocation(Operations.list, "OrganizationOperations", "!csharp");

// OrganizationResourceAPIKeyActions interface
@@clientLocation(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "Organization",
  "!csharp"
);
@@clientName(OrganizationResourceAPIKeyActions.getClusterAPIKey,
  "GetClusterAPIKey"
);
@@clientLocation(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "Organization",
  "!csharp"
);
@@clientName(OrganizationResourceAPIKeyActions.deleteClusterAPIKey,
  "DeleteClusterAPIKey"
);
// OrganizationResourceRoleBindingIdActions interface
@@clientLocation(OrganizationResourceRoleBindingIdActions.deleteRoleBinding,
  "Access",
  "!csharp"
);

// OrganizationResources interface
@@clientLocation(OrganizationResources.get, "Organization", "!csharp");
@@clientLocation(OrganizationResources.create, "Organization", "!csharp");
@@clientLocation(OrganizationResources.update, "Organization", "!csharp");
@@clientLocation(OrganizationResources.delete, "Organization", "!csharp");
@@clientLocation(OrganizationResources.listByResourceGroup,
  "Organization",
  "!csharp"
);
@@clientLocation(OrganizationResources.listBySubscription,
  "Organization",
  "!csharp"
);
@@clientLocation(OrganizationResources.listRegions, "Organization", "!csharp");
@@clientLocation(OrganizationResources.listUsers, "Access", "!csharp");
@@clientLocation(OrganizationResources.listServiceAccounts,
  "Access",
  "!csharp"
);
@@clientLocation(OrganizationResources.listInvitations, "Access", "!csharp");
@@clientLocation(OrganizationResources.inviteUser, "Access", "!csharp");
@@clientLocation(OrganizationResources.listEnvironments, "Access", "!csharp");
@@clientLocation(OrganizationResources.listClusters, "Access", "!csharp");
@@clientLocation(OrganizationResources.listRoleBindings, "Access", "!csharp");
@@clientLocation(OrganizationResources.createRoleBinding, "Access", "!csharp");
@@clientLocation(OrganizationResources.listRoleBindingNameList,
  "Access",
  "!csharp"
);

// ConnectorResources interface
@@clientLocation(ConnectorResources.get, "Connector", "!csharp");
@@clientLocation(ConnectorResources.createOrUpdate, "Connector", "!csharp");
@@clientLocation(ConnectorResources.delete, "Connector", "!csharp");
@@clientLocation(ConnectorResources.list, "Connector", "!csharp");

// MarketplaceAgreementsOperationGroup interface
@@clientLocation(MarketplaceAgreementsOperationGroup.list,
  "MarketplaceAgreements",
  "!csharp"
);
@@clientLocation(MarketplaceAgreementsOperationGroup.create,
  "MarketplaceAgreements",
  "!csharp"
);

// ValidationsOperationGroup interface
@@clientLocation(ValidationsOperationGroup.validateOrganization,
  "Validations",
  "!csharp"
);
@@clientLocation(ValidationsOperationGroup.validateOrganizationV2,
  "Validations",
  "!csharp"
);

// SCClusterRecords interface
@@clientLocation(SCClusterRecords.getClusterById, "Organization", "!csharp");
@@clientLocation(SCClusterRecords.createOrUpdate, "Cluster", "!csharp");
@@clientLocation(SCClusterRecords.delete, "Cluster", "!csharp");
@@clientLocation(SCClusterRecords.listClusters, "Organization", "!csharp");
@@clientLocation(SCClusterRecords.createAPIKey, "Organization", "!csharp");
@@clientName(SCClusterRecords.createAPIKey, "CreateApiKey");

// SCEnvironmentRecords interface
@@clientLocation(SCEnvironmentRecords.getEnvironmentById,
  "Organization",
  "!csharp"
);
@@clientLocation(SCEnvironmentRecords.createOrUpdate, "Environment", "!csharp");
@@clientLocation(SCEnvironmentRecords.delete, "Environment", "!csharp");
@@clientLocation(SCEnvironmentRecords.listEnvironments,
  "Organization",
  "!csharp"
);
@@clientLocation(SCEnvironmentRecords.listSchemaRegistryClusters,
  "Organization",
  "!csharp"
);

// SCEnvironmentRecordCluster interface
@@clientLocation(SCEnvironmentRecordCluster.getSchemaRegistryClusterById,
  "Organization",
  "!csharp"
);

// TopicRecords interface
@@clientLocation(TopicRecords.get, "Topics", "!csharp");
@@clientLocation(TopicRecords.create, "Topics", "!csharp");
@@clientLocation(TopicRecords.delete, "Topics", "!csharp");
@@clientLocation(TopicRecords.list, "Topics", "!csharp");

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
