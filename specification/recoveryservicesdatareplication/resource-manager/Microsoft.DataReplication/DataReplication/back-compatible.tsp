import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.DataReplication;

@@clientName(
  PrivateEndpointConnections.update::parameters.resource,
  "body",
  "!python"
);
@@clientName(EmailConfiguration.create::parameters.resource, "body", "!python");
@@clientName(FabricAgent.create::parameters.resource, "body", "!python");
@@clientName(Fabric.create::parameters.resource, "body", "!python");
@@clientName(Fabric.update::parameters.properties, "body", "!python");
@@clientName(ProtectedItem.create::parameters.resource, "body", "!python");
@@clientName(Policy.create::parameters.resource, "body", "!python");
@@clientName(Vault.create::parameters.resource, "body", "!python");
@@clientName(ProtectedItem.update::parameters.properties, "body", "!python");
@@clientName(
  ReplicationExtension.create::parameters.resource,
  "body",
  "!python"
);
@@clientName(Vault.update::parameters.properties, "body", "!python");
