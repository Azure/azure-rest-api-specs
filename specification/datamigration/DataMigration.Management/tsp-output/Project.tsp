import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataMigrationService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataMigration;
@doc("A project resource")
@parentResource(DataMigrationService)
model Project is TrackedResource<ProjectProperties> {
  @doc("Name of the project")
  @key("projectName")
  @segment("projects")
  name: string;

  @doc("HTTP strong entity tag value. This is ignored if submitted.")
  etag?: string;
}

@armResourceOperations
interface Projects {
  @doc("The project resource is a nested resource representing a stored migration project. The GET method retrieves information about a project.")
  get is ArmResourceRead<Project>;
  @doc("The project resource is a nested resource representing a stored migration project. The PUT method creates a new project or updates an existing one.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Project>;
  @doc("The project resource is a nested resource representing a stored migration project. The PATCH method updates an existing project.")
  update is ArmCustomPatchSync<Project, Project>;
  @doc("The project resource is a nested resource representing a stored migration project. The DELETE method deletes a project.")
  delete is ArmResourceDeleteSync<
    Project,
    {
      ...BaseParameters<Project>;

      @doc("Delete the resource even if it contains running tasks")
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;
  @doc("The project resource is a nested resource representing a stored migration project. This method returns a list of projects owned by a service resource.")
  list is ArmResourceListByParent<Project>;
}
