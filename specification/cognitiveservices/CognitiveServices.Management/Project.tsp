import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services project is an Azure resource representing the provisioned account's project, it's type, location and SKU.
 */
@parentResource(Account)
model Project
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ProjectProperties> {
  ...ResourceNameParameter<
    Resource = Project,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}
@armResourceOperations
interface Projects {
  /**
   * Returns a Cognitive Services project specified by the parameters.
   */
  get is ArmResourceRead<Project>;

  /**
   * Create Cognitive Services Account's Project. Project is a sub-resource of an account which give AI developer it's individual container to work on.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    Project,
    Response = ArmResourceUpdatedResponse<Project> | ArmResourceCreatedResponse<Project> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Project> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Project;
    })
  >;

  /**
   * Updates a Cognitive Services Project
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Project,
    PatchModel = Project,
    Response = ArmResponse<Project> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Project>> & {
      @bodyRoot
      _: Project;
    })
  >;

  /**
   * Deletes a Cognitive Services project from the resource group.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Project>;

  /**
   * Returns all the projects in a Cognitive Services account.
   */
  list is ArmResourceListByParent<Project, Response = ProjectListResult>;
}

@@maxLength(Project.name, 64);
@@minLength(Project.name, 2);
@@doc(Project.name, "The name of Cognitive Services account's project.");
@@doc(Project.properties, "Properties of Cognitive Services project.");
@@doc(Projects.create::parameters.resource,
  "The parameters to provide for the created project."
);
@@doc(Projects.update::parameters.properties,
  "The parameters to provide for the created project."
);
