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
@doc("The virtualNetworks resource definition.")
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Parameter for the name of the virtual network")
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("Extended Location definition")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the Hybrid AKS virtual network")
  @operationId("virtualNetworks_Retrieve")
  retrieve is ArmResourceRead<VirtualNetwork>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Puts the Hybrid AKS virtual network")
  @operationId("virtualNetworks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patches the Hybrid AKS virtual network")
  @operationId("virtualNetworks_Update")
  update is ArmCustomPatchAsync<
    VirtualNetwork,
    VirtualNetworksPatch,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the Hybrid AKS virtual network")
  @operationId("virtualNetworks_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the Hybrid AKS virtual networks by resource group")
  @operationId("virtualNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the Hybrid AKS virtual networks by subscription")
  @operationId("virtualNetworks_ListBySubscription")
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}

@@projectedName(VirtualNetworks.createOrUpdate::parameters.resource,
  "json",
  "virtualNetworks"
);
@@extension(VirtualNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "virtualNetworks"
);
@@doc(VirtualNetworks.createOrUpdate::parameters.resource, "");
@@projectedName(VirtualNetworks.update::parameters.properties,
  "json",
  "virtualNetworks"
);
@@extension(VirtualNetworks.update::parameters.properties,
  "x-ms-client-name",
  "virtualNetworks"
);
@@doc(VirtualNetworks.update::parameters.properties, "");
