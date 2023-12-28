import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("MSDeploy ARM response")
@singleton("MSDeploy")
@parentResource(Site)
model MSDeployStatus is ProxyResource<MSDeployStatusProperties> {
  @key("MSDeploy")
  @segment("extensions")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Get the status of the last MSDeploy operation.")
  getMSDeployStatus is ArmResourceRead<MSDeployStatus>;
  @doc("Description for Invoke the MSDeploy web app extension.")
  createMSDeployOperation is ArmResourceCreateOrUpdateAsync<MSDeployStatus>;
  @summary("Get the MSDeploy Log for the last MSDeploy operation.")
  @doc("Description for Get the MSDeploy Log for the last MSDeploy operation.")
  // FIXME: WebApps_GetMSDeployLog could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/extensions/MSDeploy/log")
  @get
  GetMSDeployLog is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of web app.")
      @path
      name: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    MSDeployLog
  >;
}
