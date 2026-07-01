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
    NamePattern = "^[A-Za-z0-9_@-]{1,50}$"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The ServerFarmSilo service returns 202 Accepted (not 201 Created) from its long-running create-or-update PUT; the contract is modeled to match the service's actual response codes."
  createOrUpdateServerFarmSilo is ArmResourceCreateOrReplaceAsync<
    ServerFarmSilo,
    Response = ArmResourceUpdatedResponse<ServerFarmSilo> | ArmAcceptedLroResponse,
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
