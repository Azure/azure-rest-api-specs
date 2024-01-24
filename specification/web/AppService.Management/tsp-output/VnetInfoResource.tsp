import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Virtual Network information ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AppServicePlan)
@Azure.ResourceManager.Private.armResourceInternal(VnetInfo)
@includeInapplicableMetadataInPayload(false)
model VnetInfoResource extends ProxyOnlyResource {
  /**
   * Name of the Virtual Network.
   */
  @path
  @key("vnetName")
  @segment("virtualNetworkConnections")
  name: string;

  /**
   * Core resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: VnetInfo;
}

@armResourceOperations
interface VnetInfoResources {
  /**
   * Description for Get a Virtual Network associated with an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_GetVnetFromServerFarm")
  getVnetFromServerFarm is ArmResourceRead<VnetInfoResource>;

  /**
   * Description for Get all Virtual Networks associated with an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_ListVnets")
  listVnets is ArmResourceListByParent<VnetInfoResource>;

  /**
   * Description for Get all routes that are associated with a Virtual Network in an App Service plan.
   */
  // FIXME: AppServicePlans_ListRoutesForVnet could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_ListRoutesForVnet")
  @summary("Get all routes that are associated with a Virtual Network in an App Service plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/virtualNetworkConnections/{vnetName}/routes")
  @get
  listRoutesForVnet is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service plan.
       */
      @path
      name: string;

      /**
       * Name of the Virtual Network.
       */
      @path
      vnetName: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    void
  >;
}
