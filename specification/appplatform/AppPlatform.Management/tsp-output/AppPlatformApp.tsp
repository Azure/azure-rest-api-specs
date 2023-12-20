import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("App resource payload")
@parentResource(AppPlatformService)
model AppPlatformApp is ProxyResource<AppResourceProperties> {
  @doc("The name of the App resource.")
  @path
  @key("appName")
  @segment("apps")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface AppPlatformApps {
  @doc("Get an App and its properties.")
  get is ArmResourceRead<
    AppPlatformApp,
    {
      ...BaseParameters<AppPlatformApp>;

      @doc("Indicates whether sync status")
      @query("syncStatus")
      syncStatus?: string;
    }
  >;
  @doc("Create a new App or update an exiting App.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformApp>;
  @doc("Operation to update an exiting App.")
  update is ArmResourcePatchAsync<AppPlatformApp, AppResourceProperties>;
  @doc("Operation to delete an App.")
  delete is ArmResourceDeleteAsync<AppPlatformApp>;
  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<AppPlatformApp>;
  @doc("Get an resource upload URL for an App, which may be artifacts or source archive.")
  getResourceUploadUrl is ArmResourceActionSync<
    AppPlatformApp,
    void,
    ResourceUploadDefinition
  >;
  @doc("Set existing Deployment under the app as active")
  setActiveDeployments is ArmResourceActionAsync<
    AppPlatformApp,
    ActiveDeploymentCollection,
    AppPlatformApp
  >;
  @doc("Check the resource name is valid as well as not in use.")
  validateDomain is ArmResourceActionSync<
    AppPlatformApp,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}
