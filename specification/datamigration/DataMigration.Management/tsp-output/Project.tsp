import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataMigrationService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
@doc("A project resource")
@parentResource(DataMigrationService)
model Project is TrackedResource<ProjectProperties> {
  @doc("Name of the project")
  @path
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

@@projectedName(Projects.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Projects.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Projects.createOrUpdate::parameters.resource,
  "Information about the project"
);
@@projectedName(Projects.update::parameters.properties, "json", "parameters");
@@extension(Projects.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Projects.update::parameters.properties, "Information about the project");
