import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a project resource.
 */
model Project is Azure.ResourceManager.TrackedResource<ProjectProperties> {
  ...ResourceNameParameter<
    Resource = Project,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;

  /**
   * Managed identity properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;

  /**
   * Partially updates a project.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Project,
    PatchModel = ProjectUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = Project | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmAsyncOperationHeader<FinalResult = Project>
    >
  >;

  /**
   * Deletes a project resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Project,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all projects in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Project,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ProjectListResult
  >;

  /**
   * Lists all projects in the subscription.
   */
  listBySubscription is ArmListBySubscription<
    Project,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ProjectListResult
  >;

  /**
   * Gets applicable inherited settings for this project.
   */
  getInheritedSettings is ArmResourceActionSync<
    Project,
    void,
    ArmResponse<InheritedSettingsForProject>
  >;

  /**
   * Lists SKUs available to the project
   */
  @list
  @action("listSkus")
  listByProject is ArmResourceActionSync<
    Project,
    void,
    ArmResponse<SkuListResult>
  >;
}

@@maxLength(Project.name, 63);
@@minLength(Project.name, 3);
@@doc(Project.name, "The name of the project.");
@@doc(Project.properties, "Properties of a project.");
@@doc(Projects.createOrUpdate::parameters.resource, "Represents a project.");
@@doc(Projects.update::parameters.properties, "Updatable project properties.");
