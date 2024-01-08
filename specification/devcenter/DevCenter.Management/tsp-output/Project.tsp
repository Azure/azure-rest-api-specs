import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevCenter;
@doc("Represents a project resource.")
model Project is TrackedResource<ProjectProperties> {
  @doc("The name of the project.")
  @key("projectName")
  @segment("projects")
  name: string;
}

@armResourceOperations
interface Projects {
  @doc("Gets a specific project.")
  get is ArmResourceRead<Project>;
  @doc("Creates or updates a project.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Project>;
  @doc("Partially updates a project.")
  update is ArmCustomPatchAsync<Project, ProjectUpdate>;
  @doc("Deletes a project resource.")
  delete is ArmResourceDeleteAsync<Project>;
  @doc("Lists all projects in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Project,
    {
      ...BaseParameters<Project>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Lists all projects in the subscription.")
  listBySubscription is ArmListBySubscription<Project>;
}
