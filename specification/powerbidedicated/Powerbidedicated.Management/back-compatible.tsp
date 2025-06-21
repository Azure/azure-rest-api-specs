import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PowerBIDedicated;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DedicatedCapacityUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AutoScaleVCoreUpdateParameters.properties);

@@clientName(Capacities.create::parameters.resource, "capacityParameters");
@@clientName(Capacities.update::parameters.properties,
  "capacityUpdateParameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DedicatedCapacity.properties);

@@clientName(AutoScaleVCores.create::parameters.resource, "vCoreParameters");
@@clientName(AutoScaleVCores.update::parameters.properties,
  "vCoreUpdateParameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AutoScaleVCore.properties);

@@clientName(CapacitiesOperationGroup.checkNameAvailability::parameters.body,
  "capacityParameters"
);

// @@clientLocation decorators for @operationId operations
@@clientLocation(CapacitiesOperationGroup.listSkus, Capacities);
@@clientLocation(CapacitiesOperationGroup.checkNameAvailability, Capacities);
