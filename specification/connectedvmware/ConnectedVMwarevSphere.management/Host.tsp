import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the host.")
model Host is TrackedResource<HostProperties> {
  @doc("Name of the host.")
  @path
  @key("hostName")
  @segment("hosts")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Hosts {
  @doc("Implements host GET method.")
  get is ArmResourceRead<Host>;
  @doc("Create Or Update host.")
  create is ArmResourceCreateOrUpdateAsync<Host>;
  @doc("API to update certain properties of the host resource.")
  update is ArmTagsPatchSync<Host>;
  @doc("Implements host DELETE method.")
  delete is ArmResourceDeleteAsync<
    Host,
    {
      ...BaseParameters<Host>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of hosts in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Host>;
  @doc("List of hosts in a subscription.")
  list is ArmListBySubscription<Host>;
}
