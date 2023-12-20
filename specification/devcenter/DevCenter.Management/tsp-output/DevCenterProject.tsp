import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents a project resource.")
model DevCenterProject is TrackedResource<ProjectProperties> {
  @doc("The name of the project.")
  @path
  @key("projectName")
  @segment("projects")
  name: string;
}

@armResourceOperations
interface DevCenterProjects {
  @doc("Gets a specific project.")
  get is ArmResourceRead<DevCenterProject>;
  @doc("Creates or updates a project.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevCenterProject>;
  @doc("Partially updates a project.")
  update is ArmResourcePatchAsync<DevCenterProject, ProjectProperties>;
  @doc("Deletes a project resource.")
  delete is ArmResourceDeleteAsync<DevCenterProject>;
  @doc("Lists all projects in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    DevCenterProject,
    {
      ...BaseParameters<DevCenterProject>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Lists all projects in the subscription.")
  listBySubscription is ArmListBySubscription<DevCenterProject>;
}
