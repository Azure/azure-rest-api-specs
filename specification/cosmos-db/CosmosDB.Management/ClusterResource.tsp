import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * Representation of a managed Cassandra cluster.
 */
model ClusterResource
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ClusterResourceProperties> {
  ...ResourceNameParameter<
    Resource = ClusterResource,
    KeyName = "clusterName",
    SegmentName = "cassandraClusters",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedCassandraManagedServiceIdentity;
}

@armResourceOperations
interface ClusterResources {
  /**
   * Get the properties of a managed Cassandra cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_Get")
  get is ArmResourceRead<ClusterResource>;

  /**
   * Create or update a managed Cassandra cluster. When updating, you must specify all writable properties. To update only some properties, use PATCH.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_CreateUpdate")
  createUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ClusterResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates some of the properties of a managed Cassandra cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("CassandraClusters_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ClusterResource,
    PatchModel = ClusterResource,
    Response = ArmResponse<ClusterResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ClusterResource;
    })
  >;

  /**
   * Deletes a managed Cassandra cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ClusterResource>;

  /**
   * List all managed Cassandra clusters in this resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ClusterResource,
    Response = ArmResponse<ListClusters>
  >;

  /**
   * List all managed Cassandra clusters in this subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    ClusterResource,
    Response = ArmResponse<ListClusters>
  >;

  /**
   * Invoke a command like nodetool for cassandra maintenance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_InvokeCommand")
  invokeCommand is ArmResourceActionAsyncBase<
    ClusterResource,
    CommandPostBody,
    ArmAcceptedLroResponse & {
      @bodyRoot
      _: CommandOutput;
    },
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ClusterResource>
  >;

  /**
   * Invoke a command like nodetool for cassandra maintenance asynchronously
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_InvokeCommandAsync")
  invokeCommandAsync is ArmResourceActionAsync<
    ClusterResource,
    CommandAsyncPostBody,
    ArmResponse<CommandPublicResource>
  >;

  /**
   * List all commands currently running on ring info
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_ListCommand")
  @list
  @get
  @action("commands")
  listCommand is ArmResourceActionSync<
    ClusterResource,
    void,
    ArmResponse<ListCommands>
  >;

  /**
   * Get details about a specified command that was run asynchronously.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_GetCommandAsync")
  @get
  getCommandAsync is ArmResourceRead<
    ClusterResource,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ClusterResource>,
    Response = ArmResponse<CommandPublicResource>,
    Parameters = {
      /**
       * Managed Cassandra cluster command id.
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$")
      @path
      @segment("commands")
      commandId: string;
    }
  >;

  /**
   * List the backups of this cluster that are available to restore.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_ListBackups")
  @list
  @get
  @action("backups")
  listBackups is ArmResourceActionSync<
    ClusterResource,
    void,
    ArmResponse<ListBackups>
  >;

  /**
   * Get the properties of an individual backup of this cluster that is available to restore.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_GetBackup")
  @get
  getBackup is ArmResourceRead<
    ClusterResource,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ClusterResource>,
    Response = ArmResponse<BackupResource>,
    Parameters = {
      /**
       * Id of a restorable backup of a Cassandra cluster.
       */
      @maxLength(15)
      @minLength(1)
      @pattern("^[0-9]+$")
      @path
      @segment("backups")
      backupId: string;
    }
  >;

  /**
   * Deallocate the Managed Cassandra Cluster and Associated Data Centers. Deallocation will deallocate the host virtual machine of this cluster, and reserved the data disk. This won't do anything on an already deallocated cluster. Use Start to restart the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_Deallocate")
  deallocate is ArmResourceActionAsyncBase<
    ClusterResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ClusterResource>,
    Parameters = {
      /**
       * Force to deallocate a cluster of Cluster Type Production. Force to deallocate a cluster of Cluster Type Production might cause data loss
       */
      @header
      xMsForceDeallocate?: string;
    }
  >;

  /**
   * Start the Managed Cassandra Cluster and Associated Data Centers. Start will start the host virtual machine of this cluster with reserved data disk. This won't do anything on an already running cluster. Use Deallocate to deallocate the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_Start")
  start is ArmResourceActionAsyncBase<
    ClusterResource,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ClusterResource>
  >;

  /**
   * Gets the CPU, memory, and disk usage statistics for each Cassandra node in a cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraClusters_Status")
  @get
  status is ArmResourceActionSync<
    ClusterResource,
    void,
    ArmResponse<CassandraClusterPublicStatus>
  >;
}

@@maxLength(ClusterResource.name, 100);
@@minLength(ClusterResource.name, 1);
@@doc(ClusterResource.name, "Managed Cassandra cluster name.");
@@doc(ClusterResource.properties, "Properties of a managed Cassandra cluster.");
@@doc(ClusterResources.createUpdate::parameters.resource,
  "The properties specifying the desired state of the managed Cassandra cluster."
);
@@doc(ClusterResources.update::parameters.properties,
  "Parameters to provide for specifying the managed Cassandra cluster."
);
@@doc(ClusterResources.invokeCommand::parameters.body,
  "Specification which command to run where"
);
@@doc(ClusterResources.invokeCommandAsync::parameters.body,
  "Specification which command to run where"
);
