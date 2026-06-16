import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
/**
 * Workspace resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Workspace
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<WorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = ""
  >;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface Workspaces {
  /**
   * Gets the properties of the specified workspace.
   */
  get is ArmResourceRead<Workspace, Error = ErrorDetails>;

  /**
   * Creates or updates a workspace resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    Response = ArmResourceUpdatedResponse<Workspace> | ArmResourceCreatedResponse<
      Workspace,
      ArmLroLocationHeader<FinalResult = Workspace> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Workspace;
    }),
    Error = ErrorDetails
  >;

  /**
   * Patch workspace details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Workspace,
    PatchModel = WorkspacePatchResource,
    Response = ArmResponse<Workspace> | (ArmAcceptedLroResponse<
      "Resource update request accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = Workspace> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot
      _: Workspace;
    }),
    Error = ErrorDetails
  >;

  /**
   * Deletes a specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Workspace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = Error
  >;

  /**
   * Lists all the available workspaces under the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    Response = ArmResponse<WorkspaceList>,
    Error = ErrorDetails
  >;

  /**
   * Lists all the available workspaces under the specified subscription.
   */
  listBySubscription is ArmListBySubscription<
    Workspace,
    Response = ArmResponse<WorkspaceList>,
    Error = ErrorDetails
  >;
}

@@maxLength(Workspace.name, 24);
@@minLength(Workspace.name, 3);
@@doc(Workspace.name, "The name of workspace resource.");
@@doc(Workspace.properties, "Workspaces resource specific properties.");
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a healthcare workspace."
);
@@doc(Workspaces.update::parameters.properties,
  "The parameters for updating a specified workspace."
);
