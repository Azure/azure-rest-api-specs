// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

interface UsagesOperations {
  /**
   * Gets the current usage information as well as limits for AML resources for given subscription and location.
   */
  @operationId("Usages_List")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningServices/locations/{location}/usages")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
  ): ArmResponse<ListUsagesResult> | ErrorResponse;
}

interface VirtualMachineSizesOperations {
  /**
   * Returns supported VM Sizes in a location
   */
  @operationId("VirtualMachineSizes_List")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningServices/locations/{location}/vmSizes")
  @get
  list(
    ...ApiVersionParameter,
    ...LocationResourceParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<VirtualMachineSizeListResult> | ErrorResponse;
}

interface QuotasOperations {
  /**
   * Update quota for each VM family in workspace.
   */
  @operationId("Quotas_Update")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningServices/locations/{location}/updateQuotas")
  @post
  update(
    ...ApiVersionParameter,
    ...LocationResourceParameter,
    ...SubscriptionIdParameter,

    /**
     * Quota update parameters.
     */
    @body
    parameters: QuotaUpdateParameters,
  ): ArmResponse<UpdateWorkspaceQuotasResult> | ErrorResponse;

  /**
   * Gets the currently assigned Workspace Quotas based on VMFamily.
   */
  @operationId("Quotas_List")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningServices/locations/{location}/quotas")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
  ): ArmResponse<ListWorkspaceQuotas> | ErrorResponse;
}

