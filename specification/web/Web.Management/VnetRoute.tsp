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
interface VnetRoutes {
  /**
   * Description for Get a Virtual Network route in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_GetRouteForVnet")
  getRouteForVnet is ArmResourceRead<
    VnetRoute,
    Response = ArmResponse<VnetRoute[]>
  >;

  /**
   * Description for Create or update a Virtual Network route in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("AppServicePlans_CreateOrUpdateVnetRoute")
  createOrUpdateVnetRoute is ArmResourceCreateOrReplaceSync<
    VnetRoute,
    Response = ArmResourceUpdatedResponse<VnetRoute>
  >;

  /**
   * Description for Create or update a Virtual Network route in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_UpdateVnetRoute")
  @patch(#{ implicitOptionality: false })
  updateVnetRoute is ArmCustomPatchSync<VnetRoute, PatchModel = VnetRoute>;

  /**
   * Description for Delete a Virtual Network route in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("AppServicePlans_DeleteVnetRoute")
  deleteVnetRoute is ArmResourceDeleteSync<
    VnetRoute,
    Response = ArmDeletedResponse
  >;

  /**
   * Description for Get all routes that are associated with a Virtual Network in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_ListRoutesForVnet")
  listRoutesForVnet is ArmResourceListByParent<
    VnetRoute,
    Response = ArmResponse<Azure.Core.Page<VnetRoute>>
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
