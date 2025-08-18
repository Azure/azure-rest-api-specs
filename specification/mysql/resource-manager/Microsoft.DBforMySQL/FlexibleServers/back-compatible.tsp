import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforMySQL;

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BackupAndExportResponse.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ValidateBackupResponse.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConfigurationForBatchUpdate.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ServerForUpdate.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AdvancedThreatProtectionForUpdate.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(LogFile.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MaintenanceUpdate.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Provisioning.properties);

@@clientName(AzureADAdministrators.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AzureADAdministrator.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ServerBackup.properties);

@@clientName(LongRunningBackup.create::parameters.resource, "parameters");
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ServerBackupV2.properties);

@@clientName(Configurations.createOrUpdate::parameters.resource, "parameters");
@@clientName(Configurations.update::parameters.properties, "parameters");
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Configuration.properties);

@@clientName(Databases.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Database.properties);

@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FirewallRule.properties);

@@clientName(Servers.create::parameters.resource, "parameters");
@@clientName(Servers.update::parameters.properties, "parameters");
@@clientName(BackupAndExport.create::parameters.body, "parameters");
@@clientName(Configurations.batchUpdate::parameters.body, "parameters");
@@clientName(Servers.validateEstimateHighAvailability::parameters.body,
  "parameters"
);
@@clientName(Servers.restart::parameters.body, "parameters");
@@clientName(Servers.resetGtid::parameters.body, "parameters");
@@clientName(Servers.detachVNet::parameters.body, "parameters");
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Server.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(AdvancedThreatProtectionSettings.updatePut::parameters.resource,
  "parameters"
);
@@clientName(AdvancedThreatProtectionSettings.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AdvancedThreatProtection.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Capability.properties);

@@clientName(Maintenances.update::parameters.properties, "parameters");
#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Maintenance.properties);

#suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
