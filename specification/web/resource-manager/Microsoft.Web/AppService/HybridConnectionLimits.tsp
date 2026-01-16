import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Hybrid Connection limits contract. This is used to return the plan limits of Hybrid Connections.
 */
@singleton("limit")
@parentResource(AppServicePlan)
model HybridConnectionLimits
  is Azure.ResourceManager.ProxyResource<HybridConnectionLimitsProperties> {
  ...ResourceNameParameter<
    Resource = HybridConnectionLimits,
    KeyName = "hybridConnectionPlanLimit",
    SegmentName = "hybridConnectionPlanLimits",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface HybridConnectionLimitsOperationGroup {
  /**
   * Description for Get the maximum number of Hybrid Connections allowed in an App Service plan.
   */
  @summary("Get the maximum number of Hybrid Connections allowed in an App Service plan.")
  getHybridConnectionPlanLimit is ArmResourceRead<
    HybridConnectionLimits,
    Error = DefaultErrorResponse
  >;
}

@@doc(HybridConnectionLimits.name, "");
@@doc(HybridConnectionLimits.properties,
  "HybridConnectionLimits resource specific properties"
);
