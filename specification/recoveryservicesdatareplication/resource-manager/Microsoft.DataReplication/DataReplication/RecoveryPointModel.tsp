import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectedItemModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Recovery point model.
 */
@parentResource(ProtectedItemModel)
model RecoveryPointModel
  is Azure.ResourceManager.ProxyResource<RecoveryPointModelProperties> {
  ...ResourceNameParameter<
    Resource = RecoveryPointModel,
    KeyName = "recoveryPointName",
    SegmentName = "recoveryPoints",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

@armResourceOperations
interface RecoveryPoint {
  /**
   * Gets the details of the recovery point of a protected item.
   */
  get is ArmResourceRead<RecoveryPointModel>;

  /**
   * Gets the list of recovery points of the given protected item.
   */
  list is ArmResourceListByParent<RecoveryPointModel>;
}

@@doc(RecoveryPointModel.name, "The recovery point name.");
