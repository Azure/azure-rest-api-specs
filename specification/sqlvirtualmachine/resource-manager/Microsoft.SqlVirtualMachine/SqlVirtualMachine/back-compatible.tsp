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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvailabilityGroupListener.properties
);

@@clientName(SqlVirtualMachineGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SqlVirtualMachineGroups.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SqlVirtualMachineGroup.properties
);

@@clientName(SqlVirtualMachines.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SqlVirtualMachines.update::parameters.properties, "parameters");
@@clientName(SqlVirtualMachines.fetchDCAssessment::parameters.body,
  "parameters"
);
@@clientName(SqlVirtualMachines.troubleshoot::parameters.body, "parameters");
@@clientName(Operation, "Info", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SqlVirtualMachine.properties
);
