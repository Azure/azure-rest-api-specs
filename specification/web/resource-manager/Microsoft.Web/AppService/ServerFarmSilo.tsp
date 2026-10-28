import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./AppServicePlan.tsp";
import "./SwiftVirtualNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * A silo of an App Service plan resource.
 */
@added(Versions.v2026_08_01)
@parentResource(AppServicePlan)
model ServerFarmSilo
  is Azure.ResourceManager.TrackedResource<ServerFarmSiloProperties> {
  ...ResourceNameParameter<
    Resource = ServerFarmSilo,
    KeyName = "siloName",
    SegmentName = "silos",
    NamePattern = "^[A-Za-z0-9-]{1,24}$"
  >;
}

@added(Versions.v2026_08_01)
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
   * Creates or updates a silo for an App Service plan. Returns 202 with polling headers when background work is queued, or 200 when no update is needed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The implemented silo PUT returns 202 with a resource body and polling headers when work is queued, or 200 when no update is needed. It does not return 201; this exception requires ARM approval."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "CsmHelper.CreateAsyncResponse includes the silo resource body in the implemented 202 response."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdateServerFarmSilo is ArmResourceCreateOrReplaceAsync<
    ServerFarmSilo,
    Response =
      | ArmResourceUpdatedResponse<ServerFarmSilo>
      | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ServerFarmSilo> &
          Azure.Core.Foundations.RetryAfterHeader> & {
          @bodyRoot
          body: ServerFarmSilo;
        }),
    Error = DefaultErrorResponse
  >;

  /**
   * Deletes a silo for an App Service plan.
   */
  deleteServerFarmSilo is ArmResourceDeleteWithoutOkAsync<
    ServerFarmSilo,
    Error = DefaultErrorResponse
  >;

  /**
   * Gets the virtual network integrations associated with an App Service plan silo.
   */
  @get
  @action("virtualNetworkIntegrations")
  getServerFarmSiloVnetIntegrations is ArmResourceActionSync<
    ServerFarmSilo,
    void,
    ArmResponse<ServerFarmSiloVnetIntegrationsResult>,
    Error = DefaultErrorResponse
  >;
}
