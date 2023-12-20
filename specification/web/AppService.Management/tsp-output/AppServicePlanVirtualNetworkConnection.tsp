import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Virtual Network information ARM resource.")
@parentResource(AppServicePlan)
model AppServicePlanVirtualNetworkConnection is ProxyResource<VnetInfo> {
  @doc("Name of the Virtual Network.")
  @path
  @key("vnetName")
  @segment("virtualNetworkConnections")
  name: string;
}

@armResourceOperations
interface AppServicePlanVirtualNetworkConnections {
  @doc("Description for Get a Virtual Network associated with an App Service plan.")
  getVnetFromServerFarm is ArmResourceRead<AppServicePlanVirtualNetworkConnection>;
  @doc("Description for Get all Virtual Networks associated with an App Service plan.")
  listVnets is ArmResourceListByParent<AppServicePlanVirtualNetworkConnection>;
  @summary("Get all routes that are associated with a Virtual Network in an App Service plan.")
  @doc("Description for Get all routes that are associated with a Virtual Network in an App Service plan.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/virtualNetworkConnections/{vnetName}/routes")
  @get
  ListRoutesForVnet is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the App Service plan.")
      @path
      name: string;

      @doc("Name of the Virtual Network.")
      @path
      vnetName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;
}
