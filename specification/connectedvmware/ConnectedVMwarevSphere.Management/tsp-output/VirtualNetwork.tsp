import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the virtualNetwork.")
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Name of the virtual network resource.")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VirtualNetworks {
  @doc("Implements virtual network GET method.")
  get is ArmResourceRead<VirtualNetwork>;

  @doc("Create Or Update virtual network.")
  create is ArmResourceCreateOrUpdateAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the virtual network resource.")
  update is ArmCustomPatchSync<VirtualNetwork, ResourcePatch>;

  @doc("Implements virtual network DELETE method.")
  delete is ArmResourceDeleteAsync<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("List of virtualNetworks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  @doc("List of virtualNetworks in a subscription.")
  list is ArmListBySubscription<VirtualNetwork>;
}

@@projectedName(VirtualNetworks.create::parameters.resource, "json", "body");
@@extension(VirtualNetworks.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualNetworks.create::parameters.resource, "Request payload.");
@@projectedName(VirtualNetworks.update::parameters.properties, "json", "body");
@@extension(VirtualNetworks.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualNetworks.update::parameters.properties,
  "Resource properties to update."
);
