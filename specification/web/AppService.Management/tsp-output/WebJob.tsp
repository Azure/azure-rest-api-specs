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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(WebJobProperties)
@includeInapplicableMetadataInPayload(false)
model WebJob extends ProxyOnlyResource {
  /**
   * Name of the web job.
   */
  @path
  @key("webJobName")
  @segment("webjobs")
  name: string;

  /**
   * WebJob resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: WebJobProperties;
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
