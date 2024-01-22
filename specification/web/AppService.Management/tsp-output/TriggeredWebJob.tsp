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
 * Triggered Web Job Information.
 */
model TriggeredWebJob is ProxyResource<TriggeredWebJobProperties> {
  /**
   * Name of Web Job.
   */
  @path
  @key("webJobName")
  @segment("triggeredwebjobs")
  name: string;
}

@armResourceOperations
interface TriggeredWebJobs {
  /**
   * Description for Gets a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetTriggeredWebJobSlot")
  getTriggeredWebJobSlot is ArmResourceRead<TriggeredWebJob>;

  /**
   * Description for Delete a triggered web job by its ID for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteTriggeredWebJobSlot")
  deleteTriggeredWebJobSlot is ArmResourceDeleteSync<TriggeredWebJob>;

  /**
   * Description for List triggered web jobs for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListTriggeredWebJobsSlot")
  listTriggeredWebJobsSlot is ArmResourceListByParent<TriggeredWebJob>;

  /**
   * Description for Run a triggered web job for an app, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_RunTriggeredWebJobSlot")
  runTriggeredWebJobSlot is ArmResourceActionSync<TriggeredWebJob, void, void>;
}
