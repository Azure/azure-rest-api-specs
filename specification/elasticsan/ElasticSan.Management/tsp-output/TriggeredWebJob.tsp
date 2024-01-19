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
@doc("Triggered Web Job Information.")
model TriggeredWebJob is ProxyResource<TriggeredWebJobProperties> {
  @doc("Name of Web Job.")
  @path
  @key("webJobName")
  @segment("triggeredwebjobs")
  name: string;
}

@armResourceOperations
interface TriggeredWebJobs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets a triggered web job by its ID for an app, or a deployment slot.")
  @operationId("WebApps_GetTriggeredWebJobSlot")
  getTriggeredWebJobSlot is ArmResourceRead<TriggeredWebJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete a triggered web job by its ID for an app, or a deployment slot.")
  @operationId("WebApps_DeleteTriggeredWebJobSlot")
  deleteTriggeredWebJobSlot is ArmResourceDeleteSync<TriggeredWebJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for List triggered web jobs for an app, or a deployment slot.")
  @operationId("WebApps_ListTriggeredWebJobsSlot")
  listTriggeredWebJobsSlot is ArmResourceListByParent<TriggeredWebJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Run a triggered web job for an app, or a deployment slot.")
  @operationId("WebApps_RunTriggeredWebJobSlot")
  runTriggeredWebJobSlot is ArmResourceActionSync<TriggeredWebJob, void, void>;
}
