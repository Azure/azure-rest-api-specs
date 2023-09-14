import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

namespace Microsoft.DatabaseWatcher;

using Azure.ResourceManager;
using TypeSpec.Versioning;

@added(Versions.v2023_09_01_preview)
@doc("The generic properties of a private connection, which uses a private endpoint for the target resource.")
model PrivateConnectionProperties {
  @doc("The ARM ResourceId of the private connection target.")
  resourceId: string;

  @doc("The fully qualified domain name (FQDN) of the target resource (e.g. someresource.eastus.kusto.windows.net).")
  resourceFullyQualifiedDomainName: string;

  @visibility("read")
  @doc("The provisioning state of the resource.")
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2023_09_01_preview)
@armResourceOperations
interface PrivateConnections
  extends ProxyResourceOperations<PrivateConnection> {}
