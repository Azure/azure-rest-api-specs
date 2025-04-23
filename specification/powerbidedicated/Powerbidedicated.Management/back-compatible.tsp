import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PowerBIDedicated;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedCapacityUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AutoScaleVCoreUpdateParameters.properties);

@@clientName(Capacities.create::parameters.resource, "capacityParameters");
@@clientName(Capacities.update::parameters.properties,
  "capacityUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedCapacity.properties);

@@clientName(AutoScaleVCores.create::parameters.resource, "vCoreParameters");
@@clientName(AutoScaleVCores.update::parameters.properties,
  "vCoreUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AutoScaleVCore.properties);
