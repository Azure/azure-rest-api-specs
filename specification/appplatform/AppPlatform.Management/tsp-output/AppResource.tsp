import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("App resource payload")
@parentResource(ServiceResource)
model AppResource is ProxyResource<AppResourceProperties> {
  @doc("The name of the App resource.")
  @key("appName")
  @segment("apps")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
@projectedName("client", "Apps")
interface AppResources_Apps {
  @doc("Get an App and its properties.")
  get is ArmResourceRead<
    AppResource,
    {
      ...BaseParameters<AppResource>;

      @doc("Indicates whether sync status")
      @query("syncStatus")
      syncStatus?: string;
    }
  >;

  @doc("Create a new App or update an exiting App.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppResource>;

  @doc("Operation to update an exiting App.")
  update is ArmCustomPatchAsync<AppResource, AppResource>;

  @doc("Operation to delete an App.")
  delete is ArmResourceDeleteAsync<AppResource>;

  @doc("Handles requests to list all resources in a Service.")
  list is ArmResourceListByParent<AppResource>;

  @doc("Get an resource upload URL for an App, which may be artifacts or source archive.")
  getResourceUploadUrl is ArmResourceActionSync<
    AppResource,
    void,
    ResourceUploadDefinition
  >;

  @doc("Set existing Deployment under the app as active")
  setActiveDeployments is ArmResourceActionAsync<
    AppResource,
    ActiveDeploymentCollection,
    AppResource
  >;

  @doc("Check the resource name is valid as well as not in use.")
  validateDomain is ArmResourceActionSync<
    AppResource,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}
