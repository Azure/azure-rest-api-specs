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

namespace Microsoft.ScVmm;
@doc("The VirtualNetworks resource definition.")
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Name of the VirtualNetwork.")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  @doc("Implements VirtualNetwork GET method.")
  get is ArmResourceRead<VirtualNetwork>;

  @doc("Onboards the ScVmm virtual network as an Azure virtual network resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the VirtualNetworks resource.")
  update is ArmCustomPatchAsync<
    VirtualNetwork,
    ResourcePatch,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  @doc("Deregisters the ScVmm virtual network from Azure.")
  delete is ArmResourceDeleteAsync<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  @doc("List of VirtualNetworks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  @doc("List of VirtualNetworks in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}

@@projectedName(VirtualNetworks.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(VirtualNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualNetworks.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(VirtualNetworks.update::parameters.properties, "json", "body");
@@extension(VirtualNetworks.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualNetworks.update::parameters.properties,
  "VirtualNetworks patch payload."
);
