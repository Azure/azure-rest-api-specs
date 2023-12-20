import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("User credentials used for publishing activity.")
@parentResource(WebSite)
model SiteDeployment is ProxyResource<DeploymentProperties> {
  @doc("Deployment ID.")
  @path
  @key("id")
  @segment("deployments")
  name: string;
}

@armResourceOperations
interface SiteDeployments {
  @doc("Description for Get a deployment by its ID for an app, or a deployment slot.")
  getDeployment is ArmResourceRead<SiteDeployment>;
  @doc("Description for Create a deployment for an app, or a deployment slot.")
  createDeployment is ArmResourceCreateOrReplaceSync<SiteDeployment>;
  @doc("Description for Delete a deployment by its ID for an app, or a deployment slot.")
  deleteDeployment is ArmResourceDeleteSync<SiteDeployment>;
  @doc("Description for List deployments for an app, or a deployment slot.")
  listDeployments is ArmResourceListByParent<SiteDeployment>;
  @summary("List deployment log for specific deployment for an app, or a deployment slot.")
  @doc("Description for List deployment log for specific deployment for an app, or a deployment slot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/deployments/{id}/log")
  @get
  ListDeploymentLog is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the app.")
      @path
      name: string;

      @doc("The ID of a specific deployment. This is the value of the name property in the JSON response from \"GET /api/sites/{siteName}/deployments\".")
      @path
      id: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    Deployment
  >;
}
