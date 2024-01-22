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

namespace Microsoft.ManagedNetworkFabric;
/**
 * Defines the Neighbor Group.
 */
model NeighborGroup is TrackedResource<NeighborGroupProperties> {
  /**
   * Name of the Neighbor Group.
   */
  @path
  @key("neighborGroupName")
  @segment("neighborGroups")
  name: string;
}

@armResourceOperations
interface NeighborGroups {
  /**
   * Gets the Neighbor Group.
   */
  get is ArmResourceRead<NeighborGroup>;

  /**
   * Implements the Neighbor Group PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<
    NeighborGroup,
    BaseParameters<NeighborGroup>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the Neighbor Group.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NeighborGroup,
    NeighborGroupPatch,
    BaseParameters<NeighborGroup>,
    ArmLroLocationHeader
  >;

  /**
   * Implements Neighbor Group DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NeighborGroup,
    BaseParameters<NeighborGroup>,
    ArmLroLocationHeader
  >;

  /**
   * Displays NeighborGroups list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NeighborGroups_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NeighborGroup>;

  /**
   * Displays NeighborGroups list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<NeighborGroup>;
}

@@projectedName(NeighborGroups.create::parameters.resource, "json", "body");
@@extension(NeighborGroups.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NeighborGroups.create::parameters.resource, "Request payload.");
@@projectedName(NeighborGroups.update::parameters.properties, "json", "body");
@@extension(NeighborGroups.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NeighborGroups.update::parameters.properties,
  "Neighbor Group properties to update. Only annotations are supported."
);
