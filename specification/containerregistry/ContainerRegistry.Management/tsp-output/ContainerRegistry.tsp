import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("An object that represents a container registry.")
model ContainerRegistry is TrackedResource<RegistryProperties> {
  @doc("The name of the container registry.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("registryName")
  @segment("registries")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ContainerRegistries {
  @doc("Gets the properties of the specified container registry.")
  get is ArmResourceRead<ContainerRegistry>;
  @doc("Creates a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ContainerRegistry>;
  @doc("Updates a container registry with the specified parameters.")
  update is ArmResourcePatchAsync<ContainerRegistry, RegistryProperties>;
  @doc("Deletes a container registry.")
  delete is ArmResourceDeleteAsync<ContainerRegistry>;
  @doc("Lists all the container registries under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<ContainerRegistry>;
  @doc("Lists all the container registries under the specified subscription.")
  list is ArmListBySubscription<ContainerRegistry>;
  @doc("Copies an image to this container registry from the specified container registry.")
  importImage is ArmResourceActionAsync<
    ContainerRegistry,
    ImportImageParameters,
    {}
  >;
  @doc("Lists the login credentials for the specified container registry.")
  listCredentials is ArmResourceActionSync<
    ContainerRegistry,
    {},
    RegistryListCredentialsResult
  >;
  @doc("Regenerates one of the login credentials for the specified container registry.")
  regenerateCredential is ArmResourceActionSync<
    ContainerRegistry,
    RegenerateCredentialParameters,
    RegistryListCredentialsResult
  >;
  @doc("Generate keys for a token of a specified container registry.")
  generateCredentials is ArmResourceActionAsync<
    ContainerRegistry,
    GenerateCredentialsParameters,
    GenerateCredentialsResult
  >;
  @doc("Schedules a new run based on the request parameters and add it to the run queue.")
  scheduleRun is ArmResourceActionAsync<
    ContainerRegistry,
    RunRequest,
    ContainerRegistryRun
  >;
  @doc("Get the upload location for the user to be able to upload the source.")
  getBuildSourceUploadUrl is ArmResourceActionSync<
    ContainerRegistry,
    {},
    SourceUploadDefinition
  >;
  @doc("Gets the quota usages for the specified container registry.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/listUsages")
  @get
  ListUsages is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the container registry.")
      @maxLength(50)
      @minLength(5)
      @pattern("^[a-zA-Z0-9]*$")
      @path
      registryName: string;
    },
    RegistryUsageListResult
  >;
}
