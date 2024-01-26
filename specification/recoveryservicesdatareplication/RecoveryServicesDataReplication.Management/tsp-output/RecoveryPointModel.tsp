import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectedItemModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Recovery point model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ProtectedItemModel)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(RecoveryPointModelProperties)
model RecoveryPointModel extends ProxyResourceBase {
  /**
   * The recovery point name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("recoveryPointName")
  @segment("recoveryPoints")
  @visibility("read")
  name: string;

  /**
   * Recovery point model properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: RecoveryPointModelProperties;
}

@armResourceOperations
interface RecoveryPointModels {
  /**
   * Gets the details of the recovery point of a protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecoveryPoints_Get")
  get is ArmResourceRead<RecoveryPointModel>;

  /**
   * Gets the list of recovery points of the given protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecoveryPoints_List")
  list is ArmResourceListByParent<RecoveryPointModel>;
}
