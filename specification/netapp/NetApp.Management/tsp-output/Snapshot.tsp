import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Snapshot of a Volume
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Volume)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotProperties)
model Snapshot extends ProxyResourceBase {
  /**
   * The name of the snapshot
   */
  @path
  @key("snapshotName")
  @segment("snapshots")
  @visibility("read")
  name: string;

  /**
   * Snapshot Properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SnapshotProperties;
}

@armResourceOperations
interface Snapshots {
  /**
   * Get details of the specified snapshot
   */
  get is ArmResourceRead<Snapshot>;

  /**
   * Create the specified snapshot within the given volume
   */
  create is ArmResourceCreateOrReplaceAsync<
    Snapshot,
    BaseParameters<Snapshot>,
    ArmLroLocationHeader
  >;

  /**
   * Delete snapshot
   */
  delete is ArmResourceDeleteAsync<
    Snapshot,
    BaseParameters<Snapshot>,
    ArmLroLocationHeader
  >;

  /**
   * List all snapshots associated with the volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Snapshots_List")
  list is ArmResourceListByParent<Snapshot>;

  /**
   * Restore the specified files from the specified snapshot to the active filesystem
   */
  restoreFiles is ArmResourceActionAsync<
    Snapshot,
    SnapshotRestoreFiles,
    void,
    BaseParameters<Snapshot>,
    ArmLroLocationHeader
  >;
}

@@projectedName(Snapshots.create::parameters.resource, "json", "body");
@@extension(Snapshots.create::parameters.resource, "x-ms-client-name", "body");
@@doc(Snapshots.create::parameters.resource,
  "Snapshot object supplied in the body of the operation."
);
@@doc(Snapshots.restoreFiles::parameters.body,
  "Restore payload supplied in the body of the operation."
);
