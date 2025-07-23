import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforMySQL;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupAndExportResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ValidateBackupResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigurationForBatchUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerForUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdvancedThreatProtectionForUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LogFile.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MaintenanceUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Provisioning.properties);

@@clientName(AzureADAdministrators.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureADAdministrator.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerBackup.properties);

@@clientName(ServerBackupV2s.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerBackupV2.properties);

@@clientName(Configurations.createOrUpdate::parameters.resource, "parameters");
@@clientName(Configurations.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Configuration.properties);

@@clientName(Databases.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Database.properties);

@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallRule.properties);

@@clientName(Servers.create::parameters.resource, "parameters");
@@clientName(Servers.update::parameters.properties, "parameters");
@@clientName(Servers.backupAndExportCreate::parameters.body, "parameters");
@@clientName(Configurations.batchUpdate::parameters.body, "parameters");
@@clientName(Servers.validateEstimateHighAvailability::parameters.body,
  "parameters"
);
@@clientName(Servers.restart::parameters.body, "parameters");
@@clientName(Servers.resetGtid::parameters.body, "parameters");
@@clientName(Servers.detachVNet::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Server.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(AdvancedThreatProtectionSettings.updatePut::parameters.resource,
  "parameters"
);
@@clientName(AdvancedThreatProtectionSettings.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdvancedThreatProtection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Capability.properties);

@@clientName(Maintenances.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Maintenance.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(CheckNameAvailabilityWithoutLocation.execute::parameters.body,
  "nameAvailabilityRequest"
);

@@clientName(CheckVirtualNetworkSubnetUsage.execute::parameters.body,
  "parameters"
);

@@clientName(CheckNameAvailability.execute::parameters.body,
  "nameAvailabilityRequest"
);
