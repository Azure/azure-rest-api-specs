import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataMigrationService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A project resource
 */
@parentResource(DataMigrationService)
model Project
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ProjectProperties> {
  ...ResourceNameParameter<
    Resource = Project,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = ""
  >;

  /**
   * HTTP strong entity tag value. This is ignored if submitted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface Projects {
  /**
   * The project resource is a nested resource representing a stored migration project. The GET method retrieves information about a project.
   */
  @tag("Project resource")
  @tag("Standard operation")
  @tag("GET")
  get is ArmResourceRead<Project>;

  /**
   * The project resource is a nested resource representing a stored migration project. The PUT method creates a new project or updates an existing one.
   */
  @tag("Project resource")
  @tag("Standard operation")
  @tag("PUT")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Project>;

  /**
   * The project resource is a nested resource representing a stored migration project. The PATCH method updates an existing project.
   */
  @tag("Project resource")
  @tag("Standard operation")
  @tag("PATCH")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Project, PatchModel = Project>;

  /**
   * The project resource is a nested resource representing a stored migration project. The DELETE method deletes a project.
   */
  @tag("Project resource")
  @tag("Standard operation")
  @tag("DELETE")
  delete is ArmResourceDeleteSync<
    Project,
    Parameters = {
      /**
       * Delete the resource even if it contains running tasks
       */
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;

  /**
   * The project resource is a nested resource representing a stored migration project. This method returns a list of projects owned by a service resource.
   */
  @tag("Project resource")
  @tag("Standard operation")
  @tag("GET")
  list is ArmResourceListByParent<Project, Response = ArmResponse<ProjectList>>;
}

@@doc(Project.name, "Name of the project");
@@doc(Project.properties, "Project properties");
@@doc(Projects.createOrUpdate::parameters.resource,
  "Information about the project"
);
@@doc(Projects.update::parameters.properties, "Information about the project");
