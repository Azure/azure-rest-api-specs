import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.DataReplication;

@@clientName(PrivateEndpointConnections.update::parameters.resource, "body");
@@clientName(EmailConfiguration.create::parameters.resource, "body");
@@clientName(FabricAgent.create::parameters.resource, "body");
@@clientName(Fabric.create::parameters.resource, "body");
@@clientName(Fabric.update::parameters.properties, "body");
@@clientName(ProtectedItem.create::parameters.resource, "body");
@@clientName(Policy.create::parameters.resource, "body");
@@clientName(Vault.create::parameters.resource, "body");
@@clientName(ProtectedItem.update::parameters.properties, "body");
@@clientName(ReplicationExtension.create::parameters.resource, "body");
@@clientName(Vault.update::parameters.properties, "body");
