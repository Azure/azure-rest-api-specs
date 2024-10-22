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

/**
 * The name of the restore point collection that the disk restore point belongs.
 */
model RestorePointCollectionNameParameter
  is Azure.ResourceManager.ProxyResource<DiskRestorePointProperties> {
  ...ResourceNameParameter<
    Resource = RestorePointCollectionNameParameter,
    KeyName = "restorePointCollectionName",
    SegmentName = "restorePointCollections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DiskRestorePoints {
  /**
   * Get disk restorePoint resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_Get")
  get is ArmResourceRead<
    RestorePointCollectionNameParameter,
    Parameters = {
      /**
       * The name of the vm restore point that the disk disk restore point belongs.
       */
      @path
      @segment("restorePoints")
      vmRestorePointName: string;

      /**
       * The name of the disk restore point created.
       */
      @path
      @segment("diskRestorePoints")
      diskRestorePointName: string;
    }
  >;

  /**
   * Lists diskRestorePoints under a vmRestorePoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_ListByRestorePoint")
  listByRestorePoint is ArmResourceListByParent<
    DiskRestorePoint,
    Response = DiskRestorePointList,
    Parameters = {
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
    }
  >;

  /** Grants access to a diskRestorePoint. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_GrantAccess")
  grantAccess is ArmResourceActionAsync<
    RestorePointCollectionNameParameter,
    GrantAccessData,
    AccessUri,
    Parameters = {
      /**
       * The name of the vm restore point that the disk disk restore point belongs.
       */
      @path
      @segment("restorePoints")
      vmRestorePointName: string;

      /**
       * The name of the disk restore point created.
       */
      @path
      @segment("diskRestorePoints")
      diskRestorePointName: string;
    }
  >;

  /**
   * Revokes access to a diskRestorePoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskRestorePoint_RevokeAccess")
  revokeAccess is ArmResourceActionAsync<
    RestorePointCollectionNameParameter,
    void,
    OkResponse,
    Parameters = {
      /**
       * The name of the vm restore point that the disk disk restore point belongs.
       */
      @path
      @segment("restorePoints")
      vmRestorePointName: string;

      /**
       * The name of the disk restore point created.
       */
      @path
      @segment("diskRestorePoints")
      diskRestorePointName: string;
    }
  >;
}

@@doc(DiskRestorePoint.name, "The name of the disk restore point created.");
@@doc(DiskRestorePoint.properties,
  "Properties of an incremental disk restore point"
);
@@doc(DiskRestorePoints.grantAccess::parameters.body,
  "Access data object supplied in the body of the get disk access operation."
);
@@doc(RestorePointCollectionNameParameter.name,
  "The name of the restore point collection that the disk restore point belongs."
);
