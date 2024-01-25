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
/**
 * The VirtualNetworks resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VirtualNetworkProperties)
model VirtualNetwork extends TrackedResourceBase {
  /**
   * Name of the VirtualNetwork.
   */
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  @visibility("read")
  name: string;

  /**
   * The extended location.
   */
  extendedLocation: ExtendedLocation;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: VirtualNetworkProperties;
}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Implements VirtualNetwork GET method.
   */
  get is ArmResourceRead<VirtualNetwork>;

  /**
   * Onboards the ScVmm virtual network as an Azure virtual network resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the VirtualNetworks resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VirtualNetwork,
    ResourcePatch,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deregisters the ScVmm virtual network from Azure.
   */
  delete is ArmResourceDeleteAsync<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      /**
       * Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.
       */
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List of VirtualNetworks in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  /**
   * List of VirtualNetworks in a subscription.
   */
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
