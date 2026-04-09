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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

alias ProjectOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** Name of the resource group */
    @path
    @segment("resourceGroups")
    @key
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the service */
    @path
    @segment("services")
    @key
    serviceName: string;
  },
  {
    /** Name of the project */
    @path
    @segment("projects")
    @key
    projectName: string;
  },
  ApiError
>;

@armResourceOperations(#{ omitTags: true })
interface Projects {
  /**
   * The project resource is a nested resource representing a stored migration project. The GET method retrieves information about a project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Projects_Get")
  @summary("Get project information")
  @tag("Project resource")
  @tag("Standard operation")
  @tag("GET")
  get is ProjectOps.Read<Project>;

  /**
   * The project resource is a nested resource representing a stored migration project. The PUT method creates a new project or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Projects_CreateOrUpdate")
  @summary("Create or update project")
  @tag("Project resource")
  @tag("Standard operation")
  @tag("PUT")
  createOrUpdate is ProjectOps.CreateOrUpdateSync<Project>;

  /**
   * The project resource is a nested resource representing a stored migration project. The PATCH method updates an existing project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Projects_Update")
  @summary("Update project")
  @tag("Project resource")
  @tag("Standard operation")
  @tag("PATCH")
  @patch(#{ implicitOptionality: false })
  update is ProjectOps.CustomPatchSync<Project, PatchModel = Project>;

  /**
   * The project resource is a nested resource representing a stored migration project. The DELETE method deletes a project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Projects_Delete")
  @summary("Delete project")
  @tag("Project resource")
  @tag("Standard operation")
  @tag("DELETE")
  delete is ProjectOps.DeleteSync<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Projects_List")
  @summary("Get projects in a service")
  @tag("Project resource")
  @tag("Standard operation")
  @tag("GET")
  list is ProjectOps.List<Project, Response = ArmResponse<ProjectList>>;
}

@@doc(Project.name, "Name of the project");
@@doc(Project.properties, "Project properties");
@@doc(Projects.createOrUpdate::parameters.resource,
  "Information about the project"
);
@@doc(Projects.update::parameters.properties, "Information about the project");
