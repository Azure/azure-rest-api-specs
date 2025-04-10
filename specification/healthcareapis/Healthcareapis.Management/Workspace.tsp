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
model Workspace is Azure.ResourceManager.TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Workspaces {
  /**
   * Gets the properties of the specified workspace.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Creates or updates a workspace resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    Response = ArmResourceUpdatedResponse<Workspace> | ArmResourceCreatedResponse<
      Workspace,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Workspace;
    })
  >;

  /**
   * Patch workspace details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Workspace,
    PatchModel = WorkspacePatchResource,
    Response = ArmResponse<Workspace> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Workspace;
    })
  >;

  /**
   * Deletes a specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Workspace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the available workspaces under the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    Response = ArmResponse<WorkspaceList>
  >;

  /**
   * Lists all the available workspaces under the specified subscription.
   */
  listBySubscription is ArmListBySubscription<
    Workspace,
    Response = ArmResponse<WorkspaceList>
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
