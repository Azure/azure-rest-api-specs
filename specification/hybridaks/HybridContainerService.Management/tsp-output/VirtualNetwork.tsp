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
/**
 * The Virtual Network resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VirtualNetworkProperties)
model VirtualNetwork extends TrackedResourceBase {
  /**
   * Parameter for the name of the virtual network
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  @visibility("read")
  name: string;

  /**
   * Extended location pointing to the underlying infrastructure
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties of the virtual network resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: VirtualNetworkProperties;
}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Gets the specified virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("virtualNetworks_Retrieve")
  retrieve is ArmResourceRead<VirtualNetwork>;

  /**
   * Creates or updates the virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("virtualNetworks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patches the virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("virtualNetworks_Update")
  update is ArmCustomPatchAsync<
    VirtualNetwork,
    VirtualNetworksPatch,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the specified virtual network resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("virtualNetworks_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    BaseParameters<VirtualNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the virtual networks in the specified resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("virtualNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  /**
   * Lists the virtual networks in the specified subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
@@doc(VirtualNetworks.createOrUpdate::parameters.resource,
  "Virtual Network resource definition"
);
@@projectedName(VirtualNetworks.update::parameters.properties,
  "json",
  "virtualNetworks"
);
@@extension(VirtualNetworks.update::parameters.properties,
  "x-ms-client-name",
  "virtualNetworks"
);
@@doc(VirtualNetworks.update::parameters.properties,
  "Virtual Network resource patch definition"
);
