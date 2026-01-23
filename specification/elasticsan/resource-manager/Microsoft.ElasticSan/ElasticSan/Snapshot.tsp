import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;
/**
 * Response for Volume Snapshot request.
 */
@parentResource(VolumeGroup)
model Snapshot
  is Azure.ResourceManager.ProxyResource<SnapshotProperties, false> {
  ...ResourceNameParameter<
    Resource = Snapshot,
    KeyName = "snapshotName",
    SegmentName = "snapshots",
    NamePattern = "^[a-z0-9]+(?:[._-][a-z0-9]+)*$"
  >;
}

@armResourceOperations
interface Snapshots {
  /**
   * Get a Volume Snapshot.
   */
  get is ArmResourceRead<Snapshot>;

  /**
   * Create a Volume Snapshot.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Snapshot,
    LroHeaders = ArmLroLocationHeader<FinalResult = Snapshot> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Volume Snapshot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Snapshot,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Snapshots in a VolumeGroup or List Snapshots by Volume (name) in a VolumeGroup using filter
   */
  listByVolumeGroup is ArmResourceListByParent<
    Snapshot,
    Parameters = {
      /**
       * Specify $filter='volumeName eq <volume name>' to filter on volume.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<SnapshotList>
  >;
}

@@maxLength(Snapshot.name, 80);
@@minLength(Snapshot.name, 1);
@@doc(Snapshot.name,
  "The name of the volume snapshot within the given volume group."
);
@@doc(Snapshot.properties, "Properties of Volume Snapshot.");
@@doc(Snapshots.create::parameters.resource, "Snapshot object.");
