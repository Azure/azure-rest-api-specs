import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Project resource.
 */
@parentResource(StorageMover)
model Project is Azure.ResourceManager.ProxyResource<ProjectProperties> {
  ...ResourceNameParameter<
    Resource = Project,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Project,
    Response = ArmResourceUpdatedResponse<Project>
  >;

  /**
   * Updates properties for a Project resource. Properties not specified in the request body will be unchanged.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Project, PatchModel = ProjectUpdateParameters>;

  /**
   * Deletes a Project resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Project,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Projects in a Storage Mover.
   */
  list is ArmResourceListByParent<Project, Response = ArmResponse<ProjectList>>;
}

@@doc(Project.name, "The name of the Project resource.");
@@doc(Project.properties, "Project properties.");
@@doc(Projects.createOrUpdate::parameters.resource, "");
@@doc(Projects.update::parameters.properties, "");
