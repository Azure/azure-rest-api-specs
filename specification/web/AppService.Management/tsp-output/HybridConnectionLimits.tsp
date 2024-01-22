import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Hybrid Connection limits contract. This is used to return the plan limits of Hybrid Connections.
 */
@singleton("limit")
@parentResource(AppServicePlan)
model HybridConnectionLimits
  is ProxyResource<HybridConnectionLimitsProperties> {
  @key("hybridConnectionPlanLimit")
  @segment("hybridConnectionPlanLimits")
  name: string;
}

@armResourceOperations
@projectedName("client", "HybridConnectionLimits")
interface HybridConnectionLimitsOperationGroup {
  /**
   * Description for Get the maximum number of Hybrid Connections allowed in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_GetHybridConnectionPlanLimit")
  getHybridConnectionPlanLimit is ArmResourceRead<HybridConnectionLimits>;
}
