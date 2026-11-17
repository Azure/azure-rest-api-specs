import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

// Go generates this client into its own ekm package, so drop the redundant "Ekm" from client and method names e.g. ekm.Client.CreateConnection
@@clientName(KeyVault, "Client", "go");
@@clientDoc(
  KeyVault,
  "Manages the External Key Manager (EKM) connection of a Managed HSM.",
  DocumentationMode.replace,
  "go"
);

@@clientName(KeyVault.getEkmConnection, "getConnection", "go");
@@clientName(KeyVault.getEkmCertificate, "getCertificate", "go");
@@clientName(KeyVault.checkEkmConnection, "checkConnection", "go");
@@clientName(KeyVault.createEkmConnection, "createConnection", "go");
@@clientName(KeyVault.updateEkmConnection, "updateConnection", "go");
@@clientName(KeyVault.deleteEkmConnection, "deleteConnection", "go");

@@clientName(KeyVault.EkmProxyInfo.ekmVendor, "EKMVendor", "go");
@@clientName(KeyVault.EkmProxyInfo.ekmProduct, "EKMProduct", "go");

@@clientName(
  KeyVault.getEkmPrivateEndpointOperationStatus,
  "getPrivateEndpointOperationStatus",
  "go"
);
@@clientName(KeyVault.createEkmPrivateEndpoint, "createPrivateEndpoint", "go");
@@clientName(KeyVault.deleteEkmPrivateEndpoint, "deletePrivateEndpoint", "go");
@@clientName(KeyVault.getEkmPrivateEndpoint, "getPrivateEndpoint", "go");
@@clientName(KeyVault.listEkmPrivateEndpoints, "listPrivateEndpoints", "go");

@@clientName(KeyVault.EkmConnectivityMode, "ConnectivityMode", "go");
@@clientName(
  KeyVault.EkmPrivateEndpointConnectionStatus,
  "PrivateEndpointConnectionStatus",
  "go"
);
@@clientName(
  KeyVault.EkmPrivateEndpointProvisioningState,
  "PrivateEndpointProvisioningState",
  "go"
);
@@clientName(
  KeyVault.EkmPrivateEndpointOperationType,
  "PrivateEndpointOperationType",
  "go"
);
