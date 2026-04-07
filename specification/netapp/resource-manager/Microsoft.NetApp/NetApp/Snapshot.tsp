import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using Rest;
using Azure.ResourceManager;
using Http;

namespace Microsoft.NetApp;
/**
 * Snapshot of a Volume
 */
#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "For backward compatibility"
@parentResource(Volume)
model Snapshot is Azure.ResourceManager.ProxyResource<SnapshotProperties> {
  ...ResourceNameParameter<
    Resource = Snapshot,
    KeyName = "snapshotName",
    SegmentName = "snapshots",
    NamePattern = ""
  >;

  /**
   * Resource location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;
}

/**
 * List of Snapshots
 */
model SnapshotsList is Azure.Core.Page<Snapshot>;

/**
 * Snapshot properties
 */
model SnapshotProperties {
  /**
   * UUID v4 used to identify the Snapshot
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  snapshotId?: string;

  /**
   * The creation date of the snapshot
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Restore payload for Single File Snapshot Restore
 */
model SnapshotRestoreFiles {
  /**
   * List of files to be restored
   */
  @maxItems(10)
  @minItems(1)
  filePaths: FileName[];

  /**
   * Destination folder where the files will be restored
   */
  destinationPath?: string;
}

/**
 * Snapshot of a Volume
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model SnapshotPatch {}

@armResourceOperations
interface Snapshots {
  /**
   * Get details of the specified snapshot
   */
  get is ArmResourceRead<Snapshot>;

  /**
   * Create the specified snapshot within the given volume
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    Snapshot,
    Response = ArmResourceCreatedResponse<
      Snapshot,
      ArmLroLocationHeader<FinalResult = Snapshot> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Patch a snapshot
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Snapshot, PatchModel = SnapshotPatch>;

  /**
   * Delete snapshot
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Snapshot,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all snapshots associated with the volume
   */
  list is ArmResourceListByParent<
    Snapshot,
    Response = ArmResponse<SnapshotsList>
  >;

  /**
   * Restore the specified files from the specified snapshot to the active filesystem
   */
  restoreFiles is ArmResourceActionAsync<
    Snapshot,
    SnapshotRestoreFiles,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Snapshot.name, "The name of the snapshot");
@@doc(Snapshot.properties, "Snapshot Properties");
@@doc(Snapshots.create::parameters.resource,
  "Snapshot object supplied in the body of the operation."
);
@@doc(Snapshots.update::parameters.properties,
  "Snapshot object supplied in the body of the operation."
);
@@doc(Snapshots.restoreFiles::parameters.body,
  "Restore payload supplied in the body of the operation."
);
