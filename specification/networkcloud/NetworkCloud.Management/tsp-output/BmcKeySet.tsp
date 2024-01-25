import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * BmcKeySet represents the baseboard management controller key set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(BmcKeySetProperties)
model BmcKeySet extends TrackedResourceBase {
  /**
   * The name of the baseboard management controller key set.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("bmcKeySetName")
  @segment("bmcKeySets")
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
  properties: BmcKeySetProperties;
}

@armResourceOperations
interface BmcKeySets {
  /**
   * Get baseboard management controller key set of the provided cluster.
   */
  get is ArmResourceRead<BmcKeySet>;

  /**
   * Create a new baseboard management controller key set or update the existing one for the provided cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BmcKeySet,
    BaseParameters<BmcKeySet>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch properties of baseboard management controller key set for the provided cluster, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    BmcKeySet,
    BmcKeySetPatchParameters,
    BaseParameters<BmcKeySet>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the baseboard management controller key set of the provided cluster.
   */
  delete is ArmResourceDeleteAsync<
    BmcKeySet,
    BaseParameters<BmcKeySet>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of baseboard management controller key sets for the provided cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BmcKeySets_ListByCluster")
  listByCluster is ArmResourceListByParent<BmcKeySet>;
}

@@projectedName(BmcKeySets.createOrUpdate::parameters.resource,
  "json",
  "bmcKeySetParameters"
);
@@extension(BmcKeySets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "bmcKeySetParameters"
);
@@doc(BmcKeySets.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(BmcKeySets.update::parameters.properties,
  "json",
  "bmcKeySetUpdateParameters"
);
@@extension(BmcKeySets.update::parameters.properties,
  "x-ms-client-name",
  "bmcKeySetUpdateParameters"
);
@@doc(BmcKeySets.update::parameters.properties, "The request body.");
