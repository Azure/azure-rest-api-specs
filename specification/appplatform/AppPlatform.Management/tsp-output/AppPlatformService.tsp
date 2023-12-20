import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Service resource")
model AppPlatformService is TrackedResource<ClusterResourceProperties> {
  @doc("The name of the Service resource.")
  @path
  @key("serviceName")
  @segment("Spring")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface AppPlatformServices {
  @doc("Get a Service and its properties.")
  get is ArmResourceRead<AppPlatformService>;
  @doc("Create a new Service or update an exiting Service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformService>;
  @doc("Operation to update an exiting Service.")
  update is ArmResourcePatchAsync<
    AppPlatformService,
    ClusterResourceProperties
  >;
  @doc("Operation to delete a Service.")
  delete is ArmResourceDeleteAsync<AppPlatformService>;
  @doc("Handles requests to list all resources in a resource group.")
  list is ArmResourceListByParent<AppPlatformService>;
  @doc("Handles requests to list all resources in a subscription.")
  listBySubscription is ArmListBySubscription<AppPlatformService>;
  @doc("List test keys for a Service.")
  listTestKeys is ArmResourceActionSync<AppPlatformService, void, TestKeys>;
  @doc("Regenerate a test key for a Service.")
  regenerateTestKey is ArmResourceActionSync<
    AppPlatformService,
    RegenerateTestKeyRequestPayload,
    TestKeys
  >;
  @doc("Disable test endpoint functionality for a Service.")
  disableTestEndpoint is ArmResourceActionSync<AppPlatformService, void, void>;
  @doc("Enable test endpoint functionality for a Service.")
  enableTestEndpoint is ArmResourceActionSync<
    AppPlatformService,
    void,
    TestKeys
  >;
  @doc("Stop a Service.")
  stop is ArmResourceActionNoResponseContentAsync<AppPlatformService, void>;
  @doc("Start a Service.")
  start is ArmResourceActionNoResponseContentAsync<AppPlatformService, void>;
  @doc("Check if the config server settings are valid.")
  validate is ArmResourceActionAsync<
    AppPlatformService,
    ConfigServerSettings,
    ConfigServerSettingsValidateResult
  >;
  @doc("List deployments for a certain service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AppPlatform/Spring/{serviceName}/deployments")
  @get
  ListForCluster is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription ID which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the Service resource.")
      @path
      serviceName: string;

      @doc("Version of the deployments to be listed")
      @query({
        name: "version",
        format: "multi",
      })
      version?: string[];
    },
    DeploymentResourceCollection
  >;
}
