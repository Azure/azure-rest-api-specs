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
 * Rack represents the hardware of the rack and is dependent upon the cluster for lifecycle.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(RackProperties)
@includeInapplicableMetadataInPayload(false)
model Rack extends TrackedResourceBase {
  /**
   * The name of the rack.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("rackName")
  @segment("racks")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: RackProperties;
}

@armResourceOperations
interface Racks {
  /**
   * Get properties of the provided rack.
   */
  get is ArmResourceRead<Rack>;

  /**
   * Patch properties of the provided rack, or update the tags associated with the rack. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Rack,
    RackPatchParameters,
    BaseParameters<Rack>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get a list of racks in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Racks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Rack>;

  /**
   * Get a list of racks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<Rack>;
}

@@projectedName(Racks.update::parameters.properties,
  "json",
  "rackUpdateParameters"
);
@@extension(Racks.update::parameters.properties,
  "x-ms-client-name",
  "rackUpdateParameters"
);
@@doc(Racks.update::parameters.properties, "The request body.");
