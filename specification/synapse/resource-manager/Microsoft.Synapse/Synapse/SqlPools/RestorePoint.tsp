import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * Database restore points.
 */
@parentResource(SqlPool)
model RestorePoint
  is Azure.ResourceManager.ProxyResource<RestorePointProperties> {
  ...ResourceNameParameter<
    Resource = RestorePoint,
    KeyName = "restorePointName",
    SegmentName = "restorePoints",
    NamePattern = ""
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

alias RestorePointOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolParentParameters,
  {
    /** The name of the restore point. */
    @segment("restorePoints")
    @key
    @path
    restorePointName: string;
  }
>;

@armResourceOperations
interface RestorePoints {
  /**
   * Gets a restore point.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolRestorePoints_Get")
  get is RestorePointOps.Read<RestorePoint>;

  /**
   * Deletes a restore point.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolRestorePoints_Delete")
  delete is RestorePointOps.DeleteSync<RestorePoint>;

  /**
   * Get SQL pool backup information
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolRestorePoints_List")
  list is RestorePointOps.List<
    RestorePoint,
    Response = ArmResponse<RestorePointListResult>
  >;
}

@@doc(RestorePoint.name, "The name of the restore point.");
@@doc(RestorePoint.properties, "Resource properties.");
