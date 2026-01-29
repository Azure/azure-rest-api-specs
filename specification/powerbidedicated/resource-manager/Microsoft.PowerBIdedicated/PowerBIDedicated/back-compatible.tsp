import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PowerBIDedicated;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DedicatedCapacityUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AutoScaleVCoreUpdateParameters.properties
);

@@clientName(Capacities.create::parameters.resource, "capacityParameters");
@@clientName(Capacities.update::parameters.properties,
  "capacityUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DedicatedCapacity.properties
);

@@clientName(AutoScaleVCores.create::parameters.resource, "vCoreParameters");
@@clientName(AutoScaleVCores.update::parameters.properties,
  "vCoreUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AutoScaleVCore.properties);

@@clientName(CapacitiesOperationGroup.checkNameAvailability::parameters.body,
  "capacityParameters"
);

// @@clientLocation decorators for @operationId operations
@@clientLocation(CapacitiesOperationGroup.listSkus, Capacities);
@@clientLocation(CapacitiesOperationGroup.checkNameAvailability, Capacities);
