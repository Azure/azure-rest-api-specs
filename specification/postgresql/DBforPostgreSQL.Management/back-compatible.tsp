import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforPostgreSQL;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AdministratorMicrosoftEntraAdd.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CapturedLog.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConfigurationForUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(LtrPreBackupResponse.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BackupsLongTermRetentionResponse.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MigrationResourceForPatch.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServerForPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ObjectRecommendation.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualEndpointResourceForPatch.properties
);

@@clientLocation(AdministratorMicrosoftEntras.get,
  "AdministratorsMicrosoftEntra"
);
@@clientLocation(AdministratorMicrosoftEntras.createOrUpdate,
  "AdministratorsMicrosoftEntra"
);
@@clientName(AdministratorMicrosoftEntras.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AdministratorMicrosoftEntras.delete,
  "AdministratorsMicrosoftEntra"
);
@@clientLocation(AdministratorMicrosoftEntras.listByServer,
  "AdministratorsMicrosoftEntra"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AdministratorMicrosoftEntra.properties
);

@@clientLocation(AdvancedThreatProtectionSettingsModels.get,
  "AdvancedThreatProtectionSettings"
);
@@clientLocation(AdvancedThreatProtectionSettingsModels.createOrUpdate,
  "ServerThreatProtectionSettings"
);
@@clientName(AdvancedThreatProtectionSettingsModels.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AdvancedThreatProtectionSettingsModels.listByServer,
  "AdvancedThreatProtectionSettings"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AdvancedThreatProtectionSettingsModel.properties
);

@@clientLocation(BackupAutomaticAndOnDemands.get,
  "BackupsAutomaticAndOnDemand"
);
@@clientLocation(BackupAutomaticAndOnDemands.create,
  "BackupsAutomaticAndOnDemand"
);
@@clientLocation(BackupAutomaticAndOnDemands.delete,
  "BackupsAutomaticAndOnDemand"
);
@@clientLocation(BackupAutomaticAndOnDemands.listByServer,
  "BackupsAutomaticAndOnDemand"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BackupAutomaticAndOnDemand.properties
);

@@clientName(Configurations.put::parameters.resource, "parameters");
@@clientName(Configurations.update::parameters.properties, "parameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Configuration.properties);

@@clientName(Databases.create::parameters.resource, "parameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Database.properties);

@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FirewallRule.properties);

@@clientLocation(BackupsLongTermRetentionOperations.get,
  "BackupsLongTermRetention"
);
@@clientLocation(BackupsLongTermRetentionOperations.listByServer,
  "BackupsLongTermRetention"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BackupsLongTermRetentionOperation.properties
);

@@clientName(Migrations.create::parameters.resource, "parameters");
@@clientName(Migrations.update::parameters.properties, "parameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Migration.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "parameters"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientName(Servers.createOrUpdate::parameters.resource, "parameters");
@@clientName(Servers.update::parameters.properties, "parameters");
@@clientLocation(Servers.list, "CapabilitiesByServer");
@@clientLocation(Servers.listByServer, "CapturedLogs");
@@clientLocation(Servers.checkPrerequisites, "BackupsLongTermRetention");
@@clientName(Servers.checkPrerequisites::parameters.body, "parameters");
@@clientLocation(Servers.start, "BackupsLongTermRetention");
@@clientName(Servers.start::parameters.body, "parameters");
@@clientLocation(Servers.checkNameAvailability, Migrations);
@@clientName(Servers.checkNameAvailability::parameters.body, "parameters");
@@clientLocation(Servers.replicasListByServer, "Replicas");
@@clientName(Servers.replicasListByServer, "ListByServer");
@@clientName(Servers.restart::parameters.body, "parameters");
@@clientName(Servers.serversStart, "Start");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Server.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualEndpoint.properties);

@@clientLocation(TuningOptionsOperationGroup.get, "TuningOptions");
@@clientLocation(TuningOptionsOperationGroup.listByServer, "TuningOptions");
@@clientLocation(TuningOptionsOperationGroup.listRecommendations,
  "TuningOptions"
);

@@clientName(VirtualEndpoints.create::parameters.resource, "parameters");
@@clientName(VirtualEndpoints.update::parameters.properties, "parameters");

@@clientLocation(CapabilitiesByLocationOperationGroup.list,
  "CapabilitiesByLocation"
);

@@clientLocation(NameAvailabilityOperationGroup.checkGlobally,
  "NameAvailability"
);
@@clientLocation(NameAvailabilityOperationGroup.checkWithLocation,
  "NameAvailability"
);

@@clientLocation(PrivateDnsZoneSuffixOperationGroup.get,
  "PrivateDnsZoneSuffix"
);

@@clientLocation(QuotaUsagesOperationGroup.list, "QuotaUsages");

@@clientLocation(VirtualNetworkSubnetUsageOperationGroup.list,
  "VirtualNetworkSubnetUsage"
);
@@clientName(NameAvailabilityOperationGroup.checkGlobally::parameters.body,
  "parameters"
);
@@clientName(NameAvailabilityOperationGroup.checkWithLocation::parameters.body,
  "parameters"
);
@@clientName(VirtualNetworkSubnetUsageOperationGroup.list::parameters.body,
  "parameters"
);
