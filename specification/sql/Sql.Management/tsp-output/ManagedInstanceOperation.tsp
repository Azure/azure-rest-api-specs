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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@includeInapplicableMetadataInPayload(false)
model ManagedInstanceOperation extends ProxyResource {
  @path
  @key("operationId")
  @segment("operations")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedInstanceOperationProperties;
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
