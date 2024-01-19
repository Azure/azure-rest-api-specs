import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
@doc("An object that represents a container registry.")
model Registry is TrackedResource<RegistryProperties> {
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
interface Registries {
  @doc("Gets the properties of the specified container registry.")
  get is ArmResourceRead<Registry>;

  @doc("Creates a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<
    Registry,
    BaseParameters<Registry>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a container registry with the specified parameters.")
  update is ArmCustomPatchAsync<
    Registry,
    RegistryUpdateParameters,
    BaseParameters<Registry>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a container registry.")
  delete is ArmResourceDeleteAsync<
    Registry,
    BaseParameters<Registry>,
    ArmLroLocationHeader
  >;

  @doc("Lists all the container registries under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<Registry>;

  @doc("Lists all the container registries under the specified subscription.")
  list is ArmListBySubscription<Registry>;

  @doc("Copies an image to this container registry from the specified container registry.")
  importImage is ArmResourceActionAsync<
    Registry,
    ImportImageParameters,
    void,
    BaseParameters<Registry>,
    ArmLroLocationHeader
  >;

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
    GenerateCredentialsResult,
    BaseParameters<Registry>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Schedules a new run based on the request parameters and add it to the run queue.")
  @operationId("Schedules_ScheduleRun")
  scheduleRun is ArmResourceActionAsync<Registry, RunRequest, Run>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the upload location for the user to be able to upload the source.")
  @operationId("Builds_GetBuildSourceUploadUrl")
  getBuildSourceUploadUrl is ArmResourceActionSync<
    Registry,
    void,
    SourceUploadDefinition
  >;

  @doc("Checks whether the container registry name is available for use. The name must contain only alphanumeric characters, be globally unique, and between 5 and 50 characters in length.")
  checkNameAvailability is checkGlobalNameAvailability<
    RegistryNameCheckRequest,
    RegistryNameStatus
  >;

  @doc("Gets the quota usages for the specified container registry.")
  // FIXME: Registries_ListUsages could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/listUsages")
  @get
  listUsages is Azure.Core.Foundations.Operation<
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

@@projectedName(Registries.create::parameters.resource, "json", "registry");
@@extension(Registries.create::parameters.resource,
  "x-ms-client-name",
  "registry"
);
@@doc(Registries.create::parameters.resource,
  "The parameters for creating a container registry."
);
@@projectedName(Registries.update::parameters.properties,
  "json",
  "registryUpdateParameters"
);
@@extension(Registries.update::parameters.properties,
  "x-ms-client-name",
  "registryUpdateParameters"
);
@@doc(Registries.update::parameters.properties,
  "The parameters for updating a container registry."
);
@@projectedName(Registries.importImage::parameters.body, "json", "parameters");
@@extension(Registries.importImage::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Registries.importImage::parameters.body,
  "The parameters specifying the image to copy and the source container registry."
);
@@projectedName(Registries.regenerateCredential::parameters.body,
  "json",
  "regenerateCredentialParameters"
);
@@extension(Registries.regenerateCredential::parameters.body,
  "x-ms-client-name",
  "regenerateCredentialParameters"
);
@@doc(Registries.regenerateCredential::parameters.body,
  "Specifies name of the password which should be regenerated -- password or password2."
);
@@projectedName(Registries.generateCredentials::parameters.body,
  "json",
  "generateCredentialsParameters"
);
@@extension(Registries.generateCredentials::parameters.body,
  "x-ms-client-name",
  "generateCredentialsParameters"
);
@@doc(Registries.generateCredentials::parameters.body,
  "The parameters for generating credentials."
);
@@projectedName(Registries.scheduleRun::parameters.body, "json", "runRequest");
@@extension(Registries.scheduleRun::parameters.body,
  "x-ms-client-name",
  "runRequest"
);
@@doc(Registries.scheduleRun::parameters.body,
  "The parameters of a run that needs to scheduled."
);
