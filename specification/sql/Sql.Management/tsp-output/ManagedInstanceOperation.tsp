import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed instance operation.
 */
@parentResource(ManagedInstance)
model ManagedInstanceOperation
  is ProxyResource<ManagedInstanceOperationProperties> {
  @path
  @key("operationId")
  @segment("operations")
  name: string;
}

@armResourceOperations
interface ManagedInstanceOperations {
  /**
   * Gets a management operation on a managed instance.
   */
  get is ArmResourceRead<ManagedInstanceOperation>;

  /**
   * Gets a list of operations performed on the managed instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceOperations_ListByManagedInstance")
  listByManagedInstance is ArmResourceListByParent<ManagedInstanceOperation>;

  /**
   * Cancels the asynchronous operation on the managed instance.
   */
  cancel is ArmResourceActionSync<ManagedInstanceOperation, void, void>;
}
