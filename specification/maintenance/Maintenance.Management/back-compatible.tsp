import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Maintenance;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MaintenanceConfigurationProperties.maintenanceWindow);

//@@flattenProperty(Update.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@clientName(MaintenanceConfigurationOperationGroup.createOrUpdate::parameters.resource,
  "configuration"
);
@@clientName(MaintenanceConfigurationOperationGroup.update::parameters.properties,
  "configuration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MaintenanceConfiguration.properties);

@@clientName(ApplyUpdateOperationGroup.createOrUpdateOrCancel::parameters.resource,
  "applyUpdate"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigurationAssignment.properties);
