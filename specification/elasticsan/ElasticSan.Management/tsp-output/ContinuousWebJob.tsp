import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Continuous Web Job Information.")
@parentResource(Site)
model ContinuousWebJob is ProxyResource<ContinuousWebJobProperties> {
  @doc("Name of Web Job.")
  @path
  @key("webJobName")
  @segment("continuouswebjobs")
  name: string;
}

@armResourceOperations
interface ContinuousWebJobs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets a continuous web job by its ID for an app, or a deployment slot.")
  @operationId("WebApps_GetContinuousWebJob")
  getContinuousWebJob is ArmResourceRead<ContinuousWebJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete a continuous web job by its ID for an app, or a deployment slot.")
  @operationId("WebApps_DeleteContinuousWebJob")
  deleteContinuousWebJob is ArmResourceDeleteSync<ContinuousWebJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for List continuous web jobs for an app, or a deployment slot.")
  @operationId("WebApps_ListContinuousWebJobs")
  listContinuousWebJobs is ArmResourceListByParent<ContinuousWebJob>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Start a continuous web job for an app, or a deployment slot.")
  @operationId("WebApps_StartContinuousWebJob")
  startContinuousWebJob is ArmResourceActionSync<ContinuousWebJob, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Stop a continuous web job for an app, or a deployment slot.")
  @operationId("WebApps_StopContinuousWebJob")
  stopContinuousWebJob is ArmResourceActionSync<ContinuousWebJob, void, void>;
}
