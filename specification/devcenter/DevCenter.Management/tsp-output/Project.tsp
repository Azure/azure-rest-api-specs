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

namespace Microsoft.DevCenter;
/**
 * Represents a project resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ProjectProperties)
model Project extends TrackedResourceBase {
  /**
   * The name of the project.
   */
  @path
  @key("projectName")
  @segment("projects")
  @visibility("read")
  name: string;

  /**
   * Properties of a project.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProjectProperties;
}

@armResourceOperations
interface Projects {
  /**
   * Gets a specific project.
   */
  get is ArmResourceRead<Project>;

  /**
   * Creates or updates a project.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Project,
    BaseParameters<Project>,
    ArmAsyncOperationHeader
  >;

  /**
   * Partially updates a project.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Project,
    ProjectUpdate,
    BaseParameters<Project>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a project resource.
   */
  delete is ArmResourceDeleteAsync<
    Project,
    BaseParameters<Project>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all projects in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Projects_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Project,
    {
      ...BaseParameters<Project>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists all projects in the subscription.
   */
  listBySubscription is ArmListBySubscription<Project>;
}

@@projectedName(Projects.createOrUpdate::parameters.resource, "json", "body");
@@extension(Projects.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Projects.createOrUpdate::parameters.resource, "Represents a project.");
@@projectedName(Projects.update::parameters.properties, "json", "body");
@@extension(Projects.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Projects.update::parameters.properties, "Updatable project properties.");
