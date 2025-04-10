import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforPostgreSQL;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ActiveDirectoryAdministratorAdd.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigurationForUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerForUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LtrPreBackupResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LtrBackupResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MigrationResourceForPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LogFile.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IndexRecommendationResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualEndpointResourceForPatch.properties);

@@clientName(ActiveDirectoryAdministrators.create::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ActiveDirectoryAdministrator.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerBackup.properties);

@@clientName(Configurations.put::parameters.resource, "parameters");
@@clientName(Configurations.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Configuration.properties);

@@clientName(Databases.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Database.properties);

@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallRule.properties);

@@clientName(Servers.create::parameters.resource, "parameters");
@@clientName(Servers.update::parameters.properties, "parameters");
@@clientName(Servers.triggerLtrPreBackup::parameters.body, "parameters");
@@clientName(Servers.startLtrBackup::parameters.body, "parameters");
@@clientName(Servers.checkMigrationNameAvailability::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Server.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LtrServerBackupOperation.properties);

@@clientName(MigrationResources.create::parameters.resource, "parameters");
@@clientName(MigrationResources.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MigrationResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(ServerThreatProtectionSettingsModels.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerThreatProtectionSettingsModel.properties);

@@clientName(VirtualEndpointResources.create::parameters.resource,
  "parameters"
);
@@clientName(VirtualEndpointResources.update::parameters.properties,
  "parameters"
);
