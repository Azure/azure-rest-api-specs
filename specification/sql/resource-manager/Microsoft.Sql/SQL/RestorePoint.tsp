import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database restore points.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Database)
@Azure.ResourceManager.Legacy.feature(Features.RestorePoints)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.RestorePoints)
interface RestorePoints {
  /**
   * Gets a restore point.
   */
  get is ArmResourceRead<RestorePoint>;

  /**
   * Deletes a restore point.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<RestorePoint, Response = ArmDeletedResponse>;

  /**
   * Gets a list of database restore points.
   */
  listByDatabase is ArmResourceListByParent<RestorePoint>;
}

@@doc(RestorePoint.name, "The name of the restore point.");
@@doc(RestorePoint.properties, "Resource properties.");
