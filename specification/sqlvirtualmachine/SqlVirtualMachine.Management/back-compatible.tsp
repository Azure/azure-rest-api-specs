import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SqlVirtualMachine;

// @@clientLocation decorators for @operationId operations
@@clientLocation(SqlVirtualMachineGroups.listBySqlVmGroup, SqlVirtualMachines);
@@clientLocation(SqlVirtualMachines.fetchDCAssessment, SqlVirtualMachines);
@@clientLocation(SqlVirtualMachines.troubleshoot,
  "SqlVirtualMachineTroubleshoot"
);

@@clientName(AvailabilityGroupListeners.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AvailabilityGroupListener.properties);

@@clientName(SqlVirtualMachineGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SqlVirtualMachineGroups.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SqlVirtualMachineGroup.properties);

@@clientName(SqlVirtualMachines.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SqlVirtualMachines.update::parameters.properties, "parameters");
@@clientName(SqlVirtualMachines.fetchDCAssessment::parameters.body,
  "parameters"
);
@@clientName(SqlVirtualMachines.troubleshoot::parameters.body, "parameters");
@@clientName(Operation, "Info", "csharp");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SqlVirtualMachine.properties);
