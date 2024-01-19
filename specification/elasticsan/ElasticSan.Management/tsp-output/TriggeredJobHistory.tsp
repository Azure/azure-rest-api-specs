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
@doc("Triggered Web Job History. List of Triggered Web Job Run Information elements.")
@parentResource(TriggeredWebJob)
model TriggeredJobHistory is ProxyResource<TriggeredJobHistoryProperties> {
  @doc("History ID.")
  @path
  @key("id")
  @segment("history")
  name: string;
}

@armResourceOperations
interface TriggeredJobHistories {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets a triggered web job's history by its ID for an app, , or a deployment slot.")
  @operationId("WebApps_GetTriggeredWebJobHistorySlot")
  getTriggeredWebJobHistorySlot is ArmResourceRead<TriggeredJobHistory>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for List a triggered web job's history for an app, or a deployment slot.")
  @operationId("WebApps_ListTriggeredWebJobHistorySlot")
  listTriggeredWebJobHistorySlot is ArmResourceListByParent<TriggeredJobHistory>;
}
