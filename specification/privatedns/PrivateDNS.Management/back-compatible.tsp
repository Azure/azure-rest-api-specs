import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(PrivateZones.createOrUpdate::parameters.resource, "parameters");
@@clientName(PrivateZones.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateZone.properties);

@@clientName(VirtualNetworkLinks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkLinks.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VirtualNetworkLink.properties);

@@clientName(RecordSets.createOrUpdate::parameters.resource, "parameters");
@@clientName(RecordSets.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RecordSet.properties);

// @@clientLocation decorators for operations with @operationId
@@clientLocation(PrivateZones.recordSetsList, RecordSets);
@@clientName(PrivateZones.recordSetsList, "List");
