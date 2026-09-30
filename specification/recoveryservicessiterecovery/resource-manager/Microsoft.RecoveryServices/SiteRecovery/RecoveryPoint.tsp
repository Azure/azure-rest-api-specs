import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ReplicationProtectedItem.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Recovery point.
 */
@parentResource(ReplicationProtectedItem)
model RecoveryPoint
  is Azure.ResourceManager.ProxyResource<RecoveryPointProperties> {
  ...ResourceNameParameter<
    Resource = RecoveryPoint,
    KeyName = "recoveryPointName",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface RecoveryPoints {
  /**
   * Get the details of specified recovery point.
   */
  @summary("Gets a recovery point.")
  get is ArmResourceRead<RecoveryPoint, Error = never>;

  /**
   * Lists the available recovery points for a replication protected item.
   */
  @summary("Gets the list of recovery points for a replication protected item.")
  listByReplicationProtectedItems is ArmResourceListByParent<
    RecoveryPoint,
    Response = ArmResponse<RecoveryPointCollection>,
    Error = never
  >;
}

@@doc(RecoveryPoint.name, "The recovery point name.");
@@doc(RecoveryPoint.properties, "The recovery point properties.");
