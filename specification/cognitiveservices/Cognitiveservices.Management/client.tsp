import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CognitiveServices;

@@clientName(Accounts.create::parameters.resource, "account");
@@clientName(Accounts.update::parameters.properties, "account");
@@clientName(Accounts.regenerateKey::parameters.body, "parameters");
@@clientName(Projects.create::parameters.resource, "project");
@@clientName(Projects.update::parameters.properties, "project");

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(Deployments.createOrUpdate::parameters.resource, "deployment");
@@clientName(Deployments.update::parameters.properties, "deployment");

@@clientName(CommitmentPlans.createOrUpdate::parameters.resource,
  "commitmentPlan"
);
@@clientName(CommitmentPlanOperationGroup.createOrUpdatePlan::parameters.resource,
  "commitmentPlan"
);
@@clientName(CommitmentPlanOperationGroup.updatePlan::parameters.properties,
  "commitmentPlan"
);

@@clientName(EncryptionScopes.createOrUpdate::parameters.resource,
  "encryptionScope"
);

@@clientName(RaiPolicies.createOrUpdate::parameters.resource, "raiPolicy");

@@clientName(RaiBlocklists.createOrUpdate::parameters.resource, "raiBlocklist");
@@clientName(RaiBlocklists.batchAdd::parameters.body, "raiBlocklistItems");
@@clientName(RaiBlocklists.batchDelete::parameters.body,
  "raiBlocklistItemsNames"
);

@@clientName(RaiBlocklistItems.createOrUpdate::parameters.resource,
  "raiBlocklistItem"
);

@@clientName(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "association"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommitmentPlanAccountAssociation.properties);

@@clientName(DefenderForAISettings.createOrUpdate::parameters.resource,
  "defenderForAISettings"
);
@@clientName(DefenderForAISettings.update::parameters.properties,
  "defenderForAISettings"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DefenderForAISetting.properties);

@@clientName(ConnectionPropertiesV2BasicResources.create::parameters.resource,
  "body"
);
@@clientName(ConnectionPropertiesV2BasicResources.update::parameters.properties,
  "body"
);
@@clientName(ProjectConnection.create::parameters.resource, "body");
@@clientName(ProjectConnection.update::parameters.properties, "body");

@@clientName(CapabilityHosts.createOrUpdate::parameters.resource, "body");
@@clientName(ProjectCapabilityHosts.createOrUpdate::parameters.resource,
  "body"
);
