import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HardwareSecurityModules;
/**
 * Resource information with extended details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
model CloudHsmCluster
  is Azure.ResourceManager.TrackedResource<CloudHsmClusterProperties> {
  ...ResourceNameParameter<
    Resource = CloudHsmCluster,
    KeyName = "cloudHsmClusterName",
    SegmentName = "cloudHsmClusters",
    NamePattern = "^[a-zA-Z0-9-]{3,23}$"
  >;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * SKU details
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sku?: CloudHsmClusterSku;
}

@armResourceOperations
interface CloudHsmClusters {
  /**
   * Gets the specified Cloud HSM Cluster
   */
  get is ArmResourceRead<CloudHsmCluster>;

  /**
   * Create or Update a Cloud HSM Cluster in the specified subscription.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CloudHsmCluster>;

  /**
   * Update a Cloud HSM Cluster in the specified subscription.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    CloudHsmCluster,
    PatchModel = CloudHsmClusterPatchParameters
  >;

  /**
   * Deletes the specified Cloud HSM Cluster
   */
  delete is ArmResourceDeleteWithoutOkAsync<CloudHsmCluster>;

  /**
   * The List operation gets information about the Cloud HSM Clusters associated with the subscription and within the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    CloudHsmCluster,
    Parameters = {
      /**
       * The page-continuation token to use with a paged version of this API
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * The List operation gets information about the Cloud HSM Clusters associated with the subscription.
   */
  listBySubscription is ArmListBySubscription<
    CloudHsmCluster,
    Parameters = {
      /**
       * The page-continuation token to use with a paged version of this API
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Pre Backup operation to validate whether the customer can perform a backup on the Cloud HSM Cluster resource in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  validateBackupProperties is ArmResourceActionAsync<
    CloudHsmCluster,
    {
      /**
       * Backup Operation Required properties
       */
      @bodyRoot
      backupRequestProperties?: BackupRequestProperties;
    },
    ArmResponse<BackupResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Create a backup of the Cloud HSM Cluster in the specified subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  backup is ArmResourceActionAsync<
    CloudHsmCluster,
    {
      /**
       * Azure storage Resource Uri
       */
      @bodyRoot
      backupRequestProperties?: BackupRequestProperties;
    },
    ArmResponse<BackupResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Queued validating pre restore operation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  validateRestoreProperties is ArmResourceActionAsync<
    CloudHsmCluster,
    {
      /**
       * Optional Parameters to validate prior performing a restore operation.
       */
      @bodyRoot
      restoreRequestProperties?: RestoreRequestProperties;
    },
    ArmResponse<RestoreResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Restores all key materials of a specified Cloud HSM Cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  restore is ArmResourceActionAsync<
    CloudHsmCluster,
    RestoreRequestProperties,
    ArmResponse<RestoreResult>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets the private link resources supported for the Cloud Hsm Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("CloudHsmClusterPrivateLinkResources_ListByCloudHsmCluster")
  listByCloudHsmCluster is ArmResourceActionSync<
    CloudHsmCluster,
    void,
    CommonTypes.PrivateLinkResourceListResult
  >;

  /**
   * Gets the backup operation status of the specified Cloud HSM Cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  @operationId("CloudHsmClusterBackupStatus_Get")
  @get
  cloudHsmClusterBackupStatusGet(
    ...ResourceInstanceParameters<
      Resource,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<CloudHsmCluster>
    >,

    #suppress "@azure-tools/typespec-azure-core/documentation-required"
    @path
    @segment("cloudHsmClusters")
    @minLength(3)
    @maxLength(23)
    @pattern("^[a-zA-Z0-9-]{3,23}$")
    cloudHsmClusterName: string,

    /**
     * Identifier for the backup operation
     */
    @path
    @segment("backupOperationStatus")
    jobId: string,
  ): BackupResult | ArmAcceptedResponse | ErrorResponse;
  /**
   * Gets the restore operation status of the specified Cloud HSM Cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  @get
  @operationId("CloudHsmClusterRestoreStatus_Get")
  cloudHsmClusterRestoreStatusGet(
    ...ResourceInstanceParameters<
      Resource,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<CloudHsmCluster>
    >,

    /**
     * Name of the Cloud HSM Cluster
     */
    @path
    @segment("cloudHsmClusters")
    @minLength(3)
    @maxLength(23)
    @pattern("^[a-zA-Z0-9-]{3,23}$")
    cloudHsmClusterName: string,

    /**
     * Identifier for the restore operation
     */
    @path
    @segment("restoreOperationStatus")
    jobId: string,
  ): RestoreResult | ArmAcceptedResponse | ErrorResponse;
}

@@maxLength(CloudHsmCluster.name, 23);
@@minLength(CloudHsmCluster.name, 3);
@@doc(CloudHsmCluster.name,
  "The name of the Cloud HSM Cluster within the specified resource group. Cloud HSM Cluster names must be between 3 and 23 characters in length."
);
@@doc(CloudHsmCluster.properties, "Properties of the Cloud HSM Cluster");
@@doc(CloudHsmClusters.createOrUpdate::parameters.resource,
  "Parameters to create Cloud HSM Cluster"
);
@@doc(CloudHsmClusters.update::parameters.properties,
  "Parameters to create Cloud HSM Cluster"
);
@@doc(CloudHsmClusters.restore::parameters.body,
  "Restore Operation Required properties"
);
