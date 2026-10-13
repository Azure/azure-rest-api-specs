import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./InstancePool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A instance pool operation.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(InstancePool)
@Azure.ResourceManager.Legacy.feature(Features.InstancePoolOperations)
model InstancePoolOperation
  is Azure.ResourceManager.ProxyResource<InstancePoolOperationProperties> {
  ...ResourceNameParameter<
    Resource = InstancePoolOperation,
    KeyName = "operationId",
    SegmentName = "operations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.InstancePoolOperations)
interface InstancePoolOperations {
  /**
   * Gets a management operation on a instance pool.
   */
  get is ArmResourceRead<InstancePoolOperation>;

  /**
   * Gets a list of operations performed on the instance pool.
   */
  listByInstancePool is ArmResourceListByParent<InstancePoolOperation>;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@format(InstancePoolOperation.name, "uuid");
@@doc(InstancePoolOperation.name, "");
@@doc(InstancePoolOperation.properties, "Resource properties.");
