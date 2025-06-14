import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Properties of disk restore point
 */
model DiskRestorePoint
  is Azure.ResourceManager.ProxyResource<DiskRestorePointProperties> {
  ...ResourceNameParameter<
    Resource = DiskRestorePoint,
    KeyName = "diskRestorePointName",
    SegmentName = "diskRestorePoints",
    NamePattern = ""
  >;
}

alias VMRestorePointPath = {
  ...Azure.ResourceManager.Legacy.BasePath;

  /**
   * The name of the restore point collection that the disk restore point belongs.
   */
  @path
  @segment("restorePointCollections")
  restorePointCollectionName: string;

  /**
   * The name of the vm restore point that the disk disk restore point belongs.
   */
  @path
  @segment("restorePoints")
  vmRestorePointName: string;
};

@armResourceOperations
interface DiskRestorePointsOps
  extends Azure.ResourceManager.Legacy.ComputeLegacyOperations<
      VMRestorePointPath,
      KeysOf<{
        ...ResourceNameParameter<
          DiskRestorePoint,
          SegmentName = "diskRestorePoints",
          KeyName = "diskRestorePointName",
          NamePattern = ""
        >,
      }>
    > {}

@armResourceOperations
interface DiskRestorePoints {
  /**
   * Get disk restorePoint resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_Get")
  get is DiskRestorePointsOps.Read<DiskRestorePoint>;

  /**
   * Lists diskRestorePoints under a vmRestorePoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_ListByRestorePoint")
  listByRestorePoint is DiskRestorePointsOps.List<
    DiskRestorePoint,
    Response = ArmResponse<DiskRestorePointList>
  >;

  /** Grants access to a diskRestorePoint. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_GrantAccess")
  @action("beginGetAccess")
  grantAccess is DiskRestorePointsOps.ActionAsync<
    DiskRestorePoint,
    GrantAccessData,
    AccessUri
  >;

  /**
   * Revokes access to a diskRestorePoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_RevokeAccess")
  @action("endGetAccess")
  revokeAccess is DiskRestorePointsOps.ActionAsync<
    DiskRestorePoint,
    void,
    OkResponse
  >;
}

@@doc(DiskRestorePoint.name, "The name of the disk restore point created.");
@@doc(DiskRestorePoint.properties,
  "Properties of an incremental disk restore point"
);
@@doc(DiskRestorePoints.grantAccess::parameters.body,
  "Access data object supplied in the body of the get disk access operation."
);