interface CodeContainersOperations {
  /**
   * List containers.
   */
  @summary("List containers.")
  @operationId("CodeContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,
  ): ArmResponse<ResourceListResult<CodeContainer>> | ErrorResponse;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  @operationId("CodeContainers_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get container.
   */
  @summary("Get container.")
  @operationId("CodeContainers_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,
  ): ArmResponse<CodeContainer> | ErrorResponse;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  @operationId("CodeContainers_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Container entity to create or update.
     */
    @body
    body: CodeContainer,
  ): ArmResponse<CodeContainer> | ErrorResponse;
}

interface CodeVersionsOperations {
  /**
   * List versions.
   */
  @summary("List versions.")
  @operationId("CodeVersions_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Ordering of list.
     */
    @query("$orderBy")
    $orderBy?: string,

    /**
     * Maximum number of records to return.
     */
    @query("$top")
    $top?: int32,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * If specified, return CodeVersion assets with specified content hash value, regardless of name
     */
    @query("hash")
    hash?: string,

    /**
     * Hash algorithm version when listing by hash
     */
    @query("hashVersion")
    hashVersion?: string,
  ): ArmResponse<ResourceListResult<CodeVersion>> | ErrorResponse;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  @operationId("CodeVersions_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get version.
   */
  @summary("Get version.")
  @operationId("CodeVersions_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,
  ): ArmResponse<CodeVersion> | ErrorResponse;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  @operationId("CodeVersions_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,

    /**
     * Version entity to create or update.
     */
    @body
    body: CodeVersion,
  ): ArmResponse<CodeVersion> | ErrorResponse;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  @operationId("CodeVersions_Publish")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}/publish")
  @post
  publish(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,

    /**
     * Destination registry info
     */
    @body
    body: DestinationAsset,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Generate a storage location and credential for the client to upload a code asset to.
   */
  @summary("Generate a storage location and credential for the client to upload a code asset to.")
  @operationId("CodeVersions_CreateOrGetStartPendingUpload")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/codes/{name}/versions/{version}/startPendingUpload")
  @post
  createOrGetStartPendingUpload(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,

    /**
     * Pending upload request object
     */
    @body
    body: PendingUploadRequestDto,
  ): ArmResponse<PendingUploadResponseDto> | ErrorResponse;
}

interface ComponentContainersOperations {
  /**
   * List component containers.
   */
  @summary("List component containers.")
  @operationId("ComponentContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<ComponentContainer>> | ErrorResponse;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  @operationId("ComponentContainers_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get container.
   */
  @summary("Get container.")
  @operationId("ComponentContainers_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,
  ): ArmResponse<ComponentContainer> | ErrorResponse;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  @operationId("ComponentContainers_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Container entity to create or update.
     */
    @body
    body: ComponentContainer,
  ): ArmResponse<ComponentContainer> | ErrorResponse;
}

interface ComponentVersionsOperations {
  /**
   * List component versions.
   */
  @summary("List component versions.")
  @operationId("ComponentVersions_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Component name.
     */
    @path
    name: string,

    /**
     * Ordering of list.
     */
    @query("$orderBy")
    $orderBy?: string,

    /**
     * Maximum number of records to return.
     */
    @query("$top")
    $top?: int32,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<ComponentVersion>> | ErrorResponse;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  @operationId("ComponentVersions_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get version.
   */
  @summary("Get version.")
  @operationId("ComponentVersions_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,
  ): ArmResponse<ComponentVersion> | ErrorResponse;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  @operationId("ComponentVersions_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,

    /**
     * Version entity to create or update.
     */
    @body
    body: ComponentVersion,
  ): ArmResponse<ComponentVersion> | ErrorResponse;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  @operationId("ComponentVersions_Publish")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/components/{name}/versions/{version}/publish")
  @post
  publish(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,

    /**
     * Destination registry info
     */
    @body
    body: DestinationAsset,
  ): ArmResponse<void> | ErrorResponse;
}

interface DataContainersOperations {
  /**
   * List data containers.
   */
  @summary("List data containers.")
  @operationId("DataContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<DataContainer>> | ErrorResponse;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  @operationId("DataContainers_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get container.
   */
  @summary("Get container.")
  @operationId("DataContainers_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,
  ): ArmResponse<DataContainer> | ErrorResponse;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  @operationId("DataContainers_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Container entity to create or update.
     */
    @body
    body: DataContainer,
  ): ArmResponse<DataContainer> | ErrorResponse;
}

interface DataVersionsOperations {
  /**
   * List data versions in the data container
   */
  @summary("List data versions in the data container")
  @operationId("DataVersions_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Data container's name
     */
    @path
    name: string,

    /**
     * Please choose OrderBy value from ['createdtime', 'modifiedtime']
     */
    @query("$orderBy")
    $orderBy?: string,

    /**
     * Top count of results, top count cannot be greater than the page size.
     *                               If topCount > page size, results with be default page size count will be returned
     */
    @query("$top")
    $top?: int32,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
     */
    @query("$tags")
    $tags?: string,

    /**
     * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<DataVersionBase>> | ErrorResponse;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  @operationId("DataVersions_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get version.
   */
  @summary("Get version.")
  @operationId("DataVersions_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,
  ): ArmResponse<DataVersionBase> | ErrorResponse;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  @operationId("DataVersions_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,

    /**
     * Version entity to create or update.
     */
    @body
    body: DataVersionBase,
  ): ArmResponse<DataVersionBase> | ErrorResponse;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  @operationId("DataVersions_Publish")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/data/{name}/versions/{version}/publish")
  @post
  publish(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,

    /**
     * Destination registry info
     */
    @body
    body: DestinationAsset,
  ): ArmResponse<void> | ErrorResponse;
}

interface EnvironmentContainersOperations {
  /**
   * List environment containers.
   */
  @summary("List environment containers.")
  @operationId("EnvironmentContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<EnvironmentContainer>> | ErrorResponse;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  @operationId("EnvironmentContainers_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get container.
   */
  @summary("Get container.")
  @operationId("EnvironmentContainers_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,
  ): ArmResponse<EnvironmentContainer> | ErrorResponse;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  @operationId("EnvironmentContainers_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Container entity to create or update.
     */
    @body
    body: EnvironmentContainer,
  ): ArmResponse<EnvironmentContainer> | ErrorResponse;
}

interface EnvironmentVersionsOperations {
  /**
   * List versions.
   */
  @summary("List versions.")
  @operationId("EnvironmentVersions_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Ordering of list.
     */
    @query("$orderBy")
    $orderBy?: string,

    /**
     * Maximum number of records to return.
     */
    @query("$top")
    $top?: int32,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<EnvironmentVersion>> | ErrorResponse;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  @operationId("EnvironmentVersions_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get version.
   */
  @summary("Get version.")
  @operationId("EnvironmentVersions_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,
  ): ArmResponse<EnvironmentVersion> | ErrorResponse;

  /**
   * Creates or updates an EnvironmentVersion.
   */
  @summary("Creates or updates an EnvironmentVersion.")
  @operationId("EnvironmentVersions_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of EnvironmentVersion. This is case-sensitive.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Version of EnvironmentVersion.
     */
    @path
    version: string,

    /**
     * Definition of EnvironmentVersion.
     */
    @body
    body: EnvironmentVersion,
  ): ArmResponse<EnvironmentVersion> | ErrorResponse;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  @operationId("EnvironmentVersions_Publish")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/environments/{name}/versions/{version}/publish")
  @post
  publish(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,

    /**
     * Destination registry info
     */
    @body
    body: DestinationAsset,
  ): ArmResponse<void> | ErrorResponse;
}

interface ModelContainersOperations {
  /**
   * List model containers.
   */
  @summary("List model containers.")
  @operationId("ModelContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * Maximum number of results to return.
     */
    @query("count")
    count?: int32,

    /**
     * View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<ModelContainer>> | ErrorResponse;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  @operationId("ModelContainers_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get container.
   */
  @summary("Get container.")
  @operationId("ModelContainers_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,
  ): ArmResponse<ModelContainer> | ErrorResponse;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  @operationId("ModelContainers_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Container entity to create or update.
     */
    @body
    body: ModelContainer,
  ): ArmResponse<ModelContainer> | ErrorResponse;
}

interface ModelVersionsOperations {
  /**
   * List model versions.
   */
  @summary("List model versions.")
  @operationId("ModelVersions_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Model name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Continuation token for pagination.
     */
    @query("$skip")
    $skip?: string,

    /**
     * Ordering of list.
     */
    @query("$orderBy")
    $orderBy?: string,

    /**
     * Maximum number of records to return.
     */
    @query("$top")
    $top?: int32,

    /**
     * Model version.
     */
    @query("version")
    version?: string,

    /**
     * Model description.
     */
    @query("description")
    description?: string,

    /**
     * Number of initial results to skip.
     */
    @query("offset")
    offset?: int32,

    /**
     * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
     */
    @query("tags")
    tags?: string,

    /**
     * Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2
     */
    @query("properties")
    properties?: string,

    /**
     * Name of the feed.
     */
    @query("feed")
    feed?: string,

    /**
     * View type for including/excluding (for example) archived entities.
     */
    @query("listViewType")
    listViewType?: ListViewType,
  ): ArmResponse<ResourceListResult<ModelVersion>> | ErrorResponse;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  @operationId("ModelVersions_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get version.
   */
  @summary("Get version.")
  @operationId("ModelVersions_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,
  ): ArmResponse<ModelVersion> | ErrorResponse;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  @operationId("ModelVersions_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name. This is case-sensitive.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @path
    name: string,

    /**
     * Version identifier. This is case-sensitive.
     */
    @path
    version: string,

    /**
     * Version entity to create or update.
     */
    @body
    body: ModelVersion,
  ): ArmResponse<ModelVersion> | ErrorResponse;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  @operationId("ModelVersions_Publish")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/models/{name}/versions/{version}/publish")
  @post
  publish(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of Azure Machine Learning workspace.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Container name.
     */
    @path
    name: string,

    /**
     * Version identifier.
     */
    @path
    version: string,

    /**
     * Destination registry info
     */
    @body
    body: DestinationAsset,
  ): ArmResponse<void> | ErrorResponse;
}

interface EndpointDeploymentOperations {
  /**
   * Get all the deployments under the endpoint resource scope
   */
  @summary("Get all the deployments under the endpoint resource scope")
  @operationId("EndpointDeployment_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,
  ): ArmResponse<ResourceListResult<EndpointDeploymentResourcePropertiesBasicResource>> | ErrorResponse;

  /**
   * Delete  endpoint deployment resource by name
   */
  @summary("Delete  endpoint deployment resource by name")
  @operationId("EndpointDeployment_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,

    /**
     * Name of the deployment resource
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    deploymentName: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Get deployments under endpoint resource by name
   */
  @summary("Get deployments under endpoint resource by name")
  @operationId("EndpointDeployment_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,

    /**
     * Name of the deployment resource
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    deploymentName: string,
  ): ArmResponse<EndpointDeploymentResourcePropertiesBasicResource> | ErrorResponse;

  /**
   * Create or update endpoint deployment resource with the specified parameters
   */
  @summary("Create or update endpoint deployment resource with the specified parameters")
  @operationId("EndpointDeployment_CreateOrUpdate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,

    /**
     * Name of the deployment resource
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    deploymentName: string,

    /**
     * deployment object
     */
    @body
    body: EndpointDeploymentResourcePropertiesBasicResource,
  ): ArmResponse<EndpointDeploymentResourcePropertiesBasicResource | void> | ErrorResponse;
}

interface RaiPoliciesOperations {
  /**
   * List the specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("List the specified Content Filters associated with the Azure OpenAI account.")
  @operationId("RaiPolicies_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,
  ): ArmResponse<ResourceListResult<RaiPolicyPropertiesBasicResource>> | ErrorResponse;
}

interface RaiPolicyOperations {
  /**
   * Deletes the specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("Deletes the specified Content Filters associated with the Azure OpenAI account.")
  @operationId("RaiPolicy_Delete")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,

    /**
     * Name of the Rai Policy.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
    @path
    raiPolicyName: string,
  ): ArmResponse<void> | ErrorResponse;

  /**
   * Gets the specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("Gets the specified Content Filters associated with the Azure OpenAI account.")
  @operationId("RaiPolicy_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,

    /**
     * Name of the Rai Policy.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
    @path
    raiPolicyName: string,
  ): ArmResponse<RaiPolicyPropertiesBasicResource> | ErrorResponse;

  /**
   * Update the state of specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("Update the state of specified Content Filters associated with the Azure OpenAI account.")
  @operationId("RaiPolicy_Create")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/raiPolicies/{raiPolicyName}")
  @put
  create(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Azure Machine Learning Workspace Name
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    @path
    workspaceName: string,

    /**
     * Name of the endpoint resource.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
    @path
    endpointName: string,

    /**
     * Name of the Rai Policy.
     */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
    @path
    raiPolicyName: string,

    @body
    body: RaiPolicyPropertiesBasicResource,
  ): ArmResponse<RaiPolicyPropertiesBasicResource> | ErrorResponse;
}
