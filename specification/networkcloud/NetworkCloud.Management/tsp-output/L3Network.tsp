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

namespace Microsoft.NetworkCloud;
/**
 * L3Network represents a network that utilizes a single isolation domain set up for layer-3 resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(L3NetworkProperties)
model L3Network extends TrackedResourceBase {
  /**
   * The name of the L3 network.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("l3NetworkName")
  @segment("l3Networks")
  @visibility("read")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: L3NetworkProperties;
}

@armResourceOperations
interface L3Networks {
  /**
   * Get properties of the provided layer 3 (L3) network.
   */
  get is ArmResourceRead<L3Network>;

  /**
   * Create a new layer 3 (L3) network or update the properties of the existing network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    L3Network,
    BaseParameters<L3Network>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update tags associated with the provided layer 3 (L3) network.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<L3Network, L3NetworkPatchParameters>;

  /**
   * Delete the provided layer 3 (L3) network.
   */
  delete is ArmResourceDeleteAsync<
    L3Network,
    BaseParameters<L3Network>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of layer 3 (L3) networks in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("L3Networks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<L3Network>;

  /**
   * Get a list of layer 3 (L3) networks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<L3Network>;
}

@@projectedName(L3Networks.createOrUpdate::parameters.resource,
  "json",
  "l3NetworkParameters"
);
@@extension(L3Networks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "l3NetworkParameters"
);
@@doc(L3Networks.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(L3Networks.update::parameters.properties,
  "json",
  "l3NetworkUpdateParameters"
);
@@extension(L3Networks.update::parameters.properties,
  "x-ms-client-name",
  "l3NetworkUpdateParameters"
);
@@doc(L3Networks.update::parameters.properties, "The request body.");
