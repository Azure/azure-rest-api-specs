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
}

@armResourceOperations
interface MigrationRecoveryPoints {
  /**
   * Gets a recovery point for a migration item.
   */
  get is ArmResourceRead<MigrationRecoveryPoint>;

  /**
   * Gets the recovery points for a migration item.
   */
  listByReplicationMigrationItems is ArmResourceListByParent<
    MigrationRecoveryPoint,
    Response = ArmResponse<MigrationRecoveryPointCollection>
  >;
}

@@doc(MigrationRecoveryPoint.name, "The migration recovery point name.");
@@doc(MigrationRecoveryPoint.properties, "Recovery point properties.");
