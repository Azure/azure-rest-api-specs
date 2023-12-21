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
@doc("Web app configuration ARM resource.")
@singleton("web")
@parentResource(Site)
model SiteConfig is ProxyResource<SiteConfigProperties> {
  @key("web")
  @segment("config")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.")
  getConfiguration is ArmResourceRead<SiteConfig>;
  @doc("Description for Updates the configuration of an app.")
  createOrUpdateConfiguration is ArmResourceCreateOrReplaceSync<SiteConfig>;
  @doc("Description for Updates the configuration of an app.")
  updateConfiguration is ArmResourcePatchSync<SiteConfig, SiteConfigProperties>;
  @doc("Description for List the configurations of an app")
  listConfigurations is ArmResourceListByParent<SiteConfig>;
  @summary("Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  @doc("Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/config/web/snapshots")
  @get
  ListConfigurationSnapshotInfo is Azure.Core.Foundations.Operation<
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

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    SiteConfigurationSnapshotInfoCollection
  >;
}
