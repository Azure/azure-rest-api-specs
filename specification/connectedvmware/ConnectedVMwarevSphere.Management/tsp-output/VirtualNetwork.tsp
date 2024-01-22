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
/**
 * Define the virtualNetwork.
 */
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  /**
   * Name of the virtual network resource.
   */
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  /**
   * Gets or sets the extended location.
   */
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Implements virtual network GET method.
   */
  get is ArmResourceRead<VirtualNetwork>;

  /**
   * Create Or Update virtual network.
   */
  create is ArmResourceCreateOrReplaceAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the virtual network resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<VirtualNetwork, ResourcePatch>;

  /**
   * Implements virtual network DELETE method.
   */
  delete is ArmResourceDeleteAsync<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List of virtualNetworks in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  /**
   * List of virtualNetworks in a subscription.
   */
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
