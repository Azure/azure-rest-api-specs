import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * A silo of an App Service plan resource.
 */
@added(Versions.v2026_06_01)
@parentResource(AppServicePlan)
model ServerFarmSilo
  is Azure.ResourceManager.ProxyResource<ServerFarmSiloProperties> {
  ...ResourceNameParameter<
    Resource = ServerFarmSilo,
    KeyName = "siloName",
    SegmentName = "silos",
    NamePattern = ""
  >;
}

@added(Versions.v2026_06_01)
@tag("AppServicePlans")
@armResourceOperations(#{ omitTags: true })
interface ServerFarmSiloResources {
  /**
   * Gets all silos for an App Service plan.
   */
  listServerFarmSilos is ArmResourceListByParent<
    ServerFarmSilo,
    Response = ArmResponse<ServerFarmSiloCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Gets a specific silo for an App Service plan.
   */
  getServerFarmSilo is ArmResourceRead<
    ServerFarmSilo,
    Error = DefaultErrorResponse
  >;

  /**
   * Creates or updates a silo for an App Service plan.
   */
  createOrUpdateServerFarmSilo is ArmResourceCreateOrReplaceAsync<
    ServerFarmSilo,
    Response =
      | ArmResourceUpdatedResponse<ServerFarmSilo>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ServerFarmSilo>>,
    Error = DefaultErrorResponse
  >;

  /**
   * Deletes a silo for an App Service plan.
   */
  deleteServerFarmSilo is ArmResourceDeleteSync<
    ServerFarmSilo,
    Error = DefaultErrorResponse
  >;
}
