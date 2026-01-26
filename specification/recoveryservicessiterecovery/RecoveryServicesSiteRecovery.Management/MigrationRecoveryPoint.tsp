import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MigrationItem.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Recovery point for a migration item.
 */
@parentResource(MigrationItem)
model MigrationRecoveryPoint
  is Azure.ResourceManager.ProxyResource<MigrationRecoveryPointProperties> {
  ...ResourceNameParameter<
    Resource = MigrationRecoveryPoint,
    KeyName = "migrationRecoveryPointName",
    SegmentName = "migrationRecoveryPoints",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface MigrationRecoveryPoints {
  /**
   * Gets a recovery point for a migration item.
   */
  @summary("Gets a recovery point for a migration item.")
  get is ArmResourceRead<MigrationRecoveryPoint, Error = never>;

  /**
   * Gets the recovery points for a migration item.
   */
  @summary("Gets the recovery points for a migration item.")
  listByReplicationMigrationItems is ArmResourceListByParent<
    MigrationRecoveryPoint,
    Response = ArmResponse<MigrationRecoveryPointCollection>,
    Error = never
  >;
}

@@doc(MigrationRecoveryPoint.name, "The migration recovery point name.");
@@doc(MigrationRecoveryPoint.properties, "Recovery point properties.");
