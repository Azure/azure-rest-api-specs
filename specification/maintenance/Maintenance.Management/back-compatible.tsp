import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Maintenance;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MaintenanceConfigurationProperties.maintenanceWindow);

//@@flattenProperty(Update.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@clientName(MaintenanceConfigurationOperationGroup.createOrUpdate::parameters.resource,
  "configuration"
);
@@clientName(MaintenanceConfigurationOperationGroup.update::parameters.properties,
  "configuration"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MaintenanceConfiguration.properties);

@@clientName(ApplyUpdateOperationGroup.createOrUpdateOrCancel::parameters.resource,
  "applyUpdate"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ApplyUpdate.properties);

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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConfigurationAssignment.properties);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Microsoft.Maintenance.Update.properties);
