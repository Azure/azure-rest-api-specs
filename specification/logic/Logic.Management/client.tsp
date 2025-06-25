import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Logic;

@@clientName(WorkflowTriggerListCallbackUrlQueries.`api-version`, "apiVersion");

@@clientName(PartnerContent.b2b, "b2B");

@@clientName(ApiResourceMetadata.apiType, "apiType");

@@clientName(WsdlService.endpointQualifiedNames, "endpointQualifiedNames");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SwaggerSchema.properties);

@@clientName(SwaggerCustomDynamicTreeSettings.canSelectParentNodes,
  "canSelectParentNodes"
);
@@clientName(SwaggerCustomDynamicTreeSettings.canSelectLeafNodes,
  "canSelectLeafNodes"
);

@@clientName(Workflows.createOrUpdate::parameters.resource, "workflow");
@@clientName(Workflows.generateUpgradedDefinition::parameters.body,
  "parameters"
);
@@clientName(Workflows.listCallbackUrl::parameters.body, "listCallbackUrl");
@@clientName(Workflows.move::parameters.body, "move");
@@clientName(Workflows.regenerateAccessKey::parameters.body, "keyType");
@@clientName(Workflows.validateByResourceGroup::parameters.body, "validate");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Workflow.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowVersion.properties);

@@clientName(WorkflowTriggers.setState::parameters.body, "setState");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowTrigger.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowTriggerHistory.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowRun.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowRunAction.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkflowRunActionRepetitionDefinition.properties);

@@clientName(IntegrationAccounts.createOrUpdate::parameters.resource,
  "integrationAccount"
);
@@clientName(IntegrationAccounts.update::parameters.properties,
  "integrationAccount"
);
@@clientName(IntegrationAccounts.listCallbackUrl::parameters.body,
  "parameters"
);
@@clientName(IntegrationAccounts.listKeyVaultKeys::parameters.body,
  "listKeyVaultKeys"
);
@@clientName(IntegrationAccounts.logTrackingEvents::parameters.body,
  "logTrackingEvents"
);
@@clientName(IntegrationAccounts.regenerateAccessKey::parameters.body,
  "regenerateAccessKey"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationAccount.properties);

@@clientName(AssemblyDefinitions.createOrUpdate::parameters.resource,
  "assemblyArtifact"
);

@@clientName(BatchConfigurations.createOrUpdate::parameters.resource,
  "batchConfiguration"
);

@@clientName(IntegrationAccountSchemas.createOrUpdate::parameters.resource,
  "schema"
);
@@clientName(IntegrationAccountSchemas.listContentCallbackUrl::parameters.body,
  "listContentCallbackUrl"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationAccountSchema.properties);

@@clientName(IntegrationAccountMaps.createOrUpdate::parameters.resource, "map");
@@clientName(IntegrationAccountMaps.listContentCallbackUrl::parameters.body,
  "listContentCallbackUrl"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationAccountMap.properties);

@@clientName(IntegrationAccountPartners.createOrUpdate::parameters.resource,
  "partner"
);
@@clientName(IntegrationAccountPartners.listContentCallbackUrl::parameters.body,
  "listContentCallbackUrl"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationAccountPartner.properties);

@@clientName(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "agreement"
);
@@clientName(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body,
  "listContentCallbackUrl"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationAccountAgreement.properties);

@@clientName(IntegrationAccountCertificates.createOrUpdate::parameters.resource,
  "certificate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationAccountCertificate.properties);

@@clientName(IntegrationAccountSessions.createOrUpdate::parameters.resource,
  "session"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationAccountSession.properties);

@@clientName(IntegrationServiceEnvironments.createOrUpdate::parameters.resource,
  "integrationServiceEnvironment"
);
@@clientName(IntegrationServiceEnvironments.update::parameters.properties,
  "integrationServiceEnvironment"
);

@@clientName(IntegrationServiceEnvironmentManagedApis.put::parameters.resource,
  "integrationServiceEnvironmentManagedApi"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IntegrationServiceEnvironmentManagedApi.properties);
