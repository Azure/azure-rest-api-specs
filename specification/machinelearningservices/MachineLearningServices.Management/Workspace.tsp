import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;
/**
 * An object that represents a machine learning workspace.
 */
model Workspace
  is Azure.ResourceManager.ProxyResource<WorkspaceProperties, false> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  kind?: string;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  location?: string;
  ...Azure.ResourceManager.ResourceSkuProperty;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing API uses additionalProperties pattern"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API includes additional envelope properties"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  tags?: Record<string>;
}

alias WorkspacesDeleteParameters = {
  /**
   * Flag to indicate delete is a purge request.
   */
  @query("forceToPurge")
  forceToPurge?: boolean = false;
};

@armResourceOperations
interface Workspaces {
  /**
   * Gets the properties of the specified machine learning workspace.
   */
  @summary("Gets the properties of the specified machine learning workspace.")
  get is ArmResourceRead<Workspace>;

  /**
   * Creates or updates a workspace with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing API returns additional response codes"
  @summary("Creates or updates a workspace with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    Response = ArmResourceUpdatedResponse<Workspace> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Workspace>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Updates a machine learning workspace with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  @summary("Updates a machine learning workspace with the specified parameters.")
  update is ArmCustomPatchAsync<
    Workspace,
    PatchModel = WorkspaceUpdateParameters
  >;

  /**
   * Deletes a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Deletes a machine learning workspace.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Workspace,
    Parameters = WorkspacesDeleteParameters,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the available machine learning workspaces under the specified resource group.
   */
  @summary("Lists all the available machine learning workspaces under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    Parameters = {
      /**
       * Kind of workspace.
       */
      @query("kind")
      kind?: string;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
      @query("aiCapabilities")
      aiCapabilities?: string;
    }
  >;

  /**
   * Lists all the available machine learning workspaces under the specified subscription.
   */
  @summary("Lists all the available machine learning workspaces under the specified subscription.")
  listBySubscription is ArmListBySubscription<
    Workspace,
    Parameters = {
      /**
       * Kind of workspace.
       */
      @query("kind")
      kind?: string;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
      @query("aiCapabilities")
      aiCapabilities?: string;
    }
  >;

  /**
   * Lists all enabled features for a workspace
   */
  @list
  @get
  @action("features")
  list is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListAmlUserFeatureResult>
  >;

  /**
   * Diagnose workspace setup issue.
   */
  @summary("Diagnose workspace setup issue.")
  diagnose is ArmResourceActionAsync<
    Workspace,
    DiagnoseWorkspaceParameters,
    DiagnoseResponseResult,
    OptionalRequestBody = true
  >;

  /**
   * Lists all the keys associated with this workspace. This includes keys for the storage account, app insights and password for container registry.
   */
  @summary("Lists all the keys associated with this workspace. This includes keys for the storage account, app insights and password for container registry.")
  listKeys is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListWorkspaceKeysResult>
  >;

  /**
   * Get Azure Machine Learning Workspace notebook access token
   */
  @summary("Get Azure Machine Learning Workspace notebook access token")
  listNotebookAccessToken is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<NotebookAccessTokenResult>
  >;

  /**
   * Lists keys of Azure Machine Learning Workspaces notebook.
   */
  @summary("Lists keys of Azure Machine Learning Workspaces notebook.")
  listNotebookKeys is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListNotebookKeysResult>
  >;

  /**
   * Lists keys of Azure Machine Learning Workspace's storage account.
   */
  @summary("Lists keys of Azure Machine Learning Workspace's storage account.")
  listStorageAccountKeys is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ListStorageAccountKeysResult>
  >;

  /**
   * Called by Client (Portal, CLI, etc) to get a list of all external outbound dependencies (FQDNs) programmatically.
   */
  @get
  @action("outboundNetworkDependenciesEndpoints")
  @summary("Called by Client (Portal, CLI, etc) to get a list of all external outbound dependencies (FQDNs) programmatically.")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ExternalFQDNResponse>
  >;

  /**
   * Prepare Azure Machine Learning Workspace's notebook resource
   */
  @summary("Prepare Azure Machine Learning Workspace's notebook resource")
  prepareNotebook is ArmResourceActionAsync<
    Workspace,
    void,
    NotebookResourceInfo
  >;

  /**
   * Resync all the keys associated with this workspace.This includes keys for the storage account, app insights and password for container registry
   */
  @summary("Resync all the keys associated with this workspace.This includes keys for the storage account, app insights and password for container registry")
  resyncKeys is ArmResourceActionAsync<
    Workspace,
    void,
    Response = {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Get models under the Azure ML workspace for all Azure OpenAI connections that the user can deploy.
   */
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  @action("listConnectionModels")
  @summary("Get all models under the Azure ML workspace for all Azure OpenAI connections that the user can deploy.")
  getAllModels is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<EndpointModels>
  >;

  /**
   * Get all the deployments under the workspace scope.
   */
  @removed(Versions.v2025_12_01)
  @added(Versions.v2026_01_15_preview)
  @summary("Get all the deployments under the workspace scope")
  @list
  @get
  @action("deployments")
  getInWorkspace is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<EndpointDeploymentResourcePropertiesBasicResourceArmPaginatedResult>,
    Parameters = {
      /**
       * Endpoint type filter
       */
      @query("endpointType")
      endpointType?: EndpointType;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    }
  >;

  /**
   * Called by Client (Portal, CLI, etc) to get available "private link resources" for the workspace.
   * Each "private link resource" is a connection endpoint (IP address) to the resource.
   * Pre single connection endpoint per workspace: the Data Plane IP address, returned by DNS resolution.
   * Other RPs, such as Azure Storage, have multiple - one for Blobs, other for Queues, etc.
   * Defined in the "[NRP] Private Endpoint Design" doc, topic "GET API for GroupIds".
   */
  @list
  @get
  @action("privateLinkResources")
  @summary("Called by Client (Portal, CLI, etc) to get available \"private link resources\" for the workspace.\r\nEach \"private link resource\" is a connection endpoint (IP address) to the resource.\r\nPre single connection endpoint per workspace: the Data Plane IP address, returned by DNS resolution.\r\nOther RPs, such as Azure Storage, have multiple - one for Blobs, other for Queues, etc.\r\nDefined in the \"[NRP] Private Endpoint Design\" doc, topic \"GET API for GroupIds\".")
  privateLinkResourcesList is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;

  /**
   * Provisions the managed network of a machine learning workspace.
   */
  @summary("Provisions the managed network of a machine learning workspace.")
  provisionManagedNetwork is ArmResourceActionAsync<
    Workspace,
    ManagedNetworkProvisionOptions,
    ManagedNetworkProvisionStatus,
    OptionalRequestBody = true
  >;
}

@@doc(Workspace.name, "Azure Machine Learning Workspace Name");
@@doc(Workspace.properties, "Additional attributes of the entity.");
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a machine learning workspace."
);
@@doc(Workspaces.update::parameters.properties,
  "The parameters for updating a machine learning workspace."
);
@@doc(Workspaces.diagnose::parameters.body,
  "The parameter of diagnosing workspace health"
);
@@doc(Workspaces.provisionManagedNetwork::parameters.body,
  "Managed Network Provisioning Options for a machine learning workspace."
);
@@doc(Workspace.sku,
  "Optional. This field is required to be implemented by the RP because AML is supporting more than one tier"
);
