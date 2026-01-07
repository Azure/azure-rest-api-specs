import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Maintenance;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MaintenanceConfigurationProperties.maintenanceWindow
);

//@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Update.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@clientName(MaintenanceConfigurationOperationGroup.createOrUpdate::parameters.resource,
  "configuration"
);
@@clientName(MaintenanceConfigurationOperationGroup.update::parameters.properties,
  "configuration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MaintenanceConfiguration.properties
);

@@clientName(ApplyUpdateOperationGroup.createOrUpdateOrCancel::parameters.resource,
  "applyUpdate"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplyUpdate.properties);

@@clientName(ConfigurationAssignments.createOrUpdateParent::parameters.resource,
  "configurationAssignment"
);
@@clientName(ConfigurationAssignmentOperationGroup.createOrUpdate::parameters.resource,
  "configurationAssignment"
);
@@clientName(ConfigurationAssignmentsForSubscriptions.createOrUpdate::parameters.resource,
  "configurationAssignment"
);
@@clientName(ConfigurationAssignmentsForSubscriptions.update::parameters.properties,
  "configurationAssignment"
);
@@clientName(ConfigurationAssignmentsForResourceGroup.createOrUpdate::parameters.resource,
  "configurationAssignment"
);
@@clientName(ConfigurationAssignmentsForResourceGroup.update::parameters.properties,
  "configurationAssignment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConfigurationAssignment.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.Maintenance.Update.properties
);

// @@clientLocation decorators for operations with @operationId
@@clientLocation(MaintenanceConfigurations.get,
  "PublicMaintenanceConfigurations"
);
@@clientLocation(MaintenanceConfigurations.list,
  "PublicMaintenanceConfigurations"
);
@@clientLocation(MaintenanceConfigurationOperationGroup.get,
  MaintenanceConfigurations
);
@@clientLocation(MaintenanceConfigurationOperationGroup.createOrUpdate,
  MaintenanceConfigurations
);
@@clientLocation(MaintenanceConfigurationOperationGroup.update,
  MaintenanceConfigurations
);
@@clientLocation(MaintenanceConfigurationOperationGroup.delete,
  MaintenanceConfigurations
);
@@clientLocation(MaintenanceConfigurationOperationGroup.list,
  "MaintenanceConfigurationsForResourceGroup"
);
@@clientLocation(MaintenanceConfigurationOperationGroup.maintenanceConfigurationsList,
  MaintenanceConfigurations
);
@@clientName(MaintenanceConfigurationOperationGroup.maintenanceConfigurationsList,
  "List"
);
@@clientLocation(ApplyUpdateOperationGroup.get, ApplyUpdates);
@@clientLocation(ApplyUpdateOperationGroup.createOrUpdateOrCancel,
  ApplyUpdates
);
@@clientLocation(ApplyUpdateOperationGroup.list, ApplyUpdates);
@@clientLocation(ConfigurationAssignmentOperationGroup.get,
  ConfigurationAssignments
);
@@clientLocation(ConfigurationAssignmentOperationGroup.createOrUpdate,
  ConfigurationAssignments
);
@@clientLocation(ConfigurationAssignmentOperationGroup.delete,
  ConfigurationAssignments
);
@@clientLocation(ConfigurationAssignmentsForSubscriptions.list,
  "ConfigurationAssignmentsWithinSubscription"
);
@@clientLocation(ScheduledEventOperationGroup.acknowledge, "ScheduledEvent");
@@clientLocation(ApplyUpdatesOperationGroup.createOrUpdateParent, ApplyUpdates);
@@clientLocation(ApplyUpdatesOperationGroup.createOrUpdate, ApplyUpdates);
@@clientLocation(ApplyUpdateForResourceGroupOperationGroup.list,
  "ApplyUpdateForResourceGroup"
);
@@clientLocation(ConfigurationAssignmentForResourceGroupOperationGroup.list,
  ConfigurationAssignments
);
@@clientLocation(UpdatesOperationGroup.listParent, "Updates");
@@clientLocation(UpdatesOperationGroup.list, "Updates");
