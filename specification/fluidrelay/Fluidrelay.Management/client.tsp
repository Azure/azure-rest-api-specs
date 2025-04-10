import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.FluidRelay;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FluidRelayServerUpdate.properties);

@@clientName(FluidRelayServers.update::parameters.properties, "resource");
@@clientName(FluidRelayServers.regenerateKey::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FluidRelayServer.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FluidRelayContainer.properties);
