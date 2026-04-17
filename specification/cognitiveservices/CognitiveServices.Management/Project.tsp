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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy usage decorator required for 'Project' to maintain SDK backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'etag' on the resource envelope for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'identity' on the resource envelope for backward compatibility"
  identity?: Identity;
}
@armResourceOperations(#{ omitTags: true })
interface Projects {
  /**
   * Returns a Cognitive Services project specified by the parameters.
   */
  @tag("CognitiveServicesProjects")
  get is ArmResourceRead<Project>;

  /**
   * Create Cognitive Services Account's Project. Project is a sub-resource of an account which give AI developer it's individual container to work on.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "PUT response codes for 'get' match existing service endpoint behavior"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "'get' returns no response body, matching existing service endpoint behavior"
  @tag("CognitiveServicesProjects")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "'create' returns no response body, matching existing service endpoint behavior"
  @tag("CognitiveServicesProjects")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete response codes match existing service endpoint behavior — Projects_Delete always completes synchronously (HTTP 200)"
  @tag("CognitiveServicesProjects")
  delete is ArmResourceDeleteWithoutOkAsync<
    Project,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns all the projects in a Cognitive Services account.
   */
  @tag("CognitiveServicesProjects")
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
