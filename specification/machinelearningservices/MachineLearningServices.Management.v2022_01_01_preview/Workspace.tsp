import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * An object that represents a machine learning workspace.
 */
model Workspace
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<WorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = ""
  >;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;

  /**
   * The sku of the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface Workspaces {
  /**
   * Gets the properties of the specified machine learning workspace.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Creates or updates a workspace with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    Response = ArmResourceUpdatedResponse<Workspace> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = Workspace> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a machine learning workspace with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Workspace,
    PatchModel = WorkspaceUpdateParameters
  >;

  /**
   * Deletes a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Workspace,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the available machine learning workspaces under the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    }
  >;

  /**
   * Lists all the available machine learning workspaces under the specified subscription.
   */
  listBySubscription is ArmListBySubscription<
    Workspace,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    }
  >;

  /**
   * Diagnose workspace setup issue.
   */
  diagnose is ArmResourceActionAsync<
    Workspace,
    DiagnoseWorkspaceParameters,
    ArmResponse<DiagnoseResponseResult>,
    OptionalRequestBody = true
  >;

  /**
   * Lists all the keys associated with this workspace. This includes keys for the storage account, app insights and password for container registry
   */
  listKeys is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListWorkspaceKeysResult>
  >;

  /**
   * Resync all the keys associated with this workspace. This includes keys for the storage account, app insights and password for container registry
   */
  resyncKeys is ArmResourceActionAsync<Workspace, void, OkResponse>;

  /**
   * return notebook access token and refresh token
   */
  listNotebookAccessToken is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<NotebookAccessTokenResult>
  >;

  /**
   * Prepare a notebook.
   */
  prepareNotebook is ArmResourceActionAsync<
    Workspace,
    void,
    ArmResponse<NotebookResourceInfo>
  >;

  /**
   * List storage account keys of a workspace.
   */
  listStorageAccountKeys is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListStorageAccountKeysResult>
  >;

  /**
   * List keys of a notebook.
   */
  listNotebookKeys is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListNotebookKeysResult>
  >;

  /**
   * Called by Client (Portal, CLI, etc) to get a list of all external outbound dependencies (FQDNs) programmatically.
   */
  @list
  @get
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ExternalFqdnResponse>
  >;

  /**
   * Gets the private link resources that need to be created for a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_List")
  @list
  @get
  @action("privateLinkResources")
  list is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;

  /**
   * Lists all enabled features for a workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceFeatures_List")
  @list
  @get
  @action("features")
  workspaceFeaturesList is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListAmlUserFeatureResult>
  >;
}

@@doc(Workspace.name, "Name of Azure Machine Learning workspace.");
@@doc(
  Workspace.properties,
  "The properties of the machine learning workspace."
);
@@doc(
  Workspaces.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a machine learning workspace."
);
@@doc(
  Workspaces.update::parameters.properties,
  "The parameters for updating a machine learning workspace."
);
@@doc(
  Workspaces.diagnose::parameters.body,
  "The parameter of diagnosing workspace health"
);
