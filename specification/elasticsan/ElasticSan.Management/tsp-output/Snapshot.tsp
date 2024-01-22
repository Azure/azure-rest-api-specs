import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;
/**
 * Response for Volume Snapshot request.
 */
@parentResource(VolumeGroup)
model Snapshot is ProxyResource<SnapshotProperties> {
  /**
   * The name of the volume snapshot within the given volume group.
   */
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-z0-9]+(?:[._-][a-z0-9]+)*$")
  @path
  @key("snapshotName")
  @segment("snapshots")
  name: string;
}

@armResourceOperations
interface Snapshots {
  /**
   * Get a Volume Snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeSnapshots_Get")
  get is ArmResourceRead<Snapshot>;

  /**
   * Create a Volume Snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeSnapshots_Create")
  create is ArmResourceCreateOrReplaceAsync<
    Snapshot,
    BaseParameters<Snapshot>,
    ArmLroLocationHeader
  >;

  /**
   * Delete a Volume Snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeSnapshots_Delete")
  delete is ArmResourceDeleteAsync<
    Snapshot,
    BaseParameters<Snapshot>,
    ArmLroLocationHeader
  >;

  /**
   * List Snapshots in a VolumeGroup or List Snapshots by Volume (name) in a VolumeGroup using filter
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeSnapshots_ListByVolumeGroup")
  listByVolumeGroup is ArmResourceListByParent<
    Snapshot,
    {
      ...BaseParameters<Snapshot>;

      /**
       * Specify $filter='volumeName eq <volume name>' to filter on volume.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Snapshots.create::parameters.resource, "json", "parameters");
@@extension(Snapshots.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Snapshots.create::parameters.resource, "Snapshot object.");
