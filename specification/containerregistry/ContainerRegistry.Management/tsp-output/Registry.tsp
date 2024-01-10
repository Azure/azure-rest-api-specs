import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerRegistry;
@doc("An object that represents a container registry.")
model Registry is TrackedResource<RegistryProperties> {
  @doc("The name of the container registry.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  @key("registryName")
  @segment("registries")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Registries {
  @doc("Gets the properties of the specified container registry.")
  get is ArmResourceRead<Registry>;

  @doc("Creates a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<Registry>;

  @doc("Updates a container registry with the specified parameters.")
  update is ArmCustomPatchAsync<Registry, RegistryUpdateParameters>;

  @doc("Deletes a container registry.")
  delete is ArmResourceDeleteAsync<Registry>;

  @doc("Lists all the container registries under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<Registry>;

  @doc("Lists all the container registries under the specified subscription.")
  list is ArmListBySubscription<Registry>;

  @doc("Copies an image to this container registry from the specified container registry.")
  importImage is ArmResourceActionAsync<Registry, ImportImageParameters, void>;

  @doc("Lists the login credentials for the specified container registry.")
  listCredentials is ArmResourceActionSync<
    Registry,
    void,
    RegistryListCredentialsResult
  >;

  @doc("Regenerates one of the login credentials for the specified container registry.")
  regenerateCredential is ArmResourceActionSync<
    Registry,
    RegenerateCredentialParameters,
    RegistryListCredentialsResult
  >;

  @doc("Generate keys for a token of a specified container registry.")
  generateCredentials is ArmResourceActionAsync<
    Registry,
    GenerateCredentialsParameters,
    GenerateCredentialsResult
  >;

  @doc("Gets the quota usages for the specified container registry.")
  // FIXME: Registries_ListUsages could not be converted to a resource operation
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

@armResourceOperations
@projectedName("client", "Schedules")
interface Registries_Schedules {
  @doc("Schedules a new run based on the request parameters and add it to the run queue.")
  scheduleRun is ArmResourceActionAsync<Registry, RunRequest, Run>;
}

@armResourceOperations
@projectedName("client", "Builds")
interface Registries_Builds {
  @doc("Get the upload location for the user to be able to upload the source.")
  getBuildSourceUploadUrl is ArmResourceActionSync<
    Registry,
    void,
    SourceUploadDefinition
  >;
}
