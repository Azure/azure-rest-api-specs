import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Static Site Build ARM resource.")
@parentResource(StaticSite)
model StaticSiteBuild is ProxyResource<StaticSiteBuildARMResourceProperties> {
  @doc("The stage site identifier.")
  @path
  @key("environmentName")
  @segment("builds")
  name: string;
}

@armResourceOperations
interface StaticSiteBuilds {
  @doc("Description for Gets the details of a static site build.")
  getStaticSiteBuild is ArmResourceRead<StaticSiteBuild>;
  @doc("Description for Deletes a static site build.")
  deleteStaticSiteBuild is ArmResourceDeleteAsync<StaticSiteBuild>;
  @doc("Description for Gets all static site builds for a particular static site.")
  getStaticSiteBuilds is ArmResourceListByParent<StaticSiteBuild>;
  @doc("Description for Gets the application settings of a static site build.")
  listStaticSiteBuildAppSettings is ArmResourceActionSync<
    StaticSiteBuild,
    {},
    StringDictionary
  >;
  @doc("Description for Gets the application settings of a static site build.")
  listStaticSiteBuildFunctionAppSettings is ArmResourceActionSync<
    StaticSiteBuild,
    {},
    StringDictionary
  >;
  @doc("Description for Deploys zipped content to a specific environment of a static site.")
  createZipDeploymentForStaticSiteBuild is ArmResourceActionAsync<
    StaticSiteBuild,
    StaticSiteZipDeploymentARMResource,
    {}
  >;
  @summary("Gets the functions of a particular static site build.")
  @doc("Description for Gets the functions of a particular static site build.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/staticSites/{name}/builds/{environmentName}/functions")
  @get
  ListStaticSiteBuildFunctions is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Name of the static site.")
      @path
      name: string;

      @doc("The stage site identifier.")
      @path
      environmentName: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    StaticSiteFunctionOverviewCollection
  >;
}
