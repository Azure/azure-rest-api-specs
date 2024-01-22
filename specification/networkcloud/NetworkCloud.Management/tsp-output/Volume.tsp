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
 * Volume represents storage made available for use by resources running on the cluster.
 */
model Volume is TrackedResource<VolumeProperties> {
  /**
   * The name of the volume.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9])$")
  @path
  @key("volumeName")
  @segment("volumes")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Volumes {
  /**
   * Get properties of the provided volume.
   */
  get is ArmResourceRead<Volume>;

  /**
   * Create a new volume or update the properties of the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Volume,
    BaseParameters<Volume>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update tags associated with the provided volume.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Volume, VolumePatchParameters>;

  /**
   * Delete the provided volume.
   */
  delete is ArmResourceDeleteAsync<
    Volume,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of volumes in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Volumes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Volume>;

  /**
   * Get a list of volumes in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<Volume>;
}

@@projectedName(Volumes.createOrUpdate::parameters.resource,
  "json",
  "volumeParameters"
);
@@extension(Volumes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "volumeParameters"
);
@@doc(Volumes.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Volumes.update::parameters.properties,
  "json",
  "volumeUpdateParameters"
);
@@extension(Volumes.update::parameters.properties,
  "x-ms-client-name",
  "volumeUpdateParameters"
);
@@doc(Volumes.update::parameters.properties, "The request body.");
