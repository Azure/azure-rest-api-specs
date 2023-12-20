import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StaticSiteBuild.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Static Site User Provided Function App ARM resource.")
@parentResource(StaticSiteBuild)
model StaticSiteBuildUserProvidedFunctionApp
  is ProxyResource<StaticSiteUserProvidedFunctionAppARMResourceProperties> {
  @doc("Name of the function app registered with the static site build.")
  @path
  @key("functionAppName")
  @segment("userProvidedFunctionApps")
  name: string;
}

@armResourceOperations
interface StaticSiteBuildUserProvidedFunctionApps {
  @doc("Description for Gets the details of the user provided function app registered with a static site build")
  getUserProvidedFunctionAppForStaticSiteBuild is ArmResourceRead<StaticSiteBuildUserProvidedFunctionApp>;
  @doc("Description for Register a user provided function app with a static site build")
  registerUserProvidedFunctionAppWithStaticSiteBuild is ArmResourceCreateOrUpdateAsync<
    StaticSiteBuildUserProvidedFunctionApp,
    {
      ...BaseParameters<StaticSiteBuildUserProvidedFunctionApp>;

      @doc("Specify <code>true</code> to force the update of the auth configuration on the function app even if an AzureStaticWebApps provider is already configured on the function app. The default is <code>false</code>.")
      @query("isForced")
      isForced?: boolean;
    }
  >;
  @doc("Description for Detach the user provided function app from the static site build")
  detachUserProvidedFunctionAppFromStaticSiteBuild is ArmResourceDeleteSync<StaticSiteBuildUserProvidedFunctionApp>;
  @doc("Description for Gets the details of the user provided function apps registered with a static site build")
  getUserProvidedFunctionAppsForStaticSiteBuild is ArmResourceListByParent<StaticSiteBuildUserProvidedFunctionApp>;
}
