import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents an environment type.")
@parentResource(Project)
model ProjectEnvironmentType
  is TrackedResource<ProjectEnvironmentTypeProperties> {
  @doc("The name of the environment type.")
  @path
  @key("environmentTypeName")
  @segment("environmentTypes")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ProjectEnvironmentTypes {
  @doc("Gets a project environment type.")
  get is ArmResourceRead<ProjectEnvironmentType>;
  @doc("Creates or updates a project environment type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectEnvironmentType>;
  @doc("Partially updates a project environment type.")
  update is ArmResourcePatchSync<
    ProjectEnvironmentType,
    ProjectEnvironmentTypeProperties
  >;
  @doc("Deletes a project environment type.")
  delete is ArmResourceDeleteSync<ProjectEnvironmentType>;
  @doc("Lists environment types for a project.")
  list is ArmResourceListByParent<
    ProjectEnvironmentType,
    {
      ...BaseParameters<ProjectEnvironmentType>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
