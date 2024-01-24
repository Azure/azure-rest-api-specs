import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TriggeredWebJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Triggered Web Job History. List of Triggered Web Job Run Information elements.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(TriggeredWebJob)
@Azure.ResourceManager.Private.armResourceInternal(
  TriggeredJobHistoryProperties
)
@includeInapplicableMetadataInPayload(false)
model TriggeredJobHistory extends ProxyOnlyResource {
  /**
   * History ID.
   */
  @path
  @key("id")
  @segment("history")
  name: string;

  /**
   * TriggeredJobHistory resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: TriggeredJobHistoryProperties;
}

@armResourceOperations
interface TriggeredJobHistories {
  /**
   * Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetTriggeredWebJobHistorySlot")
  getTriggeredWebJobHistorySlot is ArmResourceRead<TriggeredJobHistory>;

  /**
   * Description for List a triggered web job's history for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListTriggeredWebJobHistorySlot")
  listTriggeredWebJobHistorySlot is ArmResourceListByParent<TriggeredJobHistory>;
}
