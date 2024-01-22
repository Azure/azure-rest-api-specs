import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Web Job Information.
 */
model WebJob is ProxyResource<WebJobProperties> {
  /**
   * Name of the web job.
   */
  @path
  @key("webJobName")
  @segment("webjobs")
  name: string;
}

@armResourceOperations
interface WebJobs {
  /**
   * Description for Get webjob information for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetWebJobSlot")
  getWebJobSlot is ArmResourceRead<WebJob>;

  /**
   * Description for List webjobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListWebJobsSlot")
  listWebJobsSlot is ArmResourceListByParent<WebJob>;
}
