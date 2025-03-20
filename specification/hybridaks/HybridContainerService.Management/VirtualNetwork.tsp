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

namespace Microsoft.HybridContainerService;
@doc("The Virtual Network resource definition.")
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Parameter for the name of the virtual network")
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: VirtualNetworkExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the specified virtual network resource")
  @operationId("virtualNetworks_Retrieve")
  retrieve is ArmResourceRead<VirtualNetwork>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates the virtual network resource")
  @operationId("virtualNetworks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patches the virtual network resource")
  @operationId("virtualNetworks_Update")
  update is ArmCustomPatchAsync<
    VirtualNetwork,
    VirtualNetworksPatch,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the specified virtual network resource")
  @operationId("virtualNetworks_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the virtual networks in the specified resource group")
  @operationId("virtualNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the virtual networks in the specified subscription")
  @operationId("virtualNetworks_ListBySubscription")
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}
