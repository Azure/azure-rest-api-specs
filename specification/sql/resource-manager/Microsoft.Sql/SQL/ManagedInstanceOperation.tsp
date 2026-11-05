import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed instance operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ManagedInstance)
@Azure.ResourceManager.Legacy.feature(Features.ManagedInstanceOperations)
model ManagedInstanceOperation
  is Azure.ResourceManager.ProxyResource<ManagedInstanceOperationProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceOperation,
    KeyName = "operationId",
    SegmentName = "operations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.ManagedInstanceOperations)
interface ManagedInstanceOperations {
  /**
   * Gets a management operation on a managed instance.
   */
  get is ArmResourceRead<ManagedInstanceOperation>;

  /**
   * Gets a list of operations performed on the managed instance.
   */
  listByManagedInstance is ArmResourceListByParent<ManagedInstanceOperation>;

  /**
   * Cancels the asynchronous operation on the managed instance.
   */
  cancel is ArmResourceActionSync<ManagedInstanceOperation, void, OkResponse>;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@format(ManagedInstanceOperation.name, "uuid");
@@doc(ManagedInstanceOperation.name, "");
@@doc(ManagedInstanceOperation.properties, "Resource properties.");
