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
model ServiceResource is TrackedResource<ClusterResourceProperties> {
  @doc("The name of the Service resource.")
  @key("serviceName")
  @segment("Spring")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Services {
  @doc("Get a Service and its properties.")
  get is ArmResourceRead<ServiceResource>;
  @doc("Create a new Service or update an exiting Service.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceResource>;
  @doc("Operation to update an exiting Service.")
  update is ArmCustomPatchAsync<ServiceResource, ServiceResource>;
  @doc("Operation to delete a Service.")
  delete is ArmResourceDeleteAsync<ServiceResource>;
  @doc("Handles requests to list all resources in a resource group.")
  list is ArmResourceListByParent<ServiceResource>;
  @doc("Handles requests to list all resources in a subscription.")
  listBySubscription is ArmListBySubscription<ServiceResource>;
  @doc("List test keys for a Service.")
  listTestKeys is ArmResourceActionSync<ServiceResource, void, TestKeys>;
  @doc("Regenerate a test key for a Service.")
  regenerateTestKey is ArmResourceActionSync<
    ServiceResource,
    RegenerateTestKeyRequestPayload,
    TestKeys
  >;
  @doc("Disable test endpoint functionality for a Service.")
  disableTestEndpoint is ArmResourceActionSync<ServiceResource, void, void>;
  @doc("Enable test endpoint functionality for a Service.")
  enableTestEndpoint is ArmResourceActionSync<ServiceResource, void, TestKeys>;
  @doc("Stop a Service.")
  stop is ArmResourceActionNoResponseContentAsync<ServiceResource, void>;
  @doc("Start a Service.")
  start is ArmResourceActionNoResponseContentAsync<ServiceResource, void>;
}

@armResourceOperations
interface ConfigServers {
  @doc("Check if the config server settings are valid.")
  validate is ArmResourceActionAsync<
    ServiceResource,
    ConfigServerSettings,
    ConfigServerSettingsValidateResult
  >;
}

@armResourceOperations
interface Deployments {
  @doc("List deployments for a certain service")
  // FIXME: Deployments_ListForCluster could not be converted to a resource operation
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
    ResourceListResult<DeploymentResource>
  >;
}
