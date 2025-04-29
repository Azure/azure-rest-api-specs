import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(PrivateZones.createOrUpdate::parameters.resource, "parameters");
@@clientName(PrivateZones.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateZone.properties);

@@clientName(VirtualNetworkLinks.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualNetworkLinks.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetworkLink.properties);

@@clientName(RecordSets.createOrUpdate::parameters.resource, "parameters");
@@clientName(RecordSets.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RecordSet.properties);
