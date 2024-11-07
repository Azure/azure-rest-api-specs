import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.ScVmm;
/** The VirtualNetworks resource definition. */
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  /** Name of the VirtualNetwork. */
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  /** Implements VirtualNetwork GET method. */
  @summary("Gets a VirtualNetwork.")
  get is ArmResourceRead<VirtualNetwork>;
  /** Onboards the ScVmm virtual network as an Azure virtual network resource. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @summary("Implements VirtualNetworks PUT method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualNetwork,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Updates the VirtualNetworks resource. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements the VirtualNetworks PATCH method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  update is ArmTagsPatchAsync<VirtualNetwork>;
  /** Deregisters the ScVmm virtual network from Azure. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements VirtualNetwork DELETE method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    {
      ...Foundations.BaseParameters<VirtualNetwork>;
      ...QueryForceDelete;
    }
  >;
  /** List of VirtualNetworks in a resource group. */
  @summary("Implements GET VirtualNetworks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;
  /** List of VirtualNetworks in a subscription. */
  @summary("Implements GET VirtualNetworks in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}
