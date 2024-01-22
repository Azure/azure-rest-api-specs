import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Project resource.
 */
@parentResource(StorageMover)
model Project is ProxyResource<ProjectProperties> {
  /**
   * The name of the Project resource.
   */
  @path
  @key("projectName")
  @segment("projects")
  name: string;
}

@armResourceOperations
interface Projects {
  /**
   * Gets a Project resource.
   */
  get is ArmResourceRead<Project>;

  /**
   * Creates or updates a Project resource, which is a logical grouping of related jobs.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Project>;

  /**
   * Updates properties for a Project resource. Properties not specified in the request body will be unchanged.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Project, ProjectUpdateParameters>;

  /**
   * Deletes a Project resource.
   */
  delete is ArmResourceDeleteAsync<
    Project,
    BaseParameters<Project>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all Projects in a Storage Mover.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Projects_List")
  list is ArmResourceListByParent<Project>;
}

@@projectedName(Projects.createOrUpdate::parameters.resource,
  "json",
  "project"
);
@@extension(Projects.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "project"
);
@@doc(Projects.createOrUpdate::parameters.resource, "");
@@projectedName(Projects.update::parameters.properties, "json", "project");
@@extension(Projects.update::parameters.properties,
  "x-ms-client-name",
  "project"
);
@@doc(Projects.update::parameters.properties, "");
