import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VnetInfoResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Virtual Network route contract used to pass routing information for a Virtual Network.
 */
@parentResource(VnetInfoResource)
model VnetRoute is Azure.ResourceManager.ProxyResource<VnetRouteProperties> {
  ...ResourceNameParameter<
    Resource = VnetRoute,
    KeyName = "routeName",
    SegmentName = "routes",
    NamePattern = ""
  >;
}
@armResourceOperations
interface VnetRoutesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the App Service plan. */
        @path
        @segment("serverfarms")
        @key
        name: string,

        /** Name of the Virtual Network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        vnetName: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("routes")
        @key
        routeName: string,
      }
    > {}

@armResourceOperations
interface VnetRoutes {
  /**
   * Description for Get a Virtual Network route in an App Service plan.
   */
  getRouteForVnet is ArmResourceRead<
    VnetRoute,
    Response = ArmResponse<VnetRoute[]> | ArmNotFoundResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a Virtual Network route in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateVnetRoute is ArmResourceCreateOrReplaceSync<
    VnetRoute,
    Response = ArmResourceUpdatedResponse<VnetRoute> | ArmBadRequestResponse | ArmNotFoundResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a Virtual Network route in an App Service plan.
   */
  @patch(#{ implicitOptionality: false })
  updateVnetRoute is ArmCustomPatchSync<
    VnetRoute,
    PatchModel = VnetRoute,
    Response = ArmResourceUpdatedResponse<VnetRoute> | ArmBadRequestResponse | ArmNotFoundResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete a Virtual Network route in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteVnetRoute is ArmResourceDeleteSync<
    VnetRoute,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all routes that are associated with a Virtual Network in an App Service plan.
   */
  listRoutesForVnet is VnetRoutesOps.ListSinglePage<
    VnetRoute,
    Response = ArmResponse<VnetRoute[]>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(VnetRoute.name, "Name of the Virtual Network route.");
@@doc(VnetRoute.properties, "VnetRoute resource specific properties");
@@doc(VnetRoutes.createOrUpdateVnetRoute::parameters.resource,
  "Definition of the Virtual Network route."
);
@@doc(VnetRoutes.updateVnetRoute::parameters.properties,
  "Definition of the Virtual Network route."
);
