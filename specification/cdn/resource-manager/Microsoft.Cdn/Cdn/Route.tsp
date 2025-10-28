import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AFDEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly Routes name mapping to the any Routes or secret related information.
 */
@parentResource(AFDEndpoint)
model Route is Azure.ResourceManager.ProxyResource<RouteProperties> {
  ...ResourceNameParameter<
    Resource = Route,
    KeyName = "routeName",
    SegmentName = "routes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Routes {
  /**
   * Gets an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  get is ArmResourceRead<Route>;

  /**
   * Creates a new route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    Route,
    Response = ArmResourceUpdatedResponse<Route> | ArmResourceCreatedResponse<Route> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Route>> &
      ArmLroLocationHeader<FinalResult = Route> & {
        @bodyRoot
        _: Route;
      })
  >;

  /**
   * Updates an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Route,
    PatchModel = RouteUpdateParameters,
    Response = ArmResponse<Route> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Route> &
      ArmLroLocationHeader<FinalResult = Route> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Route;
    })
  >;

  /**
   * Deletes an existing route with the specified route name under the specified subscription, resource group, profile, and AzureFrontDoor endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    Route,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the existing origins within a profile.
   */
  @list
  listByEndpoint is ArmResourceListByParent<Route>;
}

@@doc(Route.name, "Name of the routing rule.");
@@doc(Route.properties,
  "The JSON object that contains the properties of the Routes to create."
);
@@doc(Routes.create::parameters.resource, "Route properties");
@@doc(Routes.update::parameters.properties, "Route update properties");
