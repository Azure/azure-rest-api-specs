import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenterProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents an environment type.")
@parentResource(DevCenterProject)
model DevCenterProjectEnvironment
  is TrackedResource<ProjectEnvironmentTypeProperties> {
  @doc("The name of the environment type.")
  @path
  @key("environmentTypeName")
  @segment("environmentTypes")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DevCenterProjectEnvironments {
  @doc("Gets a project environment type.")
  get is ArmResourceRead<DevCenterProjectEnvironment>;
  @doc("Creates or updates a project environment type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DevCenterProjectEnvironment>;
  @doc("Partially updates a project environment type.")
  update is ArmResourcePatchSync<
    DevCenterProjectEnvironment,
    ProjectEnvironmentTypeProperties
  >;
  @doc("Deletes a project environment type.")
  delete is ArmResourceDeleteSync<DevCenterProjectEnvironment>;
  @doc("Lists environment types for a project.")
  list is ArmResourceListByParent<
    DevCenterProjectEnvironment,
    {
      ...BaseParameters<DevCenterProjectEnvironment>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
